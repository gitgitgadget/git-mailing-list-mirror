From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 4/5] transport-helper: trivial cleanup
Date: Sat, 12 Apr 2014 15:33:31 -0500
Message-ID: <1397334812-12215-5-git-send-email-felipe.contreras@gmail.com>
References: <1397334812-12215-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 12 22:44:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WZ4mi-0004eg-21
	for gcvg-git-2@plane.gmane.org; Sat, 12 Apr 2014 22:44:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756234AbaDLUoI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Apr 2014 16:44:08 -0400
Received: from mail-oa0-f52.google.com ([209.85.219.52]:46415 "EHLO
	mail-oa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756287AbaDLUno (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Apr 2014 16:43:44 -0400
Received: by mail-oa0-f52.google.com with SMTP id l6so7740278oag.11
        for <git@vger.kernel.org>; Sat, 12 Apr 2014 13:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VtRHfPSdhIZgZcnlTskW8t4iDlLNV5cX/TZiDsndqho=;
        b=ptfqQqVpevcHtnU/p2yY2itNyq+GFZGEQZ1iYr8OgIuLA1uvusHLSo2G1ZkzwsmxlD
         KgaQnor7tg5uKJXDuV2JeEc7EcMqkIesmTtPM+rTXFPwXEQB3bUkzJU9cMQtBQbGg8Rs
         IW20kiFRHm5asT3Lm8rnJu6lDFFS29XQe6p7ZSxli8jc8gWLPHD64IPhM//QGn1p9U04
         huXVo0039HhpHNawR9rMrS8dLIhoSjwDWrqmwNS+fbgapnfc5k5bcKfSHqZyPj5SM8V9
         6kyr1jfMU5hwKy2GXPmVgtc0YEZWhwdksBZn18HnJZYSbe47FffINcDAK9GYGyFr7rlA
         qp0Q==
X-Received: by 10.182.236.162 with SMTP id uv2mr12081792obc.40.1397335424449;
        Sat, 12 Apr 2014 13:43:44 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id or12sm19262942obc.0.2014.04.12.13.43.42
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 Apr 2014 13:43:43 -0700 (PDT)
X-Mailer: git-send-email 1.9.1+fc3.9.gc73078e
In-Reply-To: <1397334812-12215-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246191>

It's simpler to store the file names directly, and form the fast-export
arguments only when needed, and re-use the same strbuf with a format.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 transport-helper.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/transport-helper.c b/transport-helper.c
index b068ea5..2747f98 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -195,15 +195,9 @@ static struct child_process *get_helper(struct transport *transport)
 		} else if (!strcmp(capname, "signed-tags")) {
 			data->signed_tags = 1;
 		} else if (starts_with(capname, "export-marks ")) {
-			struct strbuf arg = STRBUF_INIT;
-			strbuf_addstr(&arg, "--export-marks=");
-			strbuf_addstr(&arg, capname + strlen("export-marks "));
-			data->export_marks = strbuf_detach(&arg, NULL);
+			data->export_marks = xstrdup(capname + strlen("export-marks "));
 		} else if (starts_with(capname, "import-marks")) {
-			struct strbuf arg = STRBUF_INIT;
-			strbuf_addstr(&arg, "--import-marks=");
-			strbuf_addstr(&arg, capname + strlen("import-marks "));
-			data->import_marks = strbuf_detach(&arg, NULL);
+			data->import_marks = xstrdup(capname + strlen("import-marks "));
 		} else if (starts_with(capname, "no-private-update")) {
 			data->no_private_update = 1;
 		} else if (mandatory) {
@@ -429,6 +423,7 @@ static int get_exporter(struct transport *transport,
 	struct child_process *helper = get_helper(transport);
 	int argc = 0, i;
 	memset(fastexport, 0, sizeof(*fastexport));
+	struct strbuf tmp = STRBUF_INIT;
 
 	/* we need to duplicate helper->in because we want to use it after
 	 * fastexport is done with it. */
@@ -438,10 +433,14 @@ static int get_exporter(struct transport *transport,
 	fastexport->argv[argc++] = "--use-done-feature";
 	fastexport->argv[argc++] = data->signed_tags ?
 		"--signed-tags=verbatim" : "--signed-tags=warn-strip";
-	if (data->export_marks)
-		fastexport->argv[argc++] = data->export_marks;
-	if (data->import_marks)
-		fastexport->argv[argc++] = data->import_marks;
+	if (data->export_marks) {
+		strbuf_addf(&tmp, "--export-marks=%s", data->export_marks);
+		fastexport->argv[argc++] = strbuf_detach(&tmp, NULL);
+	}
+	if (data->import_marks) {
+		strbuf_addf(&tmp, "--import-marks=%s", data->import_marks);
+		fastexport->argv[argc++] = strbuf_detach(&tmp, NULL);
+	}
 
 	for (i = 0; i < revlist_args->nr; i++)
 		fastexport->argv[argc++] = revlist_args->items[i].string;
-- 
1.9.1+fc3.9.gc73078e
