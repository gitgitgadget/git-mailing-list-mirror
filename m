From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [REVISED PATCH 2/6] Introduce commit notes
Date: Thu, 19 Jul 2007 10:20:34 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0707191013440.27353@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0707152326080.14781@racer.site>
 <Pine.LNX.4.64.0707160022560.14781@racer.site> <7vejj96igx.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0707190258550.14781@racer.site>
 <alpine.LFD.0.999.0707181949490.27353@woody.linux-foundation.org>
 <7vfy3l3rj0.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Alberto Bertogli <albertito@gmail.com>, git@vger.kernel.org,
	Johan Herland <johan@herland.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 19 19:22:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBZha-0004hA-Ue
	for gcvg-git@gmane.org; Thu, 19 Jul 2007 19:22:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S940593AbXGSRV3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Jul 2007 13:21:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S940412AbXGSRV1
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jul 2007 13:21:27 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:52629 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S940582AbXGSRVX (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Jul 2007 13:21:23 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6JHKfPq004204
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 19 Jul 2007 10:20:42 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6JHKYY2012722;
	Thu, 19 Jul 2007 10:20:35 -0700
In-Reply-To: <7vfy3l3rj0.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-3.177 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53007>



On Wed, 18 Jul 2007, Junio C Hamano wrote:
> 
> Another anchoring clue you seem not to be exploiting fully is
> that the ASCII part must match "^[1-7][0-7]{4,5} " (mode bytes).

I did that on purpose.

The SHA1 *can* contain those characters too, so that's not really useful 
to us, and the only special character really is the NUL character (which 
is the only one cannot exists in the ASCII part - old-style trees can 
contain '/' too, although that's going away).

Also, the mode bytes may not be visible: if we start in a long filename, 
we'll never have looked at the mode bytes, but if we see a NUL character 
after having seen 20 non-NUL characters (long filename), we already know 
we got it. So I don't think we can even usefully use the other knowledge 
of the format of the ASCII part (other than to know it doesn't contain 
NUL's).

Of course, we can (and should) verify that the tree entry we find is 
valid, and *then* it makes sense to check the rules for the ASCII part. 
But that's only after we have already found the place.

> I was suggesting to have a specialized parser only to read such
> tree objects that are "abused" to represent notes.  You can
> cheaply validate that these trees are of expected shape.

Sure. That said, I'm less interested in the notes than I am in the cost fo 
"git blame", and that could be optimized by having some special code in 
"tree_entry_interesting()" to find the tree entries using binary search.

The special code would trigger only for:
 - large trees
 - "opt->nr_paths == 1"

but the latter case is the one that matters for blame in the first place, 
so..

		Linus
