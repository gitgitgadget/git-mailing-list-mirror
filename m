From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 10/12] rerere: migrate to parse-options API
Date: Thu, 5 Aug 2010 06:28:37 -0500
Message-ID: <20100805112837.GL13779@burratino>
References: <cover.1278093311.git.eyvind.bernhardsen@gmail.com>
 <20100804031935.GA19699@burratino>
 <20100804032338.GF19699@burratino>
 <7vocdifdrk.fsf@alter.siamese.dyndns.org>
 <20100805110822.GB13779@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Finn Arne Gangstad <finnag@pvv.org>,
	"git@vger.kernel.org List" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 05 13:30:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OgyeI-0007S9-Ba
	for gcvg-git-2@lo.gmane.org; Thu, 05 Aug 2010 13:30:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933142Ab0HELaG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Aug 2010 07:30:06 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:49330 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932647Ab0HELaB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Aug 2010 07:30:01 -0400
Received: by iwn33 with SMTP id 33so95066iwn.19
        for <git@vger.kernel.org>; Thu, 05 Aug 2010 04:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=cU2IIjzS715mQJqAHKdNkVyzuG4XuMrZD36Ru6bqqug=;
        b=wnKxqTCvqmolz02ohomotuFAgtYwAG5qPR6rMwdzE0/Kz+gcOeZ/6qejEq4Q7rFVbE
         TqCu/6bf5TmxZt+fy46jfWwt06o8vHOvRIfd3gSkW9HYfVXVQy6nERt3NOEbcGAhZN53
         ezvBDP45BRQaNGoyNRkCSnr1SuhQ0mwkRANK0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=pyP2UCNAFSZUZjEp5jCsRDX1KVScnaATAPgdqsjtPDZDYlKW41sbGZeTLR/E5TwdLa
         AEKYGT9IS0Pv19MnRKqZWVfBUcN1yy6JmGm8YAgnjnOLwjP/jbLJrg9AHLnNTpD0a8Zt
         /421n4zdjgQBSv508CM48DAlwVNHhrVFj5bes=
Received: by 10.231.146.129 with SMTP id h1mr11459227ibv.181.1281007800717;
        Thu, 05 Aug 2010 04:30:00 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id r3sm63450ibk.1.2010.08.05.04.30.00
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 05 Aug 2010 04:30:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100805110822.GB13779@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152642>

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
The tests don=E2=80=99t pass for me with the old implementation; I thin=
k "2 < argc"
should have been "2 <=3D argc".  Well, no use dwelling in the past.

 builtin/rerere.c  |   52 ++++++++++++++++--------------
 t/t4200-rerere.sh |   91 +++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 2 files changed, 119 insertions(+), 24 deletions(-)

diff --git a/builtin/rerere.c b/builtin/rerere.c
index 0048f9e..295fe75 100644
--- a/builtin/rerere.c
+++ b/builtin/rerere.c
@@ -1,13 +1,16 @@
 #include "builtin.h"
 #include "cache.h"
 #include "dir.h"
+#include "parse-options.h"
 #include "string-list.h"
 #include "rerere.h"
 #include "xdiff/xdiff.h"
 #include "xdiff-interface.h"
=20
-static const char git_rerere_usage[] =3D
-"git rerere [clear | status | diff | gc]";
+static const char * const rerere_usage[] =3D {
+	"git rerere [clear | status | diff | gc]",
+	NULL,
+};
=20
 /* these values are days */
 static int cutoff_noresolve =3D 15;
