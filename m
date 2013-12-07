From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v8 3/6] transport-helper: add 'force' to 'export' helpers
Date: Sat,  7 Dec 2013 15:08:09 -0600
Message-ID: <1386450492-22348-4-git-send-email-felipe.contreras@gmail.com>
References: <1386450492-22348-1-git-send-email-felipe.contreras@gmail.com>
Cc: Richard Hansen <rhansen@bbn.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 07 22:16:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VpPEH-0002x8-21
	for gcvg-git-2@plane.gmane.org; Sat, 07 Dec 2013 22:16:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758905Ab3LGVPy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Dec 2013 16:15:54 -0500
Received: from mail-oa0-f42.google.com ([209.85.219.42]:34809 "EHLO
	mail-oa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755098Ab3LGVPw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Dec 2013 16:15:52 -0500
Received: by mail-oa0-f42.google.com with SMTP id i4so2356140oah.29
        for <git@vger.kernel.org>; Sat, 07 Dec 2013 13:15:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jax5rXR6dgo58ADdWPAJaFjO63AwrDXCvXegxJcFH5w=;
        b=qnD/8R1FYOAK+E4gF7fAkxJy9WSxIivNNYMG0k34/NxRFacr1DbFppy67SuMAhzOBS
         ZiMhsluOV6zIf5UlPgDg8mi9nKs9bKLIkKaarL+Oj/9i3n2hepGfJdVuKN15vYV8WtPU
         +JVsSTvCfApZFadECHTvMaadRFEizEr2TmHLV3EumB7XlWLYiRZqVdboEpY4G6dsIg/B
         47gqhdimOAToDVYYVLZZR2bo7d0AByFXfEiKLfkzjPizYvWEWAWGcnpJot41omyv3PQq
         Hd3JvIiTm6/4++bJc7Cx4/7aupKIpd9pojhwj2BcLIHbQaMLZKMbvLExG6Ef2JypsYyV
         sGPA==
X-Received: by 10.182.232.4 with SMTP id tk4mr7740855obc.9.1386450951105;
        Sat, 07 Dec 2013 13:15:51 -0800 (PST)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id xs17sm7843048oeb.1.2013.12.07.13.15.49
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Dec 2013 13:15:49 -0800 (PST)
X-Mailer: git-send-email 1.8.5.1+fc1
In-Reply-To: <1386450492-22348-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239022>

Otherwise they cannot know when to force the push or not (other than
hacks).

Tests-by: Richard Hansen <rhansen@bbn.com>
Documentation-by: Richard Hansen <rhansen@bbn.com>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/gitremote-helpers.txt |  4 ++++
 git-remote-testgit.sh               | 18 ++++++++++++++++++
 t/t5801-remote-helpers.sh           | 13 +++++++++++++
 transport-helper.c                  |  5 +++++
 4 files changed, 40 insertions(+)

diff --git a/Documentation/gitremote-helpers.txt b/Documentation/gitremote-helpers.txt
index f1f4ca9..e75699c 100644
--- a/Documentation/gitremote-helpers.txt
+++ b/Documentation/gitremote-helpers.txt
@@ -437,6 +437,10 @@ set by Git if the remote helper has the 'option' capability.
 'option check-connectivity' \{'true'|'false'\}::
 	Request the helper to check connectivity of a clone.
 
+'option force' \{'true'|'false'\}::
+	Request the helper to perform a force update.  Defaults to
+	'false'.
+
 SEE ALSO
 --------
 linkgit:git-remote[1]
diff --git a/git-remote-testgit.sh b/git-remote-testgit.sh
index 6d2f282..1c006a0 100755
--- a/git-remote-testgit.sh
+++ b/git-remote-testgit.sh
@@ -15,6 +15,8 @@ test -z "$refspec" && prefix="refs"
 
 export GIT_DIR="$url/.git"
 
+force=
+
 mkdir -p "$dir"
 
 if test -z "$GIT_REMOTE_TESTGIT_NO_MARKS"
@@ -39,6 +41,7 @@ do
 		fi
 		test -n "$GIT_REMOTE_TESTGIT_SIGNED_TAGS" && echo "signed-tags"
 		test -n "$GIT_REMOTE_TESTGIT_NO_PRIVATE_UPDATE" && echo "no-private-update"
+		echo 'option'
 		echo
 		;;
 	list)
@@ -93,6 +96,7 @@ do
 		before=$(git for-each-ref --format=' %(refname) %(objectname) ')
 
 		git fast-import \
+			${force:+--force} \
 			${testgitmarks:+"--import-marks=$testgitmarks"} \
 			${testgitmarks:+"--export-marks=$testgitmarks"} \
 			--quiet
@@ -115,6 +119,20 @@ do
 
 		echo
 		;;
+	option\ *)
+		read cmd opt val <<-EOF
+		$line
+		EOF
+		case $opt in
+		force)
+			test $val = "true" && force="true" || force=
+			echo "ok"
+			;;
+		*)
+			echo "unsupported"
+			;;
+		esac
+		;;
 	'')
 		exit
 		;;
diff --git a/t/t5801-remote-helpers.sh b/t/t5801-remote-helpers.sh
index 613f69a..c33cc25 100755
--- a/t/t5801-remote-helpers.sh
+++ b/t/t5801-remote-helpers.sh
@@ -94,6 +94,19 @@ test_expect_failure 'push new branch with old:new refspec' '
 	compare_refs local HEAD server refs/heads/new-refspec
 '
 
+test_expect_success 'forced push' '
+	(cd local &&
+	git checkout -b force-test &&
+	echo content >> file &&
+	git commit -a -m eight &&
+	git push origin force-test &&
+	echo content >> file &&
+	git commit -a --amend -m eight-modified &&
+	git push --force origin force-test
+	) &&
+	compare_refs local refs/heads/force-test server refs/heads/force-test
+'
+
 test_expect_success 'cloning without refspec' '
 	GIT_REMOTE_TESTGIT_REFSPEC="" \
 	git clone "testgit::${PWD}/server" local2 2>error &&
diff --git a/transport-helper.c b/transport-helper.c
index 9558a0d..60fba99 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -855,6 +855,11 @@ static int push_refs_with_export(struct transport *transport,
 			die("helper %s does not support dry-run", data->name);
 	}
 
+	if (flags & TRANSPORT_PUSH_FORCE) {
+		if (set_helper_option(transport, "force", "true") != 0)
+			warning("helper %s does not support 'force'", data->name);
+	}
+
 	helper = get_helper(transport);
 
 	write_constant(helper->in, "export\n");
-- 
1.8.5.1+fc1
