From: =?UTF-8?q?Carlos=20Mart=C3=ADn=20Nieto?= <cmn@elego.de>
Subject: [PATCH 4/4] fetch: treat --tags like refs/tags/*:refs/tags/* when pruning
Date: Sat,  8 Oct 2011 00:51:09 +0200
Message-ID: <1318027869-4037-5-git-send-email-cmn@elego.de>
References: <1318027869-4037-1-git-send-email-cmn@elego.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	mathstuf@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 08 00:51:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RCJGN-00034q-DC
	for gcvg-git-2@lo.gmane.org; Sat, 08 Oct 2011 00:51:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759330Ab1JGWvS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Oct 2011 18:51:18 -0400
Received: from kimmy.cmartin.tk ([91.121.65.165]:53022 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759168Ab1JGWvL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Oct 2011 18:51:11 -0400
Received: from centaur.lab.cmartin.tk (brln-4dbc5717.pool.mediaWays.net [77.188.87.23])
	by kimmy.cmartin.tk (Postfix) with ESMTPA id 8733346180;
	Sat,  8 Oct 2011 00:50:45 +0200 (CEST)
Received: (nullmailer pid 4085 invoked by uid 1000);
	Fri, 07 Oct 2011 22:51:10 -0000
X-Mailer: git-send-email 1.7.5.2.354.g349bf
In-Reply-To: <1318027869-4037-1-git-send-email-cmn@elego.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183124>

If --tags is specified, add that refspec to the list given to
prune_refs so it knows to treat it as a filter on what refs to
should consider for prunning. This way

    git fetch --prune --tags origin

only prunes tags and doesn't delete the branch refs.

Signed-off-by: Carlos Mart=C3=ADn Nieto <cmn@elego.de>
---
 builtin/fetch.c  |   23 +++++++++++++++++++++--
 t/t5510-fetch.sh |    4 ++--
 2 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 041f79e..0f8170c 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -700,10 +700,29 @@ static int do_fetch(struct transport *transport,
 		return 1;
 	}
 	if (prune) {
-		if (ref_count)
+		/* If --tags was specified, pretend the user gave us the canonical t=
ags refspec */
+		if (tags =3D=3D TAGS_SET) {
+			const char *tags_str =3D "refs/tags/*:refs/tags/*";
+			struct refspec *tags_refspec, *refspec;
+
+			/* Copy the refspec and add the tags to it */
+			refspec =3D xcalloc(ref_count + 1, sizeof(struct refspec));
+			tags_refspec =3D parse_fetch_refspec(1, &tags_str);
+			memcpy(refspec, refs, ref_count * sizeof(struct refspec));
+			memcpy(&refspec[ref_count], tags_refspec, sizeof(struct refspec));
+			ref_count++;
+
+			prune_refs(refspec, ref_count, ref_map);
+
+			ref_count--;
+			/* The rest of the strings belong to fetch_one */
+			free_refspec(1, tags_refspec);
+			free(refspec);
+		} else if (ref_count) {
 			prune_refs(refs, ref_count, ref_map);
-		else
+		} else {
 			prune_refs(transport->remote->fetch, transport->remote->fetch_refsp=
ec_nr, ref_map);
+		}
 	}
 	free_refs(ref_map);
=20
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 581049b..e0af4c4 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -105,7 +105,7 @@ test_expect_success 'fetch --prune with a namespace=
 keeps other namespaces' '
 	git rev-parse origin/master
 '
=20
-test_expect_failure 'fetch --prune --tags does not delete the remote-t=
racking branches' '
+test_expect_success 'fetch --prune --tags does not delete the remote-t=
racking branches' '
 	cd "$D" &&
 	git clone . prune-tags &&
 	cd prune-tags &&
@@ -116,7 +116,7 @@ test_expect_failure 'fetch --prune --tags does not =
delete the remote-tracking br
 	test_must_fail git rev-parse somebranch
 '
=20
-test_expect_failure 'fetch --prune --tags with branch does not delete =
other remote-tracking branches' '
+test_expect_success 'fetch --prune --tags with branch does not delete =
other remote-tracking branches' '
 	cd "$D" &&
 	git clone . prune-tags-branch &&
 	cd prune-tags-branch &&
--=20
1.7.5.2.354.g349bf
