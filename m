From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 06/15] refs.c: rollback the lockfile before we die() in repack_without_refs
Date: Tue, 21 Oct 2014 13:36:51 -0700
Message-ID: <1413923820-14457-7-git-send-email-sahlberg@google.com>
References: <1413923820-14457-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 21 22:48:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XggMN-0005yg-7m
	for gcvg-git-2@plane.gmane.org; Tue, 21 Oct 2014 22:48:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933464AbaJUUqn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Oct 2014 16:46:43 -0400
Received: from mail-yh0-f73.google.com ([209.85.213.73]:52931 "EHLO
	mail-yh0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933390AbaJUUqj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Oct 2014 16:46:39 -0400
Received: by mail-yh0-f73.google.com with SMTP id i57so203417yha.0
        for <git@vger.kernel.org>; Tue, 21 Oct 2014 13:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=A83VEJy4rmYuCSuZr+5NWIZRZePixjpVrxZ7yqlL38M=;
        b=fLbgWXdmVNEpFj2fe4HLqra+89T2XKo55b9lXrcesATJAWcqBFy6VrUWPn0WwkIw54
         wA8FZRRSUlU/w+utBWff7RUpPdQ/GiWzJayKSAEZlfzTmhiNSywhTrllqIlnjm7Uk6uN
         NJw9mpIpY9JSE1q7T4qUgeR9gSEJPJ3S2A/ANVSbpH6rN7EzjZPHvRnQOhI9r7qbdmMm
         zw+XCon1pIVnezoLhHZG+8ncGlMJR2SIsOP/c+gQ33TpbY+IU+Jz6zAhlBBZwxzoN91L
         hIrABwhc0X7G2d9kDYPdI5IA8gUKEtdNF8MIA5prNpnNnBjCO/bCcPlDxsF84E5FPyTD
         5zYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=A83VEJy4rmYuCSuZr+5NWIZRZePixjpVrxZ7yqlL38M=;
        b=HNyU05u53L6c1Tr8ZR779GlDEzVxYAg7lM6/SWmBe4/FuWu4szcy+l7j/5Uwbck6gw
         noKKxNxaIusY1iew1txuxxMB4/DxjSZ5G6TdLvHXz9MHdaf/p3osVdFhywcZI2UB+xSr
         7fbSqG3UUjLieH6RKwsvEsXZ7VKPHLQ25+4CTzbxVEP9ji09Tdzq8nZ2TpvpxGm06VNb
         yoKlxDRYCP4abZEkOTHHIlHQS9HJpYDP8AfF9+GW7caivfpDVMXD8+dEekPUISkVi0Fp
         zq3wg9L5txgKmDuGx809gwAyt6zAA7ldSfopoFsiWiHsVLz497Zslal0QiQQi8IpWtNK
         meDA==
X-Gm-Message-State: ALoCoQk1/EuMCA1WDYoj3k89LpaUnvKWe+xIaUqsGJHib/JUudgybAu0YC7ov6lel+VZ7Dnc9Vaf
X-Received: by 10.236.53.130 with SMTP id g2mr24205082yhc.31.1413924399144;
        Tue, 21 Oct 2014 13:46:39 -0700 (PDT)
Received: from corpmail-nozzle1-2.hot.corp.google.com ([100.108.1.103])
        by gmr-mx.google.com with ESMTPS id s23si597847yhf.0.2014.10.21.13.46.38
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Oct 2014 13:46:39 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com ([172.27.69.52])
	by corpmail-nozzle1-2.hot.corp.google.com with ESMTP id EFqXq87B.1; Tue, 21 Oct 2014 13:46:39 -0700
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id E5362E117F; Tue, 21 Oct 2014 13:37:02 -0700 (PDT)
X-Mailer: git-send-email 2.1.2.738.gd04b95a
In-Reply-To: <1413923820-14457-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

commit 3989c2a763c3b355785d609b3144c7935dffb273 upstream.

Change-Id: I63a22da521ecc8eb60d7a8aaa5af666d2827a599
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 refs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index f43fef4..43df656 100644
--- a/refs.c
+++ b/refs.c
@@ -2702,8 +2702,10 @@ int repack_without_refs(struct string_list *without, struct strbuf *err)
 	/* Remove any other accumulated cruft */
 	do_for_each_entry_in_dir(packed, 0, curate_packed_ref_fn, &refs_to_delete);
 	for_each_string_list_item(ref_to_delete, &refs_to_delete) {
-		if (remove_entry(packed, ref_to_delete->string) == -1)
+		if (remove_entry(packed, ref_to_delete->string) == -1) {
+			rollback_packed_refs();
 			die("internal error");
+		}
 	}
 
 	/* Write what remains */
-- 
2.1.0.rc2.206.gedb03e5
