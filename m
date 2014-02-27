From: =?UTF-8?q?Carlos=20Mart=C3=ADn=20Nieto?= <cmn@elego.de>
Subject: [PATCH 2/2] fetch: handle overlaping refspecs on --prune
Date: Thu, 27 Feb 2014 10:00:10 +0100
Message-ID: <1393491610-19476-2-git-send-email-cmn@elego.de>
References: <1393491610-19476-1-git-send-email-cmn@elego.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 27 10:06:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WIwva-0000Nf-Vq
	for gcvg-git-2@plane.gmane.org; Thu, 27 Feb 2014 10:06:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751334AbaB0JGn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 27 Feb 2014 04:06:43 -0500
Received: from hessy.cmartin.tk ([78.47.67.53]:57136 "EHLO hessy.dwim.me"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1750818AbaB0JGi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Feb 2014 04:06:38 -0500
X-Greylist: delayed 380 seconds by postgrey-1.27 at vger.kernel.org; Thu, 27 Feb 2014 04:06:38 EST
Received: from cmartin.tk (unknown [IPv6:2001:6f8:900:8cd0:922b:34ff:fe1c:e3e4])
	by hessy.dwim.me (Postfix) with ESMTPA id 8D93580362
	for <git@vger.kernel.org>; Thu, 27 Feb 2014 10:00:12 +0100 (CET)
Received: (nullmailer pid 19519 invoked by uid 1000);
	Thu, 27 Feb 2014 09:00:10 -0000
X-Mailer: git-send-email 1.9.0.rc3.244.g3497008
In-Reply-To: <1393491610-19476-1-git-send-email-cmn@elego.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242794>

=46rom: Carlos Mart=C3=ADn Nieto <cmn@dwim.me>

We need to consider that a remote-tracking branch may match more than
one rhs of a fetch refspec. In such a case, it is not enough to stop at
the first match but look at all of the matches in order to determine
whether a head is stale.

To this goal, introduce a variant of query_refspecs which returns all o=
f
the matching refspecs and loop over those answers to check for
staleness.

Signed-off-by: Carlos Mart=C3=ADn Nieto <cmn@elego.de>
---

There is an unfortunate duplication of code here, as
query_refspecs_multiple is mostly query_refspecs but we only care
about the other side of matching refspecs and disregard the 'force'
information which query_refspecs does want.

I thought about putting both together via callbacks and having
query_refspecs stop at the first one, but I'm not sure that it would
make it easier to read or manage.

 remote.c         | 52 +++++++++++++++++++++++++++++++++++++++++++++++-=
----
 t/t5510-fetch.sh |  2 +-
 2 files changed, 48 insertions(+), 6 deletions(-)

diff --git a/remote.c b/remote.c
index 9f1a8aa..26140c7 100644
--- a/remote.c
+++ b/remote.c
@@ -821,6 +821,33 @@ static int match_name_with_pattern(const char *key=
, const char *name,
 	return ret;
 }
=20
+static void query_refspecs_multiple(struct refspec *refs, int ref_coun=
t, struct refspec *query, struct string_list *results)
+{
+	int i;
+	int find_src =3D !query->src;
+
+	if (find_src && !query->dst)
+		error("query_refspecs_multiple: need either src or dst");
+
+	for (i =3D 0; i < ref_count; i++) {
+		struct refspec *refspec =3D &refs[i];
+		const char *key =3D find_src ? refspec->dst : refspec->src;
+		const char *value =3D find_src ? refspec->src : refspec->dst;
+		const char *needle =3D find_src ? query->dst : query->src;
+		char **result =3D find_src ? &query->src : &query->dst;
+
+		if (!refspec->dst)
+			continue;
+		if (refspec->pattern) {
+			if (match_name_with_pattern(key, needle, value, result)) {
+				string_list_append_nodup(results, *result);
+			}
+		} else if (!strcmp(needle, key)) {
+			string_list_append(results, value);
+		}
+	}
+}
+
 static int query_refspecs(struct refspec *refs, int ref_count, struct =
refspec *query)
 {
 	int i;
@@ -1954,25 +1981,40 @@ static int get_stale_heads_cb(const char *refna=
me,
 	const unsigned char *sha1, int flags, void *cb_data)
 {
 	struct stale_heads_info *info =3D cb_data;
+	struct string_list matches =3D STRING_LIST_INIT_DUP;
 	struct refspec query;
+	int i, stale =3D 1;
 	memset(&query, 0, sizeof(struct refspec));
 	query.dst =3D (char *)refname;
=20
-	if (query_refspecs(info->refs, info->ref_count, &query))
+	query_refspecs_multiple(info->refs, info->ref_count, &query, &matches=
);
+	if (matches.nr =3D=3D 0)
 		return 0; /* No matches */
=20
 	/*
 	 * If we did find a suitable refspec and it's not a symref and
 	 * it's not in the list of refs that currently exist in that
-	 * remote we consider it to be stale.
+	 * remote we consider it to be stale. In order to deal with
+	 * overlapping refspecs, we need to go over all of the
+	 * matching refs.
 	 */
-	if (!((flags & REF_ISSYMREF) ||
-	      string_list_has_string(info->ref_names, query.src))) {
+	if (flags & REF_ISSYMREF)
+		return 0;
+
+	for (i =3D 0; i < matches.nr; i++) {
+		if (string_list_has_string(info->ref_names, matches.items[i].string)=
) {
+			stale =3D 0;
+			break;
+		}
+	}
+
+	string_list_clear(&matches, 0);
+
+	if (stale) {
 		struct ref *ref =3D make_linked_ref(refname, &info->stale_refs_tail)=
;
 		hashcpy(ref->new_sha1, sha1);
 	}
=20
-	free(query.src);
 	return 0;
 }
=20
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 4949e3d..a86f6bc 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -113,7 +113,7 @@ test_expect_success 'fetch --prune with a namespace=
 keeps other namespaces' '
 	git rev-parse origin/master
 '
=20
-test_expect_failure 'fetch --prune handles overlapping refspecs' '
+test_expect_success 'fetch --prune handles overlapping refspecs' '
 	cd "$D" &&
 	git update-ref refs/pull/42/head master &&
 	git clone . prune-overlapping &&
--=20
1.9.0.rc3.244.g3497008
