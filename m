From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v9 3/6] transport-helper: add 'force' to 'export' helpers
Date: Sat, 12 Apr 2014 15:12:52 -0500
Message-ID: <1397333575-11614-4-git-send-email-felipe.contreras@gmail.com>
References: <1397333575-11614-1-git-send-email-felipe.contreras@gmail.com>
Cc: Richard Hansen <rhansen@bbn.com>, Max Horn <max@quendi.de>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 12 22:23:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WZ4Sv-0007aI-Gb
	for gcvg-git-2@plane.gmane.org; Sat, 12 Apr 2014 22:23:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756232AbaDLUXn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Apr 2014 16:23:43 -0400
Received: from mail-oa0-f47.google.com ([209.85.219.47]:50711 "EHLO
	mail-oa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755580AbaDLUXJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Apr 2014 16:23:09 -0400
Received: by mail-oa0-f47.google.com with SMTP id i11so7615533oag.6
        for <git@vger.kernel.org>; Sat, 12 Apr 2014 13:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nBGabwWn22fHfnMdmBC66t4Ue4+cyRvVQ00OBV3qV2k=;
        b=hrKTELLexN90IIefCuKUV7fIkakw/vjtVncQSevrMWMUa9fM9hdfLUefJrLe3OQwBX
         +xnxWzj5A1OX9ZXmf2iRlSDg5cZjvn8dX4dZLqCx5FnzvRx9V1ALf+R2pVmxHaIPpx8n
         M/ef8D0zdAe+57UH4rTEjK8/hccAPkBEnWMjD4BP0gNBu0EAiqJHHWW1y+H6K0/H0Fa0
         HyCxseDG5PttCcC+oQpDjhjWR9gHzOtB4QsvXdkd+paGXvuWWmQkvxIKkDxRQAX7Z4RU
         JrF42CEDHcvILCFsRVX8v786i00oz00jZs4DT+V2vwivn2tgjAkDCvrRJntgZTPESLv6
         QnYA==
X-Received: by 10.182.24.226 with SMTP id x2mr26314493obf.13.1397334188897;
        Sat, 12 Apr 2014 13:23:08 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id cn1sm48914587oeb.11.2014.04.12.13.23.06
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 Apr 2014 13:23:07 -0700 (PDT)
X-Mailer: git-send-email 1.9.1+fc3.9.gc73078e
In-Reply-To: <1397333575-11614-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246181>

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
index c2908db..c24c0c2 100644
--- a/Documentation/gitremote-helpers.txt
+++ b/Documentation/gitremote-helpers.txt
@@ -444,6 +444,10 @@ set by Git if the remote helper has the 'option' capability.
 'option update-shallow \{'true'|'false'\}::
 	Allow to extend .git/shallow if the new refs require it.
 
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
index 4b3e38e..f50e84f 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -861,6 +861,11 @@ static int push_refs_with_export(struct transport *transport,
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
1.9.1+fc3.9.gc73078e
