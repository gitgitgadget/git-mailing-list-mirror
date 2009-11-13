From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Speed up bash completion loading
Date: Fri, 13 Nov 2009 03:03:56 -0600
Message-ID: <20091113090343.GA5355@progeny.tock>
References: <7vbpj9s8vk.fsf@alter.siamese.dyndns.org>
 <fabb9a1e0911110957k599ac3dfmd1a44a0499c72b2d@mail.gmail.com>
 <20091111220832.GA31620@progeny.tock>
 <4AFCFF50.5080401@gmail.com>
 <20091113070652.GA3907@progeny.tock>
 <4AFD06CD.7090003@gmail.com>
 <20091113085028.GA4804@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Kirill Smelkov <kirr@mns.spb.ru>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <junio@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 13 09:53:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8ruZ-0006VG-Ik
	for gcvg-git-2@lo.gmane.org; Fri, 13 Nov 2009 09:53:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754815AbZKMIxd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Nov 2009 03:53:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754730AbZKMIxc
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Nov 2009 03:53:32 -0500
Received: from mail-yx0-f187.google.com ([209.85.210.187]:48962 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754659AbZKMIxb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Nov 2009 03:53:31 -0500
Received: by yxe17 with SMTP id 17so2736453yxe.33
        for <git@vger.kernel.org>; Fri, 13 Nov 2009 00:53:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=QjOasx1BM9qK5lQDac2XmIfYJqGuKAmzyjF7y3MFhfU=;
        b=nlgh/vfjSFknQpXa0YeJtk5hF7QzKNpaZS1zSdWyX0IyXPUolx/v52gW1CVukVCBGM
         m109qscQ6bLmGR6S5jbrx4H+B3fjf22gEen4YgR8YEz6YDahcMpSBSuHrZEJ52b2TbTn
         HN4dy6VhqxBoPMrZM/ErcD3mx4OCFHm4BOXZw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=gyIfIJez+GgbIZA059Xz93NP/gPvJjO1N2FYhr9BcDY1X6aBZcs2UOILOjHsEStGOC
         w1pOX/Tu8Cb+ZMIpb+5UqeJCjjpD/Fzb23x8woLjpyfLZz+Sa1nsw1E6A1qphw6ABZW5
         67BjyqMb4kum3BKATJZNx0aU88YF1JGieJtzg=
Received: by 10.150.29.33 with SMTP id c33mr7236232ybc.292.1258102416596;
        Fri, 13 Nov 2009 00:53:36 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 13sm1676534gxk.1.2009.11.13.00.53.34
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 13 Nov 2009 00:53:35 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20091113085028.GA4804@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132823>

On my slow laptop (P3 600MHz), system-wide bash completions take
too much time to load (> 2s), and a significant fraction of this
time is spent loading git-completion.bash:

$ time bash -c ". ./git-completion.bash"  # hot cache, before this patc=
h

real    0m0.509s
user    0m0.310s
sys     0m0.180s

Kirill noticed that most of the time is spent warming up
merge_strategy, all_command & porcelain_command caches.

Since git is not used in each and every interactive xterm, it
seems best to load completion support with cold caches, and then
load each needed thing lazily.  This has most of the speed
advantage of pre-generating everything at build time, without the
complication of figuring out at build time what commands will be
available at run time.

The result is that loading completion is significantly faster
now:

$ time bash -c ". ./git-completion.bash"  # cold cache, after this patc=
h

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
Jonathan Nieder wrote:
> Stephen Boyd wrote:

>> Ah ok. I think this proves even more that pregenerating the
>> completion is a bad idea. With dynamic population we don't have
>> these problems and it only takes 250ms more to load on a P3
>> 700Mhz.
>
> Hmm, 250 ms is a lot.

Here=E2=80=99s the real patch.  Sorry about that.

Jonathan

 contrib/completion/git-completion.bash |   67 +++++++++++++++---------=
-------
 1 files changed, 32 insertions(+), 35 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index e3ddecc..7088ec7 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -21,13 +21,7 @@
 #    2) Added the following line to your .bashrc:
 #        source ~/.git-completion.sh
 #
-#    3) You may want to make sure the git executable is available
-#       in your PATH before this script is sourced, as some caching
-#       is performed while the script loads.  If git isn't found
-#       at source time then all lookups will be done on demand,
-#       which may be slightly slower.
-#
-#    4) Consider changing your PS1 to also show the current branch:
+#    3) Consider changing your PS1 to also show the current branch:
 #        PS1=3D'[\u@\h \W$(__git_ps1 " (%s)")]\$ '
 #
 #       The argument to __git_ps1 will be displayed only if you
@@ -324,12 +318,8 @@ __git_remotes ()
 	done
 }
