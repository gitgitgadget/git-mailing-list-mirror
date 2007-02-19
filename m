From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Teach 'git apply' to look at $GIT_DIR/config
Date: Mon, 19 Feb 2007 15:37:35 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702191527320.20368@woody.linux-foundation.org>
References: <7vlkiwsepm.fsf@assigned-by-dhcp.cox.net> <7v8xewsd2j.fsf@assigned-by-dhcp.cox.net>
 <20070217232603.GB30839@coredump.intra.peff.net> <7vmz3cqs3d.fsf@assigned-by-dhcp.cox.net>
 <20070217233203.GA6014@coredump.intra.peff.net>
 <Pine.LNX.4.64.0702191450580.20368@woody.linux-foundation.org>
 <7vodnp68p8.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Feb 20 00:37:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJI4l-0002Ir-28
	for gcvg-git@gmane.org; Tue, 20 Feb 2007 00:37:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965539AbXBSXhk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Feb 2007 18:37:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965548AbXBSXhk
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Feb 2007 18:37:40 -0500
Received: from smtp.osdl.org ([65.172.181.24]:42875 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965539AbXBSXhj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Feb 2007 18:37:39 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l1JNbZhB016571
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 19 Feb 2007 15:37:36 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l1JNbZSc024191;
	Mon, 19 Feb 2007 15:37:35 -0800
In-Reply-To: <7vodnp68p8.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-2.451 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40163>



On Mon, 19 Feb 2007, Junio C Hamano wrote:
> > ...
> > git-apply has much saner defaults (it defaults to something pretty safe, 
> > and you can then make it less safe if the patch doesn't apply).
> 
> All true.

One thing I forgot to mention: "git apply" doesn't apply *anything* unless 
everything applies cleanly. In contrast, when "patch" fails in the middle, 
it will have done part of the job, and then leaves a reject file. I much 
prefer the "everything or nothing" approach of git-apply (again, obviously 
with "--reject" you can make it work the bad old way too).

> By the way, do you want to veto a related change that makes
> git-apply behave consistently between:
> 
> 	$ cd sub/directory
>         $ git apply patch.file
> 
> and
> 
> 	$ cd sub/directory
>         $ git apply --index patch.file
> 
> The issue is, that "patch.file" (typically) starts with:
> 
> 	diff a/sub/directory/Makefile b/sub/directory/Makefile
> 	--- a/sub/directory/Makefile
> 	+++ b/sub/directory/Makefile
> 
> and the form without --index would say "What are you talking
> about? I do not see sub/directory/Makefile".
> 
> I consider this is a bugfix, but it does change the behaviour,
> so I am a bit worried about possible fallout.

Ahh.. I'm not going to veto it, although I have to admit that I don't know 
what the "right answer" is, or if a "right answer" really exists.

I _think_ that the right answer is to (a) yes, make it be consistent, but 
(b) _not_ make it be the way we do "--index" now.

Right now, when we see "--index", we do the "setup_git_directory()" and 
the git_config() stuff - which is (I think) something we should always do, 
but then we do *not* prefix the patch itself with the prefix we got. And I 
think that's wrong. I think we should always do the "-p1" behaviour from 
where we started.

Then, if somebody is in a sub/directory/, maybe they need to add a "-p3" 
to indicate that, but at least that's better than having a patch that just 
says "Makefile", and applying the patch to the *wrong* "Makefile" 
(top-level one, rather than the one you were in).

Hmm?

		Linus
