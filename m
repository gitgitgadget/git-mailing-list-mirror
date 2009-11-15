From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v2] Speed up bash completion loading
Date: Sun, 15 Nov 2009 04:29:13 -0600
Message-ID: <20091115102912.GA4100@progeny.tock>
References: <fabb9a1e0911110957k599ac3dfmd1a44a0499c72b2d@mail.gmail.com>
 <20091111220832.GA31620@progeny.tock>
 <4AFCFF50.5080401@gmail.com>
 <20091113070652.GA3907@progeny.tock>
 <4AFD06CD.7090003@gmail.com>
 <20091113085028.GA4804@progeny.tock>
 <20091113090343.GA5355@progeny.tock>
 <4AFDC4F3.1050607@gmail.com>
 <20091114110141.GB1829@progeny.tock>
 <7vd43krwd0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Stephen Boyd <bebarino@gmail.com>,
	Kirill Smelkov <kirr@mns.spb.ru>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 15 11:19:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N9cBz-0000GC-3c
	for gcvg-git-2@lo.gmane.org; Sun, 15 Nov 2009 11:18:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752618AbZKOKSf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 15 Nov 2009 05:18:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752566AbZKOKSe
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Nov 2009 05:18:34 -0500
Received: from mail-yw0-f202.google.com ([209.85.211.202]:44315 "EHLO
	mail-yw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752548AbZKOKSd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Nov 2009 05:18:33 -0500
Received: by ywh40 with SMTP id 40so2386285ywh.33
        for <git@vger.kernel.org>; Sun, 15 Nov 2009 02:18:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=oDMEBt66HOgt7sIVgd8MYXKhgEh4Bqi2/KWW4AOnaiE=;
        b=obmlZsIbeSEPvB0T7zsFCn/hgFMV+2D442rHgcxNBe0cCh79074+Fef1xEImBYrzzB
         jX1qP9KeKtRJxOtZZ1YFwH0rZeh4M1+WyEsRCnBc3HGILazHINwVUmJgkVVe/sICsaVv
         X84EYSxtjVjm+Z4xDnNer0FszHQtOXRIbal/4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=BRRTxpXVlFPrgvDrRRt8yZA9xrfG5+1Ox1mwArbMMmTvW3Jx0w688Uf3hFAw+Iw9el
         9Nx4ca/cAVees6eBTUWqdFRBo6zXchoWShtXk8RKJFIGtIbs/AEHaVdNUuMlV2S2XPSH
         bIS5xyraV43QYXWs1xCxpmOOhaBj0l3nF3KRw=
Received: by 10.150.44.27 with SMTP id r27mr11203216ybr.263.1258280318872;
        Sun, 15 Nov 2009 02:18:38 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 16sm1626793gxk.15.2009.11.15.02.18.36
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 15 Nov 2009 02:18:38 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vd43krwd0.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132928>

On my slow laptop (P3 600MHz), system-wide bash completions take
too much time to load (> 2s), and a significant fraction of this
time is spent loading git-completion.bash:

$ time bash -c ". ./git-completion.bash"  # hot cache, before this patc=
h

real    0m0.509s
user    0m0.310s
sys     0m0.180s

Kirill noticed that most of the time is spent warming up the
merge_strategy, all_command and porcelain_command caches.

Since git is not used in each and every interactive xterm, it
seems best to load completion support with cold caches and then
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
Cc: SZEDER G=E1bor <szeder@ira.uka.de>
Cc: Sverre Rabbelier <srabbelier@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
This version incorporates the small improvements previously sent, plus =
the
following nice one (which makes caching merge strategies safe again).
Thanks for the advice, everyone.

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:
>=20
> >  __git_compute_merge_strategies ()
> >  {
> > -	: ${__git_merge_strategies=3D$(__git_list_merge_strategies)}
> > +	__git_merge_strategies=3D$(__git_list_merge_strategies)
>=20
> Wouldn't
>=20
> 	: ${__gms:=3D$(command)}
>=20
> run command only until it gives a non-empty string?

Yes. :)

 contrib/completion/git-completion.bash |   76 +++++++++++++++++-------=
--------
 1 files changed, 41 insertions(+), 35 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index e3ddecc..43d76b7 100755
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
+unset __git_merge_strategies
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
+unset __git_all_commands
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
@@ -595,8 +592,13 @@ __git_porcelain_commands ()
 		esac
 	done
 }
-__git_porcelain_commandlist=3D
-__git_porcelain_commandlist=3D"$(__git_porcelain_commands 2>/dev/null)=
"
+
+unset __git_porcelain_commands
+__git_compute_porcelain_commands ()
+{
+	__git_compute_all_commands
+	: ${__git_porcelain_commands=3D$(__git_list_porcelain_commands)}
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
