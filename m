From: Marius Storm-Olsen <mstormo@gmail.com>
Subject: [PATCH 01/14] Fix non-constant array creation
Date: Fri, 21 Aug 2009 15:30:33 +0200
Message-ID: <6283b3e1775f43c6fc07e5047f9c99acdc27bc8f.1250860247.git.mstormo@gmail.com>
References: <cover.1250860247.git.mstormo@gmail.com>
Cc: msysgit@googlegroups.com, git@vger.kernel.org, lznuaa@gmail.com,
	Marius Storm-Olsen <mstormo@gmail.com>
To: Johannes.Schindelin@gmx.de
X-From: git-owner@vger.kernel.org Fri Aug 21 15:31:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MeUD9-0000V9-EV
	for gcvg-git-2@lo.gmane.org; Fri, 21 Aug 2009 15:31:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932223AbZHUNbI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Aug 2009 09:31:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932220AbZHUNbH
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Aug 2009 09:31:07 -0400
Received: from mail-ew0-f207.google.com ([209.85.219.207]:32856 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932204AbZHUNbF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Aug 2009 09:31:05 -0400
Received: by ewy3 with SMTP id 3so637034ewy.18
        for <git@vger.kernel.org>; Fri, 21 Aug 2009 06:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=x/Zhs09zswQ4Aix38ujvClJrosNWTRSXfz+wi2Btko8=;
        b=a5xcLm448e6RMum1Kfhh46rTR3WqnDdW8VsYqfBbF/000/MS0IABN2FWwdH+Fn4lG6
         RBjR1C0BM3ScKyIxHpQ6XRR8YJOPxsfx2tEpduUe41mn/H615gEmh7QSo5oSt38lW4KQ
         UW/Jf/HH7YuOtde/OMi6QRYP07XK8P+Qcp06A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=uGsyfRWrnGFLgqYuy6YO8+JFsIKaZo2dbxMMZjIjfWewyjncKIWTw1wYnkw4tUvnP0
         7pOhJEP977jW3rFf4gh4yE1lD8yUqgJabij00+V4HRSQkIZ5L9EM3/168UDparjzad4a
         3E7ce0io+ZRhbtazMO/RN78Mcguq+G1ecP3zc=
Received: by 10.210.68.8 with SMTP id q8mr1471708eba.39.1250861465622;
        Fri, 21 Aug 2009 06:31:05 -0700 (PDT)
Received: from localhost.localdomain ([62.70.27.104])
        by mx.google.com with ESMTPS id 10sm4251897eyd.24.2009.08.21.06.31.04
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 21 Aug 2009 06:31:05 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.1.418.g33d56.dirty
In-Reply-To: <cover.1250860247.git.mstormo@gmail.com>
In-Reply-To: <cover.1250860247.git.mstormo@gmail.com>
References: <cover.1250860247.git.mstormo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126709>

MSVC doesn't munge the non-constant expression, so use xmalloc instead.

Signed-off-by: Marius Storm-Olsen <mstormo@gmail.com>
---
 builtin-apply.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/builtin-apply.c b/builtin-apply.c
index ae11b41..0f19965 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -1875,7 +1875,7 @@ static int match_fragment(struct image *img,
 		size_t imgoff = 0;
 		size_t preoff = 0;
 		size_t postlen = postimage->len;
-		size_t imglen[preimage->nr];
+		size_t *imglen = xmalloc(sizeof(size_t) * preimage->nr);
 		for (i = 0; i < preimage->nr; i++) {
 			size_t prelen = preimage->line[i].len;
 
@@ -1901,6 +1901,7 @@ static int match_fragment(struct image *img,
 		memcpy(fixed_buf, img->buf + try, imgoff);
 		for (i = 0; i < preimage->nr; i++)
 			preimage->line[i].len = imglen[i];
+		free(imglen);
 
 		/*
 		 * Update the preimage buffer and the postimage context lines.
-- 
1.6.3.msysgit.0.18.gef407
