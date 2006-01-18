From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] "sleep 1" sleeps too little on cygwin
Date: Tue, 17 Jan 2006 17:41:34 -0800
Message-ID: <7vvewi2typ.fsf@assigned-by-dhcp.cox.net>
References: <81b0412b0601170325y60094b4w693ac37490c67410@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 18 02:42:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ez2KV-0006O5-BS
	for gcvg-git@gmane.org; Wed, 18 Jan 2006 02:41:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751217AbWARBlk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Jan 2006 20:41:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751285AbWARBlk
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jan 2006 20:41:40 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:35062 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1751217AbWARBlj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jan 2006 20:41:39 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060118013916.TDGB17690.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 17 Jan 2006 20:39:16 -0500
To: Alex Riesen <raa.lkml@gmail.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14808>

Alex Riesen <raa.lkml@gmail.com> writes:

> Probably another one windows quirk, or just the moon phases,
> but I have to make damn sure it sleeps long enough.

IIRC, DOS file timestamps have 2 seconds granularity, so
sleeping for one second might not be enough to begin with.  Also
I run my cygwin test on sufficiently slow machine, so that may
explain why I have not notice the problem ;-).

Instead of depending on $SECONDS (isn't it a bashism?), how
about doing something like this?

---
diff --git a/t/t4011-diff-symlink.sh b/t/t4011-diff-symlink.sh
index e3ebf38..9a5fa38 100755
--- a/t/t4011-diff-symlink.sh
+++ b/t/t4011-diff-symlink.sh
@@ -23,6 +23,7 @@ EOF
 test_expect_success \
     'diff new symlink' \
     'ln -s xyzzy frotz &&
+    touch -t 199901010000 frotz &&
     git-update-index &&
     tree=$(git-write-tree) &&
     git-update-index --add frotz &&
@@ -58,8 +59,8 @@ EOF
 
 test_expect_success \
     'diff identical, but newly created symlink' \
-    'sleep 1 &&
-    ln -s xyzzy frotz &&
+    'ln -s xyzzy frotz &&
+    touch -t 200201010000 frotz &&
     git-diff-index -M -p $tree > current &&
     compare_diff_patch current expected'
 
