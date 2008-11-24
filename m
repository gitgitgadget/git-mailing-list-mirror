From: Deskin Miller <deskinm@umich.edu>
Subject: [RFC PATCH 4/4] Make git fetch verify signed tags
Date: Sun, 23 Nov 2008 22:23:20 -0500
Message-ID: <1227497000-8684-5-git-send-email-deskinm@umich.edu>
References: <1227497000-8684-1-git-send-email-deskinm@umich.edu>
 <1227497000-8684-2-git-send-email-deskinm@umich.edu>
 <1227497000-8684-3-git-send-email-deskinm@umich.edu>
 <1227497000-8684-4-git-send-email-deskinm@umich.edu>
Cc: Deskin Miller <deskinm@umich.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 24 04:25:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L4S4L-00061G-6D
	for gcvg-git-2@gmane.org; Mon, 24 Nov 2008 04:25:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751871AbYKXDXk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Nov 2008 22:23:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751939AbYKXDXj
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Nov 2008 22:23:39 -0500
Received: from yx-out-2324.google.com ([74.125.44.28]:64271 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751723AbYKXDXc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Nov 2008 22:23:32 -0500
Received: by yx-out-2324.google.com with SMTP id 8so761713yxm.1
        for <git@vger.kernel.org>; Sun, 23 Nov 2008 19:23:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:sender;
        bh=HWxq2uIoHG8CJmlzOWm4OuhPrDZfrXsNAJxpDiwk0ro=;
        b=Jrv1FZqmK2IAa/pSUOvNOoVQLTpIoUX51d0I1f/4WnEjERWFXGPr+4FARFoxRXGau6
         qvCi6zYCTLgBh7WaAGp5S5HVBCGpfs6CZL3ltAeTF0kIu9z1RpgwbqyspOPsalqxI7RJ
         un4BoEQw4zdtt/LEXD1J+4+7bho+fm5Y4joAM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :sender;
        b=Zdt8G7jKDF/vH2howjN016OfpS91vTgvSB7p8hZYVKYwJ45Svijg7HCRJAjbqfqT8z
         2rTXDH21XBZWNlS88VVc+ABiIdAguZ59hwaexjhp/EG+aOv1qVMRHM5RfzaFWDyesArI
         UGSTcTkae7sWZol45Az3fjZapGpKwZt2CCC+c=
Received: by 10.150.196.5 with SMTP id t5mr2397286ybf.202.1227497011530;
        Sun, 23 Nov 2008 19:23:31 -0800 (PST)
Received: from localhost.localdomain ([152.160.57.162])
        by mx.google.com with ESMTPS id a13sm6706484rnc.12.2008.11.23.19.23.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 23 Nov 2008 19:23:30 -0800 (PST)
X-Mailer: git-send-email 1.6.0.4.770.ga8394
In-Reply-To: <1227497000-8684-4-git-send-email-deskinm@umich.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101587>

When git fetch downloads signed tag objects, make it verify them right
then.  This extends the output summary of fetch to include "(good
signature)" for valid tags and "(BAD SIGNATURE)" for invalid tags.  If
the user does not have the correct key in the gpg keyring, gpg returns
2, verify_tag_sha1 returns -2 and nothing additional is output about
the tag's validity.

Alternate fetch method 'git remote update' gets this check as well due
to the use of the fetch routines.

Signed-off-by: Deskin Miller <deskinm@umich.edu>
---
 builtin-fetch.c |   25 ++++++++++++++++++-------
 t/t7004-tag.sh  |   37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+), 7 deletions(-)

diff --git a/builtin-fetch.c b/builtin-fetch.c
index f151cfa..f7a50b7 100644
--- a/builtin-fetch.c
+++ b/builtin-fetch.c
@@ -10,6 +10,7 @@
 #include "transport.h"
 #include "run-command.h"
 #include "parse-options.h"
