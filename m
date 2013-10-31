From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v5 10/10] transport-helper: add support to delete branches
Date: Thu, 31 Oct 2013 03:36:27 -0600
Message-ID: <1383212197-14259-1-git-send-email-felipe.contreras@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Richard Hansen <rhansen@bbn.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 31 10:43:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vbomi-0003jD-2r
	for gcvg-git-2@plane.gmane.org; Thu, 31 Oct 2013 10:43:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752676Ab3JaJnT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Oct 2013 05:43:19 -0400
Received: from mail-ob0-f170.google.com ([209.85.214.170]:65490 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751590Ab3JaJnT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Oct 2013 05:43:19 -0400
Received: by mail-ob0-f170.google.com with SMTP id wp18so2790685obc.29
        for <git@vger.kernel.org>; Thu, 31 Oct 2013 02:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=u8vjx1c1uk4rDnAIOfHIcgiJARR3QbmwVtj1JLd0XCU=;
        b=CncGh5IyWvXxvL9frXW4Gd18WxRc0+2xvrTgKQKV+pfT7gFpXGrT4vyBbxIQsA+sc5
         smQgjnvC2I1z9dZMtUoFLeEWgfxLhOjX6RcJJRHdjx3XlYRp4RZW1qkrl4uLVW/a0eou
         brKgQ6Ych36n/92BCL85/MPn67K/gq4vRd6u1AHu/ojX+NzUVRd+T4IT4PweFTxgH/Ih
         qCNnkZRSqdIY2bBbKgpPqLNuRamJUyUgu03XVr2KFG16eYpDiSuJfJN0NINI/COblCy1
         BLKkZm3EUrPVulXSm/QUNt+vxmmmxTYsvRG6fQFqb4UV41enCX/0Zahoq1tuXdy8Ow08
         o0nw==
X-Received: by 10.60.44.239 with SMTP id h15mr1923010oem.22.1383212598523;
        Thu, 31 Oct 2013 02:43:18 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id r6sm4495292obi.14.2013.10.31.02.43.16
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Oct 2013 02:43:17 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.2+fc1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237102>

For remote-helpers that use 'export' to push.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/t5801-remote-helpers.sh |  8 ++++++++
 transport-helper.c        | 11 ++++++-----
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/t/t5801-remote-helpers.sh b/t/t5801-remote-helpers.sh
index 454337e..c667965 100755
--- a/t/t5801-remote-helpers.sh
+++ b/t/t5801-remote-helpers.sh
@@ -94,6 +94,14 @@ test_expect_success 'push new branch with old:new refspec' '
 	compare_refs local HEAD server refs/heads/new-refspec
 '
 
+test_expect_success 'push delete branch' '
+	(cd local &&
+	 git push origin :new-name
+	) &&
+	test_must_fail git --git-dir="server/.git" \
+	 rev-parse --verify refs/heads/new-name
+'
+
 test_expect_success 'forced push' '
 	(cd local &&
 	git checkout -b force-test &&
diff --git a/transport-helper.c b/transport-helper.c
index 84ff578..ef91882 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -875,9 +875,6 @@ static int push_refs_with_export(struct transport *transport,
 		char *private;
 		unsigned char sha1[20];
 
-		if (ref->deletion)
-			die("remote-helpers do not support ref deletion");
-
 		private = apply_refspecs(data->refspecs, data->refspec_nr, ref->name);
 		if (private && !get_sha1(private, sha1)) {
 			strbuf_addf(&buf, "^%s", private);
@@ -889,12 +886,16 @@ static int push_refs_with_export(struct transport *transport,
 		if (ref->peer_ref) {
 			if (strcmp(ref->name, ref->peer_ref->name)) {
 				struct strbuf buf = STRBUF_INIT;
-				strbuf_addf(&buf, "%s:%s", ref->peer_ref->name, ref->name);
+				if (!ref->deletion)
+					strbuf_addf(&buf, "%s:%s", ref->peer_ref->name, ref->name);
+				else
+					strbuf_addf(&buf, ":%s", ref->name);
 				string_list_append(&revlist_args, "--refspec");
 				string_list_append(&revlist_args, buf.buf);
 				strbuf_release(&buf);
 			}
-			string_list_append(&revlist_args, ref->peer_ref->name);
+			if (!ref->deletion)
+				string_list_append(&revlist_args, ref->peer_ref->name);
 		}
 	}
 
-- 
1.8.4.2+fc1
