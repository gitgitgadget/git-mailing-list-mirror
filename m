From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH] i18n: apply: split to fix a partial i18n message
Date: Thu, 31 May 2012 19:20:42 +0800
Message-ID: <1338463242-10618-1-git-send-email-worldhello.net@gmail.com>
Cc: Git List <git@vger.kernel.org>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Jonathan Nieder <jrnieder@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 31 13:22:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sa3SK-0006iH-OJ
	for gcvg-git-2@plane.gmane.org; Thu, 31 May 2012 13:22:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753460Ab2EaLVr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 May 2012 07:21:47 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:32791 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751792Ab2EaLVq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 May 2012 07:21:46 -0400
Received: by pbbrp8 with SMTP id rp8so1326885pbb.19
        for <git@vger.kernel.org>; Thu, 31 May 2012 04:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=KmbsoMksVJa59+tncOlW6WiRhkc4ZZ/nfIr59t5TzLY=;
        b=Xixwbz6jrcWgV1nt1Wk5kNgRw7M4O7C2hlBnp1jIeYOLpwdXTJaZkcZMbgR+JW0BKi
         c10ym7AeaaLwq0hxz3I8/IoSC5BogelKodaXzHErjNzOowls1vBeng62NLLEmjGesayf
         4nsbrM4+kwbDFV45LHASEaAnEdUBl/0dWxo509cOaLN7IecIaIDcCpbVKiPu/M08KYU8
         qI0njJgrapJ59Hh5FJOHyteKik4bsc67WQo/SZqkefUYxmgoT2vBeXAnudgyyZyH9F1e
         qqYlV20WvtLCcYkfn4JDTgpjRhe2FNa0TZ2uACa0Vm6b7KXHY08nJshwHxO18TKKgtzr
         hxeQ==
Received: by 10.68.211.131 with SMTP id nc3mr5766535pbc.4.1338463275523;
        Thu, 31 May 2012 04:21:15 -0700 (PDT)
Received: from localhost.localdomain ([123.116.228.131])
        by mx.google.com with ESMTPS id tk1sm3893934pbc.8.2012.05.31.04.21.09
        (version=SSLv3 cipher=OTHER);
        Thu, 31 May 2012 04:21:14 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.2.559.g0ba0f00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198882>

The 4th arg of "new mode (%o) of %s does not match old mode (%o)%s%s"
is blank string or string " of ". Even mark the string " of " for a
complete i18n, this message is still hard to translate right.

Split it into two slight different messages would make l10n teams happy.

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
---
 builtin/apply.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index dda9ea0..b4428ea 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -3262,10 +3262,18 @@ static int check_patch(struct patch *patch)
 		int same = !strcmp(old_name, new_name);
 		if (!patch->new_mode)
 			patch->new_mode = patch->old_mode;
-		if ((patch->old_mode ^ patch->new_mode) & S_IFMT)
-			return error(_("new mode (%o) of %s does not match old mode (%o)%s%s"),
-				patch->new_mode, new_name, patch->old_mode,
-				same ? "" : " of ", same ? "" : old_name);
+		if ((patch->old_mode ^ patch->new_mode) & S_IFMT) {
+			if (same)
+				return error(_("new mode (%o) of %s does not "
+					       "match old mode (%o)"),
+					patch->new_mode, new_name,
+					patch->old_mode);
+			else
+				return error(_("new mode (%o) of %s does not "
+					       "match old mode (%o) of %s"),
+					patch->new_mode, new_name,
+					patch->old_mode, old_name);
+		}
 	}
 
 	if (apply_data(patch, &st, ce) < 0)
-- 
1.7.10.2.559.g0ba0f00
