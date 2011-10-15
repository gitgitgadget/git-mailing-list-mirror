From: =?UTF-8?q?Carlos=20Mart=C3=ADn=20Nieto?= <cmn@elego.de>
Subject: [PATCH 3/5] remote: separate out the remote_find_tracking logic into query_refspecs
Date: Sat, 15 Oct 2011 07:04:24 +0200
Message-ID: <1318655066-29001-4-git-send-email-cmn@elego.de>
References: <1318655066-29001-1-git-send-email-cmn@elego.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	mathstuf@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 15 07:04:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1REwQN-0001QL-PP
	for gcvg-git-2@lo.gmane.org; Sat, 15 Oct 2011 07:04:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751691Ab1JOFEa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 15 Oct 2011 01:04:30 -0400
Received: from kimmy.cmartin.tk ([91.121.65.165]:48775 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751504Ab1JOFE1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Oct 2011 01:04:27 -0400
Received: from centaur.lab.cmartin.tk (brln-4dbc6671.pool.mediaWays.net [77.188.102.113])
	by kimmy.cmartin.tk (Postfix) with ESMTPA id 42CBA4618E;
	Sat, 15 Oct 2011 07:03:59 +0200 (CEST)
Received: (nullmailer pid 29049 invoked by uid 1000);
	Sat, 15 Oct 2011 05:04:26 -0000
X-Mailer: git-send-email 1.7.5.2.354.g349bf
In-Reply-To: <1318655066-29001-1-git-send-email-cmn@elego.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183638>

Move the body of remote_find_tracking to a new function query_refspecs
which does the same (find a refspec that matches and apply the
transformation) but explicitely wants the list of refspecs.

Make remote_find_tracking and apply_refspecs use query_refspecs.

Signed-off-by: Carlos Mart=C3=ADn Nieto <cmn@elego.de>
---
 remote.c |   70 ++++++++++++++++++++++++++++++------------------------=
-------
 1 files changed, 34 insertions(+), 36 deletions(-)

diff --git a/remote.c b/remote.c
index b8ecfa5..e94c6d2 100644
--- a/remote.c
+++ b/remote.c
@@ -828,59 +828,57 @@ static int match_name_with_pattern(const char *ke=
y, const char *name,
 	return ret;
 }
=20
-char *apply_refspecs(struct refspec *refspecs, int nr_refspec,
-		     const char *name)
+static int query_refspecs(struct refspec *refs, int ref_count, struct =
refspec *query)
 {
 	int i;
-	char *ret =3D NULL;
-	for (i =3D 0; i < nr_refspec; i++) {
-		struct refspec *refspec =3D refspecs + i;
-		if (refspec->pattern) {
-			if (match_name_with_pattern(refspec->src, name,
-						    refspec->dst, &ret))
-				return ret;
-		} else if (!strcmp(refspec->src, name))
-			return strdup(refspec->dst);
-	}
-	return NULL;
-}
+	int find_src =3D query->src =3D=3D NULL;
=20
-int remote_find_tracking(struct remote *remote, struct refspec *refspe=
c)
-{
-	int find_src =3D refspec->src =3D=3D NULL;
-	char *needle, **result;
-	int i;
+	if (find_src && !query->dst)
+		return error("query_refspecs: need either src or dst");
=20
-	if (find_src) {
-		if (!refspec->dst)
-			return error("find_tracking: need either src or dst");
-		needle =3D refspec->dst;
-		result =3D &refspec->src;
-	} else {
-		needle =3D refspec->src;
-		result =3D &refspec->dst;
-	}
+	for (i =3D 0; i < ref_count; i++) {
+		struct refspec *refspec =3D &refs[i];
+		const char *key =3D find_src ? refspec->dst : refspec->src;
+		const char *value =3D find_src ? refspec->src : refspec->dst;
+		const char *needle =3D find_src ? query->dst : query->src;
+		char **result =3D find_src ? &query->src : &query->dst;
=20
-	for (i =3D 0; i < remote->fetch_refspec_nr; i++) {
-		struct refspec *fetch =3D &remote->fetch[i];
-		const char *key =3D find_src ? fetch->dst : fetch->src;
-		const char *value =3D find_src ? fetch->src : fetch->dst;
-		if (!fetch->dst)
+		if (!refspec->dst)
 			continue;
-		if (fetch->pattern) {
+		if (refspec->pattern) {
 			if (match_name_with_pattern(key, needle, value, result)) {
-				refspec->force =3D fetch->force;
+				query->force =3D refspec->force;
 				return 0;
 			}
 		} else if (!strcmp(needle, key)) {
 			*result =3D xstrdup(value);
-			refspec->force =3D fetch->force;
+			query->force =3D refspec->force;
 			return 0;
 		}
 	}
+
 	return -1;
 }
=20
+char *apply_refspecs(struct refspec *refspecs, int nr_refspec,
+		     const char *name)
+{
+	struct refspec query;
+
+	memset(&query, 0x0, sizeof(struct refspec));
+	query.src =3D (char *) name;
+
+	if (query_refspecs(refspecs, nr_refspec, &query))
+		return NULL;
+
+	return query.dst;
+}
+
+int remote_find_tracking(struct remote *remote, struct refspec *refspe=
c)
+{
+	return query_refspecs(remote->fetch, remote->fetch_refspec_nr, refspe=
c);
+}
+
 static struct ref *alloc_ref_with_prefix(const char *prefix, size_t pr=
efixlen,
 		const char *name)
 {
--=20
1.7.5.2.354.g349bf
