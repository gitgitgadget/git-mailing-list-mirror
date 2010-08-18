From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v5 1/8] detached-stash: introduce parse_flags_and_revs function
Date: Wed, 18 Aug 2010 23:09:33 +1000
Message-ID: <1282136980-25793-2-git-send-email-jon.seymour@gmail.com>
References: <1282136980-25793-1-git-send-email-jon.seymour@gmail.com>
Cc: gitster@pobox.com, j6t@kdbg.org,
	Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 18 15:10:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OliPk-0001G7-Sg
	for gcvg-git-2@lo.gmane.org; Wed, 18 Aug 2010 15:10:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752849Ab0HRNKZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Aug 2010 09:10:25 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:44168 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751725Ab0HRNKX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Aug 2010 09:10:23 -0400
Received: by mail-pv0-f174.google.com with SMTP id 2so202375pvg.19
        for <git@vger.kernel.org>; Wed, 18 Aug 2010 06:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=/5QZAD8P3Z4ELJo8no8UPGVV7SBfHD8NNzqHeHFQH2Y=;
        b=eVlJBUs3mfLFKgAmU0buFuardofWXKuwgg8d4DCEkqJzi3ULVhgXkVQehf1QLnJkj5
         +sw7fFwqeA+EgFlaFZASY5m9uO71ZtVGiFM7/CenFxGxsTuHXMAcsRjuBGOUlGPzSz38
         UWZ8NSyzINIXAV8HT7J1BXnkkJ8vFtFyqiaCk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=uaRyM4HKiNNrVA7/K+AiAU07PS3LAOXqMkhPiJ3QMwZMEEcD5MxsHkAAeOnmDRudq/
         andDpuC48s59UMJF9klNApbFZ9hQZmrUHLTFfa5VXQ3Lvc2ctH0529+11bzOxTl7pZo6
         4pcAur52irpSmTowUs9SxmQ2bcJg4Mi5J8Eyk=
Received: by 10.142.192.20 with SMTP id p20mr1089691wff.342.1282137023689;
        Wed, 18 Aug 2010 06:10:23 -0700 (PDT)
Received: from localhost.localdomain ([120.16.55.229])
        by mx.google.com with ESMTPS id w31sm303253wfd.20.2010.08.18.06.10.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 18 Aug 2010 06:10:22 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.95.g4fabf
In-Reply-To: <1282136980-25793-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153840>

Introduce parse_flags_and_revs. This function requires that
there is at at most one stash-like revision parameter and
sero or more flags.

It knows how to parse -q,--quiet and --index flags, but leaves
other flags unparsed.

Specified revisions are checked to see that they are at least stash-like
(meaning: they look like something created by git stash save or git stash
create).

If this is so, then IS_STASH_LIKE is initialized to a non-empty value.

If the specified revision also looks like a stash log entry reference,
then IS_STASH_REF is initialized to a non-empty value.

References of the form ref@{spec} are required to precisely identify
an individual commit.

If no reference is specified, stash@{0} is assumed.

Once the specified reference is validated to be at least stash_like
a ensemble of derived variables, (w_commit, w_tree, b_commit, etc)
are initialized with a single call to git rev-parse.

Repeated calls to parse_flags_and_rev() avoid repeated calls
to git rev-parse if the specified arguments have already been
parsed.

An ensemble of supporting functions that make use of the state
established by parse_flags_and_rev(). These are describe below.
Subsequent patches in the series modify the existing
git stash subcommands to make use of these functions as appropriate.

The ancillary functions are:

is_stash_like(): which can be used to test
whether a specified commit looks like a commit created with
git stash save or git stash create.

assert_stash_like(): which can be used by
commands that misbehave unless their arguments stash-like.

