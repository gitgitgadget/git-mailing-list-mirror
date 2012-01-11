From: =?UTF-8?q?Carlos=20Mart=C3=ADn=20Nieto?= <cmn@elego.de>
Subject: =?UTF-8?q?=5BPATCH=5D=20archive=3A=20re-allow=20HEAD=3ADocumentation=20on=20a=20remote=20invocation?=
Date: Wed, 11 Jan 2012 13:12:38 +0100
Message-ID: <1326283958-30271-1-git-send-email-cmn@elego.de>
References: <20120110232132.GA29245@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Albert Astals Cid <aacid@kde.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 11 13:12:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rkx2s-0002F3-VY
	for gcvg-git-2@lo.gmane.org; Wed, 11 Jan 2012 13:12:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756878Ab2AKMMl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Jan 2012 07:12:41 -0500
Received: from kimmy.cmartin.tk ([91.121.65.165]:50635 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756702Ab2AKMMk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jan 2012 07:12:40 -0500
Received: from beez.lab.cmartin.tk (i59F7870A.versanet.de [89.247.135.10])
	by kimmy.cmartin.tk (Postfix) with ESMTPA id 4B883461C3;
	Wed, 11 Jan 2012 13:12:27 +0100 (CET)
Received: (nullmailer pid 30339 invoked by uid 1000);
	Wed, 11 Jan 2012 12:12:38 -0000
X-Mailer: git-send-email 1.7.8.352.g876a6f
In-Reply-To: <20120110232132.GA29245@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188357>

The tightening done in (ee27ca4a: archive: don't let remote clients
get unreachable commits, 2011-11-17) went too far and disallowed
HEAD:Documentation as it would try to find "HEAD:Documentation" as a
ref.

Only DWIM the "HEAD" part to see if it exists as a ref. Once we're
sure that we've been given a valid ref, we follow the normal code
path. This still disallows attempts to access commits which are not
branch tips.

Signed-off-by: Carlos Mart=C3=ADn Nieto <cmn@elego.de>
---

AFAICT this should still be safe. Using HEAD^:Documentation or
<sha1>:Documentation still complains that HEAD^ and <sha1> aren't
refs.

 archive.c |   19 +++++++++++++------
 1 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/archive.c b/archive.c
index 164bbd0..4735bfb 100644
--- a/archive.c
+++ b/archive.c
@@ -260,14 +260,21 @@ static void parse_treeish_arg(const char **argv,
 	/* Remotes are only allowed to fetch actual refs */
 	if (remote) {
 		char *ref =3D NULL;
-		if (!dwim_ref(name, strlen(name), sha1, &ref))
-			die("no such ref: %s", name);
+		const char *refname, *colon =3D NULL;
+
+		colon =3D strchr(name, ':');
+		if (colon)
+			refname =3D xstrndup(name, colon - name);
+		else
+			refname =3D name;
+
+		if (!dwim_ref(refname, strlen(refname), sha1, &ref))
+			die("no such ref: %s", refname);
 		free(ref);
 	}
-	else {
-		if (get_sha1(name, sha1))
-			die("Not a valid object name");
-	}
+
+	if (get_sha1(name, sha1))
+		die("Not a valid object name");
=20
 	commit =3D lookup_commit_reference_gently(sha1, 1);
 	if (commit) {
--=20
1.7.8.352.g876a6f
