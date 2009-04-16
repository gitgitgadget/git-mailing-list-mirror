From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/5] attr: add GIT_ATTR_INDEX "direction"
Date: Wed, 15 Apr 2009 19:28:34 -0700
Message-ID: <1239848917-14399-3-git-send-email-gitster@pobox.com>
References: <1239848917-14399-1-git-send-email-gitster@pobox.com>
 <1239848917-14399-2-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 16 04:31:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LuHNe-0000r0-0G
	for gcvg-git-2@gmane.org; Thu, 16 Apr 2009 04:31:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756785AbZDPC2t convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 15 Apr 2009 22:28:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756630AbZDPC2t
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Apr 2009 22:28:49 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:62638 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756368AbZDPC2s (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Apr 2009 22:28:48 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 5F1F0AA3B7;
	Wed, 15 Apr 2009 22:28:46 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 6CFB0AA3B5; Wed,
 15 Apr 2009 22:28:44 -0400 (EDT)
X-Mailer: git-send-email 1.6.3.rc0.6.g08087
In-Reply-To: <1239848917-14399-2-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 4FD10FF6-2A2E-11DE-B1F5-C121C5FC92D5-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116662>

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
index 43259e5..626eadb 100644
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
+		die("BUG: non-INDEX att direction in a bare repo");
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
1.6.3.rc0.6.g08087
