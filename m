From: =?UTF-8?q?Carlos=20Mart=C3=ADn=20Nieto?= <cmn@elego.de>
Subject: [PATCH 3/3] fetch: treat --tags like refs/tags/*:refs/tags/* when pruning
Date: Thu,  6 Oct 2011 22:19:45 +0200
Message-ID: <1317932385-28604-4-git-send-email-cmn@elego.de>
References: <1317932385-28604-1-git-send-email-cmn@elego.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	mathstuf@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 06 22:19:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBuQ5-000377-1P
	for gcvg-git-2@lo.gmane.org; Thu, 06 Oct 2011 22:19:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758710Ab1JFUTs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Oct 2011 16:19:48 -0400
Received: from kimmy.cmartin.tk ([91.121.65.165]:52073 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757062Ab1JFUTr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Oct 2011 16:19:47 -0400
Received: from centaur.lab.cmartin.tk (brln-4db9e4ec.pool.mediaWays.net [77.185.228.236])
	by kimmy.cmartin.tk (Postfix) with ESMTPA id AA5DE4615A;
	Thu,  6 Oct 2011 22:19:21 +0200 (CEST)
Received: (nullmailer pid 28648 invoked by uid 1000);
	Thu, 06 Oct 2011 20:19:45 -0000
X-Mailer: git-send-email 1.7.5.2.354.g349bf
In-Reply-To: <1317932385-28604-1-git-send-email-cmn@elego.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183026>

If --tags is specified, add that refspec to the list given to prune_ref=
s
so it knows to treat it as a filter on what refs to should consider
for prunning. This way

    git fetch --prune --tags origin

only prunes tags and doesn't delete the branch refs.

Signed-off-by: Carlos Mart=C3=ADn Nieto <cmn@elego.de>
---
 builtin/fetch.c |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index b937d71..94b2bd3 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -699,8 +699,17 @@ static int do_fetch(struct transport *transport,
 		free_refs(ref_map);
 		return 1;
 	}
-	if (prune)
+	if (prune) {
+		/* If --tags was specified, we need to tell prune_refs
+		 * that we're filtering the refs from the remote */
+		if (tags =3D=3D TAGS_SET) {
+			const char * tags_refspec =3D "refs/tags/*:refs/tags/*";
+			refs =3D xrealloc(refs, (ref_count + 1) * sizeof(struct refspec));
+			refs[ref_count] =3D *parse_fetch_refspec(1, &tags_refspec);
+			ref_count++;
+		}
 		prune_refs(transport, refs, ref_count, ref_map);
+	}
 	free_refs(ref_map);
=20
 	/* if neither --no-tags nor --tags was specified, do automated tag
--=20
1.7.5.2.354.g349bf
