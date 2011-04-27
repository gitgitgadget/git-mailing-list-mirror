From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [RFC/PATCH] completion: avoid "words" as variable name for zsh
 portability
Date: Wed, 27 Apr 2011 01:40:34 -0500
Message-ID: <20110427064033.GB4226@elie>
References: <1303867612-15975-1-git-send-email-felipe.contreras@gmail.com>
 <20110427013534.GA14286@elie>
 <7v62q0b8e0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Stefan Haller <lists@haller-berlin.de>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>,
	Mark Lodato <lodatom@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 27 08:40:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QEyQZ-000273-M8
	for gcvg-git-2@lo.gmane.org; Wed, 27 Apr 2011 08:40:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753276Ab1D0Gkk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2011 02:40:40 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:61699 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752322Ab1D0Gkj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2011 02:40:39 -0400
Received: by iwn34 with SMTP id 34so1124870iwn.19
        for <git@vger.kernel.org>; Tue, 26 Apr 2011 23:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=FwCYIcfzbZhf37jseAbSaFkyq+yvuJksLqGX5u6ghaI=;
        b=L4zqrt6tpbcSpA4cJ4GIuw3H4evkWv/pzI5EJP/f8w1HRjiaws3wZcdK220fzVVPGc
         dhsLGUoxxCreknhQGtMIu3kHp9NrVeFdIS6v/BagxBAfwnsYgEPNJl2U91HggFtQ7pvO
         q2gQbIKTBxJRGZMjjBOI8qo3gCJaGJPt1xtGI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=mJ1plENC+YLxWW8h03R+7WpRMc9tEoXBjf4tt847zLx3a0elNT3J8ayABIfU0OBd5i
         er/Pfm3ml8hZNi9L/ckbEFZQ+hfBZXSCBBL6xSNuktiseWaumCSMCXr4b7t+VSsetMyu
         lqvv0oiCF3HqwpgMPwSnWNSFh5EJlytDi1L2Y=
Received: by 10.231.63.82 with SMTP id a18mr1356999ibi.130.1303886438791;
        Tue, 26 Apr 2011 23:40:38 -0700 (PDT)
Received: from elie (adsl-68-255-96-190.dsl.chcgil.ameritech.net [68.255.96.190])
        by mx.google.com with ESMTPS id g16sm215380ibb.37.2011.04.26.23.40.36
        (version=SSLv3 cipher=OTHER);
        Tue, 26 Apr 2011 23:40:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7v62q0b8e0.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172179>

The "_get_comp_words_by_ref -n := words" command from the
bash_completion library reassembles a modified version of COMP_WORDS
with ':' and '=' no longer treated as word separators and stores it in
the ${words[@]} array.  Git's programmable tab completion script uses
this to abstract away the difference between bash v3's and bash v4's
definitions of COMP_WORDS (bash v3 used shell words, while bash v4
breaks at separator characters); see v1.7.4-rc0~11^2~2 (bash: get
--pretty=m<tab> completion to work with bash v4, 2010-12-02).

zsh has (or rather its completion functions have) another idea about
what ${words[@]} should contain: the array is prepopulated with the
words from the command it is completing.  For reasons that are not
well understood, when git-completion.bash reserves its own "words"
variable with "local words", the variable becomes empty and cannot be
changed from then on.  So the completion script neglects the arguments
it has seen, and words complete like git subcommand names.  For
example, typing "git log origi<TAB>" gives no completions because
there are no "git origi..." commands.

Work around this by using a different variable (comp_words) that is
not special to zsh.  So now commands that completed correctly before
v1.7.4-rc0~11^2~2 on zsh should be able to complete correctly again.

Reported-by: Stefan Haller <lists@haller-berlin.de>
Suggested-by: Felipe Contreras <felipe.contreras@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Junio C Hamano wrote:

> I'd love to share the enthusiasm, but find that "as we can see" needs a
> much more clarification.

Sorry, I got carried away (I am happy to see someone has made some
headway in investigating this old bug).  How about this?

There is still a "for unknown reasons" in the above explanation.

 contrib/completion/git-completion.bash |   68 ++++++++++++++++---------------
 1 files changed, 35 insertions(+), 33 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 9150ea6..ce6b3e4 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -447,8 +447,9 @@ _get_comp_words_by_ref ()
 		prev)
 			prev=${words_[$cword_-1]}
 			;;
-		words)
-			words=("${words_[@]}")
+		-w)
+			eval $2'=("${words_[@]}")'
+			shift
 			;;
 		cword)
 			cword=$cword_
@@ -468,8 +469,9 @@ _get_comp_words_by_ref ()
 		prev)
 			prev=${COMP_WORDS[COMP_CWORD-1]}
 			;;
-		words)
-			words=("${COMP_WORDS[@]}")
+		-w)
+			eval $2='("${COMP_WORDS[@]}")'
+			shift
 			;;
 		cword)
 			cword=$COMP_CWORD
