From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 3/3] git submodule update should give notice when run without init beforehand
Date: Mon, 16 Sep 2013 01:38:23 +0800
Message-ID: <1379266703-29808-3-git-send-email-rctay89@gmail.com>
References: <1379266703-29808-1-git-send-email-rctay89@gmail.com>
 <1379266703-29808-2-git-send-email-rctay89@gmail.com>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Sep 15 19:39:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VLGHu-00089h-Nl
	for gcvg-git-2@plane.gmane.org; Sun, 15 Sep 2013 19:39:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932445Ab3IORjD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Sep 2013 13:39:03 -0400
Received: from mail-pd0-f180.google.com ([209.85.192.180]:61865 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932164Ab3IORix (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Sep 2013 13:38:53 -0400
Received: by mail-pd0-f180.google.com with SMTP id y10so3186420pdj.39
        for <git@vger.kernel.org>; Sun, 15 Sep 2013 10:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=4s2FC/ZFxAE7ZkHqeU4jsu7TxUMnnklpa3I8CKu+fJ8=;
        b=LkRFOBlHcHZM4v292oricsJdaoRtUbxvmE0LG25aNpMZtyDiv5rp2pRmAVV81xo9NK
         Nsu0WNkkxd5qsKNc4ZtiRv6BSfUueSzxzOlBK3nvQv6hKZhWKHMWBuRuf/GJJpi8GZPu
         nFV90Zbic6PwjVTProVSvYdT7mLRxLbMucZNRNx6jmCiyV827Pn66yuA4kHwGiH5EQJp
         5GdRZNZdOA2Rmv/l470U32cE5Z3HrxlmAXt3tqoLcaLwuEYiPIVv2luZQXkyINTbU0D6
         OFgC+n5L/OkuctOn8W7Ar3zaXQB/ktMizPb1O2t3C7YgRvRfRdS/KY9KmnwpKwVbEeP/
         OdJQ==
X-Received: by 10.68.228.201 with SMTP id sk9mr24961119pbc.4.1379266732693;
        Sun, 15 Sep 2013 10:38:52 -0700 (PDT)
Received: from ubu-01-asus.nus.edu.sg ([42.60.190.192])
        by mx.google.com with ESMTPSA id uw6sm25617621pbc.8.1969.12.31.16.00.00
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 15 Sep 2013 10:38:52 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.rc4.527.g303b16c
In-Reply-To: <1379266703-29808-2-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234823>

When 'update' is run with no path in a repository with uninitialized
submodules, the program terminates with no output, and zero status code.
Be more helpful to users by mentioning this.

This may be controlled by an advice.* option.

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 Documentation/config.txt    |  5 +++++
 git-submodule.sh            | 16 ++++++++++++++--
 t/t7406-submodule-update.sh |  5 ++++-
 3 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index ec57a15..79313f9 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -202,6 +202,11 @@ advice.*::
 	rmHints::
 		In case of failure in the output of linkgit:git-rm[1],
 		show directions on how to proceed from the current state.
+	submoduleUpdateUninit::
+		When linkgit:git-submodule[1] `update` is run with no `path`
+		arguments in a repository with uninitialized submodules,
+		mention that uninitalized submodules are indeed present, and
+		that they may be initialized with the `--init` option.
 --
 
 core.fileMode::
diff --git a/git-submodule.sh b/git-submodule.sh
index 2979197..56f3dc2 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -777,6 +777,7 @@ cmd_update()
 	cloned_modules=
 	module_list "$@" | {
 	err=
+	has_uninit=
 	while read mode sha1 stage sm_path
 	do
 		die_if_unmatched "$mode"
@@ -807,9 +808,13 @@ cmd_update()
 		then
 			# Only mention uninitialized submodules when its
 			# path have been specified
-			test "$#" != "0" &&
-			say "$(eval_gettext "Submodule path '\$displaypath' not initialized
+			if test "$#" != "0"
+			then
+				say "$(eval_gettext "Submodule path '\$displaypath' not initialized
 Maybe you want to use 'update --init'?")"
+			else
+				has_uninit=1
+			fi
 			continue
 		fi
 
@@ -940,6 +945,13 @@ Maybe you want to use 'update --init'?")"
 		IFS=$OIFS
 		exit 1
 	fi
+
+	if test -n "$has_uninit" \
+		-a "$(git config --bool --get advice.submoduleUpdateUninit)" != "false"
+	then
+		say "$(eval_gettext "Uninitialized submodules were detected;
+Maybe you want to use 'update --init'?")"
+	fi
 	}
 }
 
diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index 00475eb..8dbe410 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -76,8 +76,11 @@ test_expect_success 'submodule update <path> warns without init beforehand' '
 	)
 '
 
-test_expect_success 'submodule update is silent without init beforehand' '
+test_expect_success 'submodule update warns without init beforehand' '
 	(cd super2 &&
+	 test_must_fail git config --get advice.submoduleUpdateUninit &&
+	 test -n "$(git submodule update)" &&
+	 git config advice.submoduleUpdateUninit false &&
 	 test -z "$(git submodule update)"
 	)
 '
-- 
1.8.4.rc4.527.g303b16c
