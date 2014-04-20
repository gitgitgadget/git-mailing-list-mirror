From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 4/8] transport-helper: add support to push symbolic refs
Date: Sun, 20 Apr 2014 13:59:26 -0500
Message-ID: <1398020370-11406-5-git-send-email-felipe.contreras@gmail.com>
References: <1398020370-11406-1-git-send-email-felipe.contreras@gmail.com>
Cc: Richard Hansen <rhansen@bbn.com>, Max Horn <max@quendi.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 20 21:10:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wbx8P-0005mr-Fr
	for gcvg-git-2@plane.gmane.org; Sun, 20 Apr 2014 21:10:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755504AbaDTTK1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Apr 2014 15:10:27 -0400
Received: from mail-yk0-f176.google.com ([209.85.160.176]:45058 "EHLO
	mail-yk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755463AbaDTTKE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Apr 2014 15:10:04 -0400
Received: by mail-yk0-f176.google.com with SMTP id 19so2822413ykq.35
        for <git@vger.kernel.org>; Sun, 20 Apr 2014 12:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wehCzERacSAT/+FYWsYDeGKD5fhKXg+ShY1W2ml6pq8=;
        b=bxFJBdxcQmxbfPbFF44gTKCNVQ32A11v6AMQWK24r2IxIuoKfQ3i+LMq4kmutEvxmg
         SzVrwzUG86EVkaetH/VRJAJ1uMK1HfaD7ZTa3IakfNv9dlOQU4ZMHEpgGnbupmXU6gad
         Loz/CoJUw33UN9DNH3kiEVHwkGW/ojI1IT3X2oVQC8XFGAyeNKFDbsIDDWt+wW1eB0x+
         HsOfokQulFYvU2hONC3WX4xmNg0qylhQ0lNnlfTazH83Bsxewn7XNk4U4t1TnjkWJF+l
         0U+LvWpIVMbLHsDDamw3NS1ZvGwcRay8nGjUFUinT0DCWdNIRm9iXQ7uiyqZBz0uG+vr
         hbpA==
X-Received: by 10.236.89.3 with SMTP id b3mr47045656yhf.54.1398021003699;
        Sun, 20 Apr 2014 12:10:03 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id u36sm65422527yhp.1.2014.04.20.12.10.02
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 20 Apr 2014 12:10:02 -0700 (PDT)
X-Mailer: git-send-email 1.9.1+fc3.9.gc73078e
In-Reply-To: <1398020370-11406-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246561>

For example 'HEAD'.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/t5801-remote-helpers.sh |  8 ++++++++
 transport-helper.c        | 11 ++++++++++-
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/t/t5801-remote-helpers.sh b/t/t5801-remote-helpers.sh
index 52b3c99..8288669 100755
--- a/t/t5801-remote-helpers.sh
+++ b/t/t5801-remote-helpers.sh
@@ -94,6 +94,14 @@ test_expect_success 'push new branch with old:new refspec' '
 	compare_refs local HEAD server refs/heads/new-refspec
 '
 
+test_expect_success 'push new branch with HEAD:new refspec' '
+	(cd local &&
+	 git checkout new-name
+	 git push origin HEAD:new-refspec-2
+	) &&
+	compare_refs local HEAD server refs/heads/new-refspec-2
+'
+
 test_expect_success 'forced push' '
 	(cd local &&
 	git checkout -b force-test &&
diff --git a/transport-helper.c b/transport-helper.c
index 3f45c47..f74eb57 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -896,7 +896,16 @@ static int push_refs_with_export(struct transport *transport,
 		if (ref->peer_ref) {
 			if (strcmp(ref->name, ref->peer_ref->name)) {
 				struct strbuf buf = STRBUF_INIT;
-				strbuf_addf(&buf, "%s:%s", ref->peer_ref->name, ref->name);
+				const char *name;
+				int flag;
+
+				/* Follow symbolic refs (mainly for HEAD). */
+				name = resolve_ref_unsafe(ref->peer_ref->name, sha1, 1, &flag);
+				if (!name || !(flag & REF_ISSYMREF))
+					name = ref->peer_ref->name;
+
+				strbuf_addf(&buf, "%s:%s", name, ref->name);
+
 				string_list_append(&revlist_args, "--refspec");
 				string_list_append(&revlist_args, buf.buf);
 				strbuf_release(&buf);
-- 
1.9.1+fc3.9.gc73078e
