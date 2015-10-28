From: Peter Wu <peter@lekensteyn.nl>
Subject: [PATCH 1/3] completion: ignore git options for subcommand completion
Date: Wed, 28 Oct 2015 18:21:23 +0100
Message-ID: <1446052885-11173-2-git-send-email-peter@lekensteyn.nl>
References: <1446052885-11173-1-git-send-email-peter@lekensteyn.nl>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 28 18:47:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZrUp5-0001Pu-Sg
	for gcvg-git-2@plane.gmane.org; Wed, 28 Oct 2015 18:47:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755154AbbJ1Rrl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2015 13:47:41 -0400
Received: from lekensteyn.nl ([178.21.112.251]:34617 "EHLO lekensteyn.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753688AbbJ1Rrj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2015 13:47:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lekensteyn.nl; s=s2048-2015-q1;
	h=References:In-Reply-To:Message-Id:Date:Subject:To:From; bh=EiL6MFwL/rsezfV4SNKr+KZji4f3pG0FpBE2Ex7nMvc=;
	b=J5QuDw5eXZz0G4LlWiEnmM9Qk5QB+Jcl/XqmevHYJgJELGO1u9s/r7W0ERm6hlBHQgUTKoWrm13e2Q9cdvx18IVyuZ/0ffsb3PCeEknCv9MQb9ARrAb0hnfTjsK8iz6wIP+6CP+spY78qosoVAKjmHuVwU7c4+dJ7S+hgBpXR5frATVGrw3wsltzGd1TtSXG1U6BwJ3DYpwoWxNRz7GXZwqsEI3/bY5lO88x9VgFLB+CxxPPwcDAslxkFKynId2qtNX2qyyEelZ1UG4fuRICAQMDsKaP3UT559bj+bRZJp3OEKenZ12+LOOzKChuWbUlCz58Ox1J83VNFuo2hKL8DA==;
Received: by lekensteyn.nl with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA256:128)
	(Exim 4.84)
	(envelope-from <peter@lekensteyn.nl>)
	id 1ZrUPm-00064K-4L; Wed, 28 Oct 2015 18:21:34 +0100
X-Mailer: git-send-email 2.6.1
In-Reply-To: <1446052885-11173-1-git-send-email-peter@lekensteyn.nl>
X-Spam-Score: 0.0 (/)
X-Spam-Status: No, hits=0.0 required=5.0 tests=NO_RELAYS=-0.001,URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280384>

Do not assume that the first option after "git" is a subcommand. This
fixes completion such as:

    # do not detect "push" as remote name
    git --git-dir=git/.git push origin <TAB>
    # do not overwrite "--git-dir=..." with the alias expansion
    git --git-dir=git/.git gerrit-diff <TAB>

Signed-off-by: Peter Wu <peter@lekensteyn.nl>
---
 contrib/completion/git-completion.bash | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 482ca84..bd9ef4c 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -531,8 +531,8 @@ __git_complete_revlist ()
 
 __git_complete_remote_or_refspec ()
 {
-	local cur_="$cur" cmd="${words[1]}"
-	local i c=2 remote="" pfx="" lhs=1 no_complete_refspec=0
+	local cur_="$cur" cmd="${words[command_word_index]}"
+	local i c=$((command_word_index+1)) remote="" pfx="" lhs=1 no_complete_refspec=0
 	if [ "$cmd" = "remote" ]; then
 		((c++))
 	fi
@@ -788,7 +788,7 @@ __git_aliased_command ()
 # __git_find_on_cmdline requires 1 argument
 __git_find_on_cmdline ()
 {
-	local word subcommand c=1
+	local word subcommand c=$command_word_index
 	while [ $c -lt $cword ]; do
 		word="${words[c]}"
 		for subcommand in $1; do
@@ -803,7 +803,7 @@ __git_find_on_cmdline ()
 
 __git_has_doubledash ()
 {
-	local c=1
+	local c=$command_word_index
 	while [ $c -lt $cword ]; do
 		if [ "--" = "${words[c]}" ]; then
 			return 0
@@ -826,8 +826,8 @@ __git_count_arguments ()
 {
 	local word i c=0
 
-	# Skip "git" (first argument)
-	for ((i=1; i < ${#words[@]}; i++)); do
+	# Skip "git" (first argument) and any options such as --git-dir.
+	for ((i=command_word_index; i < ${#words[@]}; i++)); do
 		word="${words[i]}"
 
 		case "$word" in
@@ -957,7 +957,7 @@ _git_bisect ()
 
 _git_branch ()
 {
-	local i c=1 only_local_ref="n" has_r="n"
+	local i c=$command_word_index only_local_ref="n" has_r="n"
 
 	while [ $c -lt $cword ]; do
 		i="${words[c]}"
@@ -992,7 +992,7 @@ _git_branch ()
 
 _git_bundle ()
 {
-	local cmd="${words[2]}"
+	local cmd="${words[command_word_index+1]}"
 	case "$cword" in
 	2)
 		__gitcomp "create list-heads verify unbundle"
@@ -1760,7 +1760,7 @@ _git_stage ()
 __git_config_get_set_variables ()
 {
 	local prevword word config_file= c=$cword
-	while [ $c -gt 1 ]; do
+	while [ $c -gt $command_word_index ]; do
 		word="${words[c]}"
 		case "$word" in
 		--system|--global|--local|--file=*)
@@ -2516,7 +2516,7 @@ _git_svn ()
 
 _git_tag ()
 {
-	local i c=1 f=0
+	local i c=$command_word_index f=0
 	while [ $c -lt $cword ]; do
 		i="${words[c]}"
 		case "$i" in
@@ -2562,7 +2562,7 @@ _git_whatchanged ()
 
 __git_main ()
 {
-	local i c=1 command __git_dir
+	local i c=1 command command_word_index __git_dir
 
 	while [ $c -lt $cword ]; do
 		i="${words[c]}"
@@ -2573,7 +2573,7 @@ __git_main ()
 		--help) command="help"; break ;;
 		-c|--work-tree|--namespace) ((c++)) ;;
 		-*) ;;
-		*) command="$i"; break ;;
+		*) command="$i"; command_word_index=$c; break ;;
 		esac
 		((c++))
 	done
@@ -2608,7 +2608,7 @@ __git_main ()
 
 	local expansion=$(__git_aliased_command "$command")
 	if [ -n "$expansion" ]; then
-		words[1]=$expansion
+		words[command_word_index]=$expansion
 		completion_func="_git_${expansion//-/_}"
 		declare -f $completion_func >/dev/null && $completion_func
 	fi
-- 
2.6.1
