From: =?UTF-8?q?Carlos=20Mart=C3=ADn=20Nieto?= <cmn@elego.de>
Subject: [PATCH 5/5] fetch: treat --tags like refs/tags/*:refs/tags/* when pruning
Date: Sat, 15 Oct 2011 07:04:26 +0200
Message-ID: <1318655066-29001-6-git-send-email-cmn@elego.de>
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
	id 1REwQM-0001QL-PZ
	for gcvg-git-2@lo.gmane.org; Sat, 15 Oct 2011 07:04:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751676Ab1JOFE3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 15 Oct 2011 01:04:29 -0400
Received: from kimmy.cmartin.tk ([91.121.65.165]:48779 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751508Ab1JOFE1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Oct 2011 01:04:27 -0400
Received: from centaur.lab.cmartin.tk (brln-4dbc6671.pool.mediaWays.net [77.188.102.113])
	by kimmy.cmartin.tk (Postfix) with ESMTPA id C624E4618F;
	Sat, 15 Oct 2011 07:03:59 +0200 (CEST)
Received: (nullmailer pid 29053 invoked by uid 1000);
	Sat, 15 Oct 2011 05:04:26 -0000
X-Mailer: git-send-email 1.7.5.2.354.g349bf
In-Reply-To: <1318655066-29001-1-git-send-email-cmn@elego.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183637>

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
index e295d97..9d481f8 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -735,10 +735,29 @@ static int do_fetch(struct transport *transport,
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
