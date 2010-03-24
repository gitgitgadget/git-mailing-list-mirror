From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCH 1/7] fmt-merge-msg: be quiet if nothing to merge
Date: Wed, 24 Mar 2010 00:15:58 -0700
Message-ID: <1269414964-9518-2-git-send-email-bebarino@gmail.com>
References: <1269414964-9518-1-git-send-email-bebarino@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 24 08:16:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NuKpL-0006lG-GS
	for gcvg-git-2@lo.gmane.org; Wed, 24 Mar 2010 08:16:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754881Ab0CXHQT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Mar 2010 03:16:19 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:44767 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754585Ab0CXHQK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Mar 2010 03:16:10 -0400
Received: by mail-gw0-f46.google.com with SMTP id a18so1867821gwa.19
        for <git@vger.kernel.org>; Wed, 24 Mar 2010 00:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=ZsctVl/XT8ef4pFe2Hkp4jIC3FMH5Bg8jf6o2tHS8YI=;
        b=qv4rBY3wLrz+m2nmyOFV7LLNGPiy5es/SgUfWJ/8YtayvGHumcFlNvIogS6dACVDZY
         IxoV/LR/8YiFKSFqAweL5cZOepFc4MkG3zN6A29g1tnwWOpP3Ot+7QX3kbJ6GdGex0DX
         Amx7vZttLoF/A0tFpzmnFh9MLO/M/Y7iI893M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=MCOGOfdS8wJzSRCe5ez4WM6tTDNCo+Z1Cm5RHLOg1Q7bxOYXv5dmJH1JBQ+mlYRg0n
         sOK2JVnz30j49UxmkmThlfWwkh+eoDteNydRT+yYg1z81ybaaStScOmxCKaHjGirKxU2
         3FcE1xO16HYR5hXWpKejNcMihzG8//Y+qXCUY=
Received: by 10.101.205.23 with SMTP id h23mr6763527anq.207.1269414969735;
        Wed, 24 Mar 2010 00:16:09 -0700 (PDT)
Received: from localhost (user-0c9haca.cable.mindspring.com [24.152.169.138])
        by mx.google.com with ESMTPS id 21sm5801535iwn.15.2010.03.24.00.16.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 24 Mar 2010 00:16:09 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.3.254.g4503b
In-Reply-To: <1269414964-9518-1-git-send-email-bebarino@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143068>

When FETCH_HEAD contains only 'not-for-merge' entries fmt-merge-msg
still outputs "Merge" (and if the branch isn't master " into <branch>").
In this case fmt-merge-msg is outputting junk and should really just
be quiet. Fix it.

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---
 builtin/fmt-merge-msg.c  |    3 +++
 t/t6200-fmt-merge-msg.sh |   19 +++++++++++++++++++
 2 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index 9d52400..9bb2625 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -281,6 +281,9 @@ int fmt_merge_msg(int merge_summary, struct strbuf *in, struct strbuf *out) {
 			die ("Error in line %d: %.*s", i, len, p);
 	}
 
+	if (!srcs.nr)
+		return 0;
+
 	strbuf_addstr(out, "Merge ");
 	for (i = 0; i < srcs.nr; i++) {
 		struct src_data *src_data = srcs.payload[i];
diff --git a/t/t6200-fmt-merge-msg.sh b/t/t6200-fmt-merge-msg.sh
index 42f6fff..ade209a 100755
--- a/t/t6200-fmt-merge-msg.sh
+++ b/t/t6200-fmt-merge-msg.sh
@@ -21,6 +21,8 @@ test_expect_success setup '
 	setdate &&
 	git commit -m "Initial" &&
 
+	git clone . remote &&
+
 	echo uno >one &&
 	echo dos >two &&
 	git add two &&
@@ -240,4 +242,21 @@ test_expect_success 'merge-msg -F in subdirectory' '
 	test_cmp expected actual
 '
 
+test_expect_success 'merge-msg with nothing to merge' '
+
+	git config --unset-all merge.log
+	git config --unset-all merge.summary
+	git config merge.summary yes &&
+
+	(
+		cd remote &&
+		git checkout -b unrelated &&
+		setdate &&
+		git fetch origin &&
+		git fmt-merge-msg <.git/FETCH_HEAD >../actual
+	) &&
+
+	test_cmp /dev/null actual
+'
+
 test_done
-- 
1.7.0.3.254.g4503b
