From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] transport-helper: call git fast-import properly
Date: Wed, 17 Oct 2012 10:27:20 +0200
Message-ID: <1350462440-427-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 17 10:27:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TOOyZ-0000Df-4F
	for gcvg-git-2@plane.gmane.org; Wed, 17 Oct 2012 10:27:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752410Ab2JQI12 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Oct 2012 04:27:28 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:44820 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751878Ab2JQI10 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Oct 2012 04:27:26 -0400
Received: by mail-bk0-f46.google.com with SMTP id jk13so3407113bkc.19
        for <git@vger.kernel.org>; Wed, 17 Oct 2012 01:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=V2krlx1kFV/XFZmVWgfTkyDGoaL+DNIsrHcJGIqnXXs=;
        b=IIfqE/whqEbmSIcy9Feq5XzoY0HsyOnaJgZobzNPMdU81Tqi9WyEedD3Jmp0uqyCSE
         unslJf/7bxuLK3MOFbTeM/1y4rtqaCPPY5/JJx/3oXWuQSPAn8f0O7SluIXsK6DqCUTO
         wQ9ffzrkoh2MNQ1sM6R6vvAtilD3mLGXvDSLmUtHUOVP7L3xnF4ndbc6KaaCThB1t6Xk
         Rc/C7/mmE8yLZHXdhgSuB3dDYK2XR8XpVUV+4S16Mpij86I13YHyxPzO/ds/S6MEoEoI
         S9ld//T5Pv6mobubq226E2721Ki7SU5fnfr7FCKBvZfFAN3Py9gb4yoeqp7c+pfHbZ4u
         VuWQ==
Received: by 10.204.13.20 with SMTP id z20mr4814531bkz.75.1350462444970;
        Wed, 17 Oct 2012 01:27:24 -0700 (PDT)
Received: from localhost (ip-109-43-0-45.web.vodafone.de. [109.43.0.45])
        by mx.google.com with ESMTPS id r15sm12051937bkw.9.2012.10.17.01.27.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 17 Oct 2012 01:27:24 -0700 (PDT)
X-Mailer: git-send-email 1.8.0.rc2.5.gccf4c94
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207905>

The marks options are being ignored right now.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 transport-helper.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/transport-helper.c b/transport-helper.c
index cfe0988..29bde0a 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -375,12 +375,19 @@ static int fetch_with_fetch(struct transport *transport,
 
 static int get_importer(struct transport *transport, struct child_process *fastimport)
 {
+	struct helper_data *data = transport->data;
 	struct child_process *helper = get_helper(transport);
+	int argc = 0;
+
 	memset(fastimport, 0, sizeof(*fastimport));
 	fastimport->in = helper->out;
 	fastimport->argv = xcalloc(5, sizeof(*fastimport->argv));
-	fastimport->argv[0] = "fast-import";
-	fastimport->argv[1] = "--quiet";
+	fastimport->argv[argc++] = "fast-import";
+	fastimport->argv[argc++] = "--quiet";
+	if (data->export_marks)
+		fastimport->argv[argc++] = data->export_marks;
+	if (data->import_marks)
+		fastimport->argv[argc++] = data->import_marks;
 
 	fastimport->git_cmd = 1;
 	return start_command(fastimport);
-- 
1.8.0.rc2.5.gccf4c94
