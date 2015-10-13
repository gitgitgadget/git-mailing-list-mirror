From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 21/26] mailinfo: keep the parsed log message in a strbuf
Date: Tue, 13 Oct 2015 16:16:42 -0700
Message-ID: <1444778207-859-22-git-send-email-gitster@pobox.com>
References: <1444778207-859-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 14 01:17:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zm8pG-0006XH-LJ
	for gcvg-git-2@plane.gmane.org; Wed, 14 Oct 2015 01:17:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753396AbbJMXRk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Oct 2015 19:17:40 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:34907 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752060AbbJMXRO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Oct 2015 19:17:14 -0400
Received: by padcn9 with SMTP id cn9so3400018pad.2
        for <git@vger.kernel.org>; Tue, 13 Oct 2015 16:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id:in-reply-to:references;
        bh=Jd7Kg5MtrttUHdpur/KgKyfc9Q//6D2nfS7wGQWL0mg=;
        b=ihclkd7NSNaiM4eGoPyyo6Z9FF498twWmFK3lnYCMWWhcDL2qKOS+L1RxJzPME5a4K
         rn2yJ3hK+HRIWTaQutZ78wSD/UrYtUhh+u3lJajr/qJH0Tg9MGly9H3R1vWJrZ/Orfvz
         iN4tLsBvMMDCzdVqdzgoAVHWt9LCcUbbtvHKMQg/LbncMHTPdm7VpFQ7oze+46Mlycjl
         jANa9Bdz2ypMYffz5CpIEU9gl5+EN/tMsQMdlQA29S0U1pFXjzgI7hhRzPoa4z6+j0YY
         ExeTOhQe6SdgXWocoVbSlcBUYnF0capb+NEg+T2lMhJ9LtCBhDx/5+D2SQ5xWFpAVmnB
         sDKw==
X-Received: by 10.68.249.34 with SMTP id yr2mr5720pbc.73.1444778234179;
        Tue, 13 Oct 2015 16:17:14 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:45f3:915b:d2ba:37bc])
        by smtp.gmail.com with ESMTPSA id b7sm5866786pas.31.2015.10.13.16.17.13
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 13 Oct 2015 16:17:13 -0700 (PDT)
X-Mailer: git-send-email 2.6.1-320-g86a1181
In-Reply-To: <1444778207-859-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279542>

When mailinfo() is eventually libified, the calling "git am" still
will have to write out the log message in the "msg" file for hooks
and other users of the information, but at least it does not have to
reopen and reread what was written back if the function kept it in a
strbuf so that the caller can read it from there.

This also removes the need for seeking and truncating the output
file when we see a scissors mark in the input, which in turn reduces
two callsites of die_errno().

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/mailinfo.c | 41 ++++++++++++++++++++++++++++-------------
 1 file changed, 28 insertions(+), 13 deletions(-)

diff --git a/builtin/mailinfo.c b/builtin/mailinfo.c
index c9629c8..d38d716 100644
--- a/builtin/mailinfo.c
+++ b/builtin/mailinfo.c
@@ -10,7 +10,6 @@
 struct mailinfo {
 	FILE *input;
 	FILE *output;
-	FILE *cmitmsg;
 	FILE *patchfile;
 
 	struct strbuf name;
@@ -32,6 +31,8 @@ struct mailinfo {
 	int header_stage; /* still checking in-body headers? */
 	struct strbuf **p_hdr_data;
 	struct strbuf **s_hdr_data;
+
+	struct strbuf log_message;
 };
 
 #define MAX_HDR_PARSED 10
@@ -775,10 +776,8 @@ static int handle_commit_msg(struct mailinfo *mi, struct strbuf *line)
 
 	if (mi->use_scissors && is_scissors_line(line)) {
 		int i;
-		if (fseek(mi->cmitmsg, 0L, SEEK_SET))
-			die_errno("Could not rewind output message file");
-		if (ftruncate(fileno(mi->cmitmsg), 0))
-			die_errno("Could not truncate output message file at scissors");
+
+		strbuf_setlen(&mi->log_message, 0);
 		mi->header_stage = 1;
 
 		/*
@@ -795,13 +794,12 @@ static int handle_commit_msg(struct mailinfo *mi, struct strbuf *line)
 
 	if (patchbreak(line)) {
 		if (mi->message_id)
-			fprintf(mi->cmitmsg, "Message-Id: %s\n", mi->message_id);
-		fclose(mi->cmitmsg);
-		mi->cmitmsg = NULL;
+			strbuf_addf(&mi->log_message,
+				    "Message-Id: %s\n", mi->message_id);
 		return 1;
 	}
 
-	fputs(line->buf, mi->cmitmsg);
+	strbuf_addbuf(&mi->log_message, line);
 	return 0;
 }
 
@@ -999,18 +997,19 @@ static void handle_info(struct mailinfo *mi)
 
 static int mailinfo(struct mailinfo *mi, const char *msg, const char *patch)
 {
+	FILE *cmitmsg;
 	int peek;
 	struct strbuf line = STRBUF_INIT;
 
-	mi->cmitmsg = fopen(msg, "w");
-	if (!mi->cmitmsg) {
+	cmitmsg = fopen(msg, "w");
+	if (!cmitmsg) {
 		perror(msg);
 		return -1;
 	}
 	mi->patchfile = fopen(patch, "w");
 	if (!mi->patchfile) {
 		perror(patch);
-		fclose(mi->cmitmsg);
+		fclose(cmitmsg);
 		return -1;
 	}
 
@@ -1029,6 +1028,9 @@ static int mailinfo(struct mailinfo *mi, const char *msg, const char *patch)
 	handle_body(mi, &line);
 	handle_info(mi);
 
+	fwrite(mi->log_message.buf, 1, mi->log_message.len, cmitmsg);
+	fclose(cmitmsg);
+
 	return 0;
 }
 
@@ -1052,11 +1054,20 @@ static void setup_mailinfo(struct mailinfo *mi)
 	strbuf_init(&mi->name, 0);
 	strbuf_init(&mi->email, 0);
 	strbuf_init(&mi->charset, 0);
+	strbuf_init(&mi->log_message, 0);
 	mi->header_stage = 1;
 	mi->use_inbody_headers = 1;
 	git_config(git_mailinfo_config, &mi);
 }
 
+static void clear_mailinfo(struct mailinfo *mi)
+{
+	strbuf_release(&mi->name);
+	strbuf_release(&mi->email);
+	strbuf_release(&mi->charset);
+	strbuf_release(&mi->log_message);
+}
+
 static const char mailinfo_usage[] =
 	"git mailinfo [-k | -b] [-m | --message-id] [-u | --encoding=<encoding> | -n] [--scissors | --no-scissors] <msg> <patch> < mail >info";
 
@@ -1064,6 +1075,7 @@ int cmd_mailinfo(int argc, const char **argv, const char *prefix)
 {
 	const char *def_charset;
 	struct mailinfo mi;
+	int status;
 
 	/* NEEDSWORK: might want to do the optional .git/ directory
 	 * discovery
@@ -1102,5 +1114,8 @@ int cmd_mailinfo(int argc, const char **argv, const char *prefix)
 
 	mi.input = stdin;
 	mi.output = stdout;
-	return !!mailinfo(&mi, argv[1], argv[2]);
+	status = !!mailinfo(&mi, argv[1], argv[2]);
+	clear_mailinfo(&mi);
+
+	return status;
 }
-- 
2.6.1-320-g86a1181
