From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH] fmt-merge-msg: Disallow '--log', 'merge.log' < 0
Date: Sat, 28 Aug 2010 16:05:32 +0530
Message-ID: <1282991734-3368-2-git-send-email-artagnon@gmail.com>
References: <1282991734-3368-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Aug 28 12:40:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OpIpb-0004Mo-Gl
	for gcvg-git-2@lo.gmane.org; Sat, 28 Aug 2010 12:40:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752748Ab0H1KkJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Aug 2010 06:40:09 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:63990 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752095Ab0H1KkI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Aug 2010 06:40:08 -0400
Received: by pzk9 with SMTP id 9so1398513pzk.19
        for <git@vger.kernel.org>; Sat, 28 Aug 2010 03:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=VT/5CaTOODQds/s48+SsyWz29T309M3fJD3ckShkyIU=;
        b=U33AapMqAq82wflx6evbcwRgZVfQFI8ln0HeyRgVGTdtzAAILA4lA45zgy60BUOAFQ
         GKHVwtbFpi0+a1k7if1QnP9mOu6cdi/yC4ThbafNDLNAjPMiTXgbm8fOTgvhU2VKGubd
         Xm0Fp02QErlD95r1OBVKfeyW12Q6KT+LhpxbI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Q/JAJPtgXoqOyt2qm0la1G+qrl/sLQA+iea1xQfKRCpmaLa7l5/UlNDq71D7rWVmyc
         ayYp3q2E2fCt/g9+KGq2tJJAoi2GcjfzeICkZLMc6cAXIKvNNyJeMejMMU8TlPO3Vj5d
         1vkJW4Ndj3pBDNKrr7rOWiNShozA4eEbdhYlQ=
Received: by 10.142.191.12 with SMTP id o12mr2387821wff.10.1282991901255;
        Sat, 28 Aug 2010 03:38:21 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id t11sm5855798wfc.4.2010.08.28.03.38.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 28 Aug 2010 03:38:20 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.409.gdbb11.dirty
In-Reply-To: <1282991734-3368-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154641>

Explicitly check for the case when '--log' or 'merge.log' is passed a
negative integer argument. Handle the case by making it look as if
such an argument was never parsed.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 builtin/fmt-merge-msg.c |    4 +++-
 builtin/merge.c         |    2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index d3b8297..0684179 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -18,7 +18,7 @@ static int fmt_merge_msg_config(const char *key, const char *value, void *cb)
 	if (!strcmp(key, "merge.log") || !strcmp(key, "merge.summary")) {
 		int is_bool;
 		shortlog_len = git_config_bool_or_int(key, value, &is_bool);
-		if (is_bool && shortlog_len)
+		if ((is_bool && shortlog_len) || shortlog_len < 0)
 			shortlog_len = DEFAULT_MERGE_LOG_LEN;
 	}
 	return 0;
@@ -345,6 +345,8 @@ int cmd_fmt_merge_msg(int argc, const char **argv, const char *prefix)
 		write_in_full(STDOUT_FILENO, &nl, 1);
 		return 0;
 	}
+	if (shortlog_len < 0)
+		shortlog_len = DEFAULT_MERGE_LOG_LEN;
 
 	if (inpath && strcmp(inpath, "-")) {
 		in = fopen(inpath, "r");
diff --git a/builtin/merge.c b/builtin/merge.c
index 55dc571..affa197 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -510,7 +510,7 @@ static int git_merge_config(const char *k, const char *v, void *cb)
 	else if (!strcmp(k, "merge.log") || !strcmp(k, "merge.summary")) {
 		int is_bool;
 		shortlog_len = git_config_bool_or_int(k, v, &is_bool);
-		if (is_bool && shortlog_len)
+		if ((is_bool && shortlog_len) || shortlog_len < 0)
 			shortlog_len = DEFAULT_MERGE_LOG_LEN;
 		return 0;
 	} else if (!strcmp(k, "merge.renormalize"))
-- 
1.7.2.2.409.gdbb11.dirty
