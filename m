From: "Stefan-W. Hahn" <stefan.hahn@s-hahn.de>
Subject: [PATCH 2/4] git-am: Add command line parameter `--keep-cr` passing it to git-mailsplit.
Date: Sat, 27 Feb 2010 15:20:26 +0100
Message-ID: <1267280428-18223-3-git-send-email-stefan.hahn@s-hahn.de>
References: <1266080362-24760-1-git-send-email-stefan.hahn@s-hahn.de>
Cc: "Stefan-W. Hahn" <stefan.hahn@s-hahn.de>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 27 15:21:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NlNXw-0008PJ-Np
	for gcvg-git-2@lo.gmane.org; Sat, 27 Feb 2010 15:21:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968400Ab0B0OVI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Feb 2010 09:21:08 -0500
Received: from moutng.kundenserver.de ([212.227.126.186]:52581 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S968379Ab0B0OUw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Feb 2010 09:20:52 -0500
Received: from scotty.home (port-92-203-94-156.dynamic.qsc.de [92.203.94.156])
	by mrelayeu.kundenserver.de (node=mreu2) with ESMTP (Nemesis)
	id 0LzWOk-1NhiT43lsw-0143f3; Sat, 27 Feb 2010 15:20:50 +0100
Received: from scotty.home (hs@localhost [127.0.0.1])
	by scotty.home (8.14.3/8.14.3/Debian-5) with ESMTP id o1REKmUw019208;
	Sat, 27 Feb 2010 15:20:48 +0100
Received: (from hs@localhost)
	by scotty.home (8.14.3/8.14.3/Submit) id o1REKm3w019204;
	Sat, 27 Feb 2010 15:20:48 +0100
X-Mailer: git-send-email 1.7.0.98.g42448
In-Reply-To: <1266080362-24760-1-git-send-email-stefan.hahn@s-hahn.de>
X-Spam-Status: No, score=-1.4 required=5.0 tests=ALL_TRUSTED autolearn=failed
	version=3.2.5
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on scotty.home
X-Virus-Scanned: clamav-milter 0.95.3 at scotty
X-Virus-Status: Clean
X-Provags-ID: V01U2FsdGVkX184djnVFEXLxKVjJmbprQFcbtoJYiA6itM5+sJ
 hNakBo4A7qKR5z3mkbHFQYC+KOb5HoPSZ1DTAVqpft0FJFHKmB
 N3uu1jC/Tw6LRxQE5ZcnA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141215>

c2ca1d7 (Allow mailsplit (and hence git-am) to handle mails with CRLF
line-endings, 2009-08-04) fixed "git mailsplit" to help people with
MUA whose output from save-as command uses CRLF as line terminators by
stripping CR at the end of lines.

However, when you know you are feeding output from "git format-patch"
directly to "git am", and especially when your contents have CR at the
end of line, such stripping is undesirable.  To help such a use case,
teach --keep-cr option to "git am" and pass that to "git mailinfo".

Signed-off-by: Stefan-W. Hahn <stefan.hahn@s-hahn.de>
---
 Documentation/git-am.txt |    7 ++++++-
 git-am.sh                |   22 +++++++++++++++-------
 2 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
index c66c565..df3c6d6 100644
--- a/Documentation/git-am.txt
+++ b/Documentation/git-am.txt
@@ -9,7 +9,7 @@ git-am - Apply a series of patches from a mailbox
 SYNOPSIS
 --------
 [verse]
-'git am' [--signoff] [--keep] [--utf8 | --no-utf8]
+'git am' [--signoff] [--keep] [--keep-cr] [--utf8 | --no-utf8]
 	 [--3way] [--interactive] [--committer-date-is-author-date]
 	 [--ignore-date] [--ignore-space-change | --ignore-whitespace]
 	 [--whitespace=<option>] [-C<n>] [-p<n>] [--directory=<dir>]
@@ -39,6 +39,11 @@ OPTIONS
 --keep::
 	Pass `-k` flag to 'git mailinfo' (see linkgit:git-mailinfo[1]).
 
+--keep-cr::
+	With `--keep-cr`, call 'git mailsplit' (see linkgit:git-mailsplit[1])
+	with the same option, to prevent it from stripping CR at the end of 
+	lines.
+
 -c::
 --scissors::
 	Remove everything in body before a scissors line (see
diff --git a/git-am.sh b/git-am.sh
index ebfbee5..7563609 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -15,6 +15,7 @@ q,quiet         be quiet
 s,signoff       add a Signed-off-by line to the commit message
 u,utf8          recode into utf8 (default)
 k,keep          pass -k flag to git-mailinfo
+keep-cr         pass --keep-cr flag to git-mailsplit for mbox format
 c,scissors      strip everything before a scissors line
 whitespace=     pass it through git-apply
 ignore-space-change pass it through git-apply
@@ -217,12 +218,12 @@ check_patch_format () {
 split_patches () {
 	case "$patch_format" in
 	mbox)
-		case "$rebasing" in
-		'')
-			keep_cr= ;;
-		?*)
-			keep_cr=--keep-cr ;;
-		esac
+		if test -n "$rebasing$keepcr"
+		then
+                    keep_cr=--keep-cr
+		else
+                    keep_cr=
+		fi
 		git mailsplit -d"$prec" -o"$dotest" -b $keep_cr -- "$@" > "$dotest/last" ||
 		clean_abort
 		;;
@@ -291,7 +292,7 @@ split_patches () {
 
 prec=4
 dotest="$GIT_DIR/rebase-apply"
-sign= utf8=t keep= skip= interactive= resolved= rebasing= abort=
+sign= utf8=t keep= keepcr= skip= interactive= resolved= rebasing= abort=
 resolvemsg= resume= scissors= no_inbody_headers=
 git_apply_opt=
 committer_date_is_author_date=
@@ -348,6 +349,8 @@ do
 		allow_rerere_autoupdate="$1" ;;
 	-q|--quiet)
 		GIT_QUIET=t ;;
+	--keep-cr)
+		keepcr=t ;;
 	--)
 		shift; break ;;
 	*)
@@ -453,6 +456,7 @@ else
 	echo "$sign" >"$dotest/sign"
 	echo "$utf8" >"$dotest/utf8"
 	echo "$keep" >"$dotest/keep"
+	echo "$keepcr" >"$dotest/keepcr"
 	echo "$scissors" >"$dotest/scissors"
 	echo "$no_inbody_headers" >"$dotest/no_inbody_headers"
 	echo "$GIT_QUIET" >"$dotest/quiet"
@@ -496,6 +500,10 @@ if test "$(cat "$dotest/keep")" = t
 then
 	keep=-k
 fi
+if test "$(cat "$dotest/keepcr")" = t
+then
+	keepcr=--keep-cr
+fi
 case "$(cat "$dotest/scissors")" in
 t)
 	scissors=--scissors ;;
-- 
1.7.0.98.g42448
