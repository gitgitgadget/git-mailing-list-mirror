From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2] branch -v: align even when branch names are in UTF-8
Date: Sun, 26 Aug 2012 01:17:12 +0700
Message-ID: <1345918632-17756-1-git-send-email-pclouds@gmail.com>
References: <7vvcg8yzgx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 25 20:23:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T5L1A-0001Ow-Mu
	for gcvg-git-2@plane.gmane.org; Sat, 25 Aug 2012 20:23:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755618Ab2HYSX1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 25 Aug 2012 14:23:27 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:35152 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751082Ab2HYSXZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Aug 2012 14:23:25 -0400
Received: by pbbrr13 with SMTP id rr13so5268879pbb.19
        for <git@vger.kernel.org>; Sat, 25 Aug 2012 11:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=c/IOGzQ3KL9saWfHhV6H/YviyL1abDE4Hen3uzgI7b4=;
        b=iMkIiN6SZNNapXnpwkvW8nzxZElTTR9CO7sUneITgC7oRBYZXKEbeOn3u+E/294ux/
         MYr8t5lqT+2eTeW3C/jPw1+vwL/0idy8qUFg3zcvwi4p1OtqgUv6j9Ltk8qvpUjAi3Np
         iueot2EWuWPVekgUjsCnNnwn0+VZ4KxsZEj78hVVYjHA6+z2aZbyyYYsptbIbv3+daxI
         7deZ0Maxv45MvBeyO+5/VAKwQheJ1qfposTLvl+82fxSgNK5f+hNZBxmdZeqrYFPAlOB
         oCgB8c0nEW1kwvHgauRUWgsZnsfQc5gvN7iG8I5RyXwi48OV3ntnb99DamR11LAD8qag
         pPXw==
Received: by 10.66.86.201 with SMTP id r9mr19259403paz.16.1345919004658;
        Sat, 25 Aug 2012 11:23:24 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.35.79])
        by mx.google.com with ESMTPS id hc10sm4027186pbc.21.2012.08.25.11.23.21
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 25 Aug 2012 11:23:24 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun, 26 Aug 2012 01:17:14 +0700
X-Mailer: git-send-email 1.7.12.rc2.18.g61b472e
In-Reply-To: <7vvcg8yzgx.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204279>

Branch names are usually in ASCII so they are not the problem. The
problem most likely comes from "(no branch)" translation, which is in
UTF-8 and makes length calculation just wrong.

Update document to mention the fact that we may want ref names in
UTF-8. Encodings that produce invalid UTF-8 are safe as utf8_strwidth()
falls back to strlen(). The ones that incidentally produce valid UTF-8
sequences will cause misalignment.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 On Sat, Aug 25, 2012 at 12:25 AM, Junio C Hamano <gitster@pobox.com> w=
rote:
 > I agree with all of the above, but shouldn't you be computing the
 > "maxwidth" based on the strwidth in the first place?  The use of
 > maxwidth in strbuf_addf() here clearly wants "we know N columns is
 > sufficient to show all output items, so pad the string to N columns"
 > here.  Looking for assignment "item.len =3D xxx" in the same file
 > shows these are computed as byte length, so you are offsetting off
 > of an incorrectly computed value.
 >
 > Giving fewer padding bytes when showing a string that will occupy
 > fewer columns than it has bytes is independently necessary, once we
 > have the correct maxwidth that is computed in terms of the strwidth,
 > so this patch is not wrong per-se, but it is incomplete without a
 > correct maxwidth, no?

 Yes. This fixes that and also mentions about ref names in utf-8.

 Documentation/revisions.txt |  2 ++
 builtin/branch.c            | 12 +++++++-----
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
index dc0070b..175d397 100644
--- a/Documentation/revisions.txt
+++ b/Documentation/revisions.txt
@@ -55,6 +55,8 @@ when you run `git cherry-pick`.
 +
 Note that any of the 'refs/*' cases above may come either from
 the '$GIT_DIR/refs' directory or from the '$GIT_DIR/packed-refs' file.
+While the ref name encoding is unspecified, UTF-8 is prefered as
+some output processing may assume ref names in UTF-8.
=20
 '<refname>@\{<date>\}', e.g. 'master@\{yesterday\}', 'HEAD@\{5 minutes=
 ago\}'::
   A ref followed by the suffix '@' with a date specification
diff --git a/builtin/branch.c b/builtin/branch.c
index 0e060f2..73ff7e7 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -17,6 +17,7 @@
 #include "revision.h"
 #include "string-list.h"
 #include "column.h"
+#include "utf8.h"
=20
 static const char * const builtin_branch_usage[] =3D {
 	"git branch [options] [-r | -a] [--merged | --no-merged]",
@@ -354,7 +355,7 @@ static int append_ref(const char *refname, const un=
signed char *sha1, int flags,
 	newitem->name =3D xstrdup(refname);
 	newitem->kind =3D kind;
 	newitem->commit =3D commit;
-	newitem->len =3D strlen(refname);
+	newitem->len =3D utf8_strwidth(refname);
 	newitem->dest =3D resolve_symref(orig_refname, prefix);
 	/* adjust for "remotes/" */
 	if (newitem->kind =3D=3D REF_REMOTE_BRANCH &&
@@ -490,11 +491,12 @@ static void print_ref_item(struct ref_item *item,=
 int maxwidth, int verbose,
 	}
=20
 	strbuf_addf(&name, "%s%s", prefix, item->name);
-	if (verbose)
+	if (verbose) {
+		int utf8_compensation =3D strlen(name.buf) - utf8_strwidth(name.buf)=
;
 		strbuf_addf(&out, "%c %s%-*s%s", c, branch_get_color(color),
-			    maxwidth, name.buf,
+			    maxwidth + utf8_compensation, name.buf,
 			    branch_get_color(BRANCH_COLOR_RESET));
-	else
+	} else
 		strbuf_addf(&out, "%c %s%s%s", c, branch_get_color(color),
 			    name.buf, branch_get_color(BRANCH_COLOR_RESET));
=20
@@ -533,7 +535,7 @@ static void show_detached(struct ref_list *ref_list=
)
 	if (head_commit && is_descendant_of(head_commit, ref_list->with_commi=
t)) {
 		struct ref_item item;
 		item.name =3D xstrdup(_("(no branch)"));
-		item.len =3D strlen(item.name);
+		item.len =3D utf8_strwidth(item.name);
 		item.kind =3D REF_LOCAL_BRANCH;
 		item.dest =3D NULL;
 		item.commit =3D head_commit;
--=20
1.7.12.rc2.18.g61b472e
