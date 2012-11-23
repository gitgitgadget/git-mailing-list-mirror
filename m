From: Chris Rorvick <chris@rorvick.com>
Subject: [PATCH 7/7] push: clarify rejection of update to non-commit-ish
Date: Thu, 22 Nov 2012 22:21:55 -0600
Message-ID: <1353644515-17349-8-git-send-email-chris@rorvick.com>
References: <1353644515-17349-1-git-send-email-chris@rorvick.com>
Cc: Chris Rorvick <chris@rorvick.com>,
	Angelo Borsotti <angelo.borsotti@gmail.com>,
	Drew Northup <n1xim.email@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Philip Oakley <philipoakley@iee.org>,
	Johannes Sixt <j6t@kdbg.org>,
	Kacper Kornet <draenog@pld-linux.org>,
	Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 23 05:23:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tbknx-0001ea-Ec
	for gcvg-git-2@plane.gmane.org; Fri, 23 Nov 2012 05:23:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757600Ab2KWEX0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Nov 2012 23:23:26 -0500
Received: from mail-ie0-f174.google.com ([209.85.223.174]:35469 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755367Ab2KWEXY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Nov 2012 23:23:24 -0500
Received: by mail-ie0-f174.google.com with SMTP id k11so2857476iea.19
        for <git@vger.kernel.org>; Thu, 22 Nov 2012 20:23:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=C/7u6B0kuYBPJSiEitSOIKeXU0oXgzA6WWo6S5Unrkg=;
        b=d8/JiRdcH/Nkw313qYN0MLRsH2hiuGdMGpcGcop/VD+kv6rjqFTOcHhyQKpkDSPIk+
         scHBkYZ115uRZdc257gGxYURE807rhZI7pURKbZjnCme8UkQkg7X4M8XF8LDLpjYq/iK
         TEgR1u3qR869Nr7KYl5rbkMMDkQAh1+sUndHDkEtMVb3jXd/OTGjb86Y7LmAP4d+59Up
         unsLjDrNXSzJwZv79E96dQKox2utHrVwLh67REdlVofKZe3bqdtMIXM12OdXvFKe8huB
         qGTZyEqbO1mStjyrNwTl7aa0Alp2fN/N29IUl7n7D4CLX+qQyIWRn3pP3ch8xN2kBoPJ
         1edg==
Received: by 10.42.118.13 with SMTP id v13mr2116703icq.44.1353644604774;
        Thu, 22 Nov 2012 20:23:24 -0800 (PST)
Received: from marlin.localdomain (adsl-70-131-98-170.dsl.emhril.sbcglobal.net. [70.131.98.170])
        by mx.google.com with ESMTPS id l8sm3909944igo.13.2012.11.22.20.23.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 22 Nov 2012 20:23:24 -0800 (PST)
X-Mailer: git-send-email 1.8.0.209.gf3828dc
In-Reply-To: <1353644515-17349-1-git-send-email-chris@rorvick.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210233>

Pushes must already (by default) update to a commit-ish due the fast-
forward check in set_ref_status_for_push().  But rejecting for not being
a fast-forward suggests the situation can be resolved with a merge.
Flag these updates (i.e., to a blob or a tree) as not forwardable so the
user is presented with more appropriate advice.

Signed-off-by: Chris Rorvick <chris@rorvick.com>
---
 remote.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/remote.c b/remote.c
index f5bc4e7..ee0c1e5 100644
--- a/remote.c
+++ b/remote.c
@@ -1291,6 +1291,11 @@ static inline int is_forwardable(struct ref* ref)
 	if (!o || o->type != OBJ_COMMIT)
 		return 0;
 
+	/* new object must be commit-ish */
+	o = deref_tag(parse_object(ref->new_sha1), NULL, 0);
+	if (!o || o->type != OBJ_COMMIT)
+		return 0;
+
 	return 1;
 }
 
-- 
1.8.0.209.gf3828dc
