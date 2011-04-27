From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] git-completion: fix zsh support
Date: Wed, 27 Apr 2011 04:26:52 +0300
Message-ID: <1303867612-15975-1-git-send-email-felipe.contreras@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 27 03:27:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QEtWz-00015B-Jd
	for gcvg-git-2@lo.gmane.org; Wed, 27 Apr 2011 03:27:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755576Ab1D0B07 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Apr 2011 21:26:59 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:36444 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753308Ab1D0B06 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2011 21:26:58 -0400
Received: by ewy4 with SMTP id 4so369205ewy.19
        for <git@vger.kernel.org>; Tue, 26 Apr 2011 18:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer;
        bh=772Dn96i8XS3mggIQNBnmtlDF0kKaU2Nw0BJ+rVfxe0=;
        b=sgJIQb/OldCvDvpuHEVLAMK3Lb3AZd07Jp6vR/utLMVEm1eaUJPBz5NJn5SPaGYa9H
         VzR1NJQl2ck3hAvWhiyqg8PXJHas80fB1v4WNq+CLus02MzdacUoYzjBa15Rd6R58rya
         eX+JMi/EyvO/S6X9y8TP42hxaGXtXf0RwLpXg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=TFKGh170Fc6ybsWQbrIWoQefg6Wx92hrygTiccvymjpq90ppEm1dR89kB/NPLRn+V9
         UQHqFe7Jmo42QRx46ELmkCGHFz0SQrZm8WdVqIJ9mTQXBhy9GPEH2arF5P95Q9LPYtPZ
         lGX6teSVE61XCSWmHTEjq3jLdk1v6VdtZzHHs=
Received: by 10.213.100.225 with SMTP id z33mr678990ebn.69.1303867617299;
        Tue, 26 Apr 2011 18:26:57 -0700 (PDT)
Received: from localhost (a91-153-253-80.elisa-laajakaista.fi [91.153.253.80])
        by mx.google.com with ESMTPS id q53sm185320eeh.25.2011.04.26.18.26.56
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 26 Apr 2011 18:26:56 -0700 (PDT)
X-Mailer: git-send-email 1.7.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172142>

It turns out 'words' is a special variable used by zsh completion, and
it has some strange behavior as we can see.

Better avoid it.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash |   66 ++++++++++++++++----------------
 1 files changed, 33 insertions(+), 33 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index b94ff3c..9aae484 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -447,8 +447,8 @@ _get_comp_words_by_ref ()
 		prev)
 			prev=${words_[$cword_-1]}
 			;;
-		words)
-			words=("${words_[@]}")
+		cwords)
+			cwords=("${words_[@]}")
 			;;
 		cword)
 			cword=$cword_
@@ -468,8 +468,8 @@ _get_comp_words_by_ref ()
 		prev)
 			prev=${COMP_WORDS[COMP_CWORD-1]}
 			;;
-		words)
-			words=("${COMP_WORDS[@]}")
+		cwords)
+			cwords=("${COMP_WORDS[@]}")
 			;;
 		cword)
 			cword=$COMP_CWORD
@@ -739,12 +739,12 @@ __git_complete_revlist ()
 
 __git_complete_remote_or_refspec ()
 {
-	local cur words cword
-	_get_comp_words_by_ref -n =: cur words cword
-	local cmd="${words[1]}"
+	local cur cwords cword
+	_get_comp_words_by_ref -n =: cur cwords cword
+	local cmd="${cwords[1]}"
 	local i c=2 remote="" pfx="" lhs=1 no_complete_refspec=0
 	while [ $c -lt $cword ]; do
-		i="${words[c]}"
+		i="${cwords[c]}"
 		case "$i" in
 		--mirror) [ "$cmd" = "push" ] && no_complete_refspec=1 ;;
 		--all)
