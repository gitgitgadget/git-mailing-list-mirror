From: =?ISO-8859-1?Q?Sebastian_G=F6tte?= <jaseg@physik.tu-berlin.de>
Subject: [PATCH v2 2/4] merge/pull: verify GPG signatures of commits being
 merged
Date: Sat, 23 Mar 2013 02:57:43 +0100
Message-ID: <514D0C17.5020207@physik.tu-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 23 02:58:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJDj9-0004yX-FU
	for gcvg-git-2@plane.gmane.org; Sat, 23 Mar 2013 02:58:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423092Ab3CWB55 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Mar 2013 21:57:57 -0400
Received: from mail.tu-berlin.de ([130.149.7.33]:7577 "EHLO mail.tu-berlin.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423010Ab3CWB5r (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Mar 2013 21:57:47 -0400
X-tubIT-Incoming-IP: 130.149.58.163
Received: from mail.physik-pool.tu-berlin.de ([130.149.58.163] helo=mail.physik.tu-berlin.de)
	by mail.tu-berlin.de (exim-4.75/mailfrontend-4) with esmtp 
	id 1UJDiM-0000wN-AF; Sat, 23 Mar 2013 02:57:46 +0100
Received: from [192.168.0.103] (cable-124-189.zeelandnet.nl [82.176.124.189])
	(using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.physik.tu-berlin.de (Postfix) with ESMTPSA id 4F25211403;
	Sat, 23 Mar 2013 02:57:44 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130221 Thunderbird/17.0.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218875>

When --verify-signatures is specified on the command-line of git-merge
or git-pull, check whether the commits being merged have good gpg
signatures and abort the merge in case they do not. This allows e.g.
auto-deployment from untrusted repo hosts.

Signed-off-by: Sebastian G=F6tte <jaseg@physik-pool.tu-berlin.de>
---
 Documentation/merge-options.txt    |  4 +++
 builtin/merge.c                    | 31 ++++++++++++++++++++++-
 git-pull.sh                        | 10 ++++++--
 t/t7612-merge-verify-signatures.sh | 52 ++++++++++++++++++++++++++++++=
++++++++
 4 files changed, 94 insertions(+), 3 deletions(-)

diff --git a/Documentation/merge-options.txt b/Documentation/merge-opti=
ons.txt
index 0bcbe0a..2f76ab5 100644
--- a/Documentation/merge-options.txt
+++ b/Documentation/merge-options.txt
@@ -83,6 +83,10 @@ option can be used to override --squash.
 	Pass merge strategy specific option through to the merge
 	strategy.
=20
+--verify-signatures::
+--no-verify-signatures::
+	Verify that the commits being merged have good trusted GPG signatures
+
 --summary::
 --no-summary::
 	Synonyms to --stat and --no-stat; these are deprecated and will be
diff --git a/builtin/merge.c b/builtin/merge.c
index 7c8922c..b3788aa 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -49,7 +49,7 @@ static const char * const builtin_merge_usage[] =3D {
 static int show_diffstat =3D 1, shortlog_len =3D -1, squash;
 static int option_commit =3D 1, allow_fast_forward =3D 1;
 static int fast_forward_only, option_edit =3D -1;
-static int allow_trivial =3D 1, have_message;
+static int allow_trivial =3D 1, have_message, verify_signatures;
 static int overwrite_ignore =3D 1;
 static struct strbuf merge_msg =3D STRBUF_INIT;
 static struct strategy **use_strategies;
@@ -199,6 +199,8 @@ static struct option builtin_merge_options[] =3D {
 	OPT_BOOLEAN(0, "ff-only", &fast_forward_only,
 		N_("abort if fast-forward is not possible")),
 	OPT_RERERE_AUTOUPDATE(&allow_rerere_auto),
+	OPT_BOOLEAN(0, "verify-signatures", &verify_signatures,
+		N_("Verify that the named commit has a valid GPG signature")),
 	OPT_CALLBACK('s', "strategy", &use_strategies, N_("strategy"),
 		N_("merge strategy to use"), option_parse_strategy),
 	OPT_CALLBACK('X', "strategy-option", &xopts, N_("option=3Dvalue"),
@@ -1233,6 +1235,33 @@ int cmd_merge(int argc, const char **argv, const=
 char *prefix)
 		usage_with_options(builtin_merge_usage,
 			builtin_merge_options);
=20
+	if (verify_signatures) {
+		/* Verify the commit signatures */
+		for (p =3D remoteheads; p; p =3D p->next) {
+			struct commit *commit =3D p->item;
+			struct signature signature;
+			signature.check_result =3D 0;
+
+			check_commit_signature(commit, &signature);
+
+			char hex[41];
+			strcpy(hex, find_unique_abbrev(commit->object.sha1, DEFAULT_ABBREV)=
);
+			switch(signature.check_result){
+				case 'G':
+					if (verbosity >=3D 0)
+						printf(_("Commit %s has a good GPG signature by %s\n"), hex, sig=
nature.signer);
+					break;
+				case 'B':
+					die(_("Commmit %s has a bad GPG signature allegedly by %s."), hex=
, signature.signer);
+				default: /* 'N' */
+					die(_("Commmit %s does not have a good GPG signature. In fact, co=
mmit %s does not have a GPG signature at all."), hex, hex);
+			}
+
+			free(signature.gpg_output);
+			free(signature.signer);
+		}
+	}
+
 	strbuf_addstr(&buf, "merge");
 	for (p =3D remoteheads; p; p =3D p->next)
 		strbuf_addf(&buf, " %s", merge_remote_util(p->item)->name);
diff --git a/git-pull.sh b/git-pull.sh
index 266e682..705940d 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -39,7 +39,7 @@ test -z "$(git ls-files -u)" || die_conflict
 test -f "$GIT_DIR/MERGE_HEAD" && die_merge
=20
 strategy_args=3D diffstat=3D no_commit=3D squash=3D no_ff=3D ff_only=3D
-log_arg=3D verbosity=3D progress=3D recurse_submodules=3D
+log_arg=3D verbosity=3D progress=3D recurse_submodules=3D verify_signa=
tures=3D
 merge_args=3D edit=3D
 curr_branch=3D$(git symbolic-ref -q HEAD)
 curr_branch_short=3D"${curr_branch#refs/heads/}"
@@ -125,6 +125,12 @@ do
 	--no-recurse-submodules)
 		recurse_submodules=3D--no-recurse-submodules
 		;;
+	--verify-signatures)
+		verify_signatures=3D--verify-signatures
+		;;
+	--no-verify-signatures)
+		verify_signatures=3D--no-verify-signatures
+		;;
 	--d|--dr|--dry|--dry-|--dry-r|--dry-ru|--dry-run)
 		dry_run=3D--dry-run
 		;;
@@ -283,7 +289,7 @@ true)
 	eval=3D"$eval --onto $merge_head ${oldremoteref:-$merge_head}"
 	;;
 *)
-	eval=3D"git-merge $diffstat $no_commit $edit $squash $no_ff $ff_only"
+	eval=3D"git-merge $diffstat $no_commit $verify_signatures $edit $squa=
sh $no_ff $ff_only"
 	eval=3D"$eval  $log_arg $strategy_args $merge_args $verbosity $progre=
ss"
 	eval=3D"$eval \"\$merge_name\" HEAD $merge_head"
 	;;
diff --git a/t/t7612-merge-verify-signatures.sh b/t/t7612-merge-verify-=
signatures.sh
new file mode 100755
index 0000000..31b67dd
--- /dev/null
+++ b/t/t7612-merge-verify-signatures.sh
@@ -0,0 +1,52 @@
+#!/bin/sh
+
+test_description=3D'merge signature verification tests'
+. ./test-lib.sh
+. "$TEST_DIRECTORY/lib-gpg.sh"
+
+test_expect_success GPG 'create signed commits' '
+	echo 1 >file && git add file &&
+	test_tick && git commit -m initial &&
+	git tag initial &&
+
+	git checkout -b side-signed &&
+	echo 3 >elif && git add elif &&
+	test_tick && git commit -S -m "signed on side" &&
+	git checkout initial &&
+
+	git checkout -b side-unsigned &&
+	echo 3 >foo && git add foo &&
+	test_tick && git commit -m "unsigned on side" &&
+	git checkout initial &&
+
+	git checkout -b side-bad &&
+	echo 3 >bar && git add bar &&
+	test_tick && git commit -S -m "bad on side" &&
+	git cat-file commit side-bad >raw &&
+	sed -e "s/bad/forged bad/" raw >forged &&
+	git hash-object -w -t commit forged >forged.commit &&
+	git checkout initial &&
+
+	git checkout master
+'
+
+test_expect_success GPG 'merge unsigned commit with verification' '
+	test_must_fail git merge --ff-only --verify-signatures side-unsigned =
2> mergeerror &&
+	grep "does not have a GPG signature" mergeerror
+'
+
+test_expect_success GPG 'merge commit with bad signature with verifica=
tion' '
+	test_must_fail git merge --ff-only --verify-signatures $(cat forged.c=
ommit) 2> mergeerror &&
+	grep "has a bad GPG signature" mergeerror
+'
+
+test_expect_success GPG 'merge signed commit with verification' '
+	git merge -v --ff-only --verify-signatures side-signed > mergeoutput =
&&
+	grep "has a good GPG signature" mergeoutput
+'
+
+test_expect_success GPG 'merge commit with bad signature without verif=
ication' '
+	git merge $(cat forged.commit)
+'
+
+test_done
--=20
1.8.1.5
