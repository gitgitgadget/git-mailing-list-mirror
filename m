From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v3] Speed up bash completion loading
Date: Tue, 17 Nov 2009 18:49:10 -0600
Message-ID: <20091118004910.GA5729@progeny.tock>
References: <4AFCFF50.5080401@gmail.com>
 <20091113070652.GA3907@progeny.tock>
 <4AFD06CD.7090003@gmail.com>
 <20091113085028.GA4804@progeny.tock>
 <20091113090343.GA5355@progeny.tock>
 <4AFDC4F3.1050607@gmail.com>
 <20091114110141.GB1829@progeny.tock>
 <7vd43krwd0.fsf@alter.siamese.dyndns.org>
 <20091115102912.GA4100@progeny.tock>
 <4B010D42.4090902@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>,
	Junio C Hamano <gitster@pobox.com>,
	Kirill Smelkov <kirr@mns.spb.ru>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 18 01:38:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NAYZM-0004Au-Ia
	for gcvg-git-2@lo.gmane.org; Wed, 18 Nov 2009 01:38:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756669AbZKRAi2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Nov 2009 19:38:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753310AbZKRAi1
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Nov 2009 19:38:27 -0500
Received: from mail-yw0-f176.google.com ([209.85.211.176]:43213 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751891AbZKRAiZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Nov 2009 19:38:25 -0500
Received: by ywh6 with SMTP id 6so603223ywh.4
        for <git@vger.kernel.org>; Tue, 17 Nov 2009 16:38:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=xPYT5q9CRkF1J42Yrzk+5CDUGKiLF0fvwL8snGbbEew=;
        b=wX79NbkbKEzg5UNMTx2YTxXV0UCufJZFuW7W4ItxLhCW9ewonhkuCaGDE3ctl61Au9
         w3bhKw2Za+hVlaUs7MyxwfHwKcktt421ZeWgzcRaypPajZ9TpphzwyhKITVgTL7iHDpe
         ku5wKKRWq5bSWh7K6V5pLNGuGguuWSrkt7zi8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=Y1JkkmeGUJL4QqBicPQyFs7P21iJUxlSrGV5vm1A9XigMUYZ41Vo7Yj4KEYZ58TInY
         inL42LEVHNGTBSsKe2MxWbv9iHAgGH2uFdPlNEc/etdi7N4A08/aKeMnND7wKiOlAD3z
         W84joCCTLzteq237CRPoWgOqghIBBbl3inBbA=
Received: by 10.91.126.10 with SMTP id d10mr1010228agn.70.1258504703210;
        Tue, 17 Nov 2009 16:38:23 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 36sm532163yxh.67.2009.11.17.16.38.20
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 17 Nov 2009 16:38:21 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4B010D42.4090902@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133119>

Since git is not used in each and every interactive xterm, it
seems best to load completion support with cold caches and then
load each needed thing lazily.  This has most of the speed
advantage of pre-generating everything at build time, without the
complication of figuring out at build time what commands will be
available at run time.

On this slow laptop, this decreases the time to load
git-completion.bash from about 500 ms to about 175 ms.

Suggested-by: Kirill Smelkov <kirr@mns.spb.ru>
Acked-by: Shawn O. Pearce <spearce@spearce.org>
Cc: Stephen Boyd <bebarino@gmail.com>
Cc: SZEDER G=C3=A1bor <szeder@ira.uka.de>
Cc: Sverre Rabbelier <srabbelier@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
I do not know whether it is kosher to carry over an ack like this.
The interdiff is small, for what it=E2=80=99s worth:

	$ git branch jn/faster-completion-startup ee41299
	$ git diff jn/faster-completion-startup
	diff --git a/contrib/completion/git-completion.bash b/contrib/completi=
on/git-completion.bash
	index bd22802..f67254d 100755
	--- a/contrib/completion/git-completion.bash
	+++ b/contrib/completion/git-completion.bash
	@@ -330,7 +330,7 @@ __git_list_merge_strategies ()
		}'
	 }
	=20
	-unset __git_merge_strategies
	+__git_merge_strategies=3D
	 # 'git merge -s help' (and thus detection of the merge strategy
	 # list) fails, unfortunately, if run outside of any git working
	 # tree.  __git_merge_strategies is set to the empty string in
	@@ -501,10 +501,10 @@ __git_list_all_commands ()
		done
	 }
	=20
	-unset __git_all_commands
	+__git_all_commands=3D
	 __git_compute_all_commands ()
	 {
	-	: ${__git_all_commands=3D$(__git_list_all_commands)}
	+	: ${__git_all_commands:=3D$(__git_list_all_commands)}
	 }
	=20
	 __git_list_porcelain_commands ()
	@@ -593,11 +593,11 @@ __git_list_porcelain_commands ()
		done
	 }
	=20
	-unset __git_porcelain_commands
	+__git_porcelain_commands=3D
	 __git_compute_porcelain_commands ()
	 {
		__git_compute_all_commands
	-	: ${__git_porcelain_commands=3D$(__git_list_porcelain_commands)}
	+	: ${__git_porcelain_commands:=3D$(__git_list_porcelain_commands)}
	 }
	=20
	 __git_aliases ()

