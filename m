From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 07/12] bundle: run setup_git_directory_gently() sooner
Date: Thu, 5 Aug 2010 22:12:46 -0500
Message-ID: <20100806031204.GK22369@burratino>
References: <20100626192203.GA19973@burratino>
 <7vpqzacs3h.fsf@alter.siamese.dyndns.org>
 <7v630hyf5r.fsf@alter.siamese.dyndns.org>
 <20100806023529.GB22369@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 06 05:14:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OhDNw-0007FE-ID
	for gcvg-git-2@lo.gmane.org; Fri, 06 Aug 2010 05:14:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935344Ab0HFDOK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Aug 2010 23:14:10 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:50791 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935337Ab0HFDOI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Aug 2010 23:14:08 -0400
Received: by gyg10 with SMTP id 10so2712228gyg.19
        for <git@vger.kernel.org>; Thu, 05 Aug 2010 20:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=dodSnGIL1Dq9lbCHOGqaFnpbzk3CkeInEx4VEpceWpU=;
        b=Q0YyLyuZChgbgKwgEet2rnLaKt/FXGvyjaFZ/bXeyRi0el5u6aBIv2Jg1QsBO7w4sa
         +mhPqXAwO/TkXIo+oJnAe+/e0WVRxlWFid5qlKwbGFqvr+Jx18/CZXElt6WdRWc5EugF
         bgxOA+kkK9IOXpbiaTEGYMZyRrLo3C0GWwk7M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=f7SuLs+T576b4jEpHGOlT2g0lfuxauC3TcPNyn9LL9un5xsAYfhJaNJvRPZUVxlzMB
         1kLVDq8++CR1hsXquzHn/k5jm/j+JVVW4p+/8nMjzLWRbh9glNRZbVYKKvrj8yAe6ZcG
         BSz4Ostx+4rbUQURT/fDNWaI9AP87Mov2yz/w=
Received: by 10.101.153.33 with SMTP id f33mr10030969ano.92.1281064447820;
        Thu, 05 Aug 2010 20:14:07 -0700 (PDT)
Received: from burratino (ip-64-32-208-34.chi.megapath.net [64.32.208.34])
        by mx.google.com with ESMTPS id u14sm1287388ann.20.2010.08.05.20.14.06
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 05 Aug 2010 20:14:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100806023529.GB22369@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152752>

=46rom: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>

Without this change, =E2=80=9Cgit -p bundle=E2=80=9D does not always
respect the repository-local =E2=80=9C[core] pager=E2=80=9D setting.

It is hard to notice because subcommands other than
=E2=80=9Cgit bundle unbundle=E2=80=9D do not produce much output.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
New tests and explanation.

The first new test perhaps deserves some explanation.  Its
only purpose is to let us use the=20

	test -e paginated.out || test -e subdir/paginated.out

hedge in other tests with good conscience.

 builtin/bundle.c |    6 ++----
 git.c            |    2 +-
 t/t7006-pager.sh |   33 +++++++++++++++++++++++++++++++++
 3 files changed, 36 insertions(+), 5 deletions(-)

diff --git a/builtin/bundle.c b/builtin/bundle.c
index 2006cc5..80649ba 100644
--- a/builtin/bundle.c
+++ b/builtin/bundle.c
@@ -18,7 +18,6 @@ static const char builtin_bundle_usage[] =3D
 int cmd_bundle(int argc, const char **argv, const char *prefix)
 {
 	struct bundle_header header;
-	int nongit;
 	const char *cmd, *bundle_file;
 	int bundle_fd =3D -1;
 	char buffer[PATH_MAX];
@@ -31,7 +30,6 @@ int cmd_bundle(int argc, const char **argv, const cha=
r *prefix)
 	argc -=3D 2;
 	argv +=3D 2;
=20
-	prefix =3D setup_git_directory_gently(&nongit);
 	if (prefix && bundle_file[0] !=3D '/') {
 		snprintf(buffer, sizeof(buffer), "%s/%s", prefix, bundle_file);
 		bundle_file =3D buffer;
@@ -54,11 +52,11 @@ int cmd_bundle(int argc, const char **argv, const c=
har *prefix)
 		return !!list_bundle_refs(&header, argc, argv);
 	}
 	if (!strcmp(cmd, "create")) {
-		if (nongit)
+		if (!startup_info->have_repository)
 			die("Need a repository to create a bundle.");
 		return !!create_bundle(&header, bundle_file, argc, argv);
 	} else if (!strcmp(cmd, "unbundle")) {
-		if (nongit)
+		if (!startup_info->have_repository)
 			die("Need a repository to unbundle.");
 		return !!unbundle(&header, bundle_fd) ||
 			list_bundle_refs(&header, argc, argv);
diff --git a/git.c b/git.c
index 82b390b..94bb1e3 100644
--- a/git.c
+++ b/git.c
@@ -306,7 +306,7 @@ static void handle_internal_command(int argc, const=
 char **argv)
 		{ "bisect--helper", cmd_bisect__helper, RUN_SETUP | NEED_WORK_TREE }=
,
 		{ "blame", cmd_blame, RUN_SETUP },
 		{ "branch", cmd_branch, RUN_SETUP },
-		{ "bundle", cmd_bundle },
+		{ "bundle", cmd_bundle, RUN_SETUP_GENTLY },
 		{ "cat-file", cmd_cat_file, RUN_SETUP },
 		{ "checkout", cmd_checkout, RUN_SETUP | NEED_WORK_TREE },
 		{ "checkout-index", cmd_checkout_index,
diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
index 96fbb0f..6680668 100755
--- a/t/t7006-pager.sh
+++ b/t/t7006-pager.sh
@@ -57,6 +57,21 @@ test_expect_success TTY 'some commands use a pager' =
'
 	test -e paginated.out
 '
=20
+test_expect_failure TTY 'pager runs from subdir' '
+	echo subdir/paginated.out >expected &&
+	mkdir -p subdir &&
+	rm -f paginated.out subdir/paginated.out &&
+	(
+		cd subdir &&
+		test_terminal git log
+	) &&
+	{
+		ls paginated.out subdir/paginated.out ||
+		:
+	} >actual &&
+	test_cmp expected actual
+'
+
 test_expect_success TTY 'some commands do not use a pager' '
 	rm -f paginated.out ||
 	cleanup_fail &&
@@ -118,6 +133,24 @@ test_expect_success TTY 'configuration can disable=
 pager' '
 	! test -e paginated.out
 '
=20
+test_expect_success 'configuration can enable pager (from subdir)' '
+	rm -f paginated.out &&
+	mkdir -p subdir &&
+	git config pager.bundle true &&
+	test_when_finished "git config --unset pager.bundle" &&
+
+	git bundle create test.bundle --all &&
+	rm -f paginated.out subdir/paginated.out &&
+	(
+		cd subdir &&
+		test_terminal git bundle unbundle ../test.bundle
+	) &&
+	{
+		test -e paginated.out ||
+		test -e subdir/paginated.out
+	}
+'
+
 # A colored commit log will begin with an appropriate ANSI escape
 # for the first color; the text "commit" comes later.
 colorful() {
--=20
1.7.2.1.544.ga752d.dirty
