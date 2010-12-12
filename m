From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/2] get_sha1: support ref^{/regex} syntax
Date: Sun, 12 Dec 2010 17:56:59 +0700
Message-ID: <1292151419-30678-2-git-send-email-pclouds@gmail.com>
References: <1292151419-30678-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Kevin Ballard <kevin@sb.org>, Yann Dirson <dirson@bertin.fr>,
	Jeff King <peff@peff.net>, Jakub Narebski <jnareb@gmail.com>,
	Jonathan Niedier <jrnieder@gmail.com>,
	Thiago Farina <tfransosi@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 12 11:58:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PRjdK-0008IZ-Rg
	for gcvg-git-2@lo.gmane.org; Sun, 12 Dec 2010 11:58:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752496Ab0LLK6I convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 12 Dec 2010 05:58:08 -0500
Received: from mail-pz0-f46.google.com ([209.85.210.46]:54233 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752149Ab0LLK6G (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Dec 2010 05:58:06 -0500
Received: by pzk6 with SMTP id 6so357995pzk.19
        for <git@vger.kernel.org>; Sun, 12 Dec 2010 02:58:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=v1ljaRXFVgdhPrmJ/XfLMkFEB7p9mz2iqf+DgG7bKbw=;
        b=hTRlOXUwA+K7MJumrCIyDQrjHiR23amr2ll9g1NGCNI5s8kZkaqQSUV2T9s/hJFqWA
         Nwh0gZbp8MNYnGz8iiPqihQymCoL+Rei+DaqXyn3/lzbAF4VEu3B6YHX8a8qgCB/lnLr
         MqJsM2k7m5/UDx1Q1eSsL7mKIH/K0P1RuErak=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=ZS4YEaBiYJgRE4f8pzkDP36gh1f8wCighW9+ToOMRMv6sZepgU1zwUJOg82BLn9M/N
         ZNsJU2dWTZ9UTGdaodmtASUSv6tgcp4bdx0ZWrAsC9pWqkWIVnMrFwP6nGDGVMElun65
         aEU8PeDZcjS1W+G/leElcAWM9BL9p+nJPNvGg=
Received: by 10.142.246.16 with SMTP id t16mr1640243wfh.307.1292151484914;
        Sun, 12 Dec 2010 02:58:04 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.222.178])
        by mx.google.com with ESMTPS id v19sm7141776wfh.12.2010.12.12.02.57.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 12 Dec 2010 02:58:03 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun, 12 Dec 2010 17:57:10 +0700
X-Mailer: git-send-email 1.7.3.3.476.g893a9
In-Reply-To: <1292151419-30678-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163478>

This works like :/ syntax, but only limited to one ref.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 No fancy modifiers, but still useful.

 Documentation/revisions.txt |    6 +++
 sha1_name.c                 |   35 ++++++++++++++------
 t/t1511-rev-parse-caret.sh  |   73 +++++++++++++++++++++++++++++++++++=
++++++++
 3 files changed, 103 insertions(+), 11 deletions(-)
 create mode 100755 t/t1511-rev-parse-caret.sh

diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
index 3d4b79c..174fa8e 100644
--- a/Documentation/revisions.txt
+++ b/Documentation/revisions.txt
@@ -106,6 +106,12 @@ the `$GIT_DIR/refs` directory or from the `$GIT_DI=
R/packed-refs` file.
   and dereference the tag recursively until a non-tag object is
   found.
=20
+* A suffix '{caret}' to a revision parameter followed by a brace
+  pair that contains a text led by a slash (e.g. `HEAD^{/fix nasty bug=
}`):
+  this is the same as `:/fix nasty bug` syntax below except that
+  it returns the youngest matching commit which is reachable from
+  the ref before '{caret}'.
+
 * A colon, followed by a slash, followed by a text (e.g. `:/fix nasty =
bug`): this names
   a commit whose commit message matches the specified regular expressi=
on.
   This name returns the youngest matching commit which is
diff --git a/sha1_name.c b/sha1_name.c
index c298285..f1a86d9 100644
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
@@ -562,6 +563,8 @@ static int peel_onion(const char *name, int len, un=
signed char *sha1)
 		expected_type =3D OBJ_BLOB;
 	else if (sp[0] =3D=3D '}')
 		expected_type =3D OBJ_NONE;