+#include "verify-tag.h"
 
 static const char * const builtin_fetch_usage[] = {
 	"git fetch [options] [<repository> <refspec>...]",
@@ -233,11 +234,16 @@ static int update_local_ref(struct ref *ref,
 
 	if (!is_null_sha1(ref->old_sha1) &&
 	    !prefixcmp(ref->name, "refs/tags/")) {
-		int r;
+		int r, v;
 		r = s_update_ref("updating tag", ref, 0);
-		sprintf(display, "%c %-*s %-*s -> %s%s", r ? '!' : '-',
+		if (type == OBJ_TAG)
+			v = verify_tag_sha1(ref->new_sha1, -1);
+		sprintf(display, "%c %-*s %-*s -> %s%s", r ? '!' :
+			(type == OBJ_TAG ? (v == -1 ? '!' : '-') : '-'),
 			SUMMARY_WIDTH, "[tag update]", REFCOL_WIDTH, remote,
-			pretty_ref, r ? "  (unable to update local ref)" : "");
+			pretty_ref, r ? "  (unable to update local ref)" :
+			(type == OBJ_TAG ? (v == 0 ? " (good signature)" :
+			(v == -1 ? " (BAD SIGNATURE)" : "")) : ""));
 		return r;
 	}
 
@@ -246,7 +252,7 @@ static int update_local_ref(struct ref *ref,
 	if (!current || !updated) {
 		const char *msg;
 		const char *what;
-		int r;
+		int r, v;
 		if (!strncmp(ref->name, "refs/tags/", 10)) {
 			msg = "storing tag";
 			what = "[new tag]";
@@ -257,9 +263,14 @@ static int update_local_ref(struct ref *ref,
 		}
 
 		r = s_update_ref(msg, ref, 0);
-		sprintf(display, "%c %-*s %-*s -> %s%s", r ? '!' : '*',
-			SUMMARY_WIDTH, what, REFCOL_WIDTH, remote, pretty_ref,
-			r ? "  (unable to update local ref)" : "");
+		if (type == OBJ_TAG)
+			v = verify_tag_sha1(ref->new_sha1, -1);
+		sprintf(display, "%c %-*s %-*s -> %s%s", r ? '!' :
+			(type == OBJ_TAG ? (v == -1 ? '!' : '*') : '*'),
+			SUMMARY_WIDTH, what, REFCOL_WIDTH, remote,
+			pretty_ref, r ? "  (unable to update local ref)" :
+			(type == OBJ_TAG ? (v == 0 ? " (good signature)" :
+			(v == -1 ? " (BAD SIGNATURE)" : "")) : ""));
 		return r;
 	}
 
diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index f377fea..00327cc 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -1037,6 +1037,43 @@ test_expect_success \
 	'test_must_fail git tag -s -m tail tag-gpg-failure'
 git config --unset user.signingkey
 
+git tag -s -m 'good tag' good-tag HEAD
+bad=$(git cat-file tag good-tag | sed -e 's/good-tag/bad-tag/' | git mktag)
+git tag bad-tag $bad
+head=$(git rev-parse HEAD)
+nonkey=$(cat <<EOF | git mktag
+object $head
+type commit
+tag v1.6.0.4
+tagger Junio C Hamano <gitster@pobox.com> 1226208581 -0800
+
+GIT 1.6.0.4
+-----BEGIN PGP SIGNATURE-----
+Version: GnuPG v1.4.9 (GNU/Linux)
+
+iEYEABECAAYFAkkWdUUACgkQwMbZpPMRm5rSmwCfWu+K/hXyLUnEWoOMYy1eKuMK
+KcoAnjB2qir794ibWPy6cn11uUbk7AlC
+=eaFZ
+-----END PGP SIGNATURE-----
+EOF
+)
+git tag nonkey-tag $nonkey
+
+echo 'bad-tag (BAD SIGNATURE)' > expect
+echo 'good-tag (good signature)' >> expect
+echo 'nonkey-tag' >> expect
+
+test_expect_success \
+	'git fetch verifies tags' \
+	'mkdir clone &&
+	(cd clone &&
+	git init &&
+	git remote add origin file://"$(cd .. && pwd)" &&
+	git fetch origin 2>../actual) &&
+	sed -i -ne "/ \(bad\|good\|nonkey\)-tag/s/^.*->[^a-z]*//p" actual &&
+	test_cmp expect actual
+	'
+
 # try to verify without gpg:
 
 rm -rf gpghome
-- 
1.6.0.4.770.ga8394
