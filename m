From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH v2 2/5] attr: add GIT_ATTR_INDEX "direction"
Date: Sat, 18 Apr 2009 00:17:58 +0200
Message-ID: <49E90016.7060204@lsrfire.ath.cx>
References: <1239848917-14399-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 18 00:20:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LuwQ2-0000iT-Ib
	for gcvg-git-2@gmane.org; Sat, 18 Apr 2009 00:20:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762148AbZDQWSH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 17 Apr 2009 18:18:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762010AbZDQWSG
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Apr 2009 18:18:06 -0400
Received: from india601.server4you.de ([85.25.151.105]:46211 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761701AbZDQWSE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Apr 2009 18:18:04 -0400
Received: from [10.0.1.101] (p57B7DF1E.dip.t-dialin.net [87.183.223.30])
	by india601.server4you.de (Postfix) with ESMTPSA id DA66C2F8104;
	Sat, 18 Apr 2009 00:18:01 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <1239848917-14399-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116794>

=46rom: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>

This instructs attr mechanism, not to look into working .gitattributes
at all. Needed by tools that does not handle working directory, such
as "git archive".

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 attr.c |   12 +++++++++---
 attr.h |    3 ++-
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/attr.c b/attr.c
index 43259e5..f1ca4f5 100644
--- a/attr.c
+++ b/attr.c
@@ -405,7 +405,7 @@ static struct attr_stack *read_attr(const char *pat=
h, int macro_ok)
 		if (!res)
 			res =3D read_attr_from_file(path, macro_ok);
 	}
-	else {
+	else if (direction =3D=3D GIT_ATTR_CHECKIN) {
 		res =3D read_attr_from_file(path, macro_ok);
 		if (!res)
 			/*
@@ -415,6 +415,8 @@ static struct attr_stack *read_attr(const char *pat=
h, int macro_ok)
 			 */
 			res =3D read_attr_from_index(path, macro_ok);
 	}
+	else
+		res =3D read_attr_from_index(path, macro_ok);
 	if (!res)
 		res =3D xcalloc(1, sizeof(*res));
 	return res;
@@ -466,7 +468,7 @@ static void bootstrap_attr_stack(void)
 		elem->prev =3D attr_stack;
 		attr_stack =3D elem;
=20
-		if (!is_bare_repository()) {
+		if (!is_bare_repository() || direction =3D=3D GIT_ATTR_INDEX) {
 			elem =3D read_attr(GITATTRIBUTES_FILE, 1);
 			elem->origin =3D strdup("");
 			elem->prev =3D attr_stack;
@@ -533,7 +535,7 @@ static void prepare_attr_stack(const char *path, in=
t dirlen)
 	/*
 	 * Read from parent directories and push them down
 	 */
-	if (!is_bare_repository()) {
+	if (!is_bare_repository() || direction =3D=3D GIT_ATTR_INDEX) {
 		while (1) {
 			char *cp;
=20
@@ -674,6 +676,10 @@ int git_checkattr(const char *path, int num, struc=
t git_attr_check *check)
 void git_attr_set_direction(enum git_attr_direction new, struct index_=
state *istate)
 {
 	enum git_attr_direction old =3D direction;
+
+	if (is_bare_repository() && new !=3D GIT_ATTR_INDEX)
+		die("BUG: non-INDEX attr direction in a bare repo");
+
 	direction =3D new;
 	if (new !=3D old)
 		drop_attr_stack();
diff --git a/attr.h b/attr.h
index 3a2f4ec..69b5767 100644
--- a/attr.h
+++ b/attr.h
@@ -33,7 +33,8 @@ int git_checkattr(const char *path, int, struct git_a=
ttr_check *);
=20
 enum git_attr_direction {
 	GIT_ATTR_CHECKIN,
-	GIT_ATTR_CHECKOUT
+	GIT_ATTR_CHECKOUT,
+	GIT_ATTR_INDEX,
 };
 void git_attr_set_direction(enum git_attr_direction, struct index_stat=
e *);
=20
--=20
1.6.3.rc0
