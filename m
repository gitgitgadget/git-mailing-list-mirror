From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: [PATCH v2 00/31] refactor rebase
Date: Sun, 13 Feb 2011 20:54:55 -0500 (EST)
Message-ID: <alpine.DEB.2.00.1102132047500.4253@debian>
References: <1293528648-21873-1-git-send-email-martin.von.zweigbergk@gmail.com> <1297017841-20678-1-git-send-email-martin.von.zweigbergk@gmail.com> <7vd3mz33xb.fsf@alter.siamese.dyndns.org> <alpine.DEB.2.00.1102111811300.26684@debian>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@student.ethz.ch>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 14 02:55:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Poneg-0007pR-EV
	for gcvg-git-2@lo.gmane.org; Mon, 14 Feb 2011 02:55:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755365Ab1BNBzF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Feb 2011 20:55:05 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:35711 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751302Ab1BNBzD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Feb 2011 20:55:03 -0500
Received: by vws16 with SMTP id 16so2737880vws.19
        for <git@vger.kernel.org>; Sun, 13 Feb 2011 17:55:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:x-x-sender:to:cc:subject:in-reply-to
         :message-id:references:user-agent:mime-version:content-type;
        bh=dh6qjHcBK63hK9NJWmui8aswM5Hd/QC507JLWO0C2JM=;
        b=qjyYLVi7Tv0pt3LUT9+FI2xJIztlqG8tS0Z6/TycAjaU7Tfju2GXQCwA9E3X9///qb
         W1AGmwk+hgmmtAuOpnGo08OjY9VCX/XbBbeFHSDw4ZxcHw2zwfBQwWF/pf/uo4r+wqL0
         ORHselP1kuHM+vB8iWrLklzM+FP/denIfz0ng=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:x-x-sender:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version:content-type;
        b=xI6bF6Ggu178jgT8QQo3vHne+bRFkTu7+xoIzOl8Ve+3LM2+2h8n1721NJXi+Mmm2B
         DG4bZ7V7xVi1YYgnrT+FLBS2TTe7axRx6qTSeJhmWvcF9vKLYXvI4G4ipCrskNrG5sYF
         9ir0Y8HUmJ7yx7hK1ewOh4WFCdharNXXNmuYo=
Received: by 10.220.202.194 with SMTP id ff2mr165188vcb.115.1297648501857;
        Sun, 13 Feb 2011 17:55:01 -0800 (PST)
Received: from [192.168.1.103] (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id u14sm532339vcr.25.2011.02.13.17.54.59
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 13 Feb 2011 17:55:00 -0800 (PST)
X-X-Sender: martin@debian
In-Reply-To: <alpine.DEB.2.00.1102111811300.26684@debian>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166684>

On Fri, 11 Feb 2011, Martin von Zweigbergk wrote:

> On Thu, 10 Feb 2011, Junio C Hamano wrote:
> 
> > I am not sure if forbidding "-v --continue" adds any value; would it be
> > too much effort to allow "--continue -v" instead to achieve the same
> > degree of consistency between the two?
> 
> I'll have a look at it when
> I get some time.

This would apply on top of mz/rebase after dropping 95135b0 (rebase:
stricter check of standalone sub command, 2011-02-06). If you agree
with it, I will include it in a future re-roll.

-- 8< --
Subject: [PATCH/RFC] rebase: allow options to be overridden when resuming

The sub commands '--continue', '--skip' or '--abort' may only be used
standalone according to the documentation. Other options following the
sub command are currently not accepted, but options preceeding them
are. For example, 'git rebase --continue -v' is not accepted, while
'git rebase -v --continue' is. In the latter case, the verbose option
will only be used until the rebase is interrupted (e.g. for editing,
or due to conflict). From that point on, the intial settings will be
used again.

Improve the situation by allowing options to be combined with sub
commands both before and after the sub command itself. Persist the new
value to make sure it is remembered across interruptions.

Fail if options that can not be used together with sub commands, such
as '-i', are used. For simplicity, allow the same set of options for
all three sub commands, even though e.g. '-s' makes no sense when
combined with '--abort'.

Signed-off-by: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
---
 Documentation/git-rebase.txt |    2 +-
 git-rebase.sh                |   51 ++++++++++++++++++++++++++++++++----------
 t/t3418-rebase-continue.sh   |   12 ++++++++++
 3 files changed, 52 insertions(+), 13 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 96680c8..095a67f 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -13,7 +13,7 @@ SYNOPSIS
 'git rebase' [-i | --interactive] [options] --onto <newbase>
 	--root [<branch>]
 
-'git rebase' --continue | --skip | --abort
+'git rebase' --continue | --skip | --abort [options]
 
 DESCRIPTION
 -----------
diff --git a/git-rebase.sh b/git-rebase.sh
index 34a2a0a..5abfeac 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -67,6 +67,16 @@ preserve_merges=
 autosquash=
 test "$(git config --bool rebase.autosquash)" = "true" && autosquash=t
 
+write_options() {
+	echo "$GIT_QUIET" > "$state_dir"/quiet &&
+	test t = "$verbose" && : > "$state_dir"/verbose
+	test -n "$strategy" && echo "$strategy" > "$state_dir"/strategy
+	test -n "$strategy_opts" && echo "$strategy_opts" > \
+		"$state_dir"/strategy_opts
+	test -n "$allow_rerere_autoupdate" && echo "$allow_rerere_autoupdate" > \
+		"$state_dir"/allow_rerere_autoupdate
+}
+
 read_basic_state () {
 	head_name=$(cat "$state_dir"/head-name) &&
 	onto=$(cat "$state_dir"/onto) &&
@@ -78,9 +88,21 @@ read_basic_state () {
 		orig_head=$(cat "$state_dir"/orig-head)
 	else
 		orig_head=$(cat "$state_dir"/head)
-	fi &&
-	GIT_QUIET=$(cat "$state_dir"/quiet) &&
-	test -f "$state_dir"/verbose && verbose=t
+	fi
+	# First write any overriding options from the command line
+	write_options
+	if test -n "$GIT_QUIET"
+	then
+		rm "$state_dir"/verbose
+	else
+		GIT_QUIET=$(cat "$state_dir"/quiet)
+	fi
+	if test t = "$verbose"
+	then
+		rm "$state_dir"/quiet
+	else
+		test -f "$state_dir"/verbose && verbose=t
+	fi
 	test -f "$state_dir"/strategy && strategy="$(cat "$state_dir"/strategy)"
 	test -f "$state_dir"/strategy_opts &&
 		strategy_opts="$(cat "$state_dir"/strategy_opts)"
@@ -92,13 +114,7 @@ write_basic_state () {
 	echo "$head_name" > "$state_dir"/head-name &&
 	echo "$onto" > "$state_dir"/onto &&
 	echo "$orig_head" > "$state_dir"/orig-head &&
-	echo "$GIT_QUIET" > "$state_dir"/quiet &&
-	test t = "$verbose" && : > "$state_dir"/verbose
-	test -n "$strategy" && echo "$strategy" > "$state_dir"/strategy
-	test -n "$strategy_opts" && echo "$strategy_opts" > \
-		"$state_dir"/strategy_opts
-	test -n "$allow_rerere_autoupdate" && echo "$allow_rerere_autoupdate" > \
-		"$state_dir"/allow_rerere_autoupdate
+	write_options
 }
 
 output () {
@@ -164,6 +180,7 @@ then
 fi
 test -n "$type" && in_progress=t
 
+resume_incompatible=
 while test $# != 0
 do
 	case "$1" in
@@ -174,11 +191,11 @@ do
 		ok_to_skip_pre_rebase=
 		;;
 	--continue|--skip|--abort)
+		test -n "$action" && usage
 		action=${1##--}
-		shift
-		break
 		;;
 	--onto)
+		resume_incompatible=t
 		test 2 -le "$#" || usage
 		onto="$2"
 		shift
@@ -197,6 +214,7 @@ do
 		autosquash=
 		;;
 	-M|-m|--m|--me|--mer|--merg|--merge)
+		resume_incompatible=t
 		do_merge=t
 		;;
 	-X*|--strategy-option*)
@@ -232,9 +250,11 @@ do
 		do_merge=t
 		;;
 	-n|--no-stat)
