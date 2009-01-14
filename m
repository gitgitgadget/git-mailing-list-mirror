From: ted@tedpavlic.com
Subject: [PATCH 1/3] bash-completion: Support running when set -u is enabled
Date: Wed, 14 Jan 2009 15:02:20 -0500
Message-ID: <1231963342-24461-1-git-send-email-ted@tedpavlic.com>
Cc: git@vger.kernel.org, gitster@pobox.com,
	Ted Pavlic <ted@tedpavlic.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Wed Jan 14 21:04:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNBy5-0006wS-8s
	for gcvg-git-2@gmane.org; Wed, 14 Jan 2009 21:04:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755285AbZANUCj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2009 15:02:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753350AbZANUCi
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jan 2009 15:02:38 -0500
Received: from gallifrey.ece.ohio-state.edu ([164.107.167.66]:36000 "EHLO
	gallifrey.ece.ohio-state.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752612AbZANUCe (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Jan 2009 15:02:34 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gallifrey.ece.ohio-state.edu (Postfix) with ESMTP id 053B480D80B3;
	Wed, 14 Jan 2009 14:56:48 -0500 (EST)
X-Virus-Scanned: amavisd-new at gallifrey.ece.ohio-state.edu
Received: from gallifrey.ece.ohio-state.edu ([127.0.0.1])
	by localhost (gallifrey.ece.ohio-state.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XJ4kWDsq4IX3; Wed, 14 Jan 2009 14:56:47 -0500 (EST)
Received: from localhost.localdomain (tedpc.ece.ohio-state.edu [164.107.164.122])
	by gallifrey.ece.ohio-state.edu (Postfix) with ESMTP id D639480D806E;
	Wed, 14 Jan 2009 14:56:47 -0500 (EST)
X-Mailer: git-send-email 1.6.1.87.g15624
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105693>

From: Ted Pavlic <ted@tedpavlic.com>

  Under "set -u" semantics, it is an error to access undefined
  variables. Some user environments may enable this setting in the
  interactive shell.

  In any context where the completion functions access an undefined
  variable, accessing a default empty string (aka "${1-}" instead of
  "$1") is a reasonable way to code the function, as it silences
  the undefined variable error while still supplying an empty string.

  In this patch, functions that should always take an argument still use
  $1. Functions that have optional arguments use ${1-}.

Signed-off-by: Ted Pavlic <ted@tedpavlic.com>
Acked-by: Shawn O. Pearce <spearce@spearce.org>
---
 contrib/completion/git-completion.bash |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 7b074d7..5d1515c 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -52,7 +52,7 @@ esac
 
 __gitdir ()
 {
-	if [ -z "$1" ]; then
+	if [ -z "${1-}" ]; then
 		if [ -n "$__git_dir" ]; then
 			echo "$__git_dir"
 		elif [ -d .git ]; then
@@ -111,7 +111,7 @@ __git_ps1 ()
 			fi
 		fi
 
-		if [ -n "$1" ]; then
+		if [ -n "${1-}" ]; then
 			printf "$1" "${b##refs/heads/}$r"
 		else
 			printf " (%s)" "${b##refs/heads/}$r"
@@ -143,8 +143,8 @@ __gitcomp ()
 		;;
 	*)
 		local IFS=$'\n'
-		COMPREPLY=($(compgen -P "$2" \
-			-W "$(__gitcomp_1 "$1" "$4")" \
+		COMPREPLY=($(compgen -P "${2-}" \
+			-W "$(__gitcomp_1 "${1-}" "${4-}")" \
 			-- "$cur"))
 		;;
 	esac
@@ -152,13 +152,13 @@ __gitcomp ()
 
 __git_heads ()
 {
-	local cmd i is_hash=y dir="$(__gitdir "$1")"
+	local cmd i is_hash=y dir="$(__gitdir "${1-}")"
 	if [ -d "$dir" ]; then
 		git --git-dir="$dir" for-each-ref --format='%(refname:short)' \
 			refs/heads
 		return
 	fi
-	for i in $(git ls-remote "$1" 2>/dev/null); do
+	for i in $(git ls-remote "${1-}" 2>/dev/null); do
 		case "$is_hash,$i" in
 		y,*) is_hash=n ;;
 		n,*^{}) is_hash=y ;;
@@ -170,13 +170,13 @@ __git_heads ()
 
 __git_tags ()
 {
-	local cmd i is_hash=y dir="$(__gitdir "$1")"
+	local cmd i is_hash=y dir="$(__gitdir "${1-}")"
 	if [ -d "$dir" ]; then
 		git --git-dir="$dir" for-each-ref --format='%(refname:short)' \
 			refs/tags
 		return
 	fi
-	for i in $(git ls-remote "$1" 2>/dev/null); do
+	for i in $(git ls-remote "${1-}" 2>/dev/null); do
 		case "$is_hash,$i" in
 		y,*) is_hash=n ;;
 		n,*^{}) is_hash=y ;;
@@ -188,7 +188,7 @@ __git_tags ()
 
 __git_refs ()
 {
-	local i is_hash=y dir="$(__gitdir "$1")"
+	local i is_hash=y dir="$(__gitdir "${1-}")"
 	local cur="${COMP_WORDS[COMP_CWORD]}" format refs
 	if [ -d "$dir" ]; then
 		case "$cur" in
-- 
1.6.1.87.g15624