Please let me know if I have commited a faux pas.

Stephen Boyd wrote:
>> Junio C Hamano wrote:

>>> Wouldn't
>>>
>>>	: ${__gms:=3D$(command)}
>>>
>>> run command only until it gives a non-empty string?
>=20
> Why not do this for all of the lists and not just the merge strategie=
s?

I generally find set-if-unset a little more intuitive.  But some users
might install and try out git completion before realizing the need to
install git, and in this case set-if-empty gives better behavior.

Thanks.

 contrib/completion/git-completion.bash |   76 +++++++++++++++++-------=
--------
 1 files changed, 41 insertions(+), 35 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index e3ddecc..1223a07 100755
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
@@ -339,8 +329,17 @@ __git_merge_strategies ()
 		p
 	}'
 }
-__git_merge_strategylist=3D
-__git_merge_strategylist=3D$(__git_merge_strategies 2>/dev/null)
+
+__git_merge_strategies=3D
+# 'git merge -s help' (and thus detection of the merge strategy
+# list) fails, unfortunately, if run outside of any git working
+# tree.  __git_merge_strategies is set to the empty string in
+# that case, and the detection will be repeated the next time it
+# is needed.
+__git_compute_merge_strategies ()
+{
+	: ${__git_merge_strategies:=3D$(__git_list_merge_strategies)}
+}
=20
 __git_complete_file ()
 {
@@ -474,27 +473,24 @@ __git_complete_remote_or_refspec ()
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
@@ -504,17 +500,18 @@ __git_all_commands ()
 		esac
 	done
 }
-__git_all_commandlist=3D
-__git_all_commandlist=3D"$(__git_all_commands 2>/dev/null)"
=20
-__git_porcelain_commands ()
+__git_all_commands=3D
+__git_compute_all_commands ()
+{
+	: ${__git_all_commands:=3D$(__git_list_all_commands)}
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
@@ -595,8 +592,13 @@ __git_porcelain_commands ()
 		esac
 	done
 }
-__git_porcelain_commandlist=3D
-__git_porcelain_commandlist=3D"$(__git_porcelain_commands 2>/dev/null)=
"
+
+__git_porcelain_commands=3D
+__git_compute_porcelain_commands ()
+{
+	__git_compute_all_commands
+	: ${__git_porcelain_commands:=3D$(__git_list_porcelain_commands)}
+}
=20
 __git_aliases ()
 {
@@ -1088,7 +1090,8 @@ _git_help ()
 		return
 		;;
 	esac
-	__gitcomp "$(__git_all_commands)
+	__git_compute_all_commands
+	__gitcomp "$__git_all_commands
 		attributes cli core-tutorial cvs-migration
 		diffcore gitk glossary hooks ignore modules
 		repository-layout tutorial tutorial-2
@@ -1444,7 +1447,8 @@ _git_config ()
 		return
 		;;
 	pull.twohead|pull.octopus)
-		__gitcomp "$(__git_merge_strategies)"
+		__git_compute_merge_strategies
+		__gitcomp "$__git_merge_strategies"
 		return
 		;;
 	color.branch|color.diff|color.interactive|\
@@ -1545,7 +1549,8 @@ _git_config ()
 	pager.*)
 		local pfx=3D"${cur%.*}."
 		cur=3D"${cur#*.}"
-		__gitcomp "$(__git_all_commands)" "$pfx" "$cur"
+		__git_compute_all_commands
+		__gitcomp "$__git_all_commands" "$pfx" "$cur"
 		return
 		;;
 	remote.*.*)
@@ -2142,7 +2147,8 @@ _git ()
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
