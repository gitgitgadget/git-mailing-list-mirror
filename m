From: John Keeping <john@keeping.me.uk>
Subject: [PATCH v2] rebase: use reflog to find common base with upstream
Date: Mon, 9 Dec 2013 23:16:16 +0000
Message-ID: <20131209231616.GG3163@serenity.lan>
References: <9e5fa57b027e1a5cd11a456c14f43b64f8f5386c.1386531376.git.john@keeping.me.uk>
 <xmqq7gbdzsvt.fsf@gitster.dls.corp.google.com>
 <20131209204008.GF3163@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Martin von Zweigbergk <martinvonz@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 10 00:16:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VqA40-0001wO-KJ
	for gcvg-git-2@plane.gmane.org; Tue, 10 Dec 2013 00:16:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761491Ab3LIXQ2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Dec 2013 18:16:28 -0500
Received: from jackal.aluminati.org ([72.9.247.210]:51000 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754831Ab3LIXQ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Dec 2013 18:16:26 -0500
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 685DCCDA5B8;
	Mon,  9 Dec 2013 23:16:25 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -0.999
X-Spam-Level: 
X-Spam-Status: No, score=-0.999 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, URIBL_BLOCKED=0.001] autolearn=disabled
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KrfhlvnUlneC; Mon,  9 Dec 2013 23:16:24 +0000 (GMT)
Received: from serenity.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id EB05DCDA487;
	Mon,  9 Dec 2013 23:16:18 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <20131209204008.GF3163@serenity.lan>
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239118>

Commit 15a147e (rebase: use @{upstream} if no upstream specified,
2011-02-09) says:

	Make it default to 'git rebase @{upstream}'. That is also what
	'git pull [--rebase]' defaults to, so it only makes sense that
	'git rebase' defaults to the same thing.

but that isn't actually the case.  Since commit d44e712 (pull: support
rebased upstream + fetch + pull --rebase, 2009-07-19), pull has actually
chosen the most recent reflog entry which is an ancestor of the current
branch if it can find one.

Add a '--fork-point' argument to git-rebase that can be used to trigger
this behaviour.  This option is turned on by default if no non-option
arguments are specified on the command line, otherwise we treat an
upstream specified on the command-line literally.

Signed-off-by: John Keeping <john@keeping.me.uk>
---
On Mon, Dec 09, 2013 at 08:40:08PM +0000, John Keeping wrote:
> On Mon, Dec 09, 2013 at 12:11:50PM -0800, Junio C Hamano wrote:
> >          Do you mean
> > 
> > 	git rebase <no other arguments>
> > 
> > which we interpret as "rebase the current branch on @{u}", and it
> > should behave as if the command was run like so:
> > 
> > 	git rebase --fork-point @{u}
> > 
> > If that is what you suggest, I certainly can buy that.  Those who
> > want to disable the automation can explicitly say
> > 
> > 	git rebase @{u}
> > 
> > and rebase the current exactly on top of the named commit (e.g. the
> > current value of refs/remotes/origin/master or whatever remote-tracking
> > branch you forked from).
> 
> Yes, that's what I meant; the first non-option argument to "git rebase"
> is called "upstream" in the manpage (and throughout the code).  So if
> "<no other arguments>" means "<no non-option arguments>" then that's
> exactly what I meant.

Here's an updated patch that adds a --fork-point option to git-rebase,
with the behaviour described above.

 Documentation/git-rebase.txt | 10 ++++++++++
 git-rebase.sh                | 19 +++++++++++++++++++
 t/t3400-rebase.sh            |  6 ++++--
 3 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 94e07fd..2889be6 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -324,6 +324,16 @@ fresh commits so it can be remerged successfully without needing to "revert
 the reversion" (see the
 link:howto/revert-a-faulty-merge.html[revert-a-faulty-merge How-To] for details).
 
+--fork-point::
+--no-fork-point::
+	Use 'git merge-base --fork-point' to find a better common ancestor
+	between `upstream` and `branch` when calculating which commits have
+	have been introduced by `branch` (see linkgit:git-merge-base[1]).
++
+If no non-option arguments are given on the command line, then the default is
+`--fork-point @{u}` otherwise the `upstream` argument is interpreted literally
+unless the `--fork-point` option is specified.
+
 --ignore-whitespace::
 --whitespace=<option>::
 	These flag are passed to the 'git apply' program
diff --git a/git-rebase.sh b/git-rebase.sh
index 226752f..7185dc8 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -14,6 +14,7 @@ git-rebase --continue | --abort | --skip | --edit-todo
 v,verbose!         display a diffstat of what changed upstream
 q,quiet!           be quiet. implies --no-stat
 autostash!         automatically stash/stash pop before and after
+fork-point         use 'merge-base --fork-point' to refine upstream
 onto=!             rebase onto given branch instead of upstream
 p,preserve-merges! try to recreate merges instead of ignoring them
 s,strategy=!       use the given merge strategy
@@ -66,6 +67,7 @@ verbose=
 diffstat=
 test "$(git config --bool rebase.stat)" = true && diffstat=t
 autostash="$(git config --bool rebase.autostash || echo false)"
+fork_point=auto
 git_am_opt=
 rebase_root=
 force_rebase=
@@ -260,6 +262,12 @@ do
 	--no-autosquash)
 		autosquash=
 		;;
+	--fork-point)
+		fork_point=t
+		;;
+	--no-fork-point)
+		fork_point=
+		;;
 	-M|-m)
 		do_merge=t
 		;;
@@ -437,6 +445,8 @@ then
 			error_on_missing_default_upstream "rebase" "rebase" \
 				"against" "git rebase <branch>"
 		fi
+
+		test "$fork_point" = auto && fork_point=t
 		;;
 	*)	upstream_name="$1"
 		shift
@@ -522,6 +532,15 @@ case "$#" in
 	;;
 esac
 
+if test "$fork_point" = t
+then
+	new_upstream=$(git merge-base --fork-point "$upstream_name" "$switch_to")
+	if test -n "$new_upstream"
+	then
+		upstream=$new_upstream
+	fi
+fi
+
 if test "$autostash" = true && ! (require_clean_work_tree) 2>/dev/null
 then
 	stash_sha1=$(git stash create "autostash") ||
diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index ebf93b0..998503d 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -134,12 +134,14 @@ test_expect_success 'fail when upstream arg is missing and not configured' '
 	test_must_fail git rebase
 '
 
-test_expect_success 'default to @{upstream} when upstream arg is missing' '
+test_expect_success 'default to common base in @{upstream}s reflog if no upstream arg' '
 	git checkout -b default topic &&
 	git config branch.default.remote . &&
 	git config branch.default.merge refs/heads/master &&
 	git rebase &&
-	test "$(git rev-parse default~1)" = "$(git rev-parse master)"
+	git rev-parse --verify master >expect &&
+	git rev-parse default~1 >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success 'rebase -q is quiet' '
-- 
1.8.5.226.g0d60d77
