From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH] Speed up bash completion loading
Date: Fri, 13 Nov 2009 02:50:28 -0600
Message-ID: <20091113085028.GA4804@progeny.tock>
References: <7vbpj9s8vk.fsf@alter.siamese.dyndns.org>
 <fabb9a1e0911110957k599ac3dfmd1a44a0499c72b2d@mail.gmail.com>
 <20091111220832.GA31620@progeny.tock>
 <4AFCFF50.5080401@gmail.com>
 <20091113070652.GA3907@progeny.tock>
 <4AFD06CD.7090003@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kirill Smelkov <kirr@mns.spb.ru>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <junio@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 13 09:40:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8rhc-0001HL-Hd
	for gcvg-git-2@lo.gmane.org; Fri, 13 Nov 2009 09:40:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754608AbZKMIkG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Nov 2009 03:40:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754685AbZKMIkF
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Nov 2009 03:40:05 -0500
Received: from mail-gx0-f228.google.com ([209.85.217.228]:49469 "EHLO
	mail-gx0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754168AbZKMIkD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Nov 2009 03:40:03 -0500
Received: by gxk28 with SMTP id 28so1029751gxk.9
        for <git@vger.kernel.org>; Fri, 13 Nov 2009 00:40:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=M+Jnb9ALgt7p9+aGnbbFrdfYOuqmp80EBkL4DUJLAn8=;
        b=sQ6fQzLcUIcDu1hbltyymQFItAvepIes7KkX01eCBcsRf9pUwatkISLQ1t/w48hOau
         tzN2vFF2S6zHzVj8WDngUunybbsuL1hjaYh+mloMl624qQx4lKvVeJv0R7K5QgbLZjMY
         oOumDUKSq1jW2O+1MFU2ItyOZJxeT+aZU5KiY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=VcclFJTkAlVLlmLtQKlM8exHBQ8DXefDZ9keOgg1amKcTh9z2It5BKpZoA6Jy4Aa2E
         LKLtS1/gbM31Xnq3v5XNr+23WKyAXZv/FBs6pIBvhnEz1jNfm6U3oYdWCJSp0ROclbPl
         Sx9lSZ4Ph/Bzj1aIW4VZ1P02kD9kVnHo1v2j0=
Received: by 10.101.72.10 with SMTP id z10mr4288780ank.122.1258101608925;
        Fri, 13 Nov 2009 00:40:08 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 7sm628828yxg.14.2009.11.13.00.40.07
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 13 Nov 2009 00:40:08 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4AFD06CD.7090003@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132821>

On my slow laptop (P3 600MHz), system-wide bash completions take
too much time to load (> 2s), and a significant fraction of this
time is spent loading git-completion.bash:

$ time bash -c ". ./git-completion.bash"  # hot cache, before this patch

real    0m0.509s
user    0m0.310s
sys     0m0.180s

Kirill tracked down that the most time is spent warming up
merge_strategy, all_command & porcelain_command caches.

Since git is not used in each and every interactive xterm, it
seems best to load completion support with cold caches, and then
load each needed thing lazily.  This has most of the speed
advantage of pre-generating everything at build time, without the
complication of figuring out at build time what commands will be
available at run time.

The result is that loading completion is significantly faster
now:

$ time bash -c ". ./git-completion.bash"  # cold cache, after this patch

real    0m0.171s
user    0m0.060s
sys     0m0.040s

Suggested-by: Kirill Smelkov <kirr@mns.spb.ru>
Cc: Shawn O. Pearce <spearce@spearce.org>
Cc: Stephen Boyd <bebarino@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>
Cc: Junio C Hamano <junio@pobox.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Stephen Boyd wrote:

> Ah ok. I think this proves even more that pregenerating the
> completion is a bad idea. With dynamic population we don't have
> these problems and it only takes 250ms more to load on a P3 700Mhz.

Hmm, 250 ms is a lot.

Strictly speaking, even with the existing completion script, it might
be nice to provide a "hash -r"-like command to bring the caches up to
date.  Such a function could be:

git-completion-rehash ()
{
	__git_compute_all_commands
	__git_compute_merge_strategies
	__git_compute_porcelain_commands
}

But that is a separate topic.

 contrib/completion/git-completion.bash |   35 +++++++++++++++++--------------
 1 files changed, 19 insertions(+), 16 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 9e8b607..7088ec7 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -330,10 +330,9 @@ __git_list_merge_strategies ()
 	}'
 }
 
