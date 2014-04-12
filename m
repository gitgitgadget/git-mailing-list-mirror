From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 2/5] remote-helpers: make recvline return an error
Date: Sat, 12 Apr 2014 15:33:29 -0500
Message-ID: <1397334812-12215-3-git-send-email-felipe.contreras@gmail.com>
References: <1397334812-12215-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 12 22:44:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WZ4mU-0004Oy-Sl
	for gcvg-git-2@plane.gmane.org; Sat, 12 Apr 2014 22:44:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756251AbaDLUnm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Apr 2014 16:43:42 -0400
Received: from mail-oa0-f49.google.com ([209.85.219.49]:47167 "EHLO
	mail-oa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755600AbaDLUnj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Apr 2014 16:43:39 -0400
Received: by mail-oa0-f49.google.com with SMTP id o6so7560700oag.8
        for <git@vger.kernel.org>; Sat, 12 Apr 2014 13:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZsMCKSOf7l5deF3vTJIO+1OEdgYBQhd0BkBnYkL2q7Q=;
        b=u+3p8mQWPiFTrCfeOOLDRa6gOKCOfS4EcZxIdG/bBcrI2dyODAynoNlC2dI46FL2pp
         yJDcBW3FLxGXH82MBFsWNHugbm0dkvW+LQxCGqmh1Xy2K+FpDKRzFYFIfkzEcYWdLVOp
         vJsIGDtf/wA8/6DmPYaOl6qraxPW+xoocaObWkLZTL4MkPFkdMmGQPRcO9IYcKkg+o5V
         SUqq12SNU+3sFHikWR0YXKQWP6TK8seUrQVtGbcprdknPWf3kMHoWk6DcaEJcQ358iWg
         XKBWFTlVh5EaPWGFbyPPJ7h0NeTNMOJN7v+Tk1xFb7BW3gHofScP0poVhkR4rlw1JRBv
         PJuw==
X-Received: by 10.60.162.7 with SMTP id xw7mr26113102oeb.13.1397335418892;
        Sat, 12 Apr 2014 13:43:38 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id wk5sm497888obc.19.2014.04.12.13.43.37
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 Apr 2014 13:43:37 -0700 (PDT)
X-Mailer: git-send-email 1.9.1+fc3.9.gc73078e
In-Reply-To: <1397334812-12215-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246189>

Instead of exiting directly, make it the duty of the caller to do so.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 transport-helper.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/transport-helper.c b/transport-helper.c
index bf329fd..1432a6d 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -58,7 +58,7 @@ static int recvline_fh(FILE *helper, struct strbuf *buffer, const char *name)
 	if (strbuf_getline(buffer, helper, '\n') == EOF) {
 		if (debug)
 			fprintf(stderr, "Debug: Remote helper quit.\n");
-		exit(128);
+		return 1;
 	}
 
 	if (debug)
@@ -157,7 +157,8 @@ static struct child_process *get_helper(struct transport *transport)
 	while (1) {
 		const char *capname;
 		int mandatory = 0;
-		recvline(data, &buf);
+		if (recvline(data, &buf))
+			exit(128);
 
 		if (!*buf.buf)
 			break;
@@ -302,7 +303,8 @@ static int set_helper_option(struct transport *transport,
 	strbuf_addch(&buf, '\n');
 
 	sendline(data, &buf);
-	recvline(data, &buf);
+	if (recvline(data, &buf))
+		exit(128);
 
 	if (!strcmp(buf.buf, "ok"))
 		ret = 0;
@@ -374,7 +376,8 @@ static int fetch_with_fetch(struct transport *transport,
 	sendline(data, &buf);
 
 	while (1) {
-		recvline(data, &buf);
+		if (recvline(data, &buf))
+			exit(128);
 
 		if (starts_with(buf.buf, "lock ")) {
 			const char *name = buf.buf + 5;
@@ -558,7 +561,9 @@ static int process_connect_service(struct transport *transport,
 		goto exit;
 
 	sendline(data, &cmdbuf);
-	recvline_fh(input, &cmdbuf, name);
+	if (recvline_fh(input, &cmdbuf, name))
+		exit(128);
+
 	if (!strcmp(cmdbuf.buf, "")) {
 		data->no_disconnect_req = 1;
 		if (debug)
@@ -736,7 +741,8 @@ static void push_update_refs_status(struct helper_data *data,
 	for (;;) {
 		char *private;
 
-		recvline(data, &buf);
+		if (recvline(data, &buf))
+			exit(128);
 		if (!buf.len)
 			break;
 
@@ -960,7 +966,8 @@ static struct ref *get_refs_list(struct transport *transport, int for_push)
 
 	while (1) {
 		char *eov, *eon;
-		recvline(data, &buf);
+		if (recvline(data, &buf))
+			exit(128);
 
 		if (!*buf.buf)
 			break;
-- 
1.9.1+fc3.9.gc73078e
