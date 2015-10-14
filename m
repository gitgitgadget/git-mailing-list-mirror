From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 22/31] mailinfo: keep the parsed log message in a strbuf
Date: Wed, 14 Oct 2015 13:45:48 -0700
Message-ID: <1444855557-2127-23-git-send-email-gitster@pobox.com>
References: <1444778207-859-1-git-send-email-gitster@pobox.com>
 <1444855557-2127-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 14 22:46:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZmSwm-0001mB-Rp
	for gcvg-git-2@plane.gmane.org; Wed, 14 Oct 2015 22:46:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932935AbbJNUqm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2015 16:46:42 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:34031 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932797AbbJNUq1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2015 16:46:27 -0400
Received: by payp3 with SMTP id p3so16211644pay.1
        for <git@vger.kernel.org>; Wed, 14 Oct 2015 13:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id:in-reply-to:references;
        bh=RfQyw8nUwVqxDHKdF+DSRLsjMBPR1eL3+iNNyxj9CCQ=;
        b=CTqWl7HSyxr8D6vLRn0N/2aTgFA4KxAiFlYptqGG61CHnhfhhvqT8St2FaGOuoDF9e
         rnipDN4C4QdOq2FN3cjhpBDW71WZ1T+am1I69DXX5nTcfP5zrYQgmJKdi3ieYJSqC02Z
         cTxNEpW2dZjEUDYdjjX7wpLsgrW/fjDhaJVWv8yWUy4v9+cISLnwdTQIBSL3bnkVHaFK
         eQ1OSpkQwQ5ax7pxm9uFgUnCp0M7HWaJxS09WkBi7mqh4fPdQ1YZGqyTSAKvHF6mL68G
         XMYH4frneKux6oZGqjeN+Lvn2rrhmekUVmhnFfuPX4Z5AyY35RdrKOBmnujBNTEkssH4
         FkCA==
X-Received: by 10.68.131.6 with SMTP id oi6mr5676102pbb.3.1444855586924;
        Wed, 14 Oct 2015 13:46:26 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:7964:41eb:7b4:cd77])
        by smtp.gmail.com with ESMTPSA id jt1sm1400434pbc.83.2015.10.14.13.46.26
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 14 Oct 2015 13:46:26 -0700 (PDT)
X-Mailer: git-send-email 2.6.1-320-g86a1181
In-Reply-To: <1444855557-2127-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279594>

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
 builtin/mailinfo.c | 40 +++++++++++++++++++++++++++-------------
 1 file changed, 27 insertions(+), 13 deletions(-)

diff --git a/builtin/mailinfo.c b/builtin/mailinfo.c
index aa17c77..72668c9 100644
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
@@ -746,10 +747,8 @@ static int handle_commit_msg(struct mailinfo *mi, struct strbuf *line)
 
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
@@ -766,13 +765,12 @@ static int handle_commit_msg(struct mailinfo *mi, struct strbuf *line)
 
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
 
@@ -970,18 +968,19 @@ static void handle_info(struct mailinfo *mi)
 
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
 
@@ -998,6 +997,8 @@ static int mailinfo(struct mailinfo *mi, const char *msg, const char *patch)
 		check_header(mi, &line, mi->p_hdr_data, 1);
 
 	handle_body(mi, &line);
+	fwrite(mi->log_message.buf, 1, mi->log_message.len, cmitmsg);
+	fclose(cmitmsg);
 	fclose(mi->patchfile);
 
 	handle_info(mi);
@@ -1025,11 +1026,20 @@ static void setup_mailinfo(struct mailinfo *mi)
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
 
@@ -1037,6 +1047,7 @@ int cmd_mailinfo(int argc, const char **argv, const char *prefix)
 {
 	const char *def_charset;
 	struct mailinfo mi;
+	int status;
 
 	/* NEEDSWORK: might want to do the optional .git/ directory
 	 * discovery
@@ -1075,5 +1086,8 @@ int cmd_mailinfo(int argc, const char **argv, const char *prefix)
 
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
