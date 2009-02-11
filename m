From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: RFC: Flat directory for notes, or fan-out?  Both!
Date: Tue, 10 Feb 2009 18:35:52 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0902101825360.3590@localhost.localdomain>
References: <alpine.DEB.1.00.0902092200170.10279@pacific.mpi-cbg.de> <200902100158.46884.bss@iguanasuicide.net> <20090210131600.GD17305@coredump.intra.peff.net> <200902101958.21284.bss@iguanasuicide.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, spearce@spearce.org
To: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
X-From: git-owner@vger.kernel.org Wed Feb 11 03:39:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LX50B-00082S-Ng
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 03:39:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752862AbZBKCgm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 21:36:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752853AbZBKCgl
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 21:36:41 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:36323 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752451AbZBKCgk (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Feb 2009 21:36:40 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n1B2Zrao017080
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 10 Feb 2009 18:35:54 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n1B2Zq2M018309;
	Tue, 10 Feb 2009 18:35:53 -0800
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <200902101958.21284.bss@iguanasuicide.net>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-2.757 required=5 tests=AWL,BAYES_00,PLING_QUERY
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109368>



On Tue, 10 Feb 2009, Boyd Stephen Smith Jr. wrote:
> 
> Yes, this would require a custom merge strategy for notes to flatten -> merge 
> -> canonicalize.

That sounds unnecessarily complicated. It also really sucks for the case 
you want to optimize: small differences between trees, where you don't 
need to even linearize the common parts.

Why not make it just a straight fixed 12-bit prefix, single-level trie.

Sure, if you have less than 4k objects, it's going to add an unnecessary 
indirection, and close to an extra tree object for each object. But it 
should scale pretty well to a fairly huge numbe of notes. IOW, if you have 
less than 2^24 notes (16 million), you'll never have a tree object with 
more than 4k entries.

And with each tree being ~70 bytes/object (40 bytes name, 20 bytes SHA1 + 
overhead), the individual tree objects will still be a reasonable(ish) 
size. And the fixed depth and prefix size means that merging is trivial 
and can use the normal tree merge that avoids touching common subtrees.

The default .git/objects fan-out of just 8 bits might work too, but if 
we're thinking millions of notes (which is not entirely unreasonable), it 
gets ugly pretty fast. The reason it works ok for git is the repacking.

			Linus
