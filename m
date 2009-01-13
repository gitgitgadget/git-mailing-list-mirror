From: Ted Pavlic <ted@tedpavlic.com>
Subject: [PATCH 1/3] Purest update to bash completions to prevent unbounded
 variable errors.
Date: Tue, 13 Jan 2009 11:08:56 -0500
Message-ID: <496CBC98.7090101@tedpavlic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Jan 13 17:10:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMlqR-0005fa-Ul
	for gcvg-git-2@gmane.org; Tue, 13 Jan 2009 17:10:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752068AbZAMQJA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jan 2009 11:09:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751989AbZAMQI7
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jan 2009 11:08:59 -0500
Received: from gallifrey.ece.ohio-state.edu ([164.107.167.66]:45127 "EHLO
	gallifrey.ece.ohio-state.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751721AbZAMQI6 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Jan 2009 11:08:58 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gallifrey.ece.ohio-state.edu (Postfix) with ESMTP id 074A580D8038;
	Tue, 13 Jan 2009 11:03:15 -0500 (EST)
X-Virus-Scanned: amavisd-new at gallifrey.ece.ohio-state.edu
Received: from gallifrey.ece.ohio-state.edu ([127.0.0.1])
	by localhost (gallifrey.ece.ohio-state.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id G57xhVpLnYuI; Tue, 13 Jan 2009 11:03:14 -0500 (EST)
Received: from tedbook.mshome.net (tedpc.ece.ohio-state.edu [164.107.164.122])
	by gallifrey.ece.ohio-state.edu (Postfix) with ESMTP id E25D680D801B;
	Tue, 13 Jan 2009 11:03:14 -0500 (EST)
User-Agent: Mozilla/5.0 (Macintosh; U; PPC Mac OS X Mach-O; en-US; rv:1.8) Gecko/20051201 Thunderbird/1.5 Mnenhy/0.7.3.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105504>


First in a series of patches that make bash completions more robust to
different interactive shell configurations and editors.


Signed-off-by: Ted Pavlic <ted@tedpavlic.com>
---
  contrib/completion/git-completion.bash |   18 +++++++++---------
  1 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/contrib/completion/git-completion.bash 
b/contrib/completion/git-completion.bash
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
