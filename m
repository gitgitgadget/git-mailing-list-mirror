From: "Marcel M. Cary" <marcel@oak.homeunix.org>
Subject: [RFC PATCH] git-sh-setup: Use "cd" option, not /bin/pwd, for symlinked work tree
Date: Fri,  6 Feb 2009 19:24:28 -0800
Message-ID: <1233977068-24861-1-git-send-email-marcel@oak.homeunix.org>
References: <7viqq1hghw.fsf@gitster.siamese.dyndns.org>
Cc: gitster@pobox.com, jnareb@gmail.com, ae@op5.se,
	j.sixt@viscovery.net, git-dev@marzelpan.de, win@wincent.com,
	benji@silverinsanity.com,
	"Marcel M. Cary" <marcel@oak.homeunix.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 07 04:26:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVdpW-0000v1-3y
	for gcvg-git-2@gmane.org; Sat, 07 Feb 2009 04:26:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753299AbZBGDYj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Feb 2009 22:24:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752917AbZBGDYi
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Feb 2009 22:24:38 -0500
Received: from smtp115.sbc.mail.sp1.yahoo.com ([69.147.64.88]:45294 "HELO
	smtp115.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752523AbZBGDYh (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Feb 2009 22:24:37 -0500
Received: (qmail 96017 invoked from network); 7 Feb 2009 03:24:36 -0000
Received: from unknown (HELO ordinateur.home.org) (marcel@75.61.103.6 with plain)
  by smtp115.sbc.mail.sp1.yahoo.com with SMTP; 7 Feb 2009 03:24:32 -0000
X-YMail-OSG: v8.S6xUVM1myBEzNH4a.W9t.p4n2zNhuWjnmfJUQi0rY7T9GpqGw2nOOHFH95t6M1oOjuzmRXjR6zlUKBTv2co5HcYt2K47QzimdYYXqAwyX6rTg5imQlyLpRq4QVmwteyfblz8pgEiuOJnxMelx2d.q
X-Yahoo-Newman-Property: ymail-3
Received: from polliwog.home.org ([192.168.0.18] helo=localhost.localdomain)
	by ordinateur.home.org with esmtp (Exim 4.63)
	(envelope-from <marcel@oak.homeunix.org>)
	id 1LVdnw-00011D-C0; Fri, 06 Feb 2009 19:24:28 -0800
X-Mailer: git-send-email 1.6.1
In-Reply-To: <7viqq1hghw.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108808>

In cd_to_toplevel, instead of 'cd $(unset PWD; /bin/pwd)/$path'
use 'cd -P $path'.  The "-P" option yields a desirable similarity to
C chdir.

While the "-P" option may be slightly less commonly supported than
/bin/pwd, it is more concise, better tested, and less error prone.
I've already added the 'unset PWD' to fix the /bin/pwd solution on
BSD; there may be more edge cases out there.

This still passes all the same test cases in t5521-pull-symlink.sh and
t2300-cd-to-toplevel.sh, even before updating them to use 'pwd -P'.
---

> ... I think it would probably be better to bite the bullet
> and start using "cd -P" soon after 1.6.1 goes final, ...

Here's a post-1.6.1 way to make Git shell scripts work like C programs
when in symlinked directories.

> ... and at the same time
> existing places that use "cd `pwd`" as a workaround if there are some.

I haven't found other places that use the "cd `/bin/pwd`" workaround.

I also wasn't able to think of a test case that fails under the previous
way and works under this new way either.

Any opinions on whether this is worthwhile?  It seems more standardized
if less supported, odd as that seems to me.

Marcel

 git-sh-setup.sh           |   29 ++++++++---------------------
 t/t2300-cd-to-toplevel.sh |    4 ++--
 2 files changed, 10 insertions(+), 23 deletions(-)

diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index 2142308..8382339 100755
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -85,27 +85,14 @@ cd_to_toplevel () {
 	cdup=$(git rev-parse --show-cdup)
 	if test ! -z "$cdup"
 	then
-		case "$cdup" in
-		/*)
-			# Not quite the same as if we did "cd -P '$cdup'" when
-			# $cdup contains ".." after symlink path components.
-			# Don't fix that case at least until Git switches to
-			# "cd -P" across the board.
-			phys="$cdup"
-			;;
-		..|../*|*/..|*/../*)
-			# Interpret $cdup relative to the physical, not logical, cwd.
-			# Probably /bin/pwd is more portable than passing -P to cd or pwd.
-			phys="$(unset PWD; /bin/pwd)/$cdup"
-			;;
-		*)
-			# There's no "..", so no need to make things absolute.
-			phys="$cdup"
-			;;
-		esac
-
-		cd "$phys" || {
-			echo >&2 "Cannot chdir to $phys, the toplevel of the working tree"
+		# The "-P" option says to follow "physical" directory
+		# structure instead of following symbolic links.  When cdup is
+		# "../", this means following the ".." entry in the current
+		# directory instead textually removing a symlink path element
+		# from the PWD shell variable.  The "-P" behavior is more
+		# consistent with the C-style chdir used by most of Git.
+		cd -P "$cdup" || {
+			echo >&2 "Cannot chdir to $cdup, the toplevel of the working tree"
 			exit 1
 		}
 	fi
diff --git a/t/t2300-cd-to-toplevel.sh b/t/t2300-cd-to-toplevel.sh
index e42cbfe..293dc35 100755
--- a/t/t2300-cd-to-toplevel.sh
+++ b/t/t2300-cd-to-toplevel.sh
@@ -10,12 +10,12 @@ test_cd_to_toplevel () {
 			cd '"'$1'"' &&
 			. git-sh-setup &&
 			cd_to_toplevel &&
-			[ "$(unset PWD; /bin/pwd)" = "$TOPLEVEL" ]
+			[ "$(pwd -P)" = "$TOPLEVEL" ]
 		)
 	'
 }
 
-TOPLEVEL="$(unset PWD; /bin/pwd)/repo"
+TOPLEVEL="$(pwd -P)/repo"
 mkdir -p repo/sub/dir
 mv .git repo/
 SUBDIRECTORY_OK=1
-- 
1.6.1
