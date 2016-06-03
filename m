From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 08/10] refs.c: convert trivial snprintf calls to xsnprintf
Date: Fri,  3 Jun 2016 07:47:22 +0000
Message-ID: <20160603074724.12173-8-gitter.spiros@gmail.com>
References: <20160603074724.12173-1-gitter.spiros@gmail.com>
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 03 09:48:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8jqf-0000YP-IK
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jun 2016 09:48:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752186AbcFCHst (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2016 03:48:49 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36182 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751764AbcFCHsp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jun 2016 03:48:45 -0400
Received: by mail-wm0-f66.google.com with SMTP id a20so9969031wma.3
        for <git@vger.kernel.org>; Fri, 03 Jun 2016 00:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CQI+oaTz1xlrDGcNnxO5dFY7MbWkvow8C+vehYLLdwA=;
        b=vsaR+NwwZY0DjpHtjuXV/KsVE3brs06yf8hhiROFSxucXVLp+bKEbRwQZxX0VTQ3xd
         nyZkgxf/QRSTNRElpPm9EGqHjHevl+SuAlo3MP6wYI75BBBxarXQFjGJi+2S4rcJqXNn
         krq1/XLqgkCaUDL9kVCKh6LPq79iVOhAJZF9UhD2CKmEM1waDDTVmu6oE8nP0KZDp7Hn
         AkyNh2GEFxhYkogIB3DdEczQJM7hBjlPZcbE6MXzKWGkajexW+18BHjC8nu0wPRB1OEO
         8cQbkXQ2v5Wf7xH0axlqttBxu/aJTeKT4zoQ9BeZ4tmfBu/S7hNL5+DeujbISXY+VARU
         JZjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CQI+oaTz1xlrDGcNnxO5dFY7MbWkvow8C+vehYLLdwA=;
        b=ihTQuOaJuiCGyc/5BtAVCPfw2xeo4tv5CgT4g4WtDrM6KzEAxCdw3Os/6EdyE4MFni
         BY7pF/63ptyOv19u0HmkAYazF7GznDUxapMURsNP8YdAZg9aNFScbm1D9t40A4XE6j+D
         Bls/4fYHvGg+eSqNmSHyJqj2bS7b+8QhRu6Ut6ZKCz35qdwW7y7QVLyavL/WEbjvFdR4
         I7UVVR8UNxt/YyuSMP2v7uvjO+MnNnSCKF48rliV3EqtST/JWz1ynzxfOwAwU32CQ5ji
         ecuBiZukasSpdd8gHpl3KJ5OMwf0QzOXDs1ZkpMd8Di4an4+4cL73KpgZwLg5i6wDi0V
         hQ9Q==
X-Gm-Message-State: ALyK8tIcVSgXbOhU2rDGDrJb8eBeLJaXNdApn/EH1e3iWy/W0Q27+m1lPF+GzR7lHuCjBw==
X-Received: by 10.28.85.69 with SMTP id j66mr2590914wmb.91.1464940123664;
        Fri, 03 Jun 2016 00:48:43 -0700 (PDT)
Received: from ubuntu2pinto.pd5x2phgis1evm2itoce0l41ib.ax.internal.cloudapp.net ([23.101.69.192])
        by smtp.gmail.com with ESMTPSA id o10sm4307311wjz.37.2016.06.03.00.48.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 03 Jun 2016 00:48:43 -0700 (PDT)
X-Mailer: git-send-email 2.9.0.rc1.265.geb5d750
In-Reply-To: <20160603074724.12173-1-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296278>

With the commits f2f02675 and 5096d490 we have been converted in some files the call
from snprintf/sprintf/strcpy to xsnprintf. This patch converts the remaining calls
to snprintf with xsnprintf under the following conditions:

- The call to snprintf does not control the outcome of the command
  or the presence of truncation errors.
- A call to snprintf can generate a fatal error, directly or indirectly.

The other few remaining cases in which a call to snprintf can generate a soft error
have not been changed.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 refs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index 87dc82f..c797ea0 100644
--- a/refs.c
+++ b/refs.c
@@ -912,7 +912,7 @@ char *shorten_unambiguous_ref(const char *refname, int strict)
 		for (i = 0; i < nr_rules; i++) {
 			assert(offset < total_len);
 			scanf_fmts[i] = (char *)&scanf_fmts[nr_rules] + offset;
-			offset += snprintf(scanf_fmts[i], total_len - offset,
+			offset += xsnprintf(scanf_fmts[i], total_len - offset,
 					   ref_rev_parse_rules[i], 2, "%s") + 1;
 		}
 	}
-- 
2.9.0.rc1.265.geb5d750
