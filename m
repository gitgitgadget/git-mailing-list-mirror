From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 3/9 v2] builtins: do not commit pager choice early
Date: Tue, 13 Apr 2010 21:17:04 -0500
Message-ID: <20100414021704.GA22766@progeny.tock>
References: <20100413021153.GA3978@progeny.tock>
 <20100413022420.GC4118@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 14 04:17:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O1sAM-0000qB-BP
	for gcvg-git-2@lo.gmane.org; Wed, 14 Apr 2010 04:17:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754586Ab0DNCRO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 13 Apr 2010 22:17:14 -0400
Received: from mail-gx0-f217.google.com ([209.85.217.217]:50219 "EHLO
	mail-gx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754576Ab0DNCRK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Apr 2010 22:17:10 -0400
Received: by gxk9 with SMTP id 9so4537606gxk.8
        for <git@vger.kernel.org>; Tue, 13 Apr 2010 19:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=Ku6EdTW5eNGCBxmK/tt8wmkVHVcKkQL/qEh40W1ZLaM=;
        b=Rh4E2HMBe+kc/sU9j9PJhcRnUe9hBYS0RXyHJjloir5JNQ+RX619TOrGKeLDzeqBgl
         j5MseSMvX2EEEcro064SzMqMxs95f5mYF8EIj9GN/hwGMi63FyfQjjL2o95O/rdh9jeG
         8pPjuCAeS2G22FraffG75eGjve0/6eMxJd/ME=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=V0cD6ZnyT/LPbYKfDDH85KDH+V9KBNkwVtojaGS8zbMX+YI1ix5TSQCdb0zjXzaY31
         bStM0N6k14VOLu1c28wgg+0RCEOhboOuwM4rpts/nreF7G7j0QPCE6QUdTON8/bgEyu+
         XzhQhdj2C8Y9DxsoKK59t7DLaohfskFpY3fDE=
Received: by 10.150.174.9 with SMTP id w9mr5797799ybe.0.1271211428230;
        Tue, 13 Apr 2010 19:17:08 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 4sm1662422ywd.58.2010.04.13.19.17.06
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 13 Apr 2010 19:17:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100413022420.GC4118@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144843>

=46rom: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>

If git is passed the --paginate option, committing the pager choice
will require setting up a pager, which requires access to repository
for the core.pager configuration.

After handle_options() is called, the repository has not been searched
for yet.  Unless GIT_DIR or GIT_CONFIG is set, attempting to access
the configuration at this point results in git_dir being set to .git,
which is almost certainly not what was wanted.  If a git command is
run from a subdirectory of the toplevel directory of a git repository
and the --paginate option is supplied, the core.pager setting from
that repository is not being respected.

There are several possible code paths after handle_options() and
commit_pager_choice() are called:

1. list_common_cmds_help() is a printout of 29 lines.  This can
   benefit from pagination, so do commit the pager choice before
   writing this output.

   Since =E2=80=98git=E2=80=99 without subcommand has no other reason t=
o access the
   repository, ideally this would not involve accessing the
   repository-specific configuration file.  But for now, it is simpler
   to commit the pager choice using the funny code that would notice
   whatever repository happens to be at .git.  That this accesses a
   repository if it happens to be very convenient is a bug but not
   a very important one.

2. run_argv() already commits pager choice inside run_builtin() if a
   command is found.  If the relevant git subcommand searches for a
   git directory, not commiting to a pager before then means the
   core.pager setting from the correct $GIT_DIR/config will be
   respected.

3. help_unknown_cmd() prints out a few lines to stderr.  It is not
   important to paginate this, so don=E2=80=99t.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Rebased on top of patch 2 v2

 git.c            |    2 +-
 t/t7006-pager.sh |   63 +++++++++++++++++++++++++++++++++++++++++++---=
-------
 2 files changed, 52 insertions(+), 13 deletions(-)

diff --git a/git.c b/git.c
index 6bae305..32720e5 100644
--- a/git.c
+++ b/git.c
@@ -502,12 +502,12 @@ int main(int argc, const char **argv)
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
index d5f8a18..a240b15 100755
--- a/t/t7006-pager.sh
+++ b/t/t7006-pager.sh
@@ -190,27 +190,58 @@ test_PAGER_overrides() {
 	"
 }
=20
+parse_ifwanted_arg() {
+	if test "$1" =3D yes
+	then
+		if_want_local_config=3D
+		used_if_wanted=3D'overrides PAGER'
+	else
+		if_want_local_config=3D'! '
+		used_if_wanted=3D'is not used'
+	fi
+}
+
 test_core_pager_overrides() {
+	test_core_pager yes "$@"
+}
+
+test_local_config_ignored() {
+	test_core_pager no "$@"
+}
+
+test_core_pager() {
+	parse_ifwanted_arg "$1"
+	shift
 	parse_args "$@"
=20
 	unset GIT_PAGER
 	rm -f core.pager_used
-	$test_expectation TTY "$cmd - core.pager overrides PAGER" "
+	$test_expectation TTY "$cmd - core.pager $used_if_wanted" "
 		PAGER=3Dwc &&
 		export PAGER &&
 		git config core.pager 'wc > core.pager_used' &&
 		$full_command &&
-		test -e core.pager_used
+		${if_want_local_config}test -e core.pager_used
 	"
 }
=20
 test_core_pager_subdir() {
+	test_pager_subdir_helper yes "$@"
+}
+
+test_no_local_config_subdir() {
+	test_pager_subdir_helper no "$@"
+}
+
+test_pager_subdir_helper() {
+	parse_ifwanted_arg "$1"
+	shift
 	parse_args "$@"
=20
 	unset GIT_PAGER
 	rm -f core.pager_used
 	rm -fr sub
-	$test_expectation TTY "$cmd - core.pager from subdirectory" "
+	$test_expectation TTY "$cmd - core.pager $used_if_wanted from subdire=
ctory" "
 		stampname=3D\$(pwd)/core.pager_used &&
 		PAGER=3Dwc &&
 		export PAGER stampname &&
@@ -220,7 +251,7 @@ test_core_pager_subdir() {
 			cd sub &&
 			$full_command
 		) &&
-		test -e \"\$stampname\"
+		${if_want_local_config}test -e \"\$stampname\"
 	"
 }
=20
@@ -237,6 +268,18 @@ test_GIT_PAGER_overrides() {
 	"
 }
=20
+test_doesnt_paginate() {
+	parse_args "$@"
+
+	rm -f GIT_PAGER_used
+	$test_expectation TTY "no pager for '$cmd'" "
+		GIT_PAGER=3D'wc > GIT_PAGER_used' &&
+		export GIT_PAGER &&
+		$full_command &&
+		! test -e GIT_PAGER_used
+	"
+}
+
 test_default_pager        expect_success 'git log'
 test_PAGER_overrides      expect_success 'git log'
 test_core_pager_overrides expect_success 'git log'
@@ -246,19 +289,15 @@ test_GIT_PAGER_overrides  expect_success 'git log=
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
+test_doesnt_paginate expect_success test_must_fail 'git -p nonsense'
=20
 test_done
--=20
1.7.0.4
