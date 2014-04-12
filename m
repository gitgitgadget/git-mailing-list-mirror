From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 5/5] transport-helper: fix sync issue on crashes
Date: Sat, 12 Apr 2014 15:33:32 -0500
Message-ID: <1397334812-12215-6-git-send-email-felipe.contreras@gmail.com>
References: <1397334812-12215-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 12 22:44:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WZ4mb-0004Y1-A7
	for gcvg-git-2@plane.gmane.org; Sat, 12 Apr 2014 22:44:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756291AbaDLUoI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Apr 2014 16:44:08 -0400
Received: from mail-oa0-f43.google.com ([209.85.219.43]:53742 "EHLO
	mail-oa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756300AbaDLUnr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Apr 2014 16:43:47 -0400
Received: by mail-oa0-f43.google.com with SMTP id eb12so7737239oac.30
        for <git@vger.kernel.org>; Sat, 12 Apr 2014 13:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Qr7uqhyjEYkwGNvdzzMfPY4Y4n7y6lrhczgDOxixiO8=;
        b=efQ/TNvH+2KMcJl6E4faHnOJE9+pmnC1JSb8r33VFXFjkDmFhwipnCYw/LQCagUQCH
         ZapLp8u5b0OJ05FJVBOqxhiDOxVQm4q7ZjNYnLN7xMUUXHmDKKz0pTphGmlNM/3DFzWY
         F88gwjwVdpNm5ms2lZBFgbNrm9mF0bKIHQ6cxH3g79RmgM/FFuhDjHqKwur7Djrutslm
         2RMuTKGRDQat0GYRoI2Yx6Xd1tCCy5z0D4VUP+h64olRZ8A3A0lAlhbieA8Y4jAmNVa6
         hMmHBge6rGZYTyZRwlVZ48IUa3RWnMX2tozXUnvG8TsDexCwphhV+UMxAjP0INkZJNim
         WR6A==
X-Received: by 10.182.105.1 with SMTP id gi1mr26426254obb.9.1397335427270;
        Sat, 12 Apr 2014 13:43:47 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id d9sm49165362oen.3.2014.04.12.13.43.45
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 Apr 2014 13:43:46 -0700 (PDT)
X-Mailer: git-send-email 1.9.1+fc3.9.gc73078e
In-Reply-To: <1397334812-12215-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246190>

When a remote helper crashes while pushing we should revert back to the
state before the push, however, it's possible that `git fast-export`
already finished its job, and therefore has exported the marks already.

This creates a synchronization problem because from that moment on
`git fast-{import,export}` will have marks that the remote helper is not
aware of and all further commands fail (if those marks are referenced).

The fix is to tell `git fast-export` to export to a temporary file, and
only after the remote helper has finishes successfully, move to the
final destination.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/t5801-remote-helpers.sh | 17 ++++++++++++++++-
 transport-helper.c        | 13 +++++++++++--
 2 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/t/t5801-remote-helpers.sh b/t/t5801-remote-helpers.sh
index 613f69a..cf7fd43 100755
--- a/t/t5801-remote-helpers.sh
+++ b/t/t5801-remote-helpers.sh
@@ -207,6 +207,17 @@ test_expect_success 'push update refs failure' '
 	)
 '
 
+clean_mark () {
+	cut -f 2 -d ' ' $1 | git cat-file --batch-check | grep commit | sort > $(basename $1)
+}
+
+cmp_marks () {
+	test_when_finished "rm -rf git.marks testgit.marks" &&
+	clean_mark .git/testgit/$1/git.marks &&
+	clean_mark .git/testgit/$1/testgit.marks &&
+	test_cmp git.marks testgit.marks
+}
+
 test_expect_success 'proper failure checks for fetching' '
 	(GIT_REMOTE_TESTGIT_FAILURE=1 &&
 	export GIT_REMOTE_TESTGIT_FAILURE &&
@@ -221,7 +232,11 @@ test_expect_success 'proper failure checks for pushing' '
 	(GIT_REMOTE_TESTGIT_FAILURE=1 &&
 	export GIT_REMOTE_TESTGIT_FAILURE &&
 	cd local &&
-	test_must_fail git push --all
+	git checkout -b crash master &&
+	echo crash >> file &&
+	git commit -a -m crash &&
+	test_must_fail git push --all &&
+	cmp_marks origin
 	)
 '
 
diff --git a/transport-helper.c b/transport-helper.c
index 2747f98..090c863 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -434,7 +434,7 @@ static int get_exporter(struct transport *transport,
 	fastexport->argv[argc++] = data->signed_tags ?
 		"--signed-tags=verbatim" : "--signed-tags=warn-strip";
 	if (data->export_marks) {
-		strbuf_addf(&tmp, "--export-marks=%s", data->export_marks);
+		strbuf_addf(&tmp, "--export-marks=%s.tmp", data->export_marks);
 		fastexport->argv[argc++] = strbuf_detach(&tmp, NULL);
 	}
 	if (data->import_marks) {
@@ -901,7 +901,16 @@ static int push_refs_with_export(struct transport *transport,
 
 	if (finish_command(&exporter))
 		die("Error while running fast-export");
-	return push_update_refs_status(data, remote_refs);
+	if (push_update_refs_status(data, remote_refs))
+		return 1;
+
+	if (data->export_marks) {
+		strbuf_addf(&buf, "%s.tmp", data->export_marks);
+		rename(buf.buf, data->export_marks);
+		strbuf_release(&buf);
+	}
+
+	return 0;
 }
 
 static int push_refs(struct transport *transport,
-- 
1.9.1+fc3.9.gc73078e