-__git_merge_strategies ()
+__git_compute_merge_strategies ()
 {
-	: ${__git_merge_strategylist:=$(__git_list_merge_strategies)}
-	echo "$__git_merge_strategylist"
+	: ${__git_merge_strategies=$(__git_list_merge_strategies)}
 }
 
 __git_complete_file ()
@@ -468,15 +467,16 @@ __git_complete_remote_or_refspec ()
 
 __git_complete_strategy ()
 {
+	__git_compute_merge_strategies
 	case "${COMP_WORDS[COMP_CWORD-1]}" in
 	-s|--strategy)
-		__gitcomp "$(__git_merge_strategies)"
+		__gitcomp "$__git_merge_strategies"
 		return 0
 	esac
 	local cur="${COMP_WORDS[COMP_CWORD]}"
 	case "$cur" in
 	--strategy=*)
-		__gitcomp "$(__git_merge_strategies)" "" "${cur##--strategy=}"
+		__gitcomp "$__git_merge_strategies" "" "${cur##--strategy=}"
 		return 0
 		;;
 	esac
@@ -495,16 +495,16 @@ __git_list_all_commands ()
 	done
 }
 
-__git_all_commands ()
+__git_compute_all_commands ()
 {
-	: ${__git_all_commandlist:=$(__git_list_all_commands)}
-	echo "$__git_all_commandlist"
+	: ${__git_all_commands=$(__git_list_all_commands)}
 }
 
 __git_list_porcelain_commands ()
 {
 	local i IFS=" "$'\n'
-	for i in "help" $(__git_all_commands)
+	__git_compute_all_commands
+	for i in "help" $__git_all_commands
 	do
 		case $i in
 		*--*)             : helper pattern;;
@@ -586,10 +586,9 @@ __git_list_porcelain_commands ()
 	done
 }
 
-__git_porcelain_commands ()
+__git_compute_porcelain_commands ()
 {
-	: ${__git_porcelain_commandlist:=$(__git_list_porcelain_commands)}
-	echo "$__git_porcelain_commandlist"
+	: ${__git_porcelain_commands=$(__git_list_porcelain_commands)}
 }
 
 __git_aliases ()
@@ -1082,7 +1081,8 @@ _git_help ()
 		return
 		;;
 	esac
-	__gitcomp "$(__git_all_commands)
+	__git_compute_all_commands
+	__gitcomp "__git_all_commands
 		attributes cli core-tutorial cvs-migration
 		diffcore gitk glossary hooks ignore modules
 		repository-layout tutorial tutorial-2
@@ -1438,7 +1438,8 @@ _git_config ()
 		return
 		;;
 	pull.twohead|pull.octopus)
-		__gitcomp "$(__git_merge_strategies)"
+		__git_compute_merge_strategies
+		__gitcomp "$__git_merge_strategies"
 		return
 		;;
 	color.branch|color.diff|color.interactive|\
@@ -1539,7 +1540,8 @@ _git_config ()
 	pager.*)
 		local pfx="${cur%.*}."
 		cur="${cur#*.}"
-		__gitcomp "$(__git_all_commands)" "$pfx" "$cur"
+		__git_compute_all_commands
+		__gitcomp "__git_all_commands" "$pfx" "$cur"
 		return
 		;;
 	remote.*.*)
@@ -2136,7 +2138,8 @@ _git ()
 			--help
 			"
 			;;
-		*)     __gitcomp "$(__git_porcelain_commands) $(__git_aliases)" ;;
+		*)     __git_compute_porcelain_commands
+		       __gitcomp "$__git_porcelain_commands $(__git_aliases)" ;;
 		esac
 		return
 	fi
-- 
1.6.5.2
