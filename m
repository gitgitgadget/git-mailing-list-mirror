From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 4/4] push: add 'prune' option
Date: Thu, 23 Feb 2012 00:43:41 +0200
Message-ID: <1329950621-21165-5-git-send-email-felipe.contreras@gmail.com>
References: <1329950621-21165-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 22 23:45:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0Kvv-0006f5-9q
	for gcvg-git-2@plane.gmane.org; Wed, 22 Feb 2012 23:45:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752304Ab2BVWpA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Feb 2012 17:45:00 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:43465 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752265Ab2BVWo6 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Feb 2012 17:44:58 -0500
Received: by mail-lpp01m010-f46.google.com with SMTP id u2so658901lag.19
        for <git@vger.kernel.org>; Wed, 22 Feb 2012 14:44:57 -0800 (PST)
Received-SPF: pass (google.com: domain of felipe.contreras@gmail.com designates 10.152.132.104 as permitted sender) client-ip=10.152.132.104;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of felipe.contreras@gmail.com designates 10.152.132.104 as permitted sender) smtp.mail=felipe.contreras@gmail.com; dkim=pass header.i=felipe.contreras@gmail.com
Received: from mr.google.com ([10.152.132.104])
        by 10.152.132.104 with SMTP id ot8mr24807811lab.17.1329950697771 (num_hops = 1);
        Wed, 22 Feb 2012 14:44:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=czPSHD0IAxZUE3hot1/IOEw+DW4ZLvLb0G/oEyGJ+v4=;
        b=pwC4sPLFB6ga3HL7iC/m0WGGkJu9dDF/nfSHcUTsRpWzb0+pdfxhI+J6xn6WmINDKZ
         zV0NCYLES4dGUnJKx+5mXBri+Lf2E55YCHpp1a2cCUykHirHVY//GpC2VwHPHha7eq/E
         4Og98fZjlsFeLsO7xykdYeBjR6ca9XFsN3M8M=
Received: by 10.152.132.104 with SMTP id ot8mr20800880lab.17.1329950697719;
        Wed, 22 Feb 2012 14:44:57 -0800 (PST)
Received: from localhost (a88-113-3-26.elisa-laajakaista.fi. [88.113.3.26])
        by mx.google.com with ESMTPS id fl2sm33527157lbb.4.2012.02.22.14.44.56
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 22 Feb 2012 14:44:57 -0800 (PST)
X-Mailer: git-send-email 1.7.9.1
In-Reply-To: <1329950621-21165-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191306>

This will allow us to remove refs from the remote that have been removed
locally.

It's useful to conveniently synchronize all the local branches to
certain remote.

Unfortunately, if we want to handle src:dst refspecs properly, some
extra complexity is needed, so check_pattern_match() needs to be
reorganized (previous patch).

