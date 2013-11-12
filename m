From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v7 03/11] transport-helper: add 'force' to 'export' helpers
Date: Tue, 12 Nov 2013 14:56:56 -0600
Message-ID: <1384289830-5471-4-git-send-email-felipe.contreras@gmail.com>
References: <1384289830-5471-1-git-send-email-felipe.contreras@gmail.com>
Cc: Richard Hansen <rhansen@bbn.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 12 22:04:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VgL8S-0007dt-HW
	for gcvg-git-2@plane.gmane.org; Tue, 12 Nov 2013 22:04:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932237Ab3KLVEZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Nov 2013 16:04:25 -0500
Received: from mail-oa0-f43.google.com ([209.85.219.43]:47534 "EHLO
	mail-oa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932192Ab3KLVEM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Nov 2013 16:04:12 -0500
Received: by mail-oa0-f43.google.com with SMTP id g12so6044732oah.30
        for <git@vger.kernel.org>; Tue, 12 Nov 2013 13:04:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zBfZ7HUQXqEn3ULgw4UbbzWG+EEiCWDsziD2C2kG4S4=;
        b=HLt4TfBiaJNGUYzS3a5c+W/2pqNmT5W8UdYA/Z+JRSh3YKld0EJ1XGQwbN1ZeieKCT
         G6JbqFvgYkUB61h4imowE2ZVjJUwJ0BAwiCEktcYbJQR7Q62ZQWtDXufsEEDbCVI9fgn
         sdmUdeUR2CSKa/Tpt2jbtwHBS0bl34ji+cbxlLKpepGQEa83awweXhhjkV03RCLDxZPs
         fmTT8f+qUsXEFjOugIRyzsiUW5Q/AV0CSTkFvU8LR/FEHfaj21CTRXfB88OwGX1NRLwz
         G2KZ3bLRFovM9X6NtoVy6jM0d2ICMX+1husRwkA9Cn8z/fcZc3W5Ua37GTU9UJMfoIRF
         muyw==
X-Received: by 10.182.243.138 with SMTP id wy10mr3870360obc.83.1384290251686;
        Tue, 12 Nov 2013 13:04:11 -0800 (PST)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id tz10sm35385819obc.10.2013.11.12.13.04.09
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Nov 2013 13:04:10 -0800 (PST)
X-Mailer: git-send-email 1.8.4.2+fc1
In-Reply-To: <1384289830-5471-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237741>

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
1.8.4.2+fc1
