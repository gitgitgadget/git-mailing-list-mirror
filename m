From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH] submodules: don't stumble over symbolic links when cloning
 recursively
Date: Wed, 11 Jul 2012 20:11:58 +0200
Message-ID: <4FFDC1EE.8080106@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Bob Halley <halley@play-bow.org>,
	Phil Hord <phil.hord@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 11 20:12:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sp1Oe-0007Ru-Py
	for gcvg-git-2@plane.gmane.org; Wed, 11 Jul 2012 20:12:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932199Ab2GKSMP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jul 2012 14:12:15 -0400
Received: from mout.web.de ([212.227.15.3]:55178 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754754Ab2GKSMO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jul 2012 14:12:14 -0400
Received: from [192.168.178.48] ([91.3.167.141]) by smtp.web.de (mrweb003)
 with ESMTPA (Nemesis) id 0M8iK4-1ScyAI36g0-00Ceuf; Wed, 11 Jul 2012 20:12:03
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:13.0) Gecko/20120614 Thunderbird/13.0.1
X-Provags-ID: V02:K0:+iinm39Gaf5AeqTXx2aFdcywmh82laPR/YHiHTzdCAu
 7pVqw/VZA9kUTAQvsgVcjnpVrCFLNX8RE0z+mfWZo6v//uIE+I
 yYSYFs+B1jPv67KAkhr7ryiymRfrDW6BPTKUe0CklO3zUqAEPZ
 OWV0KpzQRv3mLG3gXdqoE69l2QffNHhpjFeFxa2/Eq7RQIdcKh
 g0qWZV7AIdwa724OJRUrw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201319>

Since 69c305178 (submodules: refactor computation of relative gitdir path)
cloning a submodule recursively fails for recursive submodules when a
symbolic link is part of the path to the work tree of the superproject.

This happens when module_clone() tries to find the relative paths between
work tree and git dir. When a symbolic link in current $PWD points to a
directory in a different level determining the number of "../" needed to
traverse to the superprojects work tree leads to a wrong result.

As there is no portable way to say "pwd -P" use cd_to_toplevel to remove
the link from the pwd, which fixes this problem.

A test for this problem has been added to t7406.

Reported-by: Bob Halley <halley@play-bow.org>
Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---

Thanks to Bob for providing a very detailed bug report and test case!

 git-submodule.sh            |  4 ++--
 t/t7406-submodule-update.sh | 13 +++++++++++++
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 5629d87..f73e32e 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -186,8 +186,8 @@ module_clone()
 		die "$(eval_gettext "Clone of '\$url' into submodule path '\$sm_path' failed")"
 	fi

-	a=$(cd "$gitdir" && pwd)/
-	b=$(cd "$sm_path" && pwd)/
+	a=$(cd_to_toplevel && cd "$gitdir" && pwd)/
+	b=$(cd_to_toplevel && cd "$sm_path" && pwd)/
 	# normalize Windows-style absolute paths to POSIX-style absolute paths
 	case $a in [a-zA-Z]:/*) a=/${a%%:*}${a#*:} ;; esac
 	case $b in [a-zA-Z]:/*) b=/${b%%:*}${b#*:} ;; esac
diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index dcb195b..05521de 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -636,4 +636,17 @@ test_expect_success 'submodule update properly revives a moved submodule' '
 	)
 '

+test_expect_success 'submodule update can handle symbolic links in pwd' '
+	mkdir -p linked/dir &&
+	ln -s linked/dir linkto &&
+	(
+		cd linkto &&
+		git clone "$TRASH_DIRECTORY"/super_update_r2 super &&
+		(
+			cd super &&
+			git submodule update --init --recursive
+		)
+	)
+'
+
 test_done
-- 
1.7.11.1.166.gb8ff004
