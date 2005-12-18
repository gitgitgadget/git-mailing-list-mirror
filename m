From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] git-grep: convert from bash to sh
Date: Sun, 18 Dec 2005 15:56:21 +0100
Message-ID: <20051218145621.GX22159@pasky.or.cz>
References: <20051218152639.5c14bc26.tihirvon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 18 15:57:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Enzxw-0005td-Jg
	for gcvg-git@gmane.org; Sun, 18 Dec 2005 15:56:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965110AbVLRO4X (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Dec 2005 09:56:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965114AbVLRO4X
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Dec 2005 09:56:23 -0500
Received: from w241.dkm.cz ([62.24.88.241]:10949 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S965110AbVLRO4X (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Dec 2005 09:56:23 -0500
Received: (qmail 22154 invoked by uid 2001); 18 Dec 2005 15:56:21 +0100
To: Timo Hirvonen <tihirvon@gmail.com>
Content-Disposition: inline
In-Reply-To: <20051218152639.5c14bc26.tihirvon@gmail.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13795>

Dear diary, on Sun, Dec 18, 2005 at 02:26:39PM CET, I got a letter
where Timo Hirvonen <tihirvon@gmail.com> said that...
> sh does not support arrays so we have to use eval instead.
> 
> Signed-off-by: Timo Hirvonen <tihirvon@gmail.com>

This version also makes it work properly with patterns containing quotes
and backslashes (not so unusual when you grep for C strings).

Signed-off-by: Petr Baudis <pasky@suse.cz>

---

I'm kind of sensitive to this stuff. I still passionately hate scp
making me to double-quote remote filenames. It's just evil.

diff --git a/git-grep.sh b/git-grep.sh
index 2ed8e95..7e9e5bf 100755
--- a/git-grep.sh
+++ b/git-grep.sh
@@ -8,21 +8,21 @@ SUBDIRECTORY_OK='Yes'
 . git-sh-setup
 
 pattern=
-flags=()
-git_flags=()
+flags=
+git_flags=
 while : ; do
 	case "$1" in
 	--cached|--deleted|--others|--killed|\
 	--ignored|--exclude=*|\
 	--exclude-from=*|\--exclude-per-directory=*)
-		git_flags=("${git_flags[@]}" "$1")
+		git_flags="$git_flags '$1'"
 		;;
 	-e)
 		pattern="$2"
 		shift
 		;;
 	-A|-B|-C|-D|-d|-f|-m)
-		flags=("${flags[@]}" "$1" "$2")
+		flags="$flags '$1' '$2'"
 		shift
 		;;
 	--)
@@ -31,7 +31,7 @@ while : ; do
 		break
 		;;
 	-*)
-		flags=("${flags[@]}" "$1")
+		flags="$flags '$1'"
 		;;
 	*)
 		if [ -z "$pattern" ]; then
@@ -46,5 +46,6 @@ done
 [ "$pattern" ] || {
 	usage
 }
-git-ls-files -z "${git_flags[@]}" "$@" |
-	xargs -0 grep "${flags[@]}" -e "$pattern"
+pattern="$(echo "$pattern" | sed 's/[\\"]/\\&/g')"
+eval git-ls-files -z "$git_flags" '"$@"' |
+	eval xargs -0 grep "$flags" -e '"$pattern"'

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
