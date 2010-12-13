From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] get_sha1_oneline: do not leak or double free
Date: Sun, 12 Dec 2010 22:43:16 -0800
Message-ID: <7vk4je5g1n.fsf@alter.siamese.dyndns.org>
References: <1292209275-17451-1-git-send-email-pclouds@gmail.com>
 <7v1v5m6w26.fsf@alter.siamese.dyndns.org>
 <7vvd2y5h63.fsf@alter.siamese.dyndns.org>
 <7voc8q5gll.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Niedier <jrnieder@gmail.com>,
	Kevin Ballard <kevin@sb.org>, Yann Dirson <dirson@bertin.fr>,
	Jeff King <peff@peff.net>, Jakub Narebski <jnareb@gmail.com>,
	Thiago Farina <tfransosi@gmail.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 13 07:43:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PS28Q-0003mK-Bp
	for gcvg-git-2@lo.gmane.org; Mon, 13 Dec 2010 07:43:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752040Ab0LMGnj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Dec 2010 01:43:39 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:59344 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751162Ab0LMGni convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Dec 2010 01:43:38 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 45907222A;
	Mon, 13 Dec 2010 01:44:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=1rr8xP6mdPHF
	gf4VQ1WbhcBpEyQ=; b=QTlwhCnG75G2PSHtclmrIJuONTBoH9jKbycMfvi22EWu
	/wDqUvMVQPEy/NWdFwGDF48NL1gekCAVnd8kavdNcB/pNLu4OpBekaLSjAfxrxIe
	5a9PwMCJ4yQwWjdR29pzEhc/YKVrKIALEiJY6Fb2OChkKwHQ/SOawqtzUxrRhhY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=wdu1T1
	BM5ttTWg/BAXBeCEV9Ea9F2TnBgbNiRLQOxI6HxDFZs29E2GU+nxD80p3ZiRsk2O
	+JukLpcWiwBsnBqojADOKOcsy+mCcF282f0XAnv+OnoHML6NJCoZAb6ozLkIb9Qn
	BVFbHrS34psdlFiml2OnXG1/1rRrfwk+en/ek=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B46ED2229;
	Mon, 13 Dec 2010 01:43:53 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 38EA42228; Mon, 13 Dec 2010
 01:43:42 -0500 (EST)
In-Reply-To: <7voc8q5gll.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun\, 12 Dec 2010 22\:31\:18 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 5A06B6F4-0684-11E0-8FCD-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163519>

=2E.. and this is [3/3], whose sha1_name.c part needed some adjustment.

-- >8 --
=46rom: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>
Date: Mon, 13 Dec 2010 10:01:15 +0700
Subject: [PATCH] get_sha1: support $commit^{/regex} syntax

This works like ":/regex" syntax that finds a recently created commit
starting from all refs, but limits the discovery to those reachable fro=
m
the named commit.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/revisions.txt |    6 +++
 sha1_name.c                 |   37 +++++++++++++++------
 t/t1511-rev-parse-caret.sh  |   73 +++++++++++++++++++++++++++++++++++=
++++++++
 3 files changed, 105 insertions(+), 11 deletions(-)
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
index aefae1f..1ba4bc3 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -7,6 +7,8 @@
 #include "refs.h"
 #include "remote.h"
=20
+static int get_sha1_oneline(const char *, unsigned char *, struct comm=
it_list *);
+
 static int find_short_object_filename(int len, const char *name, unsig=
ned char *sha1)
 {
 	struct alternate_object_database *alt;
@@ -562,6 +564,8 @@ static int peel_onion(const char *name, int len, un=
signed char *sha1)
 		expected_type =3D OBJ_BLOB;
 	else if (sp[0] =3D=3D '}')
 		expected_type =3D OBJ_NONE;
+	else if (sp[0] =3D=3D '/')
+		expected_type =3D OBJ_COMMIT;
 	else
 		return -1;
=20
@@ -576,19 +580,30 @@ static int peel_onion(const char *name, int len, =
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
+	 * At this point, the syntax look correct, so
+	 * if we do not get the needed object, we should
+	 * barf.
+	 */
+	o =3D peel_to_type(name, len, o, expected_type);
+	if (!o)
 		return -1;
+
+	hashcpy(sha1, o->sha1);
+	if (sp[0] =3D=3D '/') {
+		/* "$commit^{/foo}" */
+		char *prefix;
+		int ret;
+		struct commit_list *list =3D NULL;
+
+		prefix =3D xstrndup(sp + 1, name + len - 1 - (sp + 1));
+		commit_list_insert((struct commit *)o, &list);
+		ret =3D get_sha1_oneline(prefix, sha1, list);
+		free(prefix);
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
1.7.3.3.763.g91c7d
