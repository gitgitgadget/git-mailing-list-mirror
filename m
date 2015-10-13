From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 14/26] mailinfo: move use_scissors and use_inbody_headers to struct mailinfo
Date: Tue, 13 Oct 2015 16:16:35 -0700
Message-ID: <1444778207-859-15-git-send-email-gitster@pobox.com>
References: <1444778207-859-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 14 01:17:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zm8pC-0006XH-8w
	for gcvg-git-2@plane.gmane.org; Wed, 14 Oct 2015 01:17:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753375AbbJMXRa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Oct 2015 19:17:30 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:34122 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752449AbbJMXRG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Oct 2015 19:17:06 -0400
Received: by pabws5 with SMTP id ws5so3474965pab.1
        for <git@vger.kernel.org>; Tue, 13 Oct 2015 16:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id:in-reply-to:references;
        bh=L4J74Gn9WkAmfj07yBEM8ATBzHVW8Fa5qKr4VJdOefo=;
        b=jgfI7dljx8N6/xZNpxGzCgX2Me9RwzPozuoyjGD7Uw1LleMNeHE9fJeMAQWhBY27X/
         pY1iF7gSVGJmIiprHzh2hDDokaRzqu4oi53cqtsGmphd+22JxChqfKFWGIDJA2Dh2tg5
         JbbIZeOFHE+kroMQmem1K9kScJ5V9ns7m8718yUxpr4eFqwtY1HfcBDwTGn9gI2Xpwbu
         NTX2O/E7ANnWNeDR6Z6pvSTUACVjvi4FySu9DFz30nx1Lw5mVl9FTdVnowzPv/f39lHG
         WlwpplS803FaKMZUbRw69v4ZoJQy0butRDl3jHtkJEtScUZnsBk01rAPZGYWmiyaIb4E
         1Q+Q==
X-Received: by 10.68.189.69 with SMTP id gg5mr43930pbc.118.1444778225955;
        Tue, 13 Oct 2015 16:17:05 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:45f3:915b:d2ba:37bc])
        by smtp.gmail.com with ESMTPSA id w8sm5808791pbs.87.2015.10.13.16.17.05
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 13 Oct 2015 16:17:05 -0700 (PDT)
X-Mailer: git-send-email 2.6.1-320-g86a1181
In-Reply-To: <1444778207-859-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279544>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/mailinfo.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/builtin/mailinfo.c b/builtin/mailinfo.c
index 35e1ab9..5302c03 100644
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
@@ -745,7 +745,7 @@ static int handle_commit_msg(struct mailinfo *mi, struct strbuf *line)
 			return 0;
 	}
 
-	if (use_inbody_headers && mi->header_stage) {
+	if (mi->use_inbody_headers && mi->header_stage) {
 		int is_known_header = check_header(mi, line, s_hdr_data, 0);
 
 		if (mi->header_stage == 2) {
@@ -777,7 +777,7 @@ static int handle_commit_msg(struct mailinfo *mi, struct strbuf *line)
 	if (metainfo_charset)
 		convert_to_utf8(line, charset.buf);
 
-	if (use_scissors && is_scissors_line(line)) {
+	if (mi->use_scissors && is_scissors_line(line)) {
 		int i;
 		if (fseek(cmitmsg, 0L, SEEK_SET))
 			die_errno("Could not rewind output message file");
@@ -1036,12 +1036,14 @@ static int mailinfo(struct mailinfo *mi, const char *msg, const char *patch)
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
@@ -1054,6 +1056,7 @@ static void setup_mailinfo(struct mailinfo *mi)
 	strbuf_init(&mi->name, 0);
 	strbuf_init(&mi->email, 0);
 	mi->header_stage = 1;
+	mi->use_inbody_headers = 1;
 	git_config(git_mailinfo_config, &mi);
 }
 
@@ -1087,11 +1090,11 @@ int cmd_mailinfo(int argc, const char **argv, const char *prefix)
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
