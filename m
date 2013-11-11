From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v6 03/10] transport-helper: add 'force' to 'export' helpers
Date: Mon, 11 Nov 2013 16:55:03 -0600
Message-ID: <1384210507-26561-7-git-send-email-felipe.contreras@gmail.com>
References: <1384210507-26561-1-git-send-email-felipe.contreras@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Richard Hansen <rhansen@bbn.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 12 00:02:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vg0V1-0006T2-J5
	for gcvg-git-2@plane.gmane.org; Tue, 12 Nov 2013 00:02:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753511Ab3KKXCW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Nov 2013 18:02:22 -0500
Received: from mail-ob0-f180.google.com ([209.85.214.180]:36159 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753353Ab3KKXCO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Nov 2013 18:02:14 -0500
Received: by mail-ob0-f180.google.com with SMTP id vb8so2140685obc.25
        for <git@vger.kernel.org>; Mon, 11 Nov 2013 15:02:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HMZDn+UKumiOay0PM5EM84GYcNnKLkmR5I1MHyxlTS0=;
        b=LqFFQGtUau1Am9nShtJjNrzN1NUX69ZkWWaOFmKGvvkHhldICkBNQb7wIHi2Vmy/oz
         1JPfCH3nZQHYOOZ3jIXfkfwZgKmyJt12SigycdNjVMppcRF3tLGztfMsY/uFImahfq2b
         19CWswUbDe9RYuvZkYkCL/rAOAbxu3oV7XvA1mhw4MziQgmwoMocgUDlm8JXIn26eorH
         luBtarLNbLuV4cBqhh2dahcPWS4GGKaFr5qwA2Fqf/m8LuuHBpCK2++FXKl/bQ4YctwL
         HVbX0WC38XrxQMYEkvGSibr7zfkNONfVihqjlt2GdwcW05Iq1G7p+L3kLtX2gk5yP5TO
         +8xw==
X-Received: by 10.60.157.2 with SMTP id wi2mr20712954oeb.35.1384210934218;
        Mon, 11 Nov 2013 15:02:14 -0800 (PST)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id hs4sm29291679obb.5.2013.11.11.15.02.12
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Nov 2013 15:02:13 -0800 (PST)
X-Mailer: git-send-email 1.8.4.2+fc1
In-Reply-To: <1384210507-26561-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237669>

Otherwise they cannot know when to force the push or not (other than
hacks).

Tests-by: Richard Hansen <rhansen@bbn.com>
Documentation-by: Richard Hansen <rhansen@bbn.com>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
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
index 9558a0d..bead9b9 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -855,6 +855,11 @@ static int push_refs_with_export(struct transport *transport,
 			die("helper %s does not support dry-run", data->name);
 	}
 
+	if (flags & TRANSPORT_PUSH_FORCE) {
+		if (set_helper_option(transport, "force", "true") != 0)
+			die("helper %s does not support 'force'", data->name);
+	}
+
 	helper = get_helper(transport);
 
 	write_constant(helper->in, "export\n");
-- 
1.8.4.2+fc1
