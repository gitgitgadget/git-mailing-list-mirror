From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v3 05/13] parse_fetch: convert to use struct object_id
Date: Fri,  9 Oct 2015 01:43:51 +0000
Message-ID: <1444355039-186351-6-git-send-email-sandals@crustytoothpaste.net>
References: <1444355039-186351-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 09 03:46:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZkMkv-0001vC-Et
	for gcvg-git-2@plane.gmane.org; Fri, 09 Oct 2015 03:45:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756018AbbJIBpt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Oct 2015 21:45:49 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:58068 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755695AbbJIBpL (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Oct 2015 21:45:11 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 55C292809B;
	Fri,  9 Oct 2015 01:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
	s=default; t=1444355110;
	bh=G+5TZcfbRihtpU4V7L72ZJb/YS14+WllmEuNMnNnkQE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=offvVzcb1aEATAc9Dzq7akpnZqTZ09Ew4s2+YvvR3a9Xyf0SMMfSbk25ZKZZkLTTf
	 9ciQzByPhMLcwm3tGXd59QupCyhL8tMt+1uQVseDGhnoMbhY4ntCBfnWuRdUM0dJBC
	 BKPomCuTkWhx78b8l2mfd1QicuSi5GHSBwqne3hxNgXYUMdzB+sc5JxI2nZK+ouf6d
	 Dkb1FO+9OfMpG9Y5aO00vjfbnh7DqS7vUlMBRWzI0JYVk2E6DaRjjbpxR5jMY2OSA2
	 XLBerSmipES3SGjXru1fePNhT3TQWlda2EWbWhpnD1OBsmSV5ClVFfeRHCZT/ySTO5
	 PR+Nymu0v3OA19GCgEItL7+iT1PmlN1zvi/jvghGt0Ed+8QcyMxcfa8L9e5nFJNh8A
	 3bzmErvK/ALXGMDap81hdqTQVqG2mLJhYrDVeSjmvgrCVGwp90sKOzcRVFUiHb2WCf
	 3DmzZaoxZjwnkV7NxmXh+PLD72AfJamV7rYfCBN3kJw3kGBFTYq
X-Mailer: git-send-email 2.6.1
In-Reply-To: <1444355039-186351-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: -2.5 ALL_TRUSTED,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279293>

Convert the parse_fetch function to use struct object_id.  Remove the
strlen check as get_oid_hex will fail safely on receiving a too-short
NUL-terminated string.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 remote-curl.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/remote-curl.c b/remote-curl.c
index c4b645e5..10160e63 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -806,19 +806,19 @@ static void parse_fetch(struct strbuf *buf)
 		if (skip_prefix(buf->buf, "fetch ", &p)) {
 			const char *name;
 			struct ref *ref;
-			unsigned char old_sha1[20];
+			struct object_id old_oid;
 
-			if (strlen(p) < 40 || get_sha1_hex(p, old_sha1))
+			if (get_oid_hex(p, &old_oid))
 				die("protocol error: expected sha/ref, got %s'", p);
-			if (p[40] == ' ')
-				name = p + 41;
-			else if (!p[40])
+			if (p[GIT_SHA1_HEXSZ] == ' ')
+				name = p + GIT_SHA1_HEXSZ + 1;
+			else if (!p[GIT_SHA1_HEXSZ])
 				name = "";
 			else
 				die("protocol error: expected sha/ref, got %s'", p);
 
 			ref = alloc_ref(name);
-			hashcpy(ref->old_oid.hash, old_sha1);
+			oidcpy(&ref->old_oid, &old_oid);
 
 			*list = ref;
 			list = &ref->next;
-- 
2.6.1
