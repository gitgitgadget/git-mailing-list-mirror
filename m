From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 9/9 v2] config: run setup before commiting pager choice
Date: Tue, 13 Apr 2010 21:23:15 -0500
Message-ID: <20100414022315.GC22766@progeny.tock>
References: <20100413021153.GA3978@progeny.tock>
 <20100413023124.GI4118@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 14 04:23:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O1sGD-0002QK-4t
	for gcvg-git-2@lo.gmane.org; Wed, 14 Apr 2010 04:23:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754456Ab0DNCXU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 13 Apr 2010 22:23:20 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:41048 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754369Ab0DNCXT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Apr 2010 22:23:19 -0400
Received: by gyg13 with SMTP id 13so3853328gyg.19
        for <git@vger.kernel.org>; Tue, 13 Apr 2010 19:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=VMnifmD6C7YB2NTJedFh8q4YQW9uQVkuipDnzpaJCdI=;
        b=B5jsaO7ftNnr7xQ7UW4S0SHIlJtxy0HW91lZOTK+JAyJwNivI9WofwlY6v2k5/o6Gx
         e6r0ophv2esFuNKKEW3xg30oowxPioWdkxNYHyS9iZKyqITjcYWA4Ted1TBOnBONCg7s
         jFTR1n//c24FHYhCGuxNa8NjHfHFXY/oivrEI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=PTzyuFA+SMJxerKAbxv4VR7TvPJx1XmJhDqN1hFNUwqRbAtmOPfa2BoyQtHTYbeL/m
         zSwyjHaIzWyUiNMokHJOopHb8ClgRxL7lUvuH6p0huJ0GycDMc74SET9KIAYjluXek0+
         jB+u68HksUiue4q7HUf+GN0uFri98RI9WL164=
Received: by 10.150.1.20 with SMTP id 20mr5757781yba.247.1271211798624;
        Tue, 13 Apr 2010 19:23:18 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 7sm1658053ywc.34.2010.04.13.19.23.17
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 13 Apr 2010 19:23:17 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100413023124.GI4118@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144846>

=46rom: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>

=46or the pager choice (and the choice to paginate in the first place)
to reflect the current repository configuration, the repository
needs to be searched for first.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Rebased for changes to t7006 in patches 2, 3, 4 v2.

 builtin/config.c |    6 ++----
 git.c            |    4 ++--
 t/t7006-pager.sh |   22 ++++++++++++++++------
 3 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index 4bc46b1..ecc8f87 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -326,11 +326,9 @@ static int get_colorbool(int print)
 		return get_colorbool_found ? 0 : 1;
 }
