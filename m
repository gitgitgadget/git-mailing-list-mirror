From: =?UTF-8?q?Carlos=20Mart=C3=ADn=20Nieto?= <cmn@elego.de>
Subject: [PATCH 2/2] fetch: honor the user-provided refspecs when pruning refs
Date: Thu,  6 Oct 2011 18:56:27 +0200
Message-ID: <1317920187-17389-3-git-send-email-cmn@elego.de>
References: <20111004103624.GA11863@sigill.intra.peff.net>
 <1317920187-17389-1-git-send-email-cmn@elego.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 06 18:56:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBrFK-0001u3-Ec
	for gcvg-git-2@lo.gmane.org; Thu, 06 Oct 2011 18:56:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965122Ab1JFQ4c convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Oct 2011 12:56:32 -0400
Received: from kimmy.cmartin.tk ([91.121.65.165]:54967 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758662Ab1JFQ42 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Oct 2011 12:56:28 -0400
Received: from centaur.lab.cmartin.tk (brln-4db9e4ec.pool.mediaWays.net [77.185.228.236])
	by kimmy.cmartin.tk (Postfix) with ESMTPA id 0A5C646103
	for <git@vger.kernel.org>; Thu,  6 Oct 2011 18:56:03 +0200 (CEST)
Received: (nullmailer pid 17431 invoked by uid 1000);
	Thu, 06 Oct 2011 16:56:27 -0000
X-Mailer: git-send-email 1.7.5.2.354.g349bf
In-Reply-To: <1317920187-17389-1-git-send-email-cmn@elego.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182980>

If the user gave us refspecs on the command line, we should use those
when deciding whether to prune a ref instead of relying on the
refspecs in the config.

Previously, running

    git fetch --prune origin refs/heads/master:refs/remotes/origin/mast=
er

would delete every other tag under the origin namespace because we
were using the refspec to filter the available refs but using the
configured refspec to figure out if a ref had been deleted on the
remote. This is clearly the wrong thing to do.

Teach get_stale_heads about user-provided refspecs and use them if
they're available.

Signed-off-by: Carlos Mart=C3=ADn Nieto <cmn@elego.de>
---
 builtin/fetch.c  |    6 ++--
 builtin/remote.c |    2 +-
 remote.c         |   74 ++++++++++++++++++++++++++++++++++++++++++++++=
++-----
 remote.h         |    3 +-
 4 files changed, 73 insertions(+), 12 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 30b485e..b937d71 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -505,10 +505,10 @@ static int fetch_refs(struct transport *transport=
, struct ref *ref_map)
 	return ret;
 }
