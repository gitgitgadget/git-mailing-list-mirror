From: Dmitry Ivankov <divanorama@gmail.com>
Subject: [PATCH 1/3] fast-import: die if we produce too many (MAX_PACK_ID) packs
Date: Mon, 19 Sep 2011 01:01:46 +0600
Message-ID: <1316372508-7173-2-git-send-email-divanorama@gmail.com>
References: <1316372508-7173-1-git-send-email-divanorama@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	David Barr <davidbarr@google.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 18 20:55:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R5MWr-0006E5-8v
	for gcvg-git-2@lo.gmane.org; Sun, 18 Sep 2011 20:55:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756550Ab1IRSzj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Sep 2011 14:55:39 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:65049 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755879Ab1IRSzi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Sep 2011 14:55:38 -0400
Received: by wwf22 with SMTP id 22so7083549wwf.1
        for <git@vger.kernel.org>; Sun, 18 Sep 2011 11:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=Rge26MkNprjAlNgSY7iW25YbWyneF5uKFoANBolTjeg=;
        b=TpBCtovvswznVR2YUeke0uCcxliNiUmeJRQhMKo5jOPPPV18ujAC5hV1pRqE0u361I
         dLHcBTzyROriT1+djUNi6LyaAFofglK/JLzKVFYb+8qSFi586PfKlBVyqqJ5/u0yPwOj
         oR6AIOb8IhSIPFEaEhRYawvDNEUnKhQbXCKJg=
Received: by 10.216.163.3 with SMTP id z3mr1801482wek.44.1316372136767;
        Sun, 18 Sep 2011 11:55:36 -0700 (PDT)
Received: from localhost.localdomain (117360277.convex.ru. [79.172.62.237])
        by mx.google.com with ESMTPS id h20sm16877374wbo.22.2011.09.18.11.55.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 18 Sep 2011 11:55:36 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <1316372508-7173-1-git-send-email-divanorama@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181623>

In fast-import pack_id is 16-bit with MAX_PACK_ID reserved to identify
pre-existing objects. It is unlikely to wrap under reasonable settings
but still things in fast-import will break once it happens.

Add a check and immediate die() as the simplest reaction to being unable
to continue the import.

Signed-off-by: Dmitry Ivankov <divanorama@gmail.com>
---
 fast-import.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 742e7da..907cb05 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1009,6 +1009,8 @@ static void end_packfile(void)
 static void cycle_packfile(void)
 {
 	end_packfile();
+	if (pack_id >= MAX_PACK_ID)
+		die("too many (%u) packs produced", pack_id);
 	start_packfile();
 }
 
-- 
1.7.3.4
