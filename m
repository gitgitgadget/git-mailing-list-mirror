From: Thomas Rast <trast@inf.ethz.ch>
Subject: [PATCH 2/2] lookup_commit_reference_gently: do not read non-{tag,commit}
Date: Thu, 30 May 2013 22:00:23 +0200
Message-ID: <5cc40825d5b4fb3382e4c054c49adf5e6b6fe110.1369943791.git.trast@inf.ethz.ch>
References: <2d926e4dbd218b2305f50652c00a5c1d87e81208.1369943791.git.trast@inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <kernel-hacker@bennee.com>,
	Antoine Pelisse <apelisse@gmail.com>,
	"John Keeping" <john@keeping.me.uk>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 30 22:00:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ui91Z-0001Cz-77
	for gcvg-git-2@plane.gmane.org; Thu, 30 May 2013 22:00:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759148Ab3E3UAb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 30 May 2013 16:00:31 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:12658 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757368Ab3E3UA0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 May 2013 16:00:26 -0400
Received: from CAS21.d.ethz.ch (172.31.51.111) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Thu, 30 May
 2013 22:00:23 +0200
Received: from hexa.v.cablecom.net (46.126.8.85) by CAS21.d.ethz.ch
 (172.31.51.111) with Microsoft SMTP Server (TLS) id 14.2.298.4; Thu, 30 May
 2013 22:00:24 +0200
X-Mailer: git-send-email 1.8.3.506.g4fdeee5
In-Reply-To: <2d926e4dbd218b2305f50652c00a5c1d87e81208.1369943791.git.trast@inf.ethz.ch>
X-Originating-IP: [46.126.8.85]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226034>

lookup_commit_reference_gently unconditionally parses the object given
to it.  This slows down git-describe a lot if you have a repository
with large tagged blobs in it: parse_object() will read the entire
blob and verify that its sha1 matches, only to then throw it away.

Speed it up by checking the type with sha1_object_info() prior to
unpacking.

The reason that deref_tag() does not need the same fix is a bit
subtle: parse_tag_buffer() does not fill the 'tagged' member of the
tag struct if the tagged object is a blob.

Reported-by: Alex Benn=C3=A9e <kernel-hacker@bennee.com>
Signed-off-by: Thomas Rast <trast@inf.ethz.ch>
---
 commit.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/commit.c b/commit.c
index 888e02a..00e8d4a 100644
--- a/commit.c
+++ b/commit.c
@@ -31,8 +31,12 @@ static struct commit *check_commit(struct object *ob=
j,
 struct commit *lookup_commit_reference_gently(const unsigned char *sha=
1,
 					      int quiet)
 {
-	struct object *obj =3D deref_tag(parse_object(sha1), NULL, 0);
-
+	struct object *obj;
+	int type =3D sha1_object_info(sha1, NULL);
+	/* If it's neither tag nor commit, parsing the object is wasted effor=
t */
+	if (type !=3D OBJ_TAG && type !=3D OBJ_COMMIT)
+		return NULL;
+	obj =3D deref_tag(parse_object(sha1), NULL, 0);
 	if (!obj)
 		return NULL;
 	return check_commit(obj, sha1, quiet);
--=20
1.8.3.506.g4fdeee5