=20
-__git_merge_strategies ()
+__git_list_merge_strategies ()
 {
-	if [ -n "${__git_merge_strategylist-}" ]; then
-		echo "$__git_merge_strategylist"
-		return
-	fi
 	git merge -s help 2>&1 |
 	sed -n -e '/[Aa]vailable strategies are: /,/^$/{
 		s/\.$//
@@ -339,8 +329,11 @@ __git_merge_strategies ()
 		p
 	}'
 }
-__git_merge_strategylist=3D
-__git_merge_strategylist=3D$(__git_merge_strategies 2>/dev/null)
+
+__git_compute_merge_strategies ()
+{
+	: ${__git_merge_strategies=3D$(__git_list_merge_strategies)}
+}
=20
 __git_complete_file ()
 {
@@ -474,27 +467,24 @@ __git_complete_remote_or_refspec ()
=20
 __git_complete_strategy ()
 {
+	__git_compute_merge_strategies
 	case "${COMP_WORDS[COMP_CWORD-1]}" in
 	-s|--strategy)
-		__gitcomp "$(__git_merge_strategies)"
+		__gitcomp "$__git_merge_strategies"
 		return 0
 	esac
 	local cur=3D"${COMP_WORDS[COMP_CWORD]}"
 	case "$cur" in
 	--strategy=3D*)
-		__gitcomp "$(__git_merge_strategies)" "" "${cur##--strategy=3D}"
+		__gitcomp "$__git_merge_strategies" "" "${cur##--strategy=3D}"
 		return 0
 		;;
 	esac
 	return 1
 }
=20
-__git_all_commands ()
+__git_list_all_commands ()
 {
-	if [ -n "${__git_all_commandlist-}" ]; then
-		echo "$__git_all_commandlist"
-		return
-	fi
 	local i IFS=3D" "$'\n'
 	for i in $(git help -a|egrep '^  [a-zA-Z0-9]')
 	do
@@ -504,17 +494,17 @@ __git_all_commands ()
 		esac
 	done
 }
-__git_all_commandlist=3D
-__git_all_commandlist=3D"$(__git_all_commands 2>/dev/null)"
=20
-__git_porcelain_commands ()
+__git_compute_all_commands ()
+{
+	: ${__git_all_commands=3D$(__git_list_all_commands)}
+}
+
+__git_list_porcelain_commands ()
 {
-	if [ -n "${__git_porcelain_commandlist-}" ]; then
-		echo "$__git_porcelain_commandlist"
-		return
-	fi
 	local i IFS=3D" "$'\n'
-	for i in "help" $(__git_all_commands)
+	__git_compute_all_commands
+	for i in "help" $__git_all_commands
 	do
 		case $i in
 		*--*)             : helper pattern;;
@@ -595,8 +585,11 @@ __git_porcelain_commands ()
 		esac
 	done
 }
-__git_porcelain_commandlist=3D
-__git_porcelain_commandlist=3D"$(__git_porcelain_commands 2>/dev/null)=
"
+
+__git_compute_porcelain_commands ()
+{
+	: ${__git_porcelain_commands=3D$(__git_list_porcelain_commands)}
+}
=20
 __git_aliases ()
 {
@@ -1088,7 +1081,8 @@ _git_help ()
 		return
 		;;
 	esac
-	__gitcomp "$(__git_all_commands)
+	__git_compute_all_commands
+	__gitcomp "__git_all_commands
 		attributes cli core-tutorial cvs-migration
 		diffcore gitk glossary hooks ignore modules
 		repository-layout tutorial tutorial-2
@@ -1444,7 +1438,8 @@ _git_config ()
 		return
 		;;
 	pull.twohead|pull.octopus)
-		__gitcomp "$(__git_merge_strategies)"
+		__git_compute_merge_strategies
+		__gitcomp "$__git_merge_strategies"
 		return
 		;;
 	color.branch|color.diff|color.interactive|\
@@ -1545,7 +1540,8 @@ _git_config ()
 	pager.*)
 		local pfx=3D"${cur%.*}."
 		cur=3D"${cur#*.}"
-		__gitcomp "$(__git_all_commands)" "$pfx" "$cur"
+		__git_compute_all_commands
+		__gitcomp "__git_all_commands" "$pfx" "$cur"
 		return
 		;;
 	remote.*.*)
@@ -2142,7 +2138,8 @@ _git ()
 			--help
 			"
 			;;
-		*)     __gitcomp "$(__git_porcelain_commands) $(__git_aliases)" ;;
+		*)     __git_compute_porcelain_commands
+		       __gitcomp "$__git_porcelain_commands $(__git_aliases)" ;;
 		esac
 		return
 	fi
--=20
1.6.5.2
