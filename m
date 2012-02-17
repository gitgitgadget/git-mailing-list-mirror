From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RFC/PATCH 2/3] remote: reorganize check_pattern_match()
Date: Fri, 17 Feb 2012 21:12:36 +0200
Message-ID: <1329505957-24595-3-git-send-email-felipe.contreras@gmail.com>
References: <1329505957-24595-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 17 20:13:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RyTFl-0001pK-8z
	for gcvg-git-2@plane.gmane.org; Fri, 17 Feb 2012 20:13:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751800Ab2BQTNp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Feb 2012 14:13:45 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:59289 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751510Ab2BQTNm (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 Feb 2012 14:13:42 -0500
Received: by mail-lpp01m010-f46.google.com with SMTP id u2so4133709lag.19
        for <git@vger.kernel.org>; Fri, 17 Feb 2012 11:13:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=HrTjiOZxHAI/ThIHZBxF1Duy9CA5An1JGfAxmyotYug=;
        b=vsMN2najmc8v4N2eY3Sltf9kD1ibORpCX9yaNfSCVUMPFn7QhX8NOpXc9bfKs5Efxc
         uIU6zTcDdIrGiviIHvV07FlEk89IX0AM/2bhJAxkep7J7hT41V/gS0hdyjd1Qh4X7jVS
         sWljhZYGDuKNs2myGmEcxPIaaQAVUKByllmx0=
Received: by 10.112.82.134 with SMTP id i6mr2870559lby.61.1329506021424;
        Fri, 17 Feb 2012 11:13:41 -0800 (PST)
Received: from localhost (a88-113-3-26.elisa-laajakaista.fi. [88.113.3.26])
        by mx.google.com with ESMTPS id w1sm10579974lbq.13.2012.02.17.11.13.40
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 17 Feb 2012 11:13:40 -0800 (PST)
X-Mailer: git-send-email 1.7.9.1
In-Reply-To: <1329505957-24595-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190972>

There's a lot of code that can be consolidated there, and will be useful
for next patches.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 remote.c |   59 ++++++++++++++++++++++++++++++-----------------------------
 1 files changed, 30 insertions(+), 29 deletions(-)

diff --git a/remote.c b/remote.c
index 55d68d1..019aafc 100644
--- a/remote.c
+++ b/remote.c
@@ -1110,10 +1110,11 @@ static int match_explicit_refs(struct ref *src, struct ref *dst,
 	return errs;
 }
 
-static const struct refspec *check_pattern_match(const struct refspec *rs,
-						 int rs_nr,
-						 const struct ref *src)
+static char *check_pattern_match(const struct refspec *rs, int rs_nr, struct ref *ref,
+		int send_mirror, const struct refspec **ret_pat)
 {
+	const struct refspec *pat;
+	char *name;
 	int i;
 	int matching_refs = -1;
 	for (i = 0; i < rs_nr; i++) {
@@ -1123,14 +1124,31 @@ static const struct refspec *check_pattern_match(const struct refspec *rs,
 			continue;
 		}
 
-		if (rs[i].pattern && match_name_with_pattern(rs[i].src, src->name,
-							     NULL, NULL))
-			return rs + i;
+		if (rs[i].pattern) {
+			const char *dst_side = rs[i].dst ? rs[i].dst : rs[i].src;
+			if (match_name_with_pattern(rs[i].src, ref->name, dst_side, &name)) {
+				matching_refs = i;
+				break;
+			}
+		}
 	}
-	if (matching_refs != -1)
-		return rs + matching_refs;
-	else
+	if (matching_refs == -1)
 		return NULL;
+
+	pat = rs + matching_refs;
+	if (pat->matching) {
+		/*
+		 * "matching refs"; traditionally we pushed everything
+		 * including refs outside refs/heads/ hierarchy, but
+		 * that does not make much sense these days.
+		 */
+		if (!send_mirror && prefixcmp(ref->name, "refs/heads/"))
+			return NULL;
+		name = xstrdup(ref->name);
+	}
+	if (ret_pat)
+		*ret_pat = pat;
+	return name;
 }
 
 static struct ref **tail_ref(struct ref **head)
@@ -1171,36 +1189,19 @@ int match_push_refs(struct ref *src, struct ref **dst,
 		struct ref *dst_peer;
 		const struct refspec *pat = NULL;
 		char *dst_name;
+
 		if (ref->peer_ref)
 			continue;
 
-		pat = check_pattern_match(rs, nr_refspec, ref);
-		if (!pat)
+		dst_name = check_pattern_match(rs, nr_refspec, ref, send_mirror, &pat);
+		if (!dst_name)
 			continue;
 
-		if (pat->matching) {
-			/*
-			 * "matching refs"; traditionally we pushed everything
-			 * including refs outside refs/heads/ hierarchy, but
-			 * that does not make much sense these days.
-			 */
-			if (!send_mirror && prefixcmp(ref->name, "refs/heads/"))
-				continue;
-			dst_name = xstrdup(ref->name);
-
-
-		} else {
-			const char *dst_side = pat->dst ? pat->dst : pat->src;
-			if (!match_name_with_pattern(pat->src, ref->name,
-						     dst_side, &dst_name))
-				die("Didn't think it matches any more");
-		}
 		dst_peer = find_ref_by_name(*dst, dst_name);
 		if (dst_peer) {
 			if (dst_peer->peer_ref)
 				/* We're already sending something to this ref. */
 				goto free_name;
-
 		} else {
 			if (pat->matching && !(send_all || send_mirror))
 				/*
-- 
1.7.9.1
