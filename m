From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 4/4] git --paginate: do not commit pager choice too early
Date: Sat, 26 Jun 2010 14:26:37 -0500
Message-ID: <20100626192637.GD20051@burratino>
References: <20100626192203.GA19973@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 26 21:26:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OSb1k-0000dl-LX
	for gcvg-git-2@lo.gmane.org; Sat, 26 Jun 2010 21:26:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753901Ab0FZT0w convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 26 Jun 2010 15:26:52 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:62230 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752287Ab0FZT0v (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jun 2010 15:26:51 -0400
Received: by iwn41 with SMTP id 41so3107195iwn.19
        for <git@vger.kernel.org>; Sat, 26 Jun 2010 12:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=6ce8NsM4oRCt0kamCm7hjJUOrauYzxzHgiLFOVoHXKM=;
        b=BtpA2377t5x47L4UhRanIHwWlz+Y/Oddf0pSSw0OqaXQUD1zqHfxK4UoABKTgFvxFW
         DZ2TD+VDqiGHy5+NB77UcCBOZwNZUJ4YScGb50BbHT4dAYEDJSGhQkbvR9X6plycdckc
         Y/8Hqljdtvkf9uzCfWjI9DKmZG8EuIffPCqSs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=ZCiA0H5pDoxz504wq5cnMuffMTh4k8I4gWACeXelYHezczhuJzM/83yL3NkmLDytyg
         YWKsnSmBpb50N6tdJxDLOV6DeUKCiehL6MxTGN6I/sRZTPQmweb3RtU68UC4Ma+qlWZl
         sDbLNnMvHmq0Io+1aBduKLeTsH89NWIbMgL7M=
Received: by 10.231.167.80 with SMTP id p16mr2736991iby.94.1277580410753;
        Sat, 26 Jun 2010 12:26:50 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id g31sm5546194ibh.2.2010.06.26.12.26.50
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 26 Jun 2010 12:26:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100626192203.GA19973@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149775>

=46rom: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>

When git is passed the --paginate option, starting up a pager requires
deciding what pager to start, which requires access to the core.pager
configuration.

At the relevant moment, the repository has not been searched for yet.
Attempting to access the configuration at this point results in
git_dir being set to .git [*], which is almost certainly not what was
wanted.  In particular, when run from a subdirectory of the toplevel,
git --paginate does not respect the core.pager setting from the
current repository.

[*] unless GIT_DIR or GIT_CONFIG is set

So delay the pager startup when possible:

1. run_argv() already commits pager choice inside run_builtin() if a
   command is found.  For commands that use RUN_SETUP, waiting until
   then fixes the problem described above: once git knows where to
   look, it happily respects the core.pager setting.

2. list_common_cmds_help() prints out 29 lines and exits.  This can
   benefit from pagination, so we need to commit the pager choice
   before writing this output.

   Luckily =E2=80=98git=E2=80=99 without subcommand has no other reason=
 to access a
   repository, so it would be intuitive to ignore repository-local
   configuration in this case.  Simpler for now to choose a pager
   using the funny code that notices a repository that happens to be
   at .git.  That this accesses a repository when it is very
   convenient to is a bug but not an important one.

3. help_unknown_cmd() prints out a few lines to stderr.  It is not
   important to paginate this, so don=E2=80=99t.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Thanks for reading.

 git.c            |    2 +-
 t/t7006-pager.sh |   58 ++++++++++++++++++++++++++++++++++++++++++----=
-------
 2 files changed, 47 insertions(+), 13 deletions(-)

diff --git a/git.c b/git.c
index 99f0363..25e7693 100644
--- a/git.c
+++ b/git.c
@@ -511,12 +511,12 @@ int main(int argc, const char **argv)
 	argv++;
 	argc--;
 	handle_options(&argv, &argc, NULL);
-	commit_pager_choice();
 	if (argc > 0) {
 		if (!prefixcmp(argv[0], "--"))
 			argv[0] +=3D 2;
 	} else {
 		/* The user didn't specify a command; give them help */
+		commit_pager_choice();
 		printf("usage: %s\n\n", git_usage_string);
 		list_common_cmds_help();
 		printf("\n%s\n", git_more_info_string);
diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
index 2b106be..eefef45 100755
--- a/t/t7006-pager.sh
+++ b/t/t7006-pager.sh
@@ -244,9 +244,21 @@ test_PAGER_overrides() {
 }
=20
 test_core_pager_overrides() {
+	if_local_config=3D
+	used_if_wanted=3D'overrides PAGER'
+	test_core_pager "$@"
+}
+
+test_local_config_ignored() {
+	if_local_config=3D'! '
+	used_if_wanted=3D'is not used'
+	test_core_pager "$@"
+}
+
+test_core_pager() {
 	parse_args "$@"
=20
-	$test_expectation TTY "$cmd - core.pager overrides PAGER" "
+	$test_expectation TTY "$cmd - repository-local core.pager setting $us=
ed_if_wanted" "
 		unset GIT_PAGER;
 		rm -f core.pager_used ||
 		cleanup_fail &&
@@ -255,14 +267,26 @@ test_core_pager_overrides() {
 		export PAGER &&
 		git config core.pager 'wc >core.pager_used' &&
 		$full_command &&
-		test -e core.pager_used
+		${if_local_config}test -e core.pager_used
 	"
 }
=20
 test_core_pager_subdir() {
+	if_local_config=3D
+	used_if_wanted=3D'overrides PAGER'
+	test_pager_subdir_helper "$@"
+}
+
+test_no_local_config_subdir() {
+	if_local_config=3D'! '
+	used_if_wanted=3D'is not used'
+	test_pager_subdir_helper "$@"
+}
+
+test_pager_subdir_helper() {
 	parse_args "$@"
=20
-	$test_expectation TTY "$cmd - core.pager from subdirectory" "
+	$test_expectation TTY "$cmd - core.pager $used_if_wanted from subdire=
ctory" "
 		unset GIT_PAGER;
 		rm -f core.pager_used &&
 		rm -fr sub ||
@@ -277,7 +301,7 @@ test_core_pager_subdir() {
 			cd sub &&
 			$full_command
 		) &&
-		test -e core.pager_used
+		${if_local_config}test -e core.pager_used
 	"
 }
=20
@@ -296,6 +320,20 @@ test_GIT_PAGER_overrides() {
 	"
 }
=20
+test_doesnt_paginate() {
+	parse_args "$@"
+
+	$test_expectation TTY "no pager for '$cmd'" "
+		rm -f GIT_PAGER_used ||
+		cleanup_fail &&
+
+		GIT_PAGER=3D'wc >GIT_PAGER_used' &&
+		export GIT_PAGER &&
+		$full_command &&
+		! test -e GIT_PAGER_used
+	"
+}
+
 test_default_pager        expect_success 'git log'
 test_PAGER_overrides      expect_success 'git log'
 test_core_pager_overrides expect_success 'git log'
@@ -305,19 +343,15 @@ test_GIT_PAGER_overrides  expect_success 'git log=
'
 test_default_pager        expect_success 'git -p log'
 test_PAGER_overrides      expect_success 'git -p log'
 test_core_pager_overrides expect_success 'git -p log'
-test_core_pager_subdir    expect_failure 'git -p log'
+test_core_pager_subdir    expect_success 'git -p log'
 test_GIT_PAGER_overrides  expect_success 'git -p log'
=20
 test_default_pager        expect_success test_must_fail 'git -p'
 test_PAGER_overrides      expect_success test_must_fail 'git -p'
-test_core_pager_overrides expect_success test_must_fail 'git -p'
-test_core_pager_subdir    expect_failure test_must_fail 'git -p'
+test_local_config_ignored expect_failure test_must_fail 'git -p'
+test_no_local_config_subdir expect_success test_must_fail 'git -p'
 test_GIT_PAGER_overrides  expect_success test_must_fail 'git -p'
=20
-test_default_pager        expect_success test_must_fail 'git -p nonsen=
se'
-test_PAGER_overrides      expect_success test_must_fail 'git -p nonsen=
se'
-test_core_pager_overrides expect_success test_must_fail 'git -p nonsen=
se'
-test_core_pager_subdir    expect_failure test_must_fail 'git -p nonsen=
se'
-test_GIT_PAGER_overrides  expect_success test_must_fail 'git -p nonsen=
se'
+test_doesnt_paginate      expect_success test_must_fail 'git -p nonsen=
se'
=20
 test_done
--=20
1.7.1.579.ge2549
