From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 17/34] mailinfo: move use_scissors and use_inbody_headers to struct mailinfo
Date: Mon, 19 Oct 2015 00:28:34 -0700
Message-ID: <1445239731-10677-18-git-send-email-gitster@pobox.com>
References: <1444855557-2127-1-git-send-email-gitster@pobox.com>
 <1445239731-10677-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 19 09:30:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zo4tf-0003JK-Fx
	for gcvg-git-2@plane.gmane.org; Mon, 19 Oct 2015 09:30:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752875AbbJSH3Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Oct 2015 03:29:16 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:36329 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750904AbbJSH3O (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Oct 2015 03:29:14 -0400
Received: by pacfv9 with SMTP id fv9so86972867pac.3
        for <git@vger.kernel.org>; Mon, 19 Oct 2015 00:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id:in-reply-to:references;
        bh=xBKDtr7odzw20df+zANkNbzckt6n/XClVSZZfbDfZqk=;
        b=zQeWz22BZRZDTZCG8UxKyx4/S877kEVIdV5hjMYUgjooXBEWtMI/wKCuE6sXRARUyc
         hw8WmMt5I89evFL+sB9Tio2ANZ58PyF2ZMLSuouynDrzL1RtpdfcNNLKr3C1fpRue66h
         z1MQx7ncTGtZru/MTHMNoWBzqsdzcUpL8XJ3Xc6/HMGpQMq8lzO8K4BoxGLWYzg1dBNj
         dpojEcirkOH0g8HU8uoiGAXQxfBO8eUCOvBbU7Qobl0D0Ea51Xfxh6FCUamxY6PX5LxM
         Qa3WYhzVp/MhCiY8NPK3zXEYLqNYwqbQw5hxBZowKvY+WNRaL0cIyOVfTDUam+hDpbBI
         le3w==
X-Received: by 10.68.90.34 with SMTP id bt2mr33201373pbb.145.1445239754508;
        Mon, 19 Oct 2015 00:29:14 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:f5db:ee54:4f5:9373])
        by smtp.gmail.com with ESMTPSA id dn4sm10696725pbd.0.2015.10.19.00.29.13
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 19 Oct 2015 00:29:14 -0700 (PDT)
X-Mailer: git-send-email 2.6.2-388-g10c4a0e
In-Reply-To: <1445239731-10677-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279856>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/mailinfo.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/builtin/mailinfo.c b/builtin/mailinfo.c
index c0522f2..2c8f249 100644
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
 
@@ -1068,11 +1071,11 @@ int cmd_mailinfo(int argc, const char **argv, const char *prefix)
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
2.6.2-383-g144b2e6
