From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Pass -DDEFAULT_GIT_TEMPLATE_DIR only where actually used.
Date: Thu, 22 Jun 2006 02:04:04 -0700
Message-ID: <7v7j39tvcr.fsf@assigned-by-dhcp.cox.net>
References: <0J1800MC1NKJD2C0@mxout2.netvision.net.il>
	<7vwtb9veqv.fsf@assigned-by-dhcp.cox.net>
	<20060622104901.f3543f07.tihirvon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: iler.ml@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 22 11:04:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FtL6n-0005ad-Ix
	for gcvg-git@gmane.org; Thu, 22 Jun 2006 11:04:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932527AbWFVJEI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Jun 2006 05:04:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932531AbWFVJEI
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jun 2006 05:04:08 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:6290 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S932527AbWFVJEF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jun 2006 05:04:05 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060622090405.MKPV5347.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 22 Jun 2006 05:04:05 -0400
To: Timo Hirvonen <tihirvon@gmail.com>
In-Reply-To: <20060622104901.f3543f07.tihirvon@gmail.com> (Timo Hirvonen's
	message of "Thu, 22 Jun 2006 10:49:01 +0300")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22315>

Timo Hirvonen <tihirvon@gmail.com> writes:

> Junio C Hamano <junkio@cox.net> wrote:
>
>> By the way, I really started hating that we have $(GIT_VERSION)
>> in $(TRACK_CFLAGS).  Since the version string is tied to the
>> HEAD commit object name, having it in $(TRACK_CFLAGS) means that
>> every time I switch branches, make a new commit on top of the
>> current branch, or checkout-compile-and-then-make-local-change
>> sequence would force pretty much everything to be rebuilt.
>...
>> For that matter, I do not think tracking prefix_SQ makes much
>> sense since what matters are bindir, gitexecdir and template_dir
>> which are already covered, and prefix is merely a convenience to
>> set these three (four, counting GIT_PYTHON_DIR; we probably
>> should add it to TRACK_CFLAGS).
>
> Yes, only ALL_CFLAGS, bindir, gitexecdir, template_dir and
> GIT_PYTHON_DIR should be in TRACK_CFLAGS.

Exactly my thinking.  Let's do it like this, then.

-- >8 --
Makefile: do not force unneeded recompilation upon GIT_VERSION changes

---
diff --git a/Makefile b/Makefile
index 55a84d4..d45f3dc 100644
--- a/Makefile
+++ b/Makefile
@@ -612,7 +612,7 @@ tags:
 	find . -name '*.[hcS]' -print | xargs ctags -a
 
 ### Detect prefix changes
-TRACK_CFLAGS = $(subst ','\'',$(ALL_CFLAGS)):$(GIT_VERSION):\
+TRACK_CFLAGS = $(subst ','\'',$(ALL_CFLAGS)):$(GIT_PYTHON_DIR_SQ):\
              $(bindir_SQ):$(gitexecdir_SQ):$(template_dir_SQ):$(prefix_SQ)
 
 GIT-CFLAGS: .FORCE-GIT-CFLAGS
