From: =?UTF-8?q?Carlos=20Mart=C3=ADn=20Nieto?= <cmn@elego.de>
Subject: [PATCH 4/5] fetch: honor the user-provided refspecs when pruning refs
Date: Sat, 15 Oct 2011 07:04:25 +0200
Message-ID: <1318655066-29001-5-git-send-email-cmn@elego.de>
References: <1318655066-29001-1-git-send-email-cmn@elego.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	mathstuf@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 15 07:04:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1REwQN-0001QL-9M
	for gcvg-git-2@lo.gmane.org; Sat, 15 Oct 2011 07:04:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751631Ab1JOFE3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 15 Oct 2011 01:04:29 -0400
Received: from kimmy.cmartin.tk ([91.121.65.165]:48771 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751363Ab1JOFE1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Oct 2011 01:04:27 -0400
Received: from centaur.lab.cmartin.tk (brln-4dbc6671.pool.mediaWays.net [77.188.102.113])
	by kimmy.cmartin.tk (Postfix) with ESMTPA id A73EC4618D;
	Sat, 15 Oct 2011 07:03:58 +0200 (CEST)
Received: (nullmailer pid 29051 invoked by uid 1000);
	Sat, 15 Oct 2011 05:04:26 -0000
X-Mailer: git-send-email 1.7.5.2.354.g349bf
In-Reply-To: <1318655066-29001-1-git-send-email-cmn@elego.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183636>

If the user gave us refspecs on the command line, we should use those
when deciding whether to prune a ref instead of relying on the
refspecs in the config.

Previously, running

    git fetch --prune origin refs/heads/master:refs/remotes/origin/mast=
er

would delete every other ref under the origin namespace because we
were using the refspec to filter the available refs but using the
configured refspec to figure out if a ref had been deleted on the
remote. This is clearly the wrong thing to do.

Change prune_refs and get_stale_heads to simply accept a list of
references and a list of refspecs. The caller of either function needs
to decide what refspecs should be used to decide whether a ref is
stale.

Signed-off-by: Carlos Mart=C3=ADn Nieto <cmn@elego.de>
---
 builtin/fetch.c  |   12 ++++++++----
 builtin/remote.c |    3 ++-
 remote.c         |   36 ++++++++++++++++++++++++------------
 remote.h         |    2 +-
 t/t5510-fetch.sh |    4 ++--
 5 files changed, 37 insertions(+), 20 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 605d1bf..e295d97 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -540,10 +540,10 @@ static int fetch_refs(struct transport *transport=
, struct ref *ref_map)
 	return ret;
 }
