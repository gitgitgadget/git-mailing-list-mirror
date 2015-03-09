From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 2/3] bundle.c: fix memory leak
Date: Mon,  9 Mar 2015 09:58:23 -0700
Message-ID: <1425920304-22360-2-git-send-email-sbeller@google.com>
References: <1425920304-22360-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Mar 09 17:58:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YV10l-00024O-TW
	for gcvg-git-2@plane.gmane.org; Mon, 09 Mar 2015 17:58:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753338AbbCIQ6c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Mar 2015 12:58:32 -0400
Received: from mail-ie0-f171.google.com ([209.85.223.171]:43944 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753251AbbCIQ6a (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Mar 2015 12:58:30 -0400
Received: by iecrp18 with SMTP id rp18so37004987iec.10
        for <git@vger.kernel.org>; Mon, 09 Mar 2015 09:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=h9y8eHVD3EIoZOTxb5lHAyiip/K/qtkFD6KqYiAuIjc=;
        b=mqZb4jVtRYh8Mnub9sl//5A5jhiR3HHYbb26uXxNTAA+1yHcGzHzoPtPFNS6kSDpNc
         hCL6SaGvm13qaCjekIJeF7OFPZ+7c9V+m18CIvfNrn43Lb7pYqJbbncR32Ncrui8y7Mp
         81c4e7gHzpC8g6I6ICpcxX3gtz4dBeYTjOYlH1qFlzfR1QRm2wQVrB2U6NNGFOZ+419A
         BDgLHlHpmOSbwcMGT5P9SVYufg07yZEF6MKeHMYMTDLO3ZRC8tSGC8MLBEdTxHyU4QR6
         Sd14cDPovFtJEPK8FiGqiR/ndBgjHJQVRXQd1rEmKTGjas8YhmWcSTMY/AVBtL2bCHoo
         GHZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=h9y8eHVD3EIoZOTxb5lHAyiip/K/qtkFD6KqYiAuIjc=;
        b=emoXrmPev2lAnGoNYAnbwQy+CojibXLg2ZdiLbteWSPdfPNq6gkeo2jp6OvH39H+Y6
         MYh0eksF/2f/nR0wyBwHhiiajBNGwJaj9+mnfTPi1FkdUid8/t1b05gSsWFkTYUqCezl
         p133JBfftGRRczf12+6iEAC4VE4tXHiJEQEfTtX+Amf0gHMfoG3cLIB9NSEQV6AY4CVo
         caBN+tlwt3ZjzSt4IM8YCDyt2mRQ2R/aZjlq/AzhdFn6sgVGzNZWlzqQ/o3/XNa+Ea+/
         699idOgeoJU37+YrO3gzB7A+IK/qX+QlPKxCNT7PsRAZpy8LDAHV6EfXBdFqm2ztVaw1
         7BGA==
X-Gm-Message-State: ALoCoQm8HxPTBplFFtha9Puzx4rpRDFcK2nbiV/Zsgza6Lwh8Q8GR5T1/b3yExlZqB3k4IiJgGui
X-Received: by 10.107.28.196 with SMTP id c187mr24950126ioc.48.1425920309453;
        Mon, 09 Mar 2015 09:58:29 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:556f:5b0e:5ec6:a1a9])
        by mx.google.com with ESMTPSA id t7sm6413632igz.17.2015.03.09.09.58.28
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 09 Mar 2015 09:58:28 -0700 (PDT)
X-Mailer: git-send-email 2.3.0.81.gc37f363
In-Reply-To: <1425920304-22360-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265178>

The continue statements nearby also have an accompanying free(ref);

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 bundle.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/bundle.c b/bundle.c
index 2e2dbd5..534783d 100644
--- a/bundle.c
+++ b/bundle.c
@@ -342,6 +342,7 @@ static int write_bundle_refs(int bundle_fd, struct rev_info *revs)
 		if (e->item->type == OBJ_TAG &&
 				!is_tag_in_date_range(e->item, revs)) {
 			e->item->flags |= UNINTERESTING;
+			free(ref);
 			continue;
 		}
 
-- 
2.3.0.81.gc37f363