+	else if (sp[0] =3D=3D '/')
+		expected_type =3D OBJ_COMMIT;
 	else
 		return -1;
=20
@@ -576,19 +579,29 @@ static int peel_onion(const char *name, int len, =
unsigned char *sha1)
 		if (!o || (!o->parsed && !parse_object(o->sha1)))
 			return -1;
 		hashcpy(sha1, o->sha1);
+		return 0;
 	}
-	else {
-		/*
-		 * At this point, the syntax look correct, so
-		 * if we do not get the needed object, we should
-		 * barf.
-		 */
-		o =3D peel_to_type(name, len, o, expected_type);
-		if (o) {
-			hashcpy(sha1, o->sha1);
-			return 0;
-		}
+
+	/*
+	 * At this point, the syntax look correct, so if we do not get
+	 * the needed object, we should barf.
+	 */
+	o =3D peel_to_type(name, len, o, expected_type);
+	if (!o)
 		return -1;
+
+	hashcpy(sha1, o->sha1);
+	if (sp[0] =3D=3D '/') { /* ^{/foo} */
+		struct commit_list *list =3D NULL;
+		char *prefix;
+		int ret;
+
+		commit_list_insert((struct commit *)o, &list);
+		prefix =3D xstrndup(sp + 1, name + len - 1 - (sp + 1));
+		ret =3D get_sha1_oneline(prefix, sha1, list);
+		free(prefix);
+		free_commit_list(list);
+		return ret;
 	}
 	return 0;
 }
diff --git a/t/t1511-rev-parse-caret.sh b/t/t1511-rev-parse-caret.sh
new file mode 100755
index 0000000..5c8439c
--- /dev/null
+++ b/t/t1511-rev-parse-caret.sh
@@ -0,0 +1,73 @@
+#!/bin/sh
+
+test_description=3D'tests for ref^{stuff}'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	echo blob >a-blob &&
+	git tag -a -m blob blob-tag `git hash-object -w a-blob`
+	mkdir a-tree &&
+	echo moreblobs >a-tree/another-blob &&
+	git add . &&
+	TREE_SHA1=3D`git write-tree` &&
+	git tag -a -m tree tree-tag "$TREE_SHA1" &&
+	git commit -m Initial &&
+	git tag -a -m commit commit-tag &&
+	git branch ref &&
+	git checkout master &&
+	echo modified >>a-blob &&
+	git add -u &&
+	git commit -m Modified
+'
+
+test_expect_success 'ref^{non-existent}' '
+	test_must_fail git rev-parse ref^{non-existent}
+'
+
+test_expect_success 'ref^{}' '
+	git rev-parse ref >expected &&
+	git rev-parse ref^{} >actual &&
+	test_cmp expected actual &&
+	git rev-parse commit-tag^{} >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'ref^{commit}' '
+	git rev-parse ref >expected &&
+	git rev-parse ref^{commit} >actual &&
+	test_cmp expected actual &&
+	git rev-parse commit-tag^{commit} >actual &&
+	test_cmp expected actual &&
+	test_must_fail git rev-parse tree-tag^{commit} &&
+	test_must_fail git rev-parse blob-tag^{commit}
+'
+
+test_expect_success 'ref^{tree}' '
+	echo $TREE_SHA1 >expected &&
+	git rev-parse ref^{tree} >actual &&
+	test_cmp expected actual &&
+	git rev-parse commit-tag^{tree} >actual &&
+	test_cmp expected actual &&
+	git rev-parse tree-tag^{tree} >actual &&
+	test_cmp expected actual &&
+	test_must_fail git rev-parse blob-tag^{tree}
+'
+
+test_expect_success 'ref^{/}' '
+	git rev-parse master >expected &&
+	git rev-parse master^{/} >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'ref^{/non-existent}' '
+	test_must_fail git rev-parse master^{/non-existent}
+'
+
+test_expect_success 'ref^{/Initial}' '
+	git rev-parse ref >expected &&
+	git rev-parse master^{/Initial} >actual &&
+	test_cmp expected actual
+'
+
+test_done
--=20
1.7.3.3.476.g893a9
