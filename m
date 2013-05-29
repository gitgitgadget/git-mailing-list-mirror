From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2] get_sha1: warn about full or short  object names that look like refs
Date: Wed, 29 May 2013 19:12:42 +0700
Message-ID: <1369829562-21835-1-git-send-email-pclouds@gmail.com>
References: <1367639113-17342-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 29 14:11:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhfE1-0007RP-HH
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 14:11:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965983Ab3E2MLZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 May 2013 08:11:25 -0400
Received: from mail-pb0-f49.google.com ([209.85.160.49]:45982 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965800Ab3E2MLY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 May 2013 08:11:24 -0400
Received: by mail-pb0-f49.google.com with SMTP id rp8so9008855pbb.8
        for <git@vger.kernel.org>; Wed, 29 May 2013 05:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=N/7U0InIZyCW5L5YhBvJv0OfLe4k97pnxQWqDSBK2Yw=;
        b=NcfH6SbagMof9co9P7fuf3ba0l+N65AExW+RM8m2Bm7AAyN9X250Ez4XiSz/Tl5XZu
         zlg8m3uCFXLKnBH31EOo7ex/bmOlkIcQYQoyMg+hnMBBvJTm+gajKtiyXUxGhmGvr012
         jQt/hT/efkGWFQHIprf+zvV8tqsYcLOvMraDlG/P/mY6VyWaL05BGHlaz8q8h88IJxVq
         BBKcCt2l0lgwkBNzcO9ePLwZ8G99+MjTlRZmUUD1s/rehgubGa5XWuEKnhsnzJ9pUR+b
         gEX7AYej1OM8HRrfXsSvNrpDceeiLfKUwGdRAuaNDyI/cSnu9d/WxmQ1VaxNo6tfcnNH
         vPAA==
X-Received: by 10.66.218.200 with SMTP id pi8mr3161676pac.40.1369829483602;
        Wed, 29 May 2013 05:11:23 -0700 (PDT)
Received: from lanh ([115.73.219.22])
        by mx.google.com with ESMTPSA id xz1sm9142197pab.5.2013.05.29.05.11.19
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 29 May 2013 05:11:22 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 29 May 2013 19:12:43 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1367639113-17342-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225799>

When we get 40 hex digits, we immediately assume it's an SHA-1. This
is the right thing to do because we have no way else to specify an
object. If there is a ref with the same object name, it will be
ignored. Warn the user about this case because the ref with full
object name is likely a mistake, for example

    git checkout -b $empty_var $(git rev-parse something)

advice.object_name_warning is not documented because frankly people
should not be aware about it until they encounter this situation.

While at there, warn about ambiguation with abbreviated SHA-1 too.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 advice.c                            |  2 ++
 advice.h                            |  1 +
 sha1_name.c                         | 25 +++++++++++++++++++++++--
 t/t1512-rev-parse-disambiguation.sh | 18 ++++++++++++++++++
 4 files changed, 44 insertions(+), 2 deletions(-)

diff --git a/advice.c b/advice.c
index 780f58d..22abde9 100644
--- a/advice.c
+++ b/advice.c
@@ -12,6 +12,7 @@ int advice_commit_before_merge =3D 1;
 int advice_resolve_conflict =3D 1;
 int advice_implicit_identity =3D 1;
 int advice_detached_head =3D 1;
+int advice_object_name_warning =3D 1;
=20
 static struct {
 	const char *name;
@@ -29,6 +30,7 @@ static struct {
 	{ "resolveconflict", &advice_resolve_conflict },
 	{ "implicitidentity", &advice_implicit_identity },
 	{ "detachedhead", &advice_detached_head },
+	{ "object_name_warning", &advice_object_name_warning },
=20
 	/* make this an alias for backward compatibility */
 	{ "pushnonfastforward", &advice_push_update_rejected }
diff --git a/advice.h b/advice.h
index fad36df..24d5420 100644
--- a/advice.h
+++ b/advice.h
@@ -15,6 +15,7 @@ extern int advice_commit_before_merge;
 extern int advice_resolve_conflict;
 extern int advice_implicit_identity;
 extern int advice_detached_head;
+extern int advice_object_name_warning;
=20
 int git_default_advice_config(const char *var, const char *value);
 void advise(const char *advice, ...);
diff --git a/sha1_name.c b/sha1_name.c
index 95003c7..502d107 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -435,12 +435,31 @@ static int get_sha1_1(const char *name, int len, =
unsigned char *sha1, unsigned l
 static int get_sha1_basic(const char *str, int len, unsigned char *sha=
1)
 {
 	static const char *warn_msg =3D "refname '%.*s' is ambiguous.";
+	static const char *object_name_msg =3D N_(
+	"Git normally never creates a ref that ends with 40 hex characters\n"
+	"because it will be ignored when you just specify 40-hex. These refs\=
n"
+	"may be created by mistake. For example,\n"
+	"\n"
+	"  git checkout -b $br $(git rev-parse ...)\n"
+	"\n"
+	"where \"$br\" is somehow empty and a 40-hex ref is created. Please\n=
"
+	"examine these refs and maybe delete them. Turn this message off by\n=
"
+	"running \"git config advice.object_name_warning false\"");
+	unsigned char tmp_sha1[20];
 	char *real_ref =3D NULL;
 	int refs_found =3D 0;
 	int at, reflog_len;
=20
-	if (len =3D=3D 40 && !get_sha1_hex(str, sha1))
+	if (len =3D=3D 40 && !get_sha1_hex(str, sha1)) {
+		refs_found =3D dwim_ref(str, len, tmp_sha1, &real_ref);
+		if (refs_found > 0 && warn_ambiguous_refs) {
+			warning(warn_msg, len, str);
+			if (advice_object_name_warning)
+				fprintf(stderr, "%s\n", _(object_name_msg));
+		}
+		free(real_ref);
 		return 0;
+	}
=20
 	/* basic@{time or number or -number} format to query ref-log */
 	reflog_len =3D at =3D 0;
@@ -481,7 +500,9 @@ static int get_sha1_basic(const char *str, int len,=
 unsigned char *sha1)
 	if (!refs_found)
 		return -1;
=20
-	if (warn_ambiguous_refs && refs_found > 1)
+	if (warn_ambiguous_refs &&
+	    (refs_found > 1 ||
+	     !get_short_sha1(str, len, tmp_sha1, GET_SHA1_QUIETLY)))
 		warning(warn_msg, len, str);
=20
 	if (reflog_len) {
diff --git a/t/t1512-rev-parse-disambiguation.sh b/t/t1512-rev-parse-di=
sambiguation.sh
index 6b3d797..db22808 100755
--- a/t/t1512-rev-parse-disambiguation.sh
+++ b/t/t1512-rev-parse-disambiguation.sh
@@ -261,4 +261,22 @@ test_expect_success 'rev-parse --disambiguate' '
 	test "$(sed -e "s/^\(.........\).*/\1/" actual | sort -u)" =3D 000000=
000
 '
=20
+test_expect_success 'ambiguous 40-hex ref' '
+	TREE=3D$(git mktree </dev/null) &&
+	REF=3D`git rev-parse HEAD` &&
+	VAL=3D$(git commit-tree $TREE </dev/null) &&
+	git update-ref refs/heads/$REF $VAL &&
+	test `git rev-parse $REF 2>err` =3D $REF &&
+	grep "refname.*${REF}.*ambiguous" err
+'
+
+test_expect_success 'ambiguous short sha1 ref' '
+	TREE=3D$(git mktree </dev/null) &&
+	REF=3D`git rev-parse --short HEAD` &&
+	VAL=3D$(git commit-tree $TREE </dev/null) &&
+	git update-ref refs/heads/$REF $VAL &&
+	test `git rev-parse $REF 2>err` =3D $VAL &&
+	grep "refname.*${REF}.*ambiguous" err
+'
+
 test_done
--=20
1.8.2.83.gc99314b
