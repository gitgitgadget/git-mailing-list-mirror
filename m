From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 2/2] read-cache: plug a few leaks
Date: Fri,  7 Jun 2013 17:29:28 -0500
Message-ID: <1370644168-4745-3-git-send-email-felipe.contreras@gmail.com>
References: <1370644168-4745-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Adam Spiers <git@adamspiers.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 08 00:31:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ul5Bz-0006R0-52
	for gcvg-git-2@plane.gmane.org; Sat, 08 Jun 2013 00:31:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756916Ab3FGWbZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jun 2013 18:31:25 -0400
Received: from mail-ob0-f179.google.com ([209.85.214.179]:42481 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756762Ab3FGWbY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jun 2013 18:31:24 -0400
Received: by mail-ob0-f179.google.com with SMTP id xk17so7249116obc.24
        for <git@vger.kernel.org>; Fri, 07 Jun 2013 15:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=mU8l4QZgOMkEtrldLSjKHD0GDfjU/CrnwH8CJnxPpZE=;
        b=c/rooRgLn+Zc6/93XQb+dANAhSdoj2xPmI9K4GzZjK4guJRobs1k+wUr2TIeYBzORp
         fCiJcIjT1OZaz+RFGTuszv/2JjpxGoWYxrNs9mYBvd1dkKnXgFHfY6LflsDRzWPkt5XV
         IQBit8AE9kSr1mt+vkhoV3c/I86UqUTVxTp/6+4Wlufi6f1ujfbX/6p0lSO9SoPdJe2/
         2e2JvKJJ1lWHQhQ06iEauibza+/X4guPlSBbo8s/YFxCwdxZlCd5NVXEcfSZoFsJ3zWf
         zTFOknVZ4JB8oc9mqPSehLHDZ9dpW/2GB8nfMM30gcOoASQ2SCf/iRjIS6N+42XDhk9S
         SkBg==
X-Received: by 10.60.93.6 with SMTP id cq6mr476752oeb.108.1370644284310;
        Fri, 07 Jun 2013 15:31:24 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id l4sm1014385obh.7.2013.06.07.15.31.22
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 07 Jun 2013 15:31:23 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.698.g079b096
In-Reply-To: <1370644168-4745-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226758>

We are not freeing 'istate->cache' properly.

We can't rely on 'initialized' to keep track of the 'istate->cache',
because it doesn't really mean it's initialized. So assume it always has
data, and free it before overwriting it.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 read-cache.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/read-cache.c b/read-cache.c
index 5e30746..a1dd04d 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1451,6 +1451,7 @@ int read_index_from(struct index_state *istate, const char *path)
 	istate->version = ntohl(hdr->hdr_version);
 	istate->cache_nr = ntohl(hdr->hdr_entries);
 	istate->cache_alloc = alloc_nr(istate->cache_nr);
+	free(istate->cache);
 	istate->cache = xcalloc(istate->cache_alloc, sizeof(*istate->cache));
 	istate->initialized = 1;
 
@@ -1512,6 +1513,9 @@ int discard_index(struct index_state *istate)
 
 	for (i = 0; i < istate->cache_nr; i++)
 		free(istate->cache[i]);
+	free(istate->cache);
+	istate->cache = NULL;
+	istate->cache_alloc = 0;
 	resolve_undo_clear_index(istate);
 	istate->cache_nr = 0;
 	istate->cache_changed = 0;
-- 
1.8.3.698.g079b096
