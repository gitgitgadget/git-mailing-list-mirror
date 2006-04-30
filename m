From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git builtin "push"
Date: Sun, 30 Apr 2006 14:47:48 -0700
Message-ID: <7vslnuybuj.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0604292111570.9901@g5.osdl.org>
	<445516F5.1090204@garzik.org>
	<Pine.LNX.4.64.0604301303010.5231@g5.osdl.org>
	<BAYC1-PASMTP037751CEC096DA29400513AEB00@CEZ.ICE>
	<Pine.LNX.4.64.0604301405070.2922@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 30 23:48:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FaJm1-0006Fz-1p
	for gcvg-git@gmane.org; Sun, 30 Apr 2006 23:48:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751225AbWD3Vrv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 30 Apr 2006 17:47:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751224AbWD3Vrv
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Apr 2006 17:47:51 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:20954 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1751225AbWD3Vru (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Apr 2006 17:47:50 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060430214749.PYUZ25666.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 30 Apr 2006 17:47:49 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0604301405070.2922@g5.osdl.org> (Linus Torvalds's
	message of "Sun, 30 Apr 2006 14:05:33 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19358>

Linus Torvalds <torvalds@osdl.org> writes:

>> True, as long as you don't have any Push: lines in your .git/remotes/repo
>> file.  Any such lines act just like you gave them on the command line
>> which afaik effectively removes the ability to say "update all branches
>> we have in common".
>
> Ok, so my built-in version "fixes" that "feature". 
>
> 		Linus

Alternatively/additionally you could do something like the
attached patch.  However,...

I suspect that destination repositories that you would want to
define Push: and the ones you do not want to have any Push: are
of different nature and you would not mix them.  When you do
want to have any Push: line for a repository, you would _never_
want to use the "matching refs" semantics for that repository.
So in that sense, the "fix" is not necessary, and fixing it
would probably lead to more confusion.

The Push: lines can do two related but independent things:

 - limit the set of refs that are published (hide the uncooked topics)
 - remap the source and destination refs (e.g. push master to origin)

The first can be done by not having Push: at all and by solely
relying on "matching refs" semantics.  Then usually you can just
keep doing "git push <destination>" until you have something new
to add, at that point you say "git push <destination>
<newbranch>" just once, and after that keep doing the "matching
refs" push.  You are having the remote repository remember what
the set of refs you would want there, instead of listing them on
the local "Push:" lines.  All should work well that way.

I use Push: lines to push into my private, non-bare, repository
at kernel.org machines for the second reason.  I have:

	Push: heads/master:heads/origin
        Push: heads/next:heads/next
        Push: +heads/pu:heads/pu
        Push: heads/maint:heads/maint

and leave the "master" branch checked out over there.  After
pushing, I log-in, and start my work by "git pull . origin".

The "matching refs" feature actively does a wrong thing to
remote repositories managed this way.

-- >8 --
[PATCH] git push --common <repo>

If you usually push only specific branches, it is handy to have
Push: lines only for those branches in your remotes/<repo> file.
But with that, you cannot access the underlying git-send-pack's
ability to push "only matching refs".  The flag --common can be
given to ignore Push: lines and push only matching refs.

---
diff --git a/git-push.sh b/git-push.sh
index f10cadb..381b76f 100755
--- a/git-push.sh
+++ b/git-push.sh
@@ -11,6 +11,7 @@ has_exec=
 has_thin=--thin
 remote=
 do_tags=
+do_common=
 
 while case "$#" in 0) break ;; esac
 do
@@ -19,6 +20,8 @@ do
 		has_all=--all ;;
 	--tags)
 		do_tags=yes ;;
+	--common)
+		do_common=yes ;;
 	--force)
 		has_force=--force ;;
 	--exec=*)
@@ -45,10 +48,21 @@ esac
 . git-parse-remote
 remote=$(get_remote_url "$@")
 
-case "$has_all" in
---all)
+case "$has_all,$do_common" in
+--all,yes)
+	die "Both --common and --all given." ;;
+--all,)
 	set x ;;
-'')
+,yes)
+	case "$do_tags,$#" in
+	,1)
+		set x ;;
+	yes,*)
+		die "Both --common and --tags given." ;;
+	*)
+		die "Both --common and an explicit refspec given." ;;
+	esac ;;
+,)
 	case "$do_tags,$#" in
 	yes,1)
 		set x $(cd "$GIT_DIR/refs" && find tags -type f -print) ;;