=20
-int cmd_config(int argc, const char **argv, const char *unused_prefix)
+int cmd_config(int argc, const char **argv, const char *prefix)
 {
-	int nongit;
 	char *value;
-	const char *prefix =3D setup_git_directory_gently(&nongit);
=20
 	config_exclusive_filename =3D getenv(CONFIG_ENVIRONMENT);
=20
@@ -409,7 +407,7 @@ int cmd_config(int argc, const char **argv, const c=
har *unused_prefix)
 	}
 	else if (actions =3D=3D ACTION_EDIT) {
 		check_argc(argc, 0, 0);
-		if (!config_exclusive_filename && nongit)
+		if (!config_exclusive_filename && !startup_info->have_repository)
 			die("not in a git directory");
 		git_config(git_default_config, NULL);
 		launch_editor(config_exclusive_filename ?
diff --git a/git.c b/git.c
index 56e93cf..0a0d9eb 100644
--- a/git.c
+++ b/git.c
@@ -309,7 +309,7 @@ static void handle_internal_command(int argc, const=
 char **argv)
 		{ "clean", cmd_clean, RUN_SETUP | NEED_WORK_TREE },
 		{ "commit", cmd_commit, RUN_SETUP | NEED_WORK_TREE },
 		{ "commit-tree", cmd_commit_tree, RUN_SETUP },
-		{ "config", cmd_config },
+		{ "config", cmd_config, RUN_SETUP_GENTLY },
 		{ "count-objects", cmd_count_objects, RUN_SETUP },
 		{ "describe", cmd_describe, RUN_SETUP },
 		{ "diff", cmd_diff },
@@ -366,7 +366,7 @@ static void handle_internal_command(int argc, const=
 char **argv)
 		{ "reflog", cmd_reflog, RUN_SETUP },
 		{ "remote", cmd_remote, RUN_SETUP },
 		{ "replace", cmd_replace, RUN_SETUP },
-		{ "repo-config", cmd_config },
+		{ "repo-config", cmd_config, RUN_SETUP_GENTLY },
 		{ "rerere", cmd_rerere, RUN_SETUP },
 		{ "reset", cmd_reset, RUN_SETUP },
 		{ "rev-list", cmd_rev_list, RUN_SETUP },
diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
index 97ca5d6..d649f55 100755
--- a/t/t7006-pager.sh
+++ b/t/t7006-pager.sh
@@ -80,7 +80,7 @@ test_expect_success TTY 'git rev-list uses a pager if=
 configured to' '
 git config --unset pager.rev-list
=20
 rm -f paginated.out
-test_expect_failure TTY 'git config uses a pager if configured to' '
+test_expect_success TTY 'git config uses a pager if configured to' '
 	git config pager.config true &&
 	test_terminal git config --list &&
 	test -e paginated.out
@@ -175,7 +175,7 @@ test_default_pager() {
 	parse_args "$@"
=20
 	unset PAGER GIT_PAGER
-	git config --unset core.pager
+	git --no-pager config --unset core.pager
 	rm -f default_pager_used
 	$test_expectation SIMPLEPAGER "$cmd - default pager is used by defaul=
t" "
 		cat >$less <<-\EOF &&
@@ -196,7 +196,7 @@ test_PAGER_overrides() {
 	parse_args "$@"
=20
 	unset GIT_PAGER
-	git config --unset core.pager
+	git --no-pager config --unset core.pager
 	rm -f PAGER_used
 	$test_expectation TTY "$cmd - PAGER overrides default pager" "
 		PAGER=3D'wc > PAGER_used' &&
@@ -235,7 +235,7 @@ test_core_pager() {
 	$test_expectation TTY "$cmd - core.pager $used_if_wanted" "
 		PAGER=3Dwc &&
 		export PAGER &&
-		git config core.pager 'wc > core.pager_used' &&
+		git --no-pager config core.pager 'wc > core.pager_used' &&
 		$full_command &&
 		${if_want_local_config}test -e core.pager_used
 	"
@@ -261,7 +261,7 @@ test_pager_subdir_helper() {
 		stampname=3D\$(pwd)/core.pager_used &&
 		PAGER=3Dwc &&
 		export PAGER stampname &&
-		git config core.pager 'wc > \"\$stampname\"' &&
+		git --no-pager config core.pager 'wc > \"\$stampname\"' &&
 		mkdir sub &&
 		(
 			cd sub &&
@@ -276,7 +276,7 @@ test_GIT_PAGER_overrides() {
=20
 	rm -f GIT_PAGER_used
 	$test_expectation TTY "$cmd - GIT_PAGER overrides core.pager" "
-		git config core.pager wc &&
+		git --no-pager config core.pager wc &&
 		GIT_PAGER=3D'wc > GIT_PAGER_used' &&
 		export GIT_PAGER &&
 		$full_command &&
@@ -326,4 +326,14 @@ test_core_pager_overrides expect_success 'git rev-=
list HEAD'
 test_core_pager_subdir    expect_success 'git rev-list HEAD'
 test_GIT_PAGER_overrides  expect_success 'git rev-list HEAD'
=20
+test_doesnt_paginate expect_success 'git config -l'
+test_expect_success "set up 'git config' to use a pager" '
+	git config pager.config true
+'
+test_default_pager        expect_success 'git config -l'
+test_PAGER_overrides      expect_success 'git config -l'
+test_core_pager_overrides expect_success 'git config -l'
+test_core_pager_subdir    expect_success 'git config -l'
+test_GIT_PAGER_overrides  expect_success 'git config -l'
+
 test_done
--=20
1.7.0.4
