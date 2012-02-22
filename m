From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 1/4] remote: use a local variable in match_push_refs()
Date: Thu, 23 Feb 2012 00:43:38 +0200
Message-ID: <1329950621-21165-2-git-send-email-felipe.contreras@gmail.com>
References: <1329950621-21165-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 22 23:45:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0Kvv-0006f5-Tw
	for gcvg-git-2@plane.gmane.org; Wed, 22 Feb 2012 23:45:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752207Ab2BVWoz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Feb 2012 17:44:55 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:51615 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752108Ab2BVWoy (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Feb 2012 17:44:54 -0500
Received: by lagu2 with SMTP id u2so658933lag.19
        for <git@vger.kernel.org>; Wed, 22 Feb 2012 14:44:52 -0800 (PST)
Received-SPF: pass (google.com: domain of felipe.contreras@gmail.com designates 10.152.123.68 as permitted sender) client-ip=10.152.123.68;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of felipe.contreras@gmail.com designates 10.152.123.68 as permitted sender) smtp.mail=felipe.contreras@gmail.com; dkim=pass header.i=felipe.contreras@gmail.com
Received: from mr.google.com ([10.152.123.68])
        by 10.152.123.68 with SMTP id ly4mr24272268lab.13.1329950692924 (num_hops = 1);
        Wed, 22 Feb 2012 14:44:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=Mgc1phEGK21mmcp5mDlnOY9umR15G15Q9az2dyeCq38=;
        b=jxOE0w24fOFgcuoyOHGc1PYd3tjYkOqCoMXDmlXvkEaV7Wm1TOwPZ+ZyWzqu4JHY46
         9gwV1n3KjpzKZxobARW68qCPbRTx7JvLcrBlQgHbbmWDyGjh505O1PaOuMQfLqbspOiu
         OzlbJ9p28qGHmbx1Hhg0fbeGPtjmpzj/VB/uI=
Received: by 10.152.123.68 with SMTP id ly4mr20375004lab.13.1329950692860;
        Wed, 22 Feb 2012 14:44:52 -0800 (PST)
Received: from localhost (a88-113-3-26.elisa-laajakaista.fi. [88.113.3.26])
        by mx.google.com with ESMTPS id mb8sm26277385lab.8.2012.02.22.14.44.51
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 22 Feb 2012 14:44:52 -0800 (PST)
X-Mailer: git-send-email 1.7.9.1
In-Reply-To: <1329950621-21165-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191307>

So that we can reuse src later on. No functional changes.

Will be useful in next patches.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 remote.c |   19 ++++++++++---------
 1 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/remote.c b/remote.c
index 73a3809..55d68d1 100644
--- a/remote.c
+++ b/remote.c
@@ -1157,7 +1157,7 @@ int match_push_refs(struct ref *src, struct ref **dst,
 	int send_mirror = flags & MATCH_REFS_MIRROR;
 	int errs;
 	static const char *default_refspec[] = { ":", NULL };
-	struct ref **dst_tail = tail_ref(dst);
+	struct ref *ref, **dst_tail = tail_ref(dst);
 
 	if (!nr_refspec) {
 		nr_refspec = 1;
@@ -1167,14 +1167,14 @@ int match_push_refs(struct ref *src, struct ref **dst,
 	errs = match_explicit_refs(src, *dst, &dst_tail, rs, nr_refspec);
 
 	/* pick the remainder */
-	for ( ; src; src = src->next) {
+	for (ref = src; ref; ref = ref->next) {
 		struct ref *dst_peer;
 		const struct refspec *pat = NULL;
 		char *dst_name;
-		if (src->peer_ref)
+		if (ref->peer_ref)
 			continue;
 
-		pat = check_pattern_match(rs, nr_refspec, src);
+		pat = check_pattern_match(rs, nr_refspec, ref);
 		if (!pat)
 			continue;
 
@@ -1184,13 +1184,14 @@ int match_push_refs(struct ref *src, struct ref **dst,
 			 * including refs outside refs/heads/ hierarchy, but
 			 * that does not make much sense these days.
 			 */
-			if (!send_mirror && prefixcmp(src->name, "refs/heads/"))
+			if (!send_mirror && prefixcmp(ref->name, "refs/heads/"))
 				continue;
-			dst_name = xstrdup(src->name);
+			dst_name = xstrdup(ref->name);
+
 
 		} else {
 			const char *dst_side = pat->dst ? pat->dst : pat->src;
-			if (!match_name_with_pattern(pat->src, src->name,
+			if (!match_name_with_pattern(pat->src, ref->name,
 						     dst_side, &dst_name))
 				die("Didn't think it matches any more");
 		}
@@ -1211,9 +1212,9 @@ int match_push_refs(struct ref *src, struct ref **dst,
 
 			/* Create a new one and link it */
 			dst_peer = make_linked_ref(dst_name, &dst_tail);
-			hashcpy(dst_peer->new_sha1, src->new_sha1);
+			hashcpy(dst_peer->new_sha1, ref->new_sha1);
 		}
-		dst_peer->peer_ref = copy_ref(src);
+		dst_peer->peer_ref = copy_ref(ref);
 		dst_peer->force = pat->force;
 	free_name:
 		free(dst_name);
-- 
1.7.9.1
