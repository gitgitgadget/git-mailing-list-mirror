From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv3 1/6] shallow: fix a memleak
Date: Mon, 30 Mar 2015 18:22:06 -0700
Message-ID: <1427764931-27745-2-git-send-email-sbeller@google.com>
References: <1427764931-27745-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>, sunshine@sunshineco.com,
	pclouds@gmail.com
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 31 03:22:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yckss-0008IG-Fa
	for gcvg-git-2@plane.gmane.org; Tue, 31 Mar 2015 03:22:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754125AbbCaBWU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Mar 2015 21:22:20 -0400
Received: from mail-ig0-f178.google.com ([209.85.213.178]:37476 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754100AbbCaBWP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Mar 2015 21:22:15 -0400
Received: by igcxg11 with SMTP id xg11so5054724igc.0
        for <git@vger.kernel.org>; Mon, 30 Mar 2015 18:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7cPUljnjI33AITLBiX97LGSV9FhzHLMrj1Ag/aNW2IM=;
        b=Qtjjg7noAlgAZmx6WwbwnVj0W5V+zZEhM06kEqaRihvLTG+l1Po8+EKQ0/jh5jKW6w
         +Pt2OyZbxeusNUERB0EEs1a2yfcgmP8skVkxb0p0PEaEF7FkrBtiPOytkGT5FzuWKL9J
         E2TPKCMzN6P7EQCh1kbH5GiSQR5lQJUFIWuiYu9r04O1CNPFoceIrfkH9vCNJc6ggyFg
         Ub4lbW6yTmsziKi5WkA1VtHsofcWjEr31V/8tqawVxaAufOYgjvwqUIY70VhwkmdcMoh
         cRdgSulhxIiAQRR+cdrg4Ct6qojzgsazP2hVDcwINInb1uaN+eR8mlkAnSPhcWwYDDXC
         YlOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7cPUljnjI33AITLBiX97LGSV9FhzHLMrj1Ag/aNW2IM=;
        b=fZlVFl5TueNVDgRaAzBw0uY/Ga0UatnsXh/mIjAph4npizwYVmixgmEc9+ksjmIaOc
         UDCvSJ/QMKhE+0dIi3xVpiGGrq3vTaA4QvAem955BZXErynqAsfiTZZUJw9ngxs3XJxo
         4G3m0e8lMwsVJbyx8UmOTUKXX7oSSnjoALzOLNApN1V0rt9iKqnYi0FugVCmhlJY63Uf
         +yuudfzyDiIcnQi6njZz8KqbDgrtc1vmXJrDvLCjs9i31t2VXvlM7YqIlOw0a+BIBHso
         tgcqFR1iJNtQmvoJaqPfkQ4papGe0yCRK44R9kYgtp2aSXRahIzJ6xO5xqIq3dajZtq8
         hadg==
X-Gm-Message-State: ALoCoQnj/NkQ4AXoBn54LbUvTZ2Jz2+25byv1EHAxmCP7qwwP4FoZ8WuL5MD0m6hTcmiSPRiAFS7
X-Received: by 10.42.47.73 with SMTP id n9mr66162020icf.20.1427764935118;
        Mon, 30 Mar 2015 18:22:15 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:3c88:d48a:4382:4b5])
        by mx.google.com with ESMTPSA id 13sm8646680iok.29.2015.03.30.18.22.14
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 30 Mar 2015 18:22:14 -0700 (PDT)
X-Mailer: git-send-email 2.3.0.81.gc37f363
In-Reply-To: <1427764931-27745-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266500>

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 shallow.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/shallow.c b/shallow.c
index d8bf40a..11d5c4e 100644
--- a/shallow.c
+++ b/shallow.c
@@ -412,11 +412,12 @@ static void paint_down(struct paint_info *info, const unsigned char *sha1,
 	struct commit_list *head = NULL;
 	int bitmap_nr = (info->nr_bits + 31) / 32;
 	int bitmap_size = bitmap_nr * sizeof(uint32_t);
-	uint32_t *tmp = xmalloc(bitmap_size); /* to be freed before return */
-	uint32_t *bitmap = paint_alloc(info);
+	uint32_t *tmp, *bitmap;
 	struct commit *c = lookup_commit_reference_gently(sha1, 1);
 	if (!c)
 		return;
+	tmp = xmalloc(bitmap_size); /* to be freed before return */
+	bitmap = paint_alloc(info);
 	memset(bitmap, 0, bitmap_size);
 	bitmap[id / 32] |= (1 << (id % 32));
 	commit_list_insert(c, &head);
-- 
2.3.0.81.gc37f363
