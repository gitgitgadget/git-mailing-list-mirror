From: Bo Yang <struggleyb.nku@gmail.com>
Subject: [PATCH 1/7] Add a prefix output callback to diff output.
Date: Sat, 15 May 2010 04:02:05 -0700
Message-ID: <1273921331-32702-2-git-send-email-struggleyb.nku@gmail.com>
References: <1273921331-32702-1-git-send-email-struggleyb.nku@gmail.com>
Cc: gitster@pobox.com, trast@student.ethz.ch
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 15 13:02:31 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ODF8U-0007jL-Ba
	for gcvg-git-2@lo.gmane.org; Sat, 15 May 2010 13:02:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754740Ab0EOLCN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 May 2010 07:02:13 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:42018 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754571Ab0EOLCM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 May 2010 07:02:12 -0400
Received: by pvh1 with SMTP id 1so973492pvh.19
        for <git@vger.kernel.org>; Sat, 15 May 2010 04:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=SQtf48JZzun/TcUusy5PxD/svx9ulsqJqbe+83yS/Ac=;
        b=Bqi25XIu4usFT2Q8gmiorVMJhCIgTLxrvOrDbfMsupRWkt6XtfoKV91EOGHg8W9JkZ
         buoKBjnNkOFN1/BI2neFSdWiYZdHpRG5MUVuBs7jgMS89aNRMMU5D3AQDuJCKOENSMqz
         LRlAGlGnTtBvq81/9DW0pmzhoPjOqxDEdfIfk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=HdP1McGCfpkOrBRoLT06/5yJorCwrLfUiQWBHcGfaUtpdOYDuBbRUz4bd2GGWVvwDT
         dp5Z1Igi7jZadRLuCE2nnmqgYDRGVjLpmU8XxzJ0zqDWVhQsfr9fSvECIerVhnYU27KD
         ou7e5CiohjgqISw0QC/WbrfEcTlrzXIsj7mJE=
Received: by 10.114.2.17 with SMTP id 17mr2160871wab.35.1273921331789;
        Sat, 15 May 2010 04:02:11 -0700 (PDT)
Received: from localhost.localdomain ([222.30.37.37])
        by mx.google.com with ESMTPS id d16sm28703988wam.12.2010.05.15.04.02.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 15 May 2010 04:02:10 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.4
In-Reply-To: <1273921331-32702-1-git-send-email-struggleyb.nku@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147141>

The callback allow to output some prefix string for
each line of diff output.

Signed-off-by: Bo Yang <struggleyb.nku@gmail.com>
---
 diff.c |   11 ++++++++---
 diff.h |    5 +++++
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/diff.c b/diff.c
index e49f14a..2a38bef 100644
--- a/diff.c
+++ b/diff.c
@@ -282,11 +282,16 @@ static void check_blank_at_eof(mmfile_t *mf1, mmfile_t *mf2,
 	ecbdata->blank_at_eof_in_postimage = (at - l2) + 1;
 }
 
-static void emit_line_0(FILE *file, const char *set, const char *reset,
+static void emit_line_0(struct diff_options *o, const char *set, const char *reset,
 			int first, const char *line, int len)
 {
 	int has_trailing_newline, has_trailing_carriage_return;
 	int nofirst;
+	FILE *file = o->file;
+
+	if (o->output_prefix) {
+		o->output_prefix(file, 1, o->output_prefix_data);
+	}
 
 	if (len == 0) {
 		has_trailing_newline = (first == '\n');
@@ -316,10 +321,10 @@ static void emit_line_0(FILE *file, const char *set, const char *reset,
 		fputc('\n', file);
 }
 
-static void emit_line(FILE *file, const char *set, const char *reset,
+static void emit_line(struct diff_options *o, const char *set, const char *reset,
 		      const char *line, int len)
 {
-	emit_line_0(file, set, reset, line[0], line+1, len-1);
+	emit_line_0(o, set, reset, line[0], line+1, len-1);
 }
 
 static int new_blank_line_at_eof(struct emit_callback *ecbdata, const char *line, int len)
diff --git a/diff.h b/diff.h
index 6a71013..0031dd8 100644
--- a/diff.h
+++ b/diff.h
@@ -9,6 +9,7 @@
 struct rev_info;
 struct diff_options;
 struct diff_queue_struct;
+struct strbuf;
 
 typedef void (*change_fn_t)(struct diff_options *options,
 		 unsigned old_mode, unsigned new_mode,
@@ -25,6 +26,8 @@ typedef void (*add_remove_fn_t)(struct diff_options *options,
 typedef void (*diff_format_fn_t)(struct diff_queue_struct *q,
 		struct diff_options *options, void *data);
 
+typedef struct strbuf *(*diff_prefix_fn_t)(FILE *file, int print, void *data);
+
 #define DIFF_FORMAT_RAW		0x0001
 #define DIFF_FORMAT_DIFFSTAT	0x0002
 #define DIFF_FORMAT_NUMSTAT	0x0004
@@ -122,6 +125,8 @@ struct diff_options {
 	add_remove_fn_t add_remove;
 	diff_format_fn_t format_callback;
 	void *format_callback_data;
+	diff_prefix_fn_t output_prefix;
+	void *output_prefix_data;
 };
 
 enum color_diff {
-- 
1.7.1.94.gc3269