This ensures that the following works:

 $ git push --prune remote refs/heads/*:refs/tmp/*

So that local branches are not only pushed as custom refs in the remote,
but also refs/tmp/foo would be removed if there's no corresponding local
refs/heads/foo.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/git-push.txt |    9 ++++++++-
 builtin/push.c             |    2 ++
 remote.c                   |   31 ++++++++++++++++++++++++++++---
 remote.h                   |    3 ++-
 t/t5516-fetch-push.sh      |   16 ++++++++++++++++
 transport.c                |    2 ++
 transport.h                |    1 +
 7 files changed, 59 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index aede488..204f36d 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git push' [--all | --mirror | --tags] [-n | --dry-run] [--receive-pack=<git-receive-pack>]
-	   [--repo=<repository>] [-f | --force] [-v | --verbose] [-u | --set-upstream]
+	   [--repo=<repository>] [-f | --force] [--prune] [-v | --verbose] [-u | --set-upstream]
 	   [<repository> [<refspec>...]]
 
 DESCRIPTION
@@ -71,6 +71,13 @@ nor in any Push line of the corresponding remotes file---see below).
 	Instead of naming each ref to push, specifies that all
 	refs under `refs/heads/` be pushed.
 
+--prune::
+	Remove remote branches that don't have a local counterpart. For example
+	a remote branch `tmp` will be removed if a local branch with the same
+	name doesn't exist any more. This also respects refspecs, e.g.
+	`refs/heads/*:refs/tmp/*` would make sure that remote `refs/tmp/foo`
+	will be removed if `refs/heads/foo` doesn't exist.
+
 --mirror::
 	Instead of naming each ref to push, specifies that all
 	refs under `refs/` (which includes but is not
diff --git a/builtin/push.c b/builtin/push.c
index 35cce53..fdfb2c4 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -261,6 +261,8 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 		OPT_BIT('u', "set-upstream", &flags, "set upstream for git pull/status",
 			TRANSPORT_PUSH_SET_UPSTREAM),
 		OPT_BOOLEAN(0, "progress", &progress, "force progress reporting"),
+		OPT_BIT(0, "prune", &flags, "prune locally removed refs",
+			TRANSPORT_PUSH_PRUNE),
 		OPT_END()
 	};
 
diff --git a/remote.c b/remote.c
index 4709e20..9c590ae 100644
--- a/remote.c
+++ b/remote.c
@@ -8,6 +8,8 @@
 #include "tag.h"
 #include "string-list.h"
 
+enum map_direction { FROM_SRC, FROM_DST };
+
 static struct refspec s_tag_refspec = {
 	0,
 	1,
@@ -1115,7 +1117,7 @@ static int match_explicit_refs(struct ref *src, struct ref *dst,
 }
 
 static char *get_ref_match(const struct refspec *rs, int rs_nr, const struct ref *ref,
-		int send_mirror, const struct refspec **ret_pat)
+		int send_mirror, int direction, const struct refspec **ret_pat)
 {
 	const struct refspec *pat;
 	char *name;
@@ -1130,7 +1132,12 @@ static char *get_ref_match(const struct refspec *rs, int rs_nr, const struct ref
 
 		if (rs[i].pattern) {
 			const char *dst_side = rs[i].dst ? rs[i].dst : rs[i].src;
-			if (match_name_with_pattern(rs[i].src, ref->name, dst_side, &name)) {
+			int match;
+			if (direction == FROM_SRC)
+				match = match_name_with_pattern(rs[i].src, ref->name, dst_side, &name);
+			else
+				match = match_name_with_pattern(dst_side, ref->name, rs[i].src, &name);
+			if (match) {
 				matching_refs = i;
 				break;
 			}
@@ -1177,6 +1184,7 @@ int match_push_refs(struct ref *src, struct ref **dst,
 	struct refspec *rs;
 	int send_all = flags & MATCH_REFS_ALL;
 	int send_mirror = flags & MATCH_REFS_MIRROR;
+	int send_prune = flags & MATCH_REFS_PRUNE;
 	int errs;
 	static const char *default_refspec[] = { ":", NULL };
 	struct ref *ref, **dst_tail = tail_ref(dst);
@@ -1197,7 +1205,7 @@ int match_push_refs(struct ref *src, struct ref **dst,
 		if (ref->peer_ref)
 			continue;
 
-		dst_name = get_ref_match(rs, nr_refspec, ref, send_mirror, &pat);
+		dst_name = get_ref_match(rs, nr_refspec, ref, send_mirror, FROM_SRC, &pat);
 		if (!dst_name)
 			continue;
 
@@ -1224,6 +1232,23 @@ int match_push_refs(struct ref *src, struct ref **dst,
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
+			src_name = get_ref_match(rs, nr_refspec, ref, send_mirror, FROM_DST, NULL);
+			if (src_name) {
+				if (!find_ref_by_name(src, src_name))
+					ref->peer_ref = alloc_delete_ref();
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
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index b69cf57..b5417cc 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -979,4 +979,20 @@ test_expect_success 'push --porcelain --dry-run rejected' '
 	test_cmp .git/foo .git/bar
 '
 
+test_expect_success 'push --prune' '
+	mk_test heads/master heads/second heads/foo heads/bar &&
+	git push --prune testrepo &&
+	check_push_result $the_commit heads/master &&
+	check_push_result $the_first_commit heads/second &&
+	! check_push_result $the_first_commit heads/foo heads/bar
+'
+
+test_expect_success 'push --prune refspec' '
+	mk_test tmp/master tmp/second tmp/foo tmp/bar &&
+	git push --prune testrepo "refs/heads/*:refs/tmp/*" &&
+	check_push_result $the_commit tmp/master &&
+	check_push_result $the_first_commit tmp/second &&
+	! check_push_result $the_first_commit tmp/foo tmp/bar
+'
+
 test_done
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
index 059b330..ce99ef8 100644
--- a/transport.h
+++ b/transport.h
@@ -102,6 +102,7 @@ struct transport {
 #define TRANSPORT_PUSH_PORCELAIN 16
 #define TRANSPORT_PUSH_SET_UPSTREAM 32
 #define TRANSPORT_RECURSE_SUBMODULES_CHECK 64
+#define TRANSPORT_PUSH_PRUNE 128
 
 #define TRANSPORT_SUMMARY_WIDTH (2 * DEFAULT_ABBREV + 3)
 
-- 
1.7.9.1
