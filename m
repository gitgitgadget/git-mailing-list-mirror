From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RFC/PATCH 1/3] remote: use a local variable in match_push_refs()
Date: Fri, 17 Feb 2012 21:12:35 +0200
Message-ID: <1329505957-24595-2-git-send-email-felipe.contreras@gmail.com>
References: <1329505957-24595-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 17 20:13:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RyTFZ-0001gS-RO
	for gcvg-git-2@plane.gmane.org; Fri, 17 Feb 2012 20:13:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751547Ab2BQTNm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Feb 2012 14:13:42 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:55795 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751222Ab2BQTNl (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 Feb 2012 14:13:41 -0500
Received: by lagu2 with SMTP id u2so4133732lag.19
        for <git@vger.kernel.org>; Fri, 17 Feb 2012 11:13:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=ijRe+fh4hz3JrIpgePiEJVj3z+b7fltKLb0dPJ/LK6c=;
        b=KcSRuPa35VBu0EsiD9aIwH7E6hsrA//bnHSaLTCq+6idgEFYmdG4q/k0C/I7bk08GO
         1zdyMJIdTNkuO/1nnRqO9uBkE3RhECwBQNrPnDk7GZH52d4u2qTqBZ5MGtNOnSVijIez
         fkxkGJ8Aa5YDy2vYfvQ874KdBbYpSwm3X73bQ=
Received: by 10.152.113.136 with SMTP id iy8mr5934411lab.50.1329506019457;
        Fri, 17 Feb 2012 11:13:39 -0800 (PST)
Received: from localhost (a88-113-3-26.elisa-laajakaista.fi. [88.113.3.26])
        by mx.google.com with ESMTPS id o3sm12804193lbn.2.2012.02.17.11.13.38
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 17 Feb 2012 11:13:38 -0800 (PST)
X-Mailer: git-send-email 1.7.9.1
In-Reply-To: <1329505957-24595-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190970>

So that we can reuse src later on.

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
