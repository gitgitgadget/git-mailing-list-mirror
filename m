From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 18/26] mailinfo: handle_commit_msg() shouldn't be called after finding patchbreak
Date: Tue, 13 Oct 2015 16:16:39 -0700
Message-ID: <1444778207-859-19-git-send-email-gitster@pobox.com>
References: <1444778207-859-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 14 01:17:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zm8pE-0006XH-UU
	for gcvg-git-2@plane.gmane.org; Wed, 14 Oct 2015 01:17:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753389AbbJMXRh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Oct 2015 19:17:37 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:34188 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753296AbbJMXRK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Oct 2015 19:17:10 -0400
Received: by pabws5 with SMTP id ws5so3476601pab.1
        for <git@vger.kernel.org>; Tue, 13 Oct 2015 16:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id:in-reply-to:references;
        bh=955AuB9SFe5SmT0UYQ4P2rxABkqKSBGUa/NSeQd+kcY=;
        b=qRQLFerzJ2cUviFUDdDwswycBqQ1E1admgxGAD/Y3B8B0M1eXBHYaGKv8wfKi9zQmd
         OHTDXDQDugRwIY60E3tlyhLTEAuA6GuYlbLQ1VEJQbtur7Mg4nHskoKBVIkDHdYTbWXi
         HZPknlthNsa02cgahlmm8vqixlm6Dsw7/SecLiMqTFV4keMduOEPs2s3OoPSy6EALm88
         lavOSbbkCYLlFwa9us5DyeddS91vqupPpMZGJn6zhONaKkQiQWSbVwa0U1XYJ1gf7lk5
         YfAfqu25aZOoqcRhgBgAVU2D/CxbMiPBtu2TD14fkjWANLbqnfz2OeuQkWrMQRw2oL8F
         sN1A==
X-Received: by 10.68.226.196 with SMTP id ru4mr43459171pbc.107.1444778230329;
        Tue, 13 Oct 2015 16:17:10 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:45f3:915b:d2ba:37bc])
        by smtp.gmail.com with ESMTPSA id gj10sm5823127pbc.68.2015.10.13.16.17.09
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 13 Oct 2015 16:17:09 -0700 (PDT)
X-Mailer: git-send-email 2.6.1-320-g86a1181
In-Reply-To: <1444778207-859-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279543>

There is a strange "if (!cmitmsg) return 0" at the very beginning of
handle_commit_msg(), but the condition should never trigger,
because:

 * The only place cmitmsg is set to NULL is after this function sees
   a patch break, closes the FILE * to write the commit log message
   and returns 1.  This function returns non-zero only from that
   codepath.

 * The caller of this function, upon seeing a non-zero return,
   increments filter_stage, starts treating the input as patch text
   and will never call handle_commit_msg() again.

Replace it with an assert(!mi->filter_stage).

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/mailinfo.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/builtin/mailinfo.c b/builtin/mailinfo.c
index a51b2c5..256d04a 100644
--- a/builtin/mailinfo.c
+++ b/builtin/mailinfo.c
@@ -731,8 +731,7 @@ static int handle_commit_msg(struct mailinfo *mi, struct strbuf *line)
 	 */
 	int is_empty_line;
 
-	if (!cmitmsg)
-		return 0;
+	assert(!mi->filter_stage);
 
 	is_empty_line = (!line->len || (line->len == 1 && line->buf[0] == '\n'));
 	if (mi->header_stage == 1) {
-- 
2.6.1-320-g86a1181