=20
-static int prune_refs(struct transport *transport, struct ref *ref_map=
)
+static int prune_refs(struct transport *transport, struct refspec *ref=
s, int n, struct ref *ref_map)
 {
 	int result =3D 0;
-	struct ref *ref, *stale_refs =3D get_stale_heads(transport->remote, r=
ef_map);
+	struct ref *ref, *stale_refs =3D get_stale_heads(transport->remote, r=
ef_map, refs, n);
 	const char *dangling_msg =3D dry_run
 		? _("   (%s will become dangling)\n")
 		: _("   (%s has become dangling)\n");
@@ -700,7 +700,7 @@ static int do_fetch(struct transport *transport,
 		return 1;
 	}
 	if (prune)
-		prune_refs(transport, ref_map);
+		prune_refs(transport, refs, ref_count, ref_map);
 	free_refs(ref_map);
=20
 	/* if neither --no-tags nor --tags was specified, do automated tag
diff --git a/builtin/remote.c b/builtin/remote.c
index b25dfb4..91a2148 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -349,7 +349,7 @@ static int get_ref_states(const struct ref *remote_=
refs, struct ref_states *stat
 		else
 			string_list_append(&states->tracked, abbrev_branch(ref->name));
 	}
-	stale_refs =3D get_stale_heads(states->remote, fetch_map);
+	stale_refs =3D get_stale_heads(states->remote, fetch_map, NULL, 0);
 	for (ref =3D stale_refs; ref; ref =3D ref->next) {
 		struct string_list_item *item =3D
 			string_list_append(&states->stale, abbrev_branch(ref->name));
diff --git a/remote.c b/remote.c
index 7840d2f..72a26d3 100644
--- a/remote.c
+++ b/remote.c
@@ -1684,26 +1684,84 @@ struct stale_heads_info {
 	struct remote *remote;
 	struct string_list *ref_names;
 	struct ref **stale_refs_tail;
+	struct refspec *refs;
+	int ref_count;
 };
=20
+/*
+ * Find a refspec to a remote's
+ * Returns 0 on success, -1 if it couldn't find a the refspec
+ */
+static int find_in_refs(struct refspec *refs, int ref_count, struct re=
fspec *query)
+{
+	int i;
+	struct refspec *refspec;
+
+	for (i =3D 0; i < ref_count; ++i) {
+		refspec =3D &refs[i];
+
+		/*
+		 * No '*' means that it must match exactly. If it does
+		 * have it, try to match it against the pattern. If
+		 * the refspec matches, store the ref name as it would
+		 * appear in the server in query->src.
+		 */
+		if (!strchr(refspec->dst, '*')) {
+			if (!strcmp(query->dst, refspec->dst)) {
+				query->src =3D xstrdup(refspec->src);
+				return 0;
+			}
+		} else {
+			if (match_name_with_pattern(refspec->dst, query->dst,
+						    refspec->src, &query->src)) {
+				return 0;
+			}
+		}
+	}
+
+	return -1;
+}
+
 static int get_stale_heads_cb(const char *refname,
 	const unsigned char *sha1, int flags, void *cb_data)
 {
 	struct stale_heads_info *info =3D cb_data;
 	struct refspec refspec;
+	int ret;
 	memset(&refspec, 0, sizeof(refspec));
 	refspec.dst =3D (char *)refname;
-	if (!remote_find_tracking(info->remote, &refspec)) {
-		if (!((flags & REF_ISSYMREF) ||
-		    string_list_has_string(info->ref_names, refspec.src))) {
-			struct ref *ref =3D make_linked_ref(refname, &info->stale_refs_tail=
);
-			hashcpy(ref->new_sha1, sha1);
-		}
+
+	/*
+	 * If the user speicified refspecs on the command line, we
+	 * should only use those to check. Otherwise, look in the
+	 * remote's configuration for the branch.
+	 */
+	if (info->ref_count)
+		ret =3D find_in_refs(info->refs, info->ref_count, &refspec);
+	else
+		ret =3D remote_find_tracking(info->remote, &refspec);
+
+	/* No matches */
+	if (ret)
+		return 0;
+
+	/*
+	 * If we did find a suitable refspec and it's not a symref and
+	 * it's not in the list of refs that currently exist in that
+	 * remote we consider it to be stale.
+	 */
+	if (!((flags & REF_ISSYMREF) ||
+	      string_list_has_string(info->ref_names, refspec.src))) {
+		struct ref *ref =3D make_linked_ref(refname, &info->stale_refs_tail)=
;
+		hashcpy(ref->new_sha1, sha1);
 	}
+
+	free(refspec.src);
 	return 0;
 }
=20
-struct ref *get_stale_heads(struct remote *remote, struct ref *fetch_m=
ap)
+struct ref *get_stale_heads(struct remote *remote, struct ref *fetch_m=
ap,
+			    struct refspec *refs, int ref_count)
 {
 	struct ref *ref, *stale_refs =3D NULL;
 	struct string_list ref_names =3D STRING_LIST_INIT_NODUP;
@@ -1711,6 +1769,8 @@ struct ref *get_stale_heads(struct remote *remote=
, struct ref *fetch_map)
 	info.remote =3D remote;
 	info.ref_names =3D &ref_names;
 	info.stale_refs_tail =3D &stale_refs;
+	info.refs =3D refs;
+	info.ref_count =3D ref_count;
 	for (ref =3D fetch_map; ref; ref =3D ref->next)
 		string_list_append(&ref_names, ref->name);
 	sort_string_list(&ref_names);
diff --git a/remote.h b/remote.h
index 9a30a9d..2f753a0 100644
--- a/remote.h
+++ b/remote.h
@@ -164,6 +164,7 @@ struct ref *guess_remote_head(const struct ref *hea=
d,
 			      int all);
=20
 /* Return refs which no longer exist on remote */
-struct ref *get_stale_heads(struct remote *remote, struct ref *fetch_m=
ap);
+struct ref *get_stale_heads(struct remote *remote, struct ref *fetch_m=
ap,
+			    struct refspec *refs, int ref_count);
=20
 #endif
--=20
1.7.5.2.354.g349bf