@@ -991,10 +991,10 @@ __git_aliased_command ()
 # __git_find_on_cmdline requires 1 argument
 __git_find_on_cmdline ()
 {
-	local word subcommand c=1 words cword
-	_get_comp_words_by_ref -n =: words cword
+	local word subcommand c=1 cwords cword
+	_get_comp_words_by_ref -n =: cwords cword
 	while [ $c -lt $cword ]; do
-		word="${words[c]}"
+		word="${cwords[c]}"
 		for subcommand in $1; do
 			if [ "$subcommand" = "$word" ]; then
 				echo "$subcommand"
@@ -1007,10 +1007,10 @@ __git_find_on_cmdline ()
 
 __git_has_doubledash ()
 {
-	local c=1 words cword
-	_get_comp_words_by_ref -n =: words cword
+	local c=1 cwords cword
+	_get_comp_words_by_ref -n =: cwords cword
 	while [ $c -lt $cword ]; do
-		if [ "--" = "${words[c]}" ]; then
+		if [ "--" = "${cwords[c]}" ]; then
 			return 0
 		fi
 		c=$((++c))
@@ -1135,11 +1135,11 @@ _git_bisect ()
 
 _git_branch ()
 {
-	local i c=1 only_local_ref="n" has_r="n" cur words cword
+	local i c=1 only_local_ref="n" has_r="n" cur cwords cword
 
-	_get_comp_words_by_ref -n =: cur words cword
+	_get_comp_words_by_ref -n =: cur cwords cword
 	while [ $c -lt $cword ]; do
-		i="${words[c]}"
+		i="${cwords[c]}"
 		case "$i" in
 		-d|-m)	only_local_ref="y" ;;
 		-r)	has_r="y" ;;
@@ -1167,9 +1167,9 @@ _git_branch ()
 
 _git_bundle ()
 {
-	local words cword
-	_get_comp_words_by_ref -n =: words cword
-	local cmd="${words[2]}"
+	local cwords cword
+	_get_comp_words_by_ref -n =: cwords cword
+	local cmd="${cwords[2]}"
 	case "$cword" in
 	2)
 		__gitcomp "create list-heads verify unbundle"
@@ -1713,15 +1713,15 @@ _git_notes ()
 {
 	local subcommands='add append copy edit list prune remove show'
 	local subcommand="$(__git_find_on_cmdline "$subcommands")"
-	local cur words cword
-	_get_comp_words_by_ref -n =: cur words cword
+	local cur cwords cword
+	_get_comp_words_by_ref -n =: cur cwords cword
 
 	case "$subcommand,$cur" in
 	,--*)
 		__gitcomp '--ref'
 		;;
 	,*)
-		case "${words[cword-1]}" in
+		case "${cwords[cword-1]}" in
 		--ref)
 			__gitcomp "$(__git_refs)"
 			;;
@@ -1749,7 +1749,7 @@ _git_notes ()
 	prune,*)
 		;;
 	*)
-		case "${words[cword-1]}" in
+		case "${cwords[cword-1]}" in
 		-m|-F)
 			;;
 		*)
@@ -1893,11 +1893,11 @@ _git_stage ()
 
 __git_config_get_set_variables ()
 {
-	local words cword
-	_get_comp_words_by_ref -n =: words cword
+	local cwords cword
+	_get_comp_words_by_ref -n =: cwords cword
 	local prevword word config_file= c=$cword
 	while [ $c -gt 1 ]; do
-		word="${words[c]}"
+		word="${cwords[c]}"
 		case "$word" in
 		--global|--system|--file=*)
 			config_file="$word"
@@ -2665,10 +2665,10 @@ _git_svn ()
 _git_tag ()
 {
 	local i c=1 f=0
-	local words cword prev
-	_get_comp_words_by_ref -n =: words cword prev
+	local cwords cword prev
+	_get_comp_words_by_ref -n =: cwords cword prev
 	while [ $c -lt $cword ]; do
-		i="${words[c]}"
+		i="${cwords[c]}"
 		case "$i" in
 		-d|-v)
 			__gitcomp "$(__git_tags)"
@@ -2712,10 +2712,10 @@ _git ()
 		setopt KSH_TYPESET
 	fi
 
-	local cur words cword
-	_get_comp_words_by_ref -n =: cur words cword
+	local cur cwords cword
+	_get_comp_words_by_ref -n =: cur cwords cword
 	while [ $c -lt $cword ]; do
-		i="${words[c]}"
+		i="${cwords[c]}"
 		case "$i" in
 		--git-dir=*) __git_dir="${i#--git-dir=}" ;;
 		--bare)      __git_dir="." ;;
-- 
1.7.5
