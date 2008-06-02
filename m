From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [PATCH v2 1/2] Clean up builtin-update-ref's option parsing
Date: Tue, 03 Jun 2008 01:34:48 +0200
Message-ID: <20080602233447.26087.14533.stgit@yoghurt>
References: <20080602233244.26087.51827.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 03 01:36:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3JZY-0002sL-91
	for gcvg-git-2@gmane.org; Tue, 03 Jun 2008 01:36:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754160AbYFBXfX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Jun 2008 19:35:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753876AbYFBXfX
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jun 2008 19:35:23 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4746 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752646AbYFBXfX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2008 19:35:23 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1K3JY8-0001a0-00; Tue, 03 Jun 2008 00:34:48 +0100
In-Reply-To: <20080602233244.26087.51827.stgit@yoghurt>
User-Agent: StGIT/0.14.2.171.g5c0d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83593>

builtin-update-ref's option parsing was somewhat tricky to follow,
especially if the -d option was given. This patch cleans it upp a bit,
at the expense of making it a bit longer.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 builtin-update-ref.c |   34 +++++++++++++++++++---------------
 1 files changed, 19 insertions(+), 15 deletions(-)


diff --git a/builtin-update-ref.c b/builtin-update-ref.c
index 93c1271..cc8bc5c 100644
--- a/builtin-update-ref.c
+++ b/builtin-update-ref.c
@@ -11,7 +11,7 @@ static const char * const git_update_ref_usage[] =3D =
{
=20
 int cmd_update_ref(int argc, const char **argv, const char *prefix)
 {
-	const char *refname, *value, *oldval, *msg=3DNULL;
+	const char *refname, *oldval, *msg=3DNULL;
 	unsigned char sha1[20], oldsha1[20];
 	int delete =3D 0, no_deref =3D 0;
 	struct option options[] =3D {
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
+			usage_with_options(git_update_ref_usage, options);
+		refname =3D argv[0];
+		oldval =3D argv[1];
+	} else {
+                const char *value;
+		if (argc < 2 || argc > 3)
 			usage_with_options(git_update_ref_usage, options);
-		return delete_ref(refname, sha1);
+		refname =3D argv[0];
+		value =3D argv[1];
+		oldval =3D argv[2];
+		if (get_sha1(value, sha1))
+			die("%s: not a valid SHA1", value);
 	}
=20
-	hashclr(oldsha1);
+	hashclr(oldsha1); /* all-zero hash in case oldval is the empty string=
 */
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
