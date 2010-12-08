From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/2] get_sha1: support ref^{/regex} syntax
Date: Wed,  8 Dec 2010 21:58:39 +0700
Message-ID: <1291820319-12455-3-git-send-email-pclouds@gmail.com>
References: <1291820319-12455-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Kevin Ballard <kevin@sb.org>, Yann Dirson <dirson@bertin.fr>,
	Jeff King <peff@peff.net>, Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 08 16:00:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQLVH-0003wk-39
	for gcvg-git-2@lo.gmane.org; Wed, 08 Dec 2010 16:00:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755438Ab0LHPAD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Dec 2010 10:00:03 -0500
Received: from mail-pv0-f174.google.com ([74.125.83.174]:38168 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755428Ab0LHPAB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Dec 2010 10:00:01 -0500
Received: by pva4 with SMTP id 4so270927pva.19
        for <git@vger.kernel.org>; Wed, 08 Dec 2010 07:00:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=Vt63CiP6z3D89xpH5oE8+mzGWXsNgasJGoCbNv2BDoA=;
        b=jDMijpIs/GfK9AAUgIDIeAaXm0YaeXj4EPAJUDYA8+37AHxNwyvRR3p/SQNroxZUnL
         +R6pNKRGOO/WmSp4cMHIJcy9imss7IsJwiCggZvD8YW2skoVhjehe7ktooNty9RttbvC
         HpqW2aXojXrF5QIAr5M/qmBu7tD7nsqu8Lla0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=ve9sxtlUcMXXW040jGhIElgi8Zd87aFCb9trZEgVP2fhDGR3nhL5ibfbOgDwzC47Gu
         nMqPLFw37OQJUd3g3a/yoQp6yGUBSMrjh1Jk0qoxnwU8zjWamECM0j4+E9a4QmUT/Vwm
         ElOGbaG4V8LEEPsWK4LBU64H41DI1ZP818l4I=
Received: by 10.142.203.9 with SMTP id a9mr2620234wfg.119.1291820400926;
        Wed, 08 Dec 2010 07:00:00 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.222.178])
        by mx.google.com with ESMTPS id w22sm943312wfd.7.2010.12.08.06.59.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 08 Dec 2010 06:59:59 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 08 Dec 2010 21:59:04 +0700
X-Mailer: git-send-email 1.7.3.2.316.gda8b3
In-Reply-To: <1291820319-12455-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163197>

This works like :/ syntax, but only limited to one ref.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/revisions.txt |    7 +++++++
 sha1_name.c                 |   26 ++++++++++++++++++++++----
 2 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
index 3d4b79c..fbe6245 100644
--- a/Documentation/revisions.txt
+++ b/Documentation/revisions.txt
@@ -106,6 +106,13 @@ the `$GIT_DIR/refs` directory or from the `$GIT_DI=
R/packed-refs` file.
   and dereference the tag recursively until a non-tag object is
   found.
=20
+* A suffix '{caret}' to a revision parameter followed by a brace
+  pair that contains a text led by a slash (e.g. `HEAD^{/fix nasty bug=
}`):
+  this names a commit whose commit message matches the specified
+  regular expression. This name returns the youngest matching commit
+  which is reachable from the dereferenced commit. The leading '!'
+  in the text is treated especially like in `:/` syntax below.
+
 * A colon, followed by a slash, followed by a text (e.g. `:/fix nasty =
bug`): this names
   a commit whose commit message matches the specified regular expressi=
on.
   This name returns the youngest matching commit which is
diff --git a/sha1_name.c b/sha1_name.c
index f4ccdc5..00e52b0 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -527,6 +527,7 @@ struct object *peel_to_type(const char *name, int n=
amelen,
 	}
 }
=20
+static int get_sha1_oneline(const char *, unsigned char *, struct comm=
it_list *);
 static int peel_onion(const char *name, int len, unsigned char *sha1)
 {
 	unsigned char outer[20];
@@ -562,6 +563,11 @@ static int peel_onion(const char *name, int len, u=
nsigned char *sha1)
 		expected_type =3D OBJ_BLOB;
 	else if (sp[0] =3D=3D '}')
 		expected_type =3D OBJ_NONE;
+	else if (sp[0] =3D=3D '/') {
+		if (sp[1] =3D=3D '}')
+			return -1;
+		expected_type =3D OBJ_COMMIT;
+	}
 	else
 		return -1;
=20
@@ -584,11 +590,23 @@ static int peel_onion(const char *name, int len, =
unsigned char *sha1)
 		 * barf.
 		 */
 		o =3D peel_to_type(name, len, o, expected_type);
-		if (o) {
-			hashcpy(sha1, o->sha1);
-			return 0;
+		if (!o)
+			return -1;
+
+		hashcpy(sha1, o->sha1);
+		if (sp[0] =3D=3D '/') { /* ^{/foo} */
+			struct commit_list *list =3D NULL;
+			char *prefix;
+			int ret;
+
+			commit_list_insert((struct commit *)o, &list);
+			prefix =3D xstrndup(sp + 1, name + len - 1 - (sp + 1));
+			ret =3D get_sha1_oneline(prefix, sha1, list);
+			free(prefix);
+			free_commit_list(list);
+			return ret;
 		}
-		return -1;
+		return 0;
 	}
 	return 0;
 }
--=20
1.7.3.2.316.gda8b3