@@ -103,25 +106,26 @@ static int diff_two(const char *file1, const char=
 *label1,
 int cmd_rerere(int argc, const char **argv, const char *prefix)
 {
 	struct string_list merge_rr =3D { NULL, 0, 0, 1 };
-	int i, fd, flags =3D 0;
-
-	if (2 < argc) {
-		if (!strcmp(argv[1], "-h"))
-			usage(git_rerere_usage);
-		if (!strcmp(argv[1], "--rerere-autoupdate"))
-			flags =3D RERERE_AUTOUPDATE;
-		else if (!strcmp(argv[1], "--no-rerere-autoupdate"))
-			flags =3D RERERE_NOAUTOUPDATE;
-		if (flags) {
-			argc--;
-			argv++;
-		}
-	}
-	if (argc < 2)
+	int i, fd, autoupdate =3D -1, flags =3D 0;
+
+	struct option options[] =3D {
+		OPT_SET_INT(0, "rerere-autoupdate", &autoupdate,
+			"register clean resolutions in index", 1),
+		OPT_END(),
+	};
+
+	argc =3D parse_options(argc, argv, prefix, options, rerere_usage, 0);
+
+	if (autoupdate =3D=3D 1)
+		flags =3D RERERE_AUTOUPDATE;
+	if (autoupdate =3D=3D 0)
+		flags =3D RERERE_NOAUTOUPDATE;
+
+	if (argc < 1)
 		return rerere(flags);
=20
-	if (!strcmp(argv[1], "forget")) {
-		const char **pathspec =3D get_pathspec(prefix, argv + 2);
+	if (!strcmp(argv[0], "forget")) {
+		const char **pathspec =3D get_pathspec(prefix, argv + 1);
 		return rerere_forget(pathspec);
 	}
=20
@@ -129,26 +133,26 @@ int cmd_rerere(int argc, const char **argv, const=
 char *prefix)
 	if (fd < 0)
 		return 0;
=20
-	if (!strcmp(argv[1], "clear")) {
+	if (!strcmp(argv[0], "clear")) {
 		for (i =3D 0; i < merge_rr.nr; i++) {
 			const char *name =3D (const char *)merge_rr.items[i].util;
 			if (!has_rerere_resolution(name))
 				unlink_rr_item(name);
 		}
 		unlink_or_warn(git_path("rr-cache/MERGE_RR"));
-	} else if (!strcmp(argv[1], "gc"))
+	} else if (!strcmp(argv[0], "gc"))
 		garbage_collect(&merge_rr);
-	else if (!strcmp(argv[1], "status"))
+	else if (!strcmp(argv[0], "status"))
 		for (i =3D 0; i < merge_rr.nr; i++)
 			printf("%s\n", merge_rr.items[i].string);
-	else if (!strcmp(argv[1], "diff"))
+	else if (!strcmp(argv[0], "diff"))
 		for (i =3D 0; i < merge_rr.nr; i++) {
 			const char *path =3D merge_rr.items[i].string;
 			const char *name =3D (const char *)merge_rr.items[i].util;
 			diff_two(rerere_path(name, "preimage"), path, path, path);
 		}
 	else
-		usage(git_rerere_usage);
+		usage_with_options(rerere_usage, options);
=20
 	string_list_clear(&merge_rr, 1);
 	return 0;
diff --git a/t/t4200-rerere.sh b/t/t4200-rerere.sh
index 3ed4d1a..876f09a 100755
--- a/t/t4200-rerere.sh
+++ b/t/t4200-rerere.sh
@@ -292,4 +292,95 @@ test_expect_success 'merge --no-rerere-autoupdate'=
 '
 	test_cmp expected actual
 '
=20
+test_expect_success 'set up an unresolved merge' '
+	headblob=3D$(git rev-parse version2:file3) &&
+	mergeblob=3D$(git rev-parse fifth:file3) &&
+	cat >expected.unresolved <<-EOF &&
+	100644 $headblob 2	file3
+	100644 $mergeblob 3	file3
+	EOF
+
+	test_might_fail git config --unset rerere.autoupdate &&
+	git reset --hard &&
+	git checkout version2 &&
+	fifth=3D$(git rev-parse fifth) &&
+	echo "$fifth		branch 'fifth' of ." |
+	git fmt-merge-msg >msg &&
+	ancestor=3D$(git merge-base version2 fifth) &&
+	test_must_fail git merge-recursive "$ancestor" -- HEAD fifth &&
+
+	git ls-files --stage >failedmerge &&
+	cp file3 file3.conflict &&
+
+	git ls-files -u >actual &&
+	test_cmp expected.unresolved actual
+'
+
+test_expect_success 'explicit rerere' '
+	test_might_fail git config --unset rerere.autoupdate &&
+	git rm -fr --cached . &&
+	git update-index --index-info <failedmerge &&
+	cp file3.conflict file3 &&
+	test_must_fail git update-index --refresh -q &&
+
+	git rerere &&
+	git ls-files -u >actual &&
+	test_cmp expected.unresolved actual
+'
+
+test_expect_success 'explicit rerere with autoupdate' '
+	git config rerere.autoupdate true &&
+	git rm -fr --cached . &&
+	git update-index --index-info <failedmerge &&
+	cp file3.conflict file3 &&
+	test_must_fail git update-index --refresh -q &&
+
+	git rerere &&
+	git update-index --refresh
+'
+
+test_expect_success 'explicit rerere --rerere-autoupdate overrides' '
+	git config rerere.autoupdate false &&
+	git rm -fr --cached . &&
+	git update-index --index-info <failedmerge &&
+	cp file3.conflict file3 &&
+	git rerere &&
+	git ls-files -u >actual1 &&
+
+	git rm -fr --cached . &&
+	git update-index --index-info <failedmerge &&
+	cp file3.conflict file3 &&
+	git rerere --rerere-autoupdate &&
+	git update-index --refresh &&
+
+	git rm -fr --cached . &&
+	git update-index --index-info <failedmerge &&
+	cp file3.conflict file3 &&
+	git rerere --rerere-autoupdate --no-rerere-autoupdate &&
+	git ls-files -u >actual2 &&
+
+	git rm -fr --cached . &&
+	git update-index --index-info <failedmerge &&
+	cp file3.conflict file3 &&
+	git rerere --rerere-autoupdate --no-rerere-autoupdate --rerere-autoup=
date &&
+	git update-index --refresh &&
+
+	test_cmp expected.unresolved actual1 &&
+	test_cmp expected.unresolved actual2
+'
+
+test_expect_success 'rerere --no-no-rerere-autoupdate' '
+	git rm -fr --cached . &&
+	git update-index --index-info <failedmerge &&
+	cp file3.conflict file3 &&
+	test_must_fail git rerere --no-no-rerere-autoupdate 2>err &&
+	grep [Uu]sage err &&
+	test_must_fail git update-index --refresh
+'
+
+test_expect_success 'rerere -h' '
+	test_must_fail git rerere -h >help &&
+	grep [Uu]sage help
+'
+
 test_done
--=20
1.7.2.1.544.ga752d.dirty
