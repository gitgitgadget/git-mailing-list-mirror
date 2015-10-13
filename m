From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 12/26] mailinfo: move patch_lines to struct mailinfo
Date: Tue, 13 Oct 2015 16:16:33 -0700
Message-ID: <1444778207-859-13-git-send-email-gitster@pobox.com>
References: <1444778207-859-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 14 01:17:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zm8oz-0006OA-E2
	for gcvg-git-2@plane.gmane.org; Wed, 14 Oct 2015 01:17:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753369AbbJMXR0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Oct 2015 19:17:26 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:34093 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752315AbbJMXRE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Oct 2015 19:17:04 -0400
Received: by pabws5 with SMTP id ws5so3474234pab.1
        for <git@vger.kernel.org>; Tue, 13 Oct 2015 16:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id:in-reply-to:references;
        bh=Faa1hrcYyZ9rtTl5CiVXDgd/u2TIdCFXJtowRzMDlE8=;
        b=hmPiGsvLsJPf3vwSh0doghSwFT6Cbvcf/Pffk6nrDqiemixtmUKOo8d4hI2AzDZkHB
         0WLlC717kcX1hoDRsnBzD9r9e2RjEa14aoZPf/k+MAYrel8ZZmO7qmsHaoCe7qv42V5a
         Y0ePMYZ8RfhzSuWU4FPbPfTvRe+2WFU8i/FedVSJVxh7V/NwpW8Kwvy0wsMupZQC7XS6
         Yng1aRvldzrc3ZJayx9oJd0LTZ3HJKjys4I9ih2nbLNQ254UWnwHUSVqAl5wCe1szfHX
         uM/fI1+3ZfwtIomd+beD7L7Cu0WC/pHQG53ibI21eJsZNBdp4x8gRd6slYxY6TdGH/X7
         nOoA==
X-Received: by 10.68.98.34 with SMTP id ef2mr14515pbb.45.1444778223785;
        Tue, 13 Oct 2015 16:17:03 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:45f3:915b:d2ba:37bc])
        by smtp.gmail.com with ESMTPSA id rk2sm5815520pbc.75.2015.10.13.16.17.03
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 13 Oct 2015 16:17:03 -0700 (PDT)
X-Mailer: git-send-email 2.6.1-320-g86a1181
In-Reply-To: <1444778207-859-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279535>

This one is trivial thanks to previous steps that started passing
the structure throughout the input codepaths.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/mailinfo.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/mailinfo.c b/builtin/mailinfo.c
index 7e39769..163032e 100644
--- a/builtin/mailinfo.c
+++ b/builtin/mailinfo.c
@@ -20,6 +20,7 @@ struct mailinfo {
 	int keep_subject;
 	int keep_non_patch_brackets_in_subject;
 
+	int patch_lines;
 	int filter_stage; /* still reading log or are we copying patch? */
 	int header_stage; /* still checking in-body headers? */
 };
@@ -30,7 +31,6 @@ static enum  {
 } transfer_encoding;
 
 static struct strbuf charset = STRBUF_INIT;
-static int patch_lines;
 
 static struct strbuf **p_hdr_data, **s_hdr_data;
 static int use_scissors;
@@ -807,10 +807,10 @@ static int handle_commit_msg(struct mailinfo *mi, struct strbuf *line)
 	return 0;
 }
 
-static void handle_patch(const struct strbuf *line)
+static void handle_patch(struct mailinfo *mi, const struct strbuf *line)
 {
 	fwrite(line->buf, 1, line->len, patchfile);
-	patch_lines++;
+	mi->patch_lines++;
 }
 
 static void handle_filter(struct mailinfo *mi, struct strbuf *line)
@@ -821,7 +821,7 @@ static void handle_filter(struct mailinfo *mi, struct strbuf *line)
 			break;
 		mi->filter_stage++;
 	case 1:
-		handle_patch(line);
+		handle_patch(mi, line);
 		break;
 	}
 }
@@ -973,7 +973,7 @@ static void handle_info(struct mailinfo *mi)
 
 	for (i = 0; header[i]; i++) {
 		/* only print inbody headers if we output a patch file */
-		if (patch_lines && s_hdr_data[i])
+		if (mi->patch_lines && s_hdr_data[i])
 			hdr = s_hdr_data[i];
 		else if (p_hdr_data[i])
 			hdr = p_hdr_data[i];
-- 
2.6.1-320-g86a1181
