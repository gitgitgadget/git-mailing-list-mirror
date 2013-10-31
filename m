From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v5 03/10] transport-helper: add 'force' to 'export' helpers
Date: Thu, 31 Oct 2013 03:36:33 -0600
Message-ID: <1383212197-14259-7-git-send-email-felipe.contreras@gmail.com>
References: <1383212197-14259-1-git-send-email-felipe.contreras@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Richard Hansen <rhansen@bbn.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 31 10:44:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbonW-000418-Gp
	for gcvg-git-2@plane.gmane.org; Thu, 31 Oct 2013 10:44:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753886Ab3JaJn7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Oct 2013 05:43:59 -0400
Received: from mail-ob0-f182.google.com ([209.85.214.182]:50474 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753469Ab3JaJnd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Oct 2013 05:43:33 -0400
Received: by mail-ob0-f182.google.com with SMTP id wn1so2746948obc.41
        for <git@vger.kernel.org>; Thu, 31 Oct 2013 02:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fOcQncSl2IIBhYFXUvEVZz6QGqY1DNA6wGO6dYupv2I=;
        b=0jEwmO5L5VCeIbVtGfIsaaNdw/f/AgAFdmY6rM2te8wklHwqyglN1URfyGZ5bRzGGF
         2rHOxYXn9xyAd3qeyJfiwtXVDkPIKEiwiOCNayZHwyV6Szn0/NACS94HrGAoLpgsr5EU
         RiZRfqVVgxNpnfzPJ+QnHEL2EBHR4pyzL+l1rCKbJfxJowzJYUdtYqOXpR9Mw7N0NJL5
         0xKXYiURLkrY9hiPOGo2anWaXEu+bkaO9TZTp5Kg89LRJ7w4MR8L0PwZ2F0dU8TcWmc7
         RIHsNmPCQfdY/C+LJxAzrzC4Q/OsHeCMqsesP8wzSnJ5ze41oBEMsb/V9o0ZRVbryVzc
         g2Ag==
X-Received: by 10.60.40.5 with SMTP id t5mr1917391oek.26.1383212612803;
        Thu, 31 Oct 2013 02:43:32 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id rl1sm5448531oeb.7.2013.10.31.02.43.31
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Oct 2013 02:43:32 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.2+fc1
In-Reply-To: <1383212197-14259-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237111>

Otherwise they cannot know when to force the push or not (other than
hacks).

Tests-by: Richard Hansen <rhansen@bbn.com>
Documentation-by: Richard Hansen <rhansen@bbn.com>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/gitremote-helpers.txt |  4 ++++
 git-remote-testgit.sh               | 16 ++++++++++++++++
 t/t5801-remote-helpers.sh           | 13 +++++++++++++
 transport-helper.c                  |  5 +++++
 4 files changed, 38 insertions(+)

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
index 6d2f282..716aa4c 100755
--- a/git-remote-testgit.sh
+++ b/git-remote-testgit.sh
@@ -39,6 +39,7 @@ do
 		fi
 		test -n "$GIT_REMOTE_TESTGIT_SIGNED_TAGS" && echo "signed-tags"
 		test -n "$GIT_REMOTE_TESTGIT_NO_PRIVATE_UPDATE" && echo "no-private-update"
+		echo 'option'
 		echo
 		;;
 	list)
@@ -93,6 +94,7 @@ do
 		before=$(git for-each-ref --format=' %(refname) %(objectname) ')
 
 		git fast-import \
+			${force:+--force} \
 			${testgitmarks:+"--import-marks=$testgitmarks"} \
 			${testgitmarks:+"--export-marks=$testgitmarks"} \
 			--quiet
@@ -115,6 +117,20 @@ do
 
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
index d05fc7c..ed238e5 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -854,6 +854,11 @@ static int push_refs_with_export(struct transport *transport,
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
