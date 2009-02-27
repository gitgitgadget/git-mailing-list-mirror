From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH 07a/21] remote: make copy_ref() perform a deep copy
Date: Fri, 27 Feb 2009 14:10:04 -0500
Message-ID: <45e13cde37f6da8e6c379b5deea81b00148b4355.1235759631.git.jaysoffian@gmail.com>
References: <cover.1235759631.git.jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jay Soffian <jaysoffian@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 27 20:11:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ld87g-0000L0-B8
	for gcvg-git-2@gmane.org; Fri, 27 Feb 2009 20:11:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756431AbZB0TKQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Feb 2009 14:10:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756057AbZB0TKP
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Feb 2009 14:10:15 -0500
Received: from qw-out-2122.google.com ([74.125.92.27]:43671 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754646AbZB0TKN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Feb 2009 14:10:13 -0500
Received: by qw-out-2122.google.com with SMTP id 5so2090607qwi.37
        for <git@vger.kernel.org>; Fri, 27 Feb 2009 11:10:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references
         :references:mime-version:content-type:content-transfer-encoding;
        bh=fpWh/E0cblKdupHuWgx80lXpAv42oyQcJOsaDKkidI8=;
        b=qGMyIevXsfuTBqC2oJkGub7A1iV08Pw7vWU2OmRlRudxhUYnSXyKMAZgNropoMv3GF
         TceTkWMdov8nAMPuMVV6Ae/g4yROlZixjwHckgEc3fB1HNqm4BT2riYGNv0cHpscCWzh
         Ju8/NsRwHhsIj5gbXWKVralh/C5Kyw1Ea7Byo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=W1DUluAMp/MwIB8hVMvVk54WOJpnEhDxTX27NBH1apPwrVSdV0qUUUgpyG87LRFCl7
         FEzAqD7NyLmJxqIIYsOdRnhWVI5pESv00MjAxnxEOq1sf9rTMqnykPQzFwCSqsWiC1sz
         SujQZab9QIfFubzs9XXreyO3kp8YY0B5bs5ZA=
Received: by 10.224.74.83 with SMTP id t19mr4608001qaj.334.1235761812151;
        Fri, 27 Feb 2009 11:10:12 -0800 (PST)
Received: from localhost (cpe-075-182-093-216.nc.res.rr.com [75.182.93.216])
        by mx.google.com with ESMTPS id 4sm505628qwe.55.2009.02.27.11.10.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 27 Feb 2009 11:10:11 -0800 (PST)
X-Mailer: git-send-email 1.6.2.rc1.309.g5f417
In-Reply-To: <cover.1235759631.git.jaysoffian@gmail.com>
In-Reply-To: <cover.1235759631.git.jaysoffian@gmail.com>
References: <cover.1235759631.git.jaysoffian@gmail.com>
References: <cover.1235546707.git.jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111695>

To ensure that copied refs can always be freed w/o causing a
double-free, make copy_ref() perform a deep copy.

Also have copy_ref() return NULL if asked to copy NULL to simplify
things for the caller.

Background: currently copy_ref() performs a shallow copy. This is fine
for current callers who never free the result and/or only copy refs
which contain NULL pointers. But copy_ref() is about to gain a new
caller (guess_remote_head()) which copies refs where peer_ref is not
NULL and the caller of guess_remote_head() will want to free the result.

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
This is a new patch, which should come after 07/21 in the original
series - http://article.gmane.org/gmane.comp.version-control.git/111394

 remote.c |   18 +++++++++++++-----
 1 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/remote.c b/remote.c
index aed760e..22203ea 100644
--- a/remote.c
+++ b/remote.c
@@ -779,10 +779,18 @@ struct ref *alloc_ref(const char *name)
 
 static struct ref *copy_ref(const struct ref *ref)
 {
-	struct ref *ret = xmalloc(sizeof(struct ref) + strlen(ref->name) + 1);
-	memcpy(ret, ref, sizeof(struct ref) + strlen(ref->name) + 1);
-	ret->next = NULL;
-	return ret;
+	struct ref *cpy;
+	size_t len;
+	if (!ref)
+		return NULL;
+	len = strlen(ref->name);
+	cpy = xmalloc(sizeof(struct ref) + len + 1);
+	memcpy(cpy, ref, sizeof(struct ref) + len + 1);
+	cpy->next = NULL;
+	cpy->symref = ref->symref ? xstrdup(ref->symref) : NULL;
+	cpy->remote_status = ref->remote_status ? xstrdup(ref->remote_status) : NULL;
+	cpy->peer_ref = copy_ref(ref->peer_ref);
+	return cpy;
 }
 
 struct ref *copy_ref_list(const struct ref *ref)
@@ -801,6 +809,7 @@ static void free_ref(struct ref *ref)
 {
 	if (!ref)
 		return;
+	free_ref(ref->peer_ref);
 	free(ref->remote_status);
 	free(ref->symref);
 	free(ref);
@@ -811,7 +820,6 @@ void free_refs(struct ref *ref)
 	struct ref *next;
 	while (ref) {
 		next = ref->next;
-		free(ref->peer_ref);
 		free_ref(ref);
 		ref = next;
 	}
-- 
1.6.2.rc1.309.g5f417
