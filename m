From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 15/31] mailinfo: move use_scissors and use_inbody_headers to struct mailinfo
Date: Wed, 14 Oct 2015 13:45:41 -0700
Message-ID: <1444855557-2127-16-git-send-email-gitster@pobox.com>
References: <1444778207-859-1-git-send-email-gitster@pobox.com>
 <1444855557-2127-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 14 22:47:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZmSxG-0002Kx-CL
	for gcvg-git-2@plane.gmane.org; Wed, 14 Oct 2015 22:47:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932914AbbJNUqj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2015 16:46:39 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:33514 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932447AbbJNUqS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2015 16:46:18 -0400
Received: by pabrc13 with SMTP id rc13so64155659pab.0
        for <git@vger.kernel.org>; Wed, 14 Oct 2015 13:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id:in-reply-to:references;
        bh=xFqt9ellLBtNakfFyqDXXupphwqU9NIbI4UX0PlYaNw=;
        b=A5DLK5yubmAga844KjZK8urtDN6cnOHokePjVKWKHC+wDfWnGKqB6EKmkrk8/iaj6h
         eqhCUPFzIxbDa4nmhaomxShJR9DxtEf+/VqZ2em9KR6DCJsvPAHs2MW9PTIyqUA7GRJj
         +dw62LGlGvhBCNU4K7l8mBZaB8o424UhkomMB07htf/YDwSJ00EXtCeHQkQwJde6BlKB
         U7MMljhFxvkPsHmJWf82shTUwMiz9XUdirqSMFKKC06/iJu3rdQGm/fHY6n1nvwvjE1O
         CfYwm51G5OXxKJ5DerRxC05YKPToXZZuQkKKqPwy+cZ1yN8EepYnlr5glXfTEbkBh344
         J5rg==
X-Received: by 10.68.110.165 with SMTP id ib5mr5687381pbb.58.1444855577991;
        Wed, 14 Oct 2015 13:46:17 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:7964:41eb:7b4:cd77])
        by smtp.gmail.com with ESMTPSA id bo5sm11262262pbb.76.2015.10.14.13.46.17
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 14 Oct 2015 13:46:17 -0700 (PDT)
X-Mailer: git-send-email 2.6.1-320-g86a1181
In-Reply-To: <1444855557-2127-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279607>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/mailinfo.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/builtin/mailinfo.c b/builtin/mailinfo.c
index 6703453..80034a2 100644
--- a/builtin/mailinfo.c
+++ b/builtin/mailinfo.c
@@ -20,6 +20,8 @@ struct mailinfo {
 	int keep_subject;
 	int keep_non_patch_brackets_in_subject;
 	int add_message_id;
+	int use_scissors;
+	int use_inbody_headers; /* defaults to 1 */
 
 	char *message_id;
 	int patch_lines;
@@ -34,8 +36,6 @@ static enum  {
 static struct strbuf charset = STRBUF_INIT;
 
 static struct strbuf **p_hdr_data, **s_hdr_data;
-static int use_scissors;
-static int use_inbody_headers = 1;
 
 #define MAX_HDR_PARSED 10
 #define MAX_BOUNDARIES 5
@@ -734,7 +734,7 @@ static int handle_commit_msg(struct mailinfo *mi, struct strbuf *line)
 			return 0;
 	}
 
-	if (use_inbody_headers && mi->header_stage) {
+	if (mi->use_inbody_headers && mi->header_stage) {
 		mi->header_stage = check_header(mi, line, s_hdr_data, 0);
 		if (mi->header_stage)
 			return 0;
@@ -748,7 +748,7 @@ static int handle_commit_msg(struct mailinfo *mi, struct strbuf *line)
 	if (metainfo_charset)
 		convert_to_utf8(line, charset.buf);
 
-	if (use_scissors && is_scissors_line(line)) {
+	if (mi->use_scissors && is_scissors_line(line)) {
 		int i;
 		if (fseek(cmitmsg, 0L, SEEK_SET))
 			die_errno("Could not rewind output message file");
@@ -1009,12 +1009,14 @@ static int mailinfo(struct mailinfo *mi, const char *msg, const char *patch)
 	return 0;
 }
 
-static int git_mailinfo_config(const char *var, const char *value, void *unused)
+static int git_mailinfo_config(const char *var, const char *value, void *mi_)
 {
+	struct mailinfo *mi = mi_;
+
 	if (!starts_with(var, "mailinfo."))
-		return git_default_config(var, value, unused);
+		return git_default_config(var, value, NULL);
 	if (!strcmp(var, "mailinfo.scissors")) {
-		use_scissors = git_config_bool(var, value);
+		mi->use_scissors = git_config_bool(var, value);
 		return 0;
 	}
 	/* perhaps others here */
@@ -1027,6 +1029,7 @@ static void setup_mailinfo(struct mailinfo *mi)
 	strbuf_init(&mi->name, 0);
 	strbuf_init(&mi->email, 0);
 	mi->header_stage = 1;
+	mi->use_inbody_headers = 1;
 	git_config(git_mailinfo_config, &mi);
 }
 
@@ -1060,11 +1063,11 @@ int cmd_mailinfo(int argc, const char **argv, const char *prefix)
 		else if (starts_with(argv[1], "--encoding="))
 			metainfo_charset = argv[1] + 11;
 		else if (!strcmp(argv[1], "--scissors"))
-			use_scissors = 1;
+			mi.use_scissors = 1;
 		else if (!strcmp(argv[1], "--no-scissors"))
-			use_scissors = 0;
+			mi.use_scissors = 0;
 		else if (!strcmp(argv[1], "--no-inbody-headers"))
-			use_inbody_headers = 0;
+			mi.use_inbody_headers = 0;
 		else
 			usage(mailinfo_usage);
 		argc--; argv++;
-- 
2.6.1-320-g86a1181