@@ -739,12 +741,12 @@ __git_complete_revlist ()
 
 __git_complete_remote_or_refspec ()
 {
-	local cur words cword
-	_get_comp_words_by_ref -n =: cur words cword
-	local cmd="${words[1]}"
+	local cur comp_words cword
+	_get_comp_words_by_ref -n =: -w comp_words cur cword
+	local cmd="${comp_words[1]}"
 	local i c=2 remote="" pfx="" lhs=1 no_complete_refspec=0
 	while [ $c -lt $cword ]; do
-		i="${words[c]}"
+		i="${comp_words[c]}"
 		case "$i" in
 		--mirror) [ "$cmd" = "push" ] && no_complete_refspec=1 ;;
 		--all)
@@ -991,10 +993,10 @@ __git_aliased_command ()
 # __git_find_on_cmdline requires 1 argument
 __git_find_on_cmdline ()
 {
-	local word subcommand c=1 words cword
-	_get_comp_words_by_ref -n =: words cword
+	local word subcommand c=1 comp_words cword
+	_get_comp_words_by_ref -n =: -w comp_words cword
 	while [ $c -lt $cword ]; do
-		word="${words[c]}"
+		word="${comp_words[c]}"
 		for subcommand in $1; do
 			if [ "$subcommand" = "$word" ]; then
 				echo "$subcommand"
@@ -1007,10 +1009,10 @@ __git_find_on_cmdline ()
 
 __git_has_doubledash ()
 {
-	local c=1 words cword
-	_get_comp_words_by_ref -n =: words cword
+	local c=1 comp_words cword
+	_get_comp_words_by_ref -n =: -w comp_words cword
 	while [ $c -lt $cword ]; do
-		if [ "--" = "${words[c]}" ]; then
+		if [ "--" = "${comp_words[c]}" ]; then
 			return 0
 		fi
 		c=$((++c))
@@ -1135,11 +1137,11 @@ _git_bisect ()
 
 _git_branch ()
 {
-	local i c=1 only_local_ref="n" has_r="n" cur words cword
+	local i c=1 only_local_ref="n" has_r="n" cur comp_words cword
 
-	_get_comp_words_by_ref -n =: cur words cword
+	_get_comp_words_by_ref -n =: -w comp_words cur cword
 	while [ $c -lt $cword ]; do
-		i="${words[c]}"
+		i="${comp_words[c]}"
 		case "$i" in
 		-d|-m)	only_local_ref="y" ;;
 		-r)	has_r="y" ;;
@@ -1167,9 +1169,9 @@ _git_branch ()
 
 _git_bundle ()
 {
-	local words cword
-	_get_comp_words_by_ref -n =: words cword
-	local cmd="${words[2]}"
+	local comp_words cword
+	_get_comp_words_by_ref -n =: -w comp_words cword
+	local cmd="${comp_words[2]}"
 	case "$cword" in
 	2)
 		__gitcomp "create list-heads verify unbundle"
@@ -1713,15 +1715,15 @@ _git_notes ()
 {
 	local subcommands='add append copy edit list prune remove show'
 	local subcommand="$(__git_find_on_cmdline "$subcommands")"
-	local cur words cword
-	_get_comp_words_by_ref -n =: cur words cword
+	local cur comp_words cword
+	_get_comp_words_by_ref -n =: -w comp_words cur cword
 
 	case "$subcommand,$cur" in
 	,--*)
 		__gitcomp '--ref'
 		;;
 	,*)
-		case "${words[cword-1]}" in
+		case "${comp_words[cword-1]}" in
 		--ref)
 			__gitcomp "$(__git_refs)"
 			;;
@@ -1749,7 +1751,7 @@ _git_notes ()
 	prune,*)
 		;;
 	*)
-		case "${words[cword-1]}" in
+		case "${comp_words[cword-1]}" in
 		-m|-F)
 			;;
 		*)
@@ -1893,11 +1895,11 @@ _git_stage ()
 
 __git_config_get_set_variables ()
 {
-	local words cword
-	_get_comp_words_by_ref -n =: words cword
+	local comp_words cword
+	_get_comp_words_by_ref -n =: -w comp_words cword
 	local prevword word config_file= c=$cword
 	while [ $c -gt 1 ]; do
-		word="${words[c]}"
+		word="${comp_words[c]}"
 		case "$word" in
 		--global|--system|--file=*)
 			config_file="$word"
@@ -2665,10 +2667,10 @@ _git_svn ()
 _git_tag ()
 {
 	local i c=1 f=0
-	local words cword prev
-	_get_comp_words_by_ref -n =: words cword prev
+	local comp_words cword prev
+	_get_comp_words_by_ref -n =: -w comp_words cword prev
 	while [ $c -lt $cword ]; do
-		i="${words[c]}"
+		i="${comp_words[c]}"
 		case "$i" in
 		-d|-v)
 			__gitcomp "$(__git_tags)"
@@ -2712,10 +2714,10 @@ _git ()
 		setopt KSH_TYPESET
 	fi
 
-	local cur words cword
-	_get_comp_words_by_ref -n =: cur words cword
+	local cur comp_words cword
+	_get_comp_words_by_ref -n =: -w comp_words cur cword
 	while [ $c -lt $cword ]; do
-		i="${words[c]}"
+		i="${comp_words[c]}"
 		case "$i" in
 		--git-dir=*) __git_dir="${i#--git-dir=}" ;;
 		--bare)      __git_dir="." ;;
-- 
1.7.5
