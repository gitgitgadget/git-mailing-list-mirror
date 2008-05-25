From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [PATCH 2/3] Clean up builtin-update-ref's option parsing
Date: Sun, 25 May 2008 18:14:35 +0200
Message-ID: <20080525161435.25087.82683.stgit@yoghurt>
References: <20080525161125.25087.18083.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 25 18:16:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K0Its-0001E4-Os
	for gcvg-git-2@gmane.org; Sun, 25 May 2008 18:16:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753573AbYEYQPc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 May 2008 12:15:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753628AbYEYQPc
	(ORCPT <rfc822;git-outgoing>); Sun, 25 May 2008 12:15:32 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1639 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753573AbYEYQPb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 May 2008 12:15:31 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1K0Iri-0001DY-00; Sun, 25 May 2008 17:14:34 +0100
In-Reply-To: <20080525161125.25087.18083.stgit@yoghurt>
User-Agent: StGIT/0.14.2.156.gbabd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82868>

builtin-update-ref's option parsing was somewhat tricky to follow,
especially if the -d option was given. This patch cleans it upp a bit
(including fixing an out-of-bounds argv access), at the expense of
making it a bit longer.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 builtin-update-ref.c |   30 +++++++++++++++++-------------
 1 files changed, 17 insertions(+), 13 deletions(-)


diff --git a/builtin-update-ref.c b/builtin-update-ref.c
index e90737c..0d3eb8e 100644
--- a/builtin-update-ref.c
+++ b/builtin-update-ref.c
@@ -27,25 +27,29 @@ int cmd_update_ref(int argc, const char **argv, con=
st char *prefix)
 	if (msg && !*msg)
 		die("Refusing to perform update with empty message.");
=20
-	if (argc < 2 || argc > 3)
-		usage_with_options(git_update_ref_usage, options);
-	refname =3D argv[0];
-	value   =3D argv[1];
-	oldval  =3D argv[2];
-
-	if (get_sha1(value, sha1))
-		die("%s: not a valid SHA1", value);
-
 	if (delete) {
-		if (oldval)
+		if (argc !=3D 2)
 			usage_with_options(git_update_ref_usage, options);
-		return delete_ref(refname, sha1);
+		refname =3D argv[0];
+		value =3D NULL;
+		oldval =3D argv[1];
+	} else {
+		if (argc < 2 || argc > 3)
+			usage_with_options(git_update_ref_usage, options);
+		refname =3D argv[0];
+		value =3D argv[1];
+		oldval =3D argc > 2 ? argv[2] : NULL;
 	}
=20
+	if (value && *value && get_sha1(value, sha1))
+		die("%s: not a valid SHA1", value);
 	hashclr(oldsha1);
 	if (oldval && *oldval && get_sha1(oldval, oldsha1))
 		die("%s: not a valid old SHA1", oldval);
=20
-	return update_ref(msg, refname, sha1, oldval ? oldsha1 : NULL,
-			  no_deref ? REF_NODEREF : 0, DIE_ON_ERR);
+	if (delete)
+		return delete_ref(refname, oldsha1);
+	else
+		return update_ref(msg, refname, sha1, oldval ? oldsha1 : NULL,
+				  no_deref ? REF_NODEREF : 0, DIE_ON_ERR);
 }
