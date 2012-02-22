From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 2/4] remote: reorganize check_pattern_match()
Date: Thu, 23 Feb 2012 00:43:39 +0200
Message-ID: <1329950621-21165-3-git-send-email-felipe.contreras@gmail.com>
References: <1329950621-21165-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 22 23:44:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0Kvj-0006Vf-91
	for gcvg-git-2@plane.gmane.org; Wed, 22 Feb 2012 23:44:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752231Ab2BVWo4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Feb 2012 17:44:56 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:43465 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751461Ab2BVWoz (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Feb 2012 17:44:55 -0500
Received: by mail-lpp01m010-f46.google.com with SMTP id u2so658901lag.19
        for <git@vger.kernel.org>; Wed, 22 Feb 2012 14:44:54 -0800 (PST)
Received-SPF: pass (google.com: domain of felipe.contreras@gmail.com designates 10.112.10.70 as permitted sender) client-ip=10.112.10.70;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of felipe.contreras@gmail.com designates 10.112.10.70 as permitted sender) smtp.mail=felipe.contreras@gmail.com; dkim=pass header.i=felipe.contreras@gmail.com
Received: from mr.google.com ([10.112.10.70])
        by 10.112.10.70 with SMTP id g6mr12038353lbb.0.1329950694482 (num_hops = 1);
        Wed, 22 Feb 2012 14:44:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=d0uU/fH4fC38jB0IWtnFb94ADrZhjAJ/AVvo4VeEab8=;
        b=lntJpZdDsQxEtDUsObxJlkVGVZTlCRQq+iu8WXOQkcYNNdQ+SvGrlAsJvtN/IJKeS1
         UA8oBymuMpO3zaO97bv3eCXaCrd9weWM81CaKcjFXRg4DzwbY3jQw/T7rcJPd1zWgLs3
         NSBf/ZReKaNE9+zxpJEepZsd2CfttxXGzQ1iA=
Received: by 10.112.10.70 with SMTP id g6mr10083447lbb.0.1329950694392;
        Wed, 22 Feb 2012 14:44:54 -0800 (PST)
Received: from localhost (a88-113-3-26.elisa-laajakaista.fi. [88.113.3.26])
        by mx.google.com with ESMTPS id jg7sm33548963lbb.0.2012.02.22.14.44.53
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 22 Feb 2012 14:44:53 -0800 (PST)
X-Mailer: git-send-email 1.7.9.1
In-Reply-To: <1329950621-21165-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191303>

There's a lot of code that can be consolidated there, and will be useful
for next patches.

Right now match_name_with_pattern() is called twice, the first one
without value and result, and the second one with them. Since
check_pattern_match() is only used in one place, we can just reorganize
it to make a single call and fetch the values at the same time.

Since this is a semantic change, also rename the function to
get_ref_match() which actually describes more closely what it's actually
doing now.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 remote.c |   59 ++++++++++++++++++++++++++++++-----------------------------
 1 files changed, 30 insertions(+), 29 deletions(-)

diff --git a/remote.c b/remote.c
index 55d68d1..9d29acc 100644
--- a/remote.c
+++ b/remote.c
@@ -1110,10 +1110,11 @@ static int match_explicit_refs(struct ref *src, struct ref *dst,
 	return errs;
 }
 
-static const struct refspec *check_pattern_match(const struct refspec *rs,
-						 int rs_nr,
-						 const struct ref *src)
+static char *get_ref_match(const struct refspec *rs, int rs_nr, const struct ref *ref,
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
+		dst_name = get_ref_match(rs, nr_refspec, ref, send_mirror, &pat);
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
