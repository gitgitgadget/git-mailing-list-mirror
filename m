From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 13/31] mailinfo: move patch_lines to struct mailinfo
Date: Wed, 14 Oct 2015 13:45:39 -0700
Message-ID: <1444855557-2127-14-git-send-email-gitster@pobox.com>
References: <1444778207-859-1-git-send-email-gitster@pobox.com>
 <1444855557-2127-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 14 22:46:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZmSwl-0001mB-De
	for gcvg-git-2@plane.gmane.org; Wed, 14 Oct 2015 22:46:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932910AbbJNUqh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2015 16:46:37 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:33477 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932412AbbJNUqP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2015 16:46:15 -0400
Received: by pabrc13 with SMTP id rc13so64154776pab.0
        for <git@vger.kernel.org>; Wed, 14 Oct 2015 13:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id:in-reply-to:references;
        bh=FHzrZQlmHvdy893IALtpIJqHeOvm7u689hddfpuHYSk=;
        b=j/CT+jhxg/zTXAINprFrlJB/0kyjKKWiC1HedQZFJD/F48eO1yz98t59bTElPcA5SL
         9KcqbGESUrm6Lxmg8uu0NlQ4ehG5/Lm/UkyWAltQvxdt0gW0y2SfgOjFdHXCZd6Wd4Vb
         JmrR9VVQoKI+zvzwMoZdbdICAyEuUSzXEuE6mPg/VXodqH09AUWSei7lw+S3jAg5kTuo
         vwcrT1uabJRLhNi5cMmsnxXsPEEF6nO+tfP3ViikRpFc/b/qkONkkNAvhhT/r8bIB1p8
         /3ZCX3gSOQwddL0j/l4XHHUf9P/ORM6/tMSfimPe5rHNJoNwc7fCJhWyjJtT5ZvdNMIh
         E0pw==
X-Received: by 10.66.229.8 with SMTP id sm8mr5615768pac.135.1444855575580;
        Wed, 14 Oct 2015 13:46:15 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:7964:41eb:7b4:cd77])
        by smtp.gmail.com with ESMTPSA id st5sm11335232pab.42.2015.10.14.13.46.14
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 14 Oct 2015 13:46:15 -0700 (PDT)
X-Mailer: git-send-email 2.6.1-320-g86a1181
In-Reply-To: <1444855557-2127-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279600>

This one is trivial thanks to previous steps that started passing
the structure throughout the input codepaths.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/mailinfo.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/mailinfo.c b/builtin/mailinfo.c
index 5d2d88a..f451ba4 100644
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
@@ -778,10 +778,10 @@ static int handle_commit_msg(struct mailinfo *mi, struct strbuf *line)
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
@@ -792,7 +792,7 @@ static void handle_filter(struct mailinfo *mi, struct strbuf *line)
 			break;
 		mi->filter_stage++;
 	case 1:
-		handle_patch(line);
+		handle_patch(mi, line);
 		break;
 	}
 }
@@ -944,7 +944,7 @@ static void handle_info(struct mailinfo *mi)
 
 	for (i = 0; header[i]; i++) {
 		/* only print inbody headers if we output a patch file */
-		if (patch_lines && s_hdr_data[i])
+		if (mi->patch_lines && s_hdr_data[i])
 			hdr = s_hdr_data[i];
 		else if (p_hdr_data[i])
 			hdr = p_hdr_data[i];
-- 
2.6.1-320-g86a1181