=20
-static int prune_refs(struct transport *transport, struct ref *ref_map=
)
+static int prune_refs(struct refspec *refs, int ref_count, struct ref =
*ref_map)
 {
 	int result =3D 0;
-	struct ref *ref, *stale_refs =3D get_stale_heads(transport->remote, r=
ef_map);
+	struct ref *ref, *stale_refs =3D get_stale_heads(refs, ref_count, ref=
_map);
 	const char *dangling_msg =3D dry_run
 		? _("   (%s will become dangling)\n")
 		: _("   (%s has become dangling)\n");
@@ -734,8 +734,12 @@ static int do_fetch(struct transport *transport,
 		free_refs(ref_map);
 		return 1;
 	}
-	if (prune)
-		prune_refs(transport, ref_map);
+	if (prune) {
+		if (ref_count)
+			prune_refs(refs, ref_count, ref_map);
+		else
+			prune_refs(transport->remote->fetch, transport->remote->fetch_refsp=
ec_nr, ref_map);
+	}
 	free_refs(ref_map);
=20
 	/* if neither --no-tags nor --tags was specified, do automated tag
diff --git a/builtin/remote.c b/builtin/remote.c
index f2a9c26..de52367 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -349,7 +349,8 @@ static int get_ref_states(const struct ref *remote_=
refs, struct ref_states *stat
 		else
 			string_list_append(&states->tracked, abbrev_branch(ref->name));
 	}
-	stale_refs =3D get_stale_heads(states->remote, fetch_map);
+	stale_refs =3D get_stale_heads(states->remote->fetch,
+				     states->remote->fetch_refspec_nr, fetch_map);
 	for (ref =3D stale_refs; ref; ref =3D ref->next) {
 		struct string_list_item *item =3D
 			string_list_append(&states->stale, abbrev_branch(ref->name));
diff --git a/remote.c b/remote.c
index e94c6d2..069b1ff 100644
--- a/remote.c
+++ b/remote.c
@@ -1679,36 +1679,48 @@ struct ref *guess_remote_head(const struct ref =
*head,
 }
=20
 struct stale_heads_info {
-	struct remote *remote;
 	struct string_list *ref_names;
 	struct ref **stale_refs_tail;
+	struct refspec *refs;
+	int ref_count;
 };
=20
 static int get_stale_heads_cb(const char *refname,
 	const unsigned char *sha1, int flags, void *cb_data)
 {
 	struct stale_heads_info *info =3D cb_data;
-	struct refspec refspec;
-	memset(&refspec, 0, sizeof(refspec));
-	refspec.dst =3D (char *)refname;
-	if (!remote_find_tracking(info->remote, &refspec)) {
-		if (!((flags & REF_ISSYMREF) ||
-		    string_list_has_string(info->ref_names, refspec.src))) {
-			struct ref *ref =3D make_linked_ref(refname, &info->stale_refs_tail=
);
-			hashcpy(ref->new_sha1, sha1);
-		}
+	struct refspec query;
+	memset(&query, 0, sizeof(struct refspec));
+	query.dst =3D (char *)refname;
+
+	if (query_refspecs(info->refs, info->ref_count, &query))
+	    return 0; /* No matches */
+
+
+	/*
+	 * If we did find a suitable refspec and it's not a symref and
+	 * it's not in the list of refs that currently exist in that
+	 * remote we consider it to be stale.
+	 */
+	if (!((flags & REF_ISSYMREF) ||
+	      string_list_has_string(info->ref_names, query.src))) {
+		struct ref *ref =3D make_linked_ref(refname, &info->stale_refs_tail)=
;
+		hashcpy(ref->new_sha1, sha1);
 	}
+
+	free(query.src);
 	return 0;
 }
=20
-struct ref *get_stale_heads(struct remote *remote, struct ref *fetch_m=
ap)
+struct ref *get_stale_heads(struct refspec *refs, int ref_count, struc=
t ref *fetch_map)
 {
 	struct ref *ref, *stale_refs =3D NULL;
 	struct string_list ref_names =3D STRING_LIST_INIT_NODUP;
 	struct stale_heads_info info;
-	info.remote =3D remote;
 	info.ref_names =3D &ref_names;
 	info.stale_refs_tail =3D &stale_refs;
+	info.refs =3D refs;
+	info.ref_count =3D ref_count;
 	for (ref =3D fetch_map; ref; ref =3D ref->next)
 		string_list_append(&ref_names, ref->name);
 	sort_string_list(&ref_names);
diff --git a/remote.h b/remote.h
index 9a30a9d..f2541b5 100644
--- a/remote.h
+++ b/remote.h
@@ -164,6 +164,6 @@ struct ref *guess_remote_head(const struct ref *hea=
d,
 			      int all);
=20
 /* Return refs which no longer exist on remote */
-struct ref *get_stale_heads(struct remote *remote, struct ref *fetch_m=
ap);
+struct ref *get_stale_heads(struct refspec *refs, int ref_count, struc=
t ref *fetch_map);
=20
 #endif
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 8b5e925..581049b 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -86,7 +86,7 @@ test_expect_success 'fetch --prune on its own works a=
s expected' '
 	test_must_fail git rev-parse origin/extrabranch
 '
=20
-test_expect_failure 'fetch --prune with a branch name keeps branches' =
'
+test_expect_success 'fetch --prune with a branch name keeps branches' =
'
 	cd "$D" &&
 	git clone . prune-branch &&
 	cd prune-branch &&
@@ -96,7 +96,7 @@ test_expect_failure 'fetch --prune with a branch name=
 keeps branches' '
 	git rev-parse origin/extrabranch
 '
=20
-test_expect_failure 'fetch --prune with a namespace keeps other namesp=
aces' '
+test_expect_success 'fetch --prune with a namespace keeps other namesp=
aces' '
 	cd "$D" &&
 	git clone . prune-namespace &&
 	cd prune-namespace &&
--=20
1.7.5.2.354.g349bf
