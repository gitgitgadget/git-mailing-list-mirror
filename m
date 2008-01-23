From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: I'm a total push-over..
Date: Wed, 23 Jan 2008 09:29:31 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0801230922190.1741@woody.linux-foundation.org>
References: <alpine.LFD.1.00.0801221515350.1741@woody.linux-foundation.org> <7vabmxqnz8.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.00.0801221844570.1741@woody.linux-foundation.org> <7vprvtngxk.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0801231224300.5731@racer.site>
 <alpine.LFD.1.00.0801230817390.1741@woody.linux-foundation.org> <alpine.LSU.1.00.0801231630480.5731@racer.site> <alpine.LFD.1.00.0801230906000.1741@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jan 23 18:32:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHjRm-00065K-Ci
	for gcvg-git-2@gmane.org; Wed, 23 Jan 2008 18:31:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757472AbYAWRa1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jan 2008 12:30:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757339AbYAWRa0
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jan 2008 12:30:26 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:47389 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757472AbYAWRaX (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Jan 2008 12:30:23 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0NHTViJ023748
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 23 Jan 2008 09:29:32 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0NHTVmi018292;
	Wed, 23 Jan 2008 09:29:31 -0800
In-Reply-To: <alpine.LFD.1.00.0801230906000.1741@woody.linux-foundation.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-2.723 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71561>



On Wed, 23 Jan 2008, Linus Torvalds wrote:
> 
> > But I really hope that you are not proposing to use the case-ignoring 
> > hash when we are _not_ on a case-challenged filesystem...
> 
> I actually suspect that we could, and nobody will notice. The hash would 
> cause a few more collissions, but not so you'd know.

To clarify: the thing I want to point out that the decision to *hash* the 
filenames in a case-insensitive hash, is very different from the decision 
to then *compare* the filenames when traversing the hash with a 
case-insensitive compare.

And this difference is actually very important. Hashing things together 
that are "equivalent" according to any random rule is what makes it 
possible to then *check* for equivalence cheaply (because you only need to 
make the potentially expensive check with the subset of cases where it 
might trigger), but it in no way forces you to actually recode or mangle 
or compare things equivalently.

In fact, I'd argue that this is what HFS+ did wrong in the first place: 
they had stupid/incompetent people who didn't understand about this, so 
they normalized the string *before* the hashing rather than as part of the 
hash itself, and thus actually corrupt the string itself.

So what you can do (and I'd argue that we do) is to have a hash that can 
handle almost arbitrary input, but then never corrupt the filename, and 
always compare exactly by default.

Then, depending on a config option, we can decide to change the compare so 
that equivalent (according to whatever rule) filenames either cause a 
warning (people on sane filesystems, but working with people who aren't), 
or are silently considered the same file (people on insane filesystems).

			Linus
