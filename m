From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RFC/PATCH 3/3] push: add 'prune' option
Date: Fri, 17 Feb 2012 21:12:37 +0200
Message-ID: <1329505957-24595-4-git-send-email-felipe.contreras@gmail.com>
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
	id 1RyTFk-0001pK-Jz
	for gcvg-git-2@plane.gmane.org; Fri, 17 Feb 2012 20:13:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751831Ab2BQTNp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Feb 2012 14:13:45 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:55795 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751599Ab2BQTNo (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 Feb 2012 14:13:44 -0500
Received: by mail-lpp01m010-f46.google.com with SMTP id u2so4133732lag.19
        for <git@vger.kernel.org>; Fri, 17 Feb 2012 11:13:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=N87V+7BfNKGErUTm0aI6T/NQ1TP2fzTCjWgSYNDzYGY=;
        b=vrtB3tDZbtIhsCa6LF9AaOQkfSmExfkUvXDlFfPvjykxsogcXm6cV9nAfWuxK0ea3R
         0miZ4CE1ZU7EaBYfYgiHDnH3Wuaf7DZGPeTPZWNEIyKfQofJdT7a8aRL2/7ipLskkDV0
         K8Xf6zSJgT766fPHEgG1yB66R4IBfq03LiG28=
Received: by 10.152.109.193 with SMTP id hu1mr6064987lab.38.1329506023374;
        Fri, 17 Feb 2012 11:13:43 -0800 (PST)
Received: from localhost (a88-113-3-26.elisa-laajakaista.fi. [88.113.3.26])
        by mx.google.com with ESMTPS id z2sm12776766lbk.7.2012.02.17.11.13.42
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 17 Feb 2012 11:13:42 -0800 (PST)
X-Mailer: git-send-email 1.7.9.1
In-Reply-To: <1329505957-24595-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190973>

This will allow us to remove refs from the remote that have been removed
locally.

It's useful to conveniently synchronize all the local branches to
certain remote.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/push.c |    2 ++
 remote.c       |   29 ++++++++++++++++++++++++++---
 remote.h       |    3 ++-
 transport.c    |    2 ++
 transport.h    |    1 +
 5 files changed, 33 insertions(+), 4 deletions(-)

diff --git a/builtin/push.c b/builtin/push.c
index 35cce53..46b99b1 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -261,6 +261,8 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 		OPT_BIT('u', "set-upstream", &flags, "set upstream for git pull/status",
 			TRANSPORT_PUSH_SET_UPSTREAM),
 		OPT_BOOLEAN(0, "progress", &progress, "force progress reporting"),
+		OPT_BIT('p', "prune", &flags, "prune locally removed refs",
+			TRANSPORT_PUSH_PRUNE),
 		OPT_END()
 	};
 
diff --git a/remote.c b/remote.c
index 019aafc..0900bb5 100644
--- a/remote.c
+++ b/remote.c
@@ -1111,7 +1111,7 @@ static int match_explicit_refs(struct ref *src, struct ref *dst,
 }
 
 static char *check_pattern_match(const struct refspec *rs, int rs_nr, struct ref *ref,
-		int send_mirror, const struct refspec **ret_pat)
+		int send_mirror, int dir, const struct refspec **ret_pat)
 {
 	const struct refspec *pat;
 	char *name;
@@ -1126,7 +1126,12 @@ static char *check_pattern_match(const struct refspec *rs, int rs_nr, struct ref
 
 		if (rs[i].pattern) {
 			const char *dst_side = rs[i].dst ? rs[i].dst : rs[i].src;
-			if (match_name_with_pattern(rs[i].src, ref->name, dst_side, &name)) {
+			int match;
+			if (dir == 0)
+				match = match_name_with_pattern(rs[i].src, ref->name, dst_side, &name);
+			else
+				match = match_name_with_pattern(dst_side, ref->name, rs[i].src, &name);
+			if (match) {
 				matching_refs = i;
 				break;
 			}
@@ -1173,6 +1178,7 @@ int match_push_refs(struct ref *src, struct ref **dst,
 	struct refspec *rs;
 	int send_all = flags & MATCH_REFS_ALL;
 	int send_mirror = flags & MATCH_REFS_MIRROR;
+	int send_prune = flags & MATCH_REFS_PRUNE;
 	int errs;
 	static const char *default_refspec[] = { ":", NULL };
 	struct ref *ref, **dst_tail = tail_ref(dst);
@@ -1193,7 +1199,7 @@ int match_push_refs(struct ref *src, struct ref **dst,
 		if (ref->peer_ref)
 			continue;
 
-		dst_name = check_pattern_match(rs, nr_refspec, ref, send_mirror, &pat);
+		dst_name = check_pattern_match(rs, nr_refspec, ref, send_mirror, 0, &pat);
 		if (!dst_name)
 			continue;
 
@@ -1220,6 +1226,23 @@ int match_push_refs(struct ref *src, struct ref **dst,
 	free_name:
 		free(dst_name);
 	}
+	if (send_prune) {
+		/* check for missing refs on the remote */
+		for (ref = *dst; ref; ref = ref->next) {
+			char *src_name;
+
+			if (ref->peer_ref)
+				/* We're already sending something to this ref. */
+				continue;
+
+			src_name = check_pattern_match(rs, nr_refspec, ref, send_mirror, 1, NULL);
+			if (src_name) {
+				if (!find_ref_by_name(src, src_name))
+					ref->peer_ref = try_explicit_object_name("");
+				free(src_name);
+			}
+		}
+	}
 	if (errs)
 		return -1;
 	return 0;
diff --git a/remote.h b/remote.h
index b395598..341142c 100644
--- a/remote.h
+++ b/remote.h
@@ -145,7 +145,8 @@ int branch_merge_matches(struct branch *, int n, const char *);
 enum match_refs_flags {
 	MATCH_REFS_NONE		= 0,
 	MATCH_REFS_ALL 		= (1 << 0),
-	MATCH_REFS_MIRROR	= (1 << 1)
+	MATCH_REFS_MIRROR	= (1 << 1),
+	MATCH_REFS_PRUNE	= (1 << 2),
 };
 
 /* Reporting of tracking info */
diff --git a/transport.c b/transport.c
index cac0c06..c20267c 100644
--- a/transport.c
+++ b/transport.c
@@ -1028,6 +1028,8 @@ int transport_push(struct transport *transport,
 			match_flags |= MATCH_REFS_ALL;
 		if (flags & TRANSPORT_PUSH_MIRROR)
 			match_flags |= MATCH_REFS_MIRROR;
+		if (flags & TRANSPORT_PUSH_PRUNE)
+			match_flags |= MATCH_REFS_PRUNE;
 
 		if (match_push_refs(local_refs, &remote_refs,
 				    refspec_nr, refspec, match_flags)) {
diff --git a/transport.h b/transport.h
index 059b330..5d30328 100644
--- a/transport.h
+++ b/transport.h
@@ -101,6 +101,7 @@ struct transport {
 #define TRANSPORT_PUSH_MIRROR 8
 #define TRANSPORT_PUSH_PORCELAIN 16
 #define TRANSPORT_PUSH_SET_UPSTREAM 32
+#define TRANSPORT_PUSH_PRUNE 64
 #define TRANSPORT_RECURSE_SUBMODULES_CHECK 64
 
 #define TRANSPORT_SUMMARY_WIDTH (2 * DEFAULT_ABBREV + 3)
-- 
1.7.9.1
