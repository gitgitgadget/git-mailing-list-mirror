From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH] bash completion: use read -r everywhere
Date: Wed, 21 Dec 2011 16:54:14 +0100
Message-ID: <4502a0248bb843018335e9b5cdf70736c096ebe3.1324482693.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, Kevin Ballard <kevin@sb.org>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Dec 21 16:54:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RdOUs-0001SD-5R
	for gcvg-git-2@lo.gmane.org; Wed, 21 Dec 2011 16:54:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752797Ab1LUPyV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Dec 2011 10:54:21 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:13193 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751944Ab1LUPyU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Dec 2011 10:54:20 -0500
Received: from CAS21.d.ethz.ch (172.31.51.111) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.355.2; Wed, 21 Dec
 2011 16:54:15 +0100
Received: from thomas.inf.ethz.ch (129.132.153.233) by CAS21.d.ethz.ch
 (172.31.51.111) with Microsoft SMTP Server (TLS) id 14.1.355.2; Wed, 21 Dec
 2011 16:54:16 +0100
X-Mailer: git-send-email 1.7.8.484.gdad4270
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187569>

POSIX specifies

  The read utility shall read a single line from standard input.
  By default, unless the -r option is specified, backslash ('\')
  shall act as an escape character...

Our omission of -r breaks the loop reading refnames from
git-for-each-ref in __git_refs() if there are refnames such as
"foo'bar", in which case for-each-ref helpfully quotes them as in

  $ git update-ref "refs/remotes/test/foo'bar" HEAD
  $ git for-each-ref --shell --format="ref=%(refname:short)" "refs/remotes"
  ref='test/foo'\''bar'

Interpolating the \' here will read "ref='test/foo'''bar'" instead,
and eval then chokes on the unbalanced quotes.

However, since none of the read loops _want_ to have backslashes
interpolated, it's much safer to use read -r everywhere.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 contrib/completion/git-completion.bash |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 78257ae..e7a39ef 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -111,7 +111,7 @@ __git_ps1_show_upstream ()
 
 	# get some config options from git-config
 	local output="$(git config -z --get-regexp '^(svn-remote\..*\.url|bash\.showupstream)$' 2>/dev/null | tr '\0\n' '\n ')"
-	while read key value; do
+	while read -r key value; do
 		case "$key" in
 		bash.showupstream)
 			GIT_PS1_SHOWUPSTREAM="$value"
@@ -589,7 +589,7 @@ __git_refs ()
 			local ref entry
 			git --git-dir="$dir" for-each-ref --shell --format="ref=%(refname:short)" \
 				"refs/remotes/" | \
-			while read entry; do
+			while read -r entry; do
 				eval "$entry"
 				ref="${ref#*/}"
 				if [[ "$ref" == "$cur"* ]]; then
@@ -602,7 +602,7 @@ __git_refs ()
 	case "$cur" in
 	refs|refs/*)
 		git ls-remote "$dir" "$cur*" 2>/dev/null | \
-		while read hash i; do
+		while read -r hash i; do
 			case "$i" in
 			*^{}) ;;
 			*) echo "$i" ;;
@@ -611,7 +611,7 @@ __git_refs ()
 		;;
 	*)
 		git ls-remote "$dir" HEAD ORIG_HEAD 'refs/tags/*' 'refs/heads/*' 'refs/remotes/*' 2>/dev/null | \
-		while read hash i; do
+		while read -r hash i; do
 			case "$i" in
 			*^{}) ;;
 			refs/*) echo "${i#refs/*/}" ;;
@@ -636,7 +636,7 @@ __git_refs_remotes ()
 {
 	local i hash
 	git ls-remote "$1" 'refs/heads/*' 2>/dev/null | \
-	while read hash i; do
+	while read -r hash i; do
 		echo "$i:refs/remotes/$1/${i#refs/heads/}"
 	done
 }
@@ -1863,7 +1863,7 @@ __git_config_get_set_variables ()
 	done
 
 	git --git-dir="$(__gitdir)" config $config_file --list 2>/dev/null |
-	while read line
+	while read -r line
 	do
 		case "$line" in
 		*.*=*)
-- 
1.7.8.484.gdad4270