is_stash_ref(): which checks whether an argument
is valid stash reference(e.g. is of the form
['refs/']stash['@{'something'}])

assert_stash_ref(): which can be used by commands
that misbehave unless their arguments are both stash-like and
refer to valid stash entries.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 git-stash.sh |  133 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 133 insertions(+), 0 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index 1d95447..42b0da2 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -225,6 +225,138 @@ show_stash () {
 	git diff $flags $b_commit $w_commit
 }
 
+#
+# Parses the remaining options looking for flags and
+# at most one revision defaulting to ${ref_stash}@{0}
+# if none found.
+#
+# Derives related tree and commit objects from the
+# revision, if one is found.
+#
+# stash records the work tree, and is a merge between the
+# base commit (first parent) and the index tree (second parent).
+#
+#   REV is set to the symbolic version of the specified stash-like commit
+#   IS_STASH_LIKE is non-blank if ${REV} looks like a stash
+#   IS_STASH_REF is non-blank if the ${REV} looks like a stash ref
+#   s is set to the SHA1 of the stash commit
+#   w_commit is set to the commit containing the working tree
+#   b_commit is set to the base commit
+#   i_commit is set to the commit containing the index tree
+#   w_tree is set to the working tree
+#   b_tree is set to the base tree
+#   i_tree is set to the index tree
+#
+#   GIT_QUIET is set to t if -q is specified
+#   INDEX_OPTION is set to --index if --index is specified.
+#   FLAGS is set to the remaining flags
+#
+# dies if:
+#   * too many revisions specified
+#   * no revision is specified and there is no stash stack
+#   * a revision is specified which cannot be resolve to a SHA1
+#   * a non-existent stash reference is specified
+#
+
+parse_flags_and_rev()
+{
+	test "$PARSE_CACHE" = "$*" && return 0 # optimisation
+	PARSE_CACHE="$*"
+
+	IS_STASH_LIKE=
+	IS_STASH_REF=
+	INDEX_OPTION=
+	s=
+	w_commit=
+	b_commit=
+	i_commit=
+	w_tree=
+	b_tree=
+	i_tree=
+
+	REV=$(git rev-parse --no-flags --symbolic "$@" 2>/dev/null)
+	FLAGS=$(git rev-parse --no-revs -- "$@" 2>/dev/null)
+
+	set -- $FLAGS
+
+	FLAGS=
+	while test $# -ne 0
+	do
+		case "$1" in
+			-q|--quiet)
+				GIT_QUIET=-t
+			;;
+			--index)
+				INDEX_OPTION=--index
+			;;
+			--)
+				:
+			;;
+			*)
+				FLAGS="${FLAGS}${FLAGS:+ }$1"
+			;;
+		esac
+		shift
+	done
+
+	set -- $REV
+
+	case $# in
+		0)
+			have_stash || die "No stash found."
+			set -- ${ref_stash}@{0}
+		;;
+		1)
+			:
+		;;
+		*)
+			die "Too many revisions specified: $REV"
+		;;
+	esac
+
+	REV=$(git rev-parse --quiet --symbolic --verify $1 2>/dev/null) || die "$1 is not valid reference"
+
+	i_commit=$(git rev-parse --quiet --verify $REV^2 2>/dev/null) &&
+	set -- $(git rev-parse $REV $REV^1 $REV: $REV^1: $REV^2: 2>/dev/null) &&
+	s=$1 &&
+	w_commit=$1 &&
+	b_commit=$2 &&
+	w_tree=$3 &&
+	b_tree=$4 &&
+	i_tree=$5 &&
+	IS_STASH_LIKE=t &&
+	test "$ref_stash" = "$(git rev-parse --symbolic-full-name "${REV%@*}")" &&
+	IS_STASH_REF=t
+
+	if test "${REV}" != "${REV%{*\}}"
+	then
+		# maintainers: it would be better if git rev-parse indicated
+		# this condition with a non-zero status code but as of 1.7.2.1 it
+		# it did not. So, we use non-empty stderr output as a proxy for the
+		# condition of interest.
+		test -z "$(git rev-parse "$REV" 2>&1 >/dev/null)" || die "$REV does not exist in the stash log"
+	fi
+
+}
+
+is_stash_like()
+{
+	parse_flags_and_rev "$@"
+	test -n "$IS_STASH_LIKE"
+}
+
+assert_stash_like() {
+	is_stash_like "$@" || die "'$*' is not a stash-like commit"
+}
+
+is_stash_ref() {
+	is_stash_like "$@" && test -n "$IS_STASH_REF"
+}
+
+assert_stash_ref() {
+	is_stash_ref "$@" || die "'$*' is not a stash reference"
+}
+
 apply_stash () {
 	applied_stash=
 	unstash_index=
@@ -375,6 +507,7 @@ apply_to_branch () {
 	drop_stash $stash
 }
 
+PARSE_CACHE='--not-parsed'
 # The default command is "save" if nothing but options are given
 seen_non_option=
 for opt
-- 
1.7.2.1.95.g4fabf
