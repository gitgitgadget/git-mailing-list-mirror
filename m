From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 7/8] transport-helper: add support to delete branches
Date: Sun, 20 Apr 2014 13:59:29 -0500
Message-ID: <1398020370-11406-8-git-send-email-felipe.contreras@gmail.com>
References: <1398020370-11406-1-git-send-email-felipe.contreras@gmail.com>
Cc: Richard Hansen <rhansen@bbn.com>, Max Horn <max@quendi.de>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 20 21:10:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wbx8Y-0005yI-7a
	for gcvg-git-2@plane.gmane.org; Sun, 20 Apr 2014 21:10:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755513AbaDTTKh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Apr 2014 15:10:37 -0400
Received: from mail-yh0-f50.google.com ([209.85.213.50]:43703 "EHLO
	mail-yh0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755481AbaDTTKO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Apr 2014 15:10:14 -0400
Received: by mail-yh0-f50.google.com with SMTP id t59so1010332yho.23
        for <git@vger.kernel.org>; Sun, 20 Apr 2014 12:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1K3zv7JeJMORL7OSYTDcqiH2erT0xBBKTUabzszADhg=;
        b=yFxUyS5sJYYeWbyQ8uTZmQgWN0oDI7Kw1I/UX2Kigns8UzLQeAtmCk+Li3nQ2yXFV+
         rZtFuPAdf8Kqw2u4LF/PinZAjwPGJPV8Q0hTzpla+xXmdhrl7oFWmHoVabVn9R21Eybw
         w2K9VF7UxcSzH7JbMDBJPpvrK6JgphNUS55XD8S9mCN1V2GsGKmpTP/Chlae/Kc1wev0
         ELrv6JE4uUJaJlMuvUcOhJuNETeZNxY1p/zDltNYXaAIRdi7LCR0vt+wQma0+J82STw2
         5gY8B4RYr+G1Nz+DubJm+p0+VUxBe3GvDTEnxIfpKH0tleZR3q8ljl7hnv3snpML0vhv
         Z+kQ==
X-Received: by 10.236.200.67 with SMTP id y43mr11392724yhn.77.1398021014256;
        Sun, 20 Apr 2014 12:10:14 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id l32sm65396450yhq.42.2014.04.20.12.10.12
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 20 Apr 2014 12:10:13 -0700 (PDT)
X-Mailer: git-send-email 1.9.1+fc3.9.gc73078e
In-Reply-To: <1398020370-11406-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246565>

For remote-helpers that use 'export' to push.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t5801-remote-helpers.sh |  8 ++++++++
 transport-helper.c        | 24 +++++++++++++-----------
 2 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/t/t5801-remote-helpers.sh b/t/t5801-remote-helpers.sh
index 8288669..aec924b 100755
--- a/t/t5801-remote-helpers.sh
+++ b/t/t5801-remote-helpers.sh
@@ -102,6 +102,14 @@ test_expect_success 'push new branch with HEAD:new refspec' '
 	compare_refs local HEAD server refs/heads/new-refspec-2
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
index f74eb57..36fbf93 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -882,9 +882,6 @@ static int push_refs_with_export(struct transport *transport,
 		char *private;
 		unsigned char sha1[20];
 
-		if (ref->deletion)
-			die("remote-helpers do not support ref deletion");
-
 		private = apply_refspecs(data->refspecs, data->refspec_nr, ref->name);
 		if (private && !get_sha1(private, sha1)) {
 			strbuf_addf(&buf, "^%s", private);
@@ -896,21 +893,26 @@ static int push_refs_with_export(struct transport *transport,
 		if (ref->peer_ref) {
 			if (strcmp(ref->name, ref->peer_ref->name)) {
 				struct strbuf buf = STRBUF_INIT;
-				const char *name;
-				int flag;
 
-				/* Follow symbolic refs (mainly for HEAD). */
-				name = resolve_ref_unsafe(ref->peer_ref->name, sha1, 1, &flag);
-				if (!name || !(flag & REF_ISSYMREF))
-					name = ref->peer_ref->name;
+				if (!ref->deletion) {
+					const char *name;
+					int flag;
+
+					/* Follow symbolic refs (mainly for HEAD). */
+					name = resolve_ref_unsafe(ref->peer_ref->name, sha1, 1, &flag);
+					if (!name || !(flag & REF_ISSYMREF))
+						name = ref->peer_ref->name;
 
-				strbuf_addf(&buf, "%s:%s", name, ref->name);
+					strbuf_addf(&buf, "%s:%s", name, ref->name);
+				} else
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
1.9.1+fc3.9.gc73078e