+		resume_incompatible=t
 		diffstat=
 		;;
 	--stat)
+		resume_incompatible=t
 		diffstat=t
 		;;
 	-v|--verbose)
@@ -249,6 +269,7 @@ do
 		diffstat=
 		;;
 	--whitespace=*)
+		resume_incompatible=t
 		git_am_opt="$git_am_opt $1"
 		case "$1" in
 		--whitespace=fix|--whitespace=strip)
@@ -257,19 +278,24 @@ do
 		esac
 		;;
 	--ignore-whitespace)
+		resume_incompatible=t
 		git_am_opt="$git_am_opt $1"
 		;;
 	--committer-date-is-author-date|--ignore-date)
+		resume_incompatible=t
 		git_am_opt="$git_am_opt $1"
 		force_rebase=t
 		;;
 	-C*)
+		resume_incompatible=t
 		git_am_opt="$git_am_opt $1"
 		;;
 	--root)
+		resume_incompatible=t
 		rebase_root=t
 		;;
 	-f|--f|--fo|--for|--forc|--force|--force-r|--force-re|--force-reb|--force-reba|--force-rebas|--force-rebase|--no-ff)
+		resume_incompatible=t
 		force_rebase=t
 		;;
 	--rerere-autoupdate|--no-rerere-autoupdate)
@@ -288,6 +314,7 @@ test $# -gt 2 && usage
 
 if test -n "$action"
 then
+	test -n "$resume_incompatible" && "--$action used with incompatible option"
 	test -z "$in_progress" && die "No rebase in progress?"
 	# Only interactive rebase uses detailed reflog messages
 	if test "$type" = interactive && test "$GIT_REFLOG_ACTION" = rebase
diff --git a/t/t3418-rebase-continue.sh b/t/t3418-rebase-continue.sh
index 15cef3c..1581f00 100755
--- a/t/t3418-rebase-continue.sh
+++ b/t/t3418-rebase-continue.sh
@@ -90,4 +90,16 @@ test_expect_success 'rebase --continue remembers --rerere-autoupdate' '
 	git rebase --continue
 '
 
+test_expect_success 'rebase --continue --no-rerere-autoupdate overrides' '
+	rm -fr .git/rebase-* &&
+	git reset --hard topic@{1} &&
+	test_must_fail git rebase -m --rerere-autoupdate master &&
+	test "$(cat F2)" = "Resolved" &&
+	git rebase --continue --no-rerere-autoupdate &&
+	test "$(cat F3)" = "Resolved" &&
+	test_must_fail git rebase --continue &&
+	git add F3 &&
+	git rebase --continue
+'
+
 test_done
-- 
1.7.4.rc2.33.g8a14f
