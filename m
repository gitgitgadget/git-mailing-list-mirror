From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 2/2] transport-helper: fix remote helper namespace regression
Date: Fri, 10 May 2013 07:08:30 -0500
Message-ID: <1368187710-4434-3-git-send-email-felipe.contreras@gmail.com>
References: <1368187710-4434-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 10 14:10:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uam9Q-0000qv-DH
	for gcvg-git-2@plane.gmane.org; Fri, 10 May 2013 14:10:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752527Ab3EJMKG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 May 2013 08:10:06 -0400
Received: from mail-oa0-f45.google.com ([209.85.219.45]:51974 "EHLO
	mail-oa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751718Ab3EJMKE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 May 2013 08:10:04 -0400
Received: by mail-oa0-f45.google.com with SMTP id j6so3671848oag.4
        for <git@vger.kernel.org>; Fri, 10 May 2013 05:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=ZK9fXMV0xg86jR1lpswlxEX3WyxUMlHXaIaV75wgnBA=;
        b=ACkcXW6j1n/gK2PEBcPzOw8yeOFCowXnGgqB2ztJzTKta4IGchR0YshhODtp5XPWlC
         Sd9HzvxkOwCqmT1FY9qea6so0W2ClQrJ+30RDqwDBUNyeu1UQpMndLvOGHPBtmwwxD/S
         dddqbnR+Khh28BH+SJZlfnz9Zygpi1ESTWtoeXuiAo+vA/X4fvRKj0QbEuQP2QlJ8lDQ
         HPavMYWllFqQr98K4E4yNDdtUhPJZs8DtdJbk7RXaAER9Fees6brGbKAK/D1gFl1vk+Z
         XTpFxT7uvBg+/NLTyR9W6KKL6W4vAwLeWs4o2qHUSIQ2PRKHh3wnvsNBrIonKdi1gnbN
         26Sw==
X-Received: by 10.60.178.139 with SMTP id cy11mr6626426oec.120.1368187804074;
        Fri, 10 May 2013 05:10:04 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id wq8sm2434797obb.7.2013.05.10.05.10.02
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 10 May 2013 05:10:03 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.579.g184e698
In-Reply-To: <1368187710-4434-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223835>

Commit 664059f (transport-helper: update remote helper namespace)
updates the namespace when the push succeeds or not; we should do it
only when it succeeded.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---

The regression is in 'next' so far.

 git-remote-testgit.sh     |  7 ++++++-
 t/t5801-remote-helpers.sh | 13 +++++++++++++
 transport-helper.c        |  2 +-
 3 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/git-remote-testgit.sh b/git-remote-testgit.sh
index e83315f..2109070 100755
--- a/git-remote-testgit.sh
+++ b/git-remote-testgit.sh
@@ -104,7 +104,12 @@ do
 			*" $ref $a "*)
 				continue ;;	# unchanged
 			esac
-			echo "ok $ref"
+			if test -z "$GIT_REMOTE_TESTGIT_PUSH_ERROR"
+			then
+				echo "ok $ref"
+			else
+				echo "error $ref $GIT_REMOTE_TESTGIT_PUSH_ERROR"
+			fi
 		done
 
 		echo
diff --git a/t/t5801-remote-helpers.sh b/t/t5801-remote-helpers.sh
index 352115c..fa72181 100755
--- a/t/t5801-remote-helpers.sh
+++ b/t/t5801-remote-helpers.sh
@@ -182,6 +182,19 @@ test_expect_success 'push update refs' '
 	)
 '
 
+test_expect_success 'push update refs failure' '
+	(cd local &&
+	git checkout update &&
+	echo "update fail" >>file &&
+	git commit -a -m "update fail" &&
+	git rev-parse --verify testgit/origin/heads/update >expect &&
+	GIT_REMOTE_TESTGIT_PUSH_ERROR="non-fast forward" \
+	test_expect_code 1 git push origin update &&
+	git rev-parse --verify testgit/origin/heads/update >actual &&
+	test_cmp expect actual
+	)
+'
+
 test_expect_success 'proper failure checks for fetching' '
 	(GIT_REMOTE_TESTGIT_FAILURE=1 &&
 	export GIT_REMOTE_TESTGIT_FAILURE &&
diff --git a/transport-helper.c b/transport-helper.c
index f11d78a..2f5ac3f 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -705,7 +705,7 @@ static int push_update_ref_status(struct strbuf *buf,
 
 	(*ref)->status = status;
 	(*ref)->remote_status = msg;
-	return 0;
+	return !(status == REF_STATUS_OK);
 }
 
 static void push_update_refs_status(struct helper_data *data,
-- 
1.8.3.rc1.579.g184e698
