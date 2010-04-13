From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 3/9] builtins: do not commit pager choice early
Date: Mon, 12 Apr 2010 21:24:20 -0500
Message-ID: <20100413022420.GC4118@progeny.tock>
References: <20100413021153.GA3978@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 13 04:24:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O1Vnl-0007Hd-Qw
	for gcvg-git-2@lo.gmane.org; Tue, 13 Apr 2010 04:24:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754596Ab0DMCYa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 12 Apr 2010 22:24:30 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:47064 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754481Ab0DMCYY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Apr 2010 22:24:24 -0400
Received: by gwaa18 with SMTP id a18so314225gwa.19
        for <git@vger.kernel.org>; Mon, 12 Apr 2010 19:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=UqscZtLxsi8KZTWUeUTZGVrbGXcslVJznstp9dYbgL8=;
        b=BuwFZ2BwX9suVZntdqVY+LpOlcr6B4fomErKQYVXltuEnF3fM1aaxRhjrOqh+ihR3u
         t09qAR6zBVCBFpkiPxVEMbDOX1a4/0zDjGFqMLVaTb3yWT2NbrSryofNNK9yF8jOad9H
         XhID337pY+q+KBISLO2TFcsZpIaIydAQ4rESo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=hkDzKZGZvuLirK7fCY8SdSs942iIEOg1cOOZv1w29bdUP0f8AljI1Om045DCBxjKgn
         238WWWmF6qOf7jnsniXTPi7+AhxFIwI0dg1PIoobzyTVlfMqYAcXDCKGRzJOYfRe9uT2
         47lAboF3ifsDoDUmPEegJA1UTC2xdDc2AyOiY=
Received: by 10.101.211.15 with SMTP id n15mr9433277anq.64.1271125461621;
        Mon, 12 Apr 2010 19:24:21 -0700 (PDT)
Received: from progeny.tock (wireless-239-104.uchicago.edu [128.135.239.104])
        by mx.google.com with ESMTPS id 22sm4495095iwn.4.2010.04.12.19.24.19
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 12 Apr 2010 19:24:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100413021153.GA3978@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144781>

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
   repository if it happens to be very convenient to is a bug but not
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
Duy=E2=80=99s version did not allow paginating list_common_cmds_help() =
output.
I have an idea for fixing the setup procedure for that later, but one
thing at a time.  In other words, this is analogous to a lock pushdown
in a way: the immediate goal is not to eliminate problems but to reduce
their scope.

 git.c            |    2 +-
 t/t7006-pager.sh |   65 +++++++++++++++++++++++++++++++++++++---------=
-------
 2 files changed, 46 insertions(+), 21 deletions(-)

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
index 403c260..944e830 100755
--- a/t/t7006-pager.sh
+++ b/t/t7006-pager.sh
@@ -132,23 +132,28 @@ then
 fi
=20
 test_pager_choice() {
-	if test $# =3D 1
+	wrapper=3Dtest_terminal
+
+	if test "$1" =3D test_must_fail
 	then
-		cmd=3D$1
-		full_cmd=3D"test_terminal $cmd"
-	else
-		cmd=3D$2
-		full_cmd=3D"test_must_fail test_terminal $cmd"
+		wrapper=3D"test_must_fail $wrapper"
+		shift
 	fi
=20
-	case "$cmd" in
-	*-p*)
-		test_expect_expected=3Dtest_expect_failure
-		;;
-	*)
-		test_expect_expected=3Dtest_expect_success
-		;;
-	esac
+	cmd=3D$1
+	toplevel_expectation=3D${2:-success}
+	use_repository_config=3D"${3:-yes}"
+
+	full_cmd=3D"$wrapper $cmd"
+	test_expectation=3D"test_expect_$toplevel_expectation"
+	if test "$use_repository_config" =3D no
+	then
+		if_want_local_config=3D'! '
+		used_if_wanted=3D'is not used'
+	else
+		if_want_local_config=3D
+		used_if_wanted=3D'overrides PAGER'
+	fi
=20
 	unset PAGER GIT_PAGER
 	git config --unset core.pager
@@ -175,18 +180,18 @@ test_pager_choice() {
=20
 	unset GIT_PAGER
 	rm -f core.pager_used
-	test_expect_success TTY "$cmd - core.pager overrides PAGER" "
+	$test_expectation TTY "$cmd - core.pager ${used_if_wanted}" "
 		PAGER=3Dwc &&
 		export PAGER &&
 		git config core.pager 'wc > core.pager_used' &&
 		$full_cmd &&
-		test -e core.pager_used
+		${if_want_local_config}test -e core.pager_used
 	"
=20
 	unset GIT_PAGER
 	rm -f core.pager_used
 	rm -fr sub
-	$test_expect_expected TTY "$cmd - core.pager in subdir" "
+	test_expect_success TTY "$cmd - core.pager ${used_if_wanted} from sub=
directory" "
 		PAGER=3Dwc &&
 		stampname=3D\$(pwd)/core.pager_used &&
 		export PAGER stampname &&
@@ -196,7 +201,7 @@ test_pager_choice() {
 			cd sub &&
 			$full_cmd
 		) &&
-		test -e \"\$stampname\"
+		${if_want_local_config}test -e \"\$stampname\"
 	"
=20
 	rm -f GIT_PAGER_used
@@ -209,9 +214,29 @@ test_pager_choice() {
 	"
 }
=20
+doesnt_paginate() {
+	if test $# =3D 1
+	then
+		cmd=3D$1
+		full_cmd=3D"test_terminal $cmd"
+	else
+		cmd=3D$2
+		full_cmd=3D"test_must_fail test_terminal $cmd"
+	fi
+
+	rm -f GIT_PAGER_used
+	test_expect_success TTY "no pager for '$cmd'" "
+		GIT_PAGER=3D'wc > GIT_PAGER_used' &&
+		export GIT_PAGER
+		$full_cmd &&
+		! test -e GIT_PAGER_used
+	"
+}
+
 test_pager_choice 'git log'
 test_pager_choice 'git -p log'
-test_pager_choice test_must_fail 'git -p'
-test_pager_choice test_must_fail 'git -p nonsense'
+test_pager_choice test_must_fail 'git -p' failure no
+
+doesnt_paginate test_must_fail 'git -p nonsense'
=20
 test_done
--=20
1.7.0.4
