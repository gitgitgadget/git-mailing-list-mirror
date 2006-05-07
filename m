From: Pavel Roskin <proski@gnu.org>
Subject: Implementing branch attributes in git config
Date: Sun, 07 May 2006 17:34:19 -0400
Message-ID: <1147037659.25090.25.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sun May 07 23:34:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fcqtc-00047G-Hp
	for gcvg-git@gmane.org; Sun, 07 May 2006 23:34:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932230AbWEGVeW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 May 2006 17:34:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932235AbWEGVeW
	(ORCPT <rfc822;git-outgoing>); Sun, 7 May 2006 17:34:22 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:54422 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S932230AbWEGVeW
	(ORCPT <rfc822;git@vger.kernel.org>); Sun, 7 May 2006 17:34:22 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1FcqtR-0003r1-4i
	for git@vger.kernel.org; Sun, 07 May 2006 17:34:21 -0400
Received: from proski by dv.roinet.com with local (Exim 4.62)
	(envelope-from <proski@dv.roinet.com>)
	id 1FcqtP-0007F0-TM
	for git@vger.kernel.org; Sun, 07 May 2006 17:34:19 -0400
To: git <git@vger.kernel.org>
X-Mailer: Evolution 2.6.1 (2.6.1-3) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19719>

Hello!

I have tried to implement branch attributes (more specifically, the
default for git-fetch) in git config.  It turns out that the format of
the config file is to rigid.

Minuses, underscores, colons and dots are not allowed in the section
headers and keys.  I can understand that dots should be allowed either
in the section names or in the key names, but other limitations seem
totally unnecessary.

I think a good implementation should allow any characters in the keys,
even "=", because the key can be quoted.  Section names may disallow
square brackets and dots.

Such limitations make it unpractical to use branch names in section or
key names.  I'd like to have it fixed.

The only remaining place is values.  This means that there should be
multiple entries for the same key.  While this is allowed, it seems
quite fragile and inconvenient.

In particular, git-repo-config leaves the config file locked in the
regex is wrong:

$ git-repo-config branch.fetch "master:origin" +
Invalid pattern: +
$ git-repo-config branch.fetch "master:origin" +
could not lock config file

To fix it, just add "close(fd); unlink(lock_file);" after "Invalid
pattern" in config.c.

I don't quite understand what pattern is needed to add an entry.  "foo"
seems to work fine, I don't know why.

That problem with multiple values is that they are quite fragile and
require special options to access them.  Since regex is used, dots in
the branch names need to be escaped.  Probably more escapes are needed.

Anyway, here's the preliminary patch that implements default fetch
branches.  Unfortunately, it doesn't even come close to the goal of
having per-branch attributes due to the config file limitations.

To add an entry, use

git-repo-config branch.fetch "localbranch:remotebranch" foo


Read the default fetch branch from the config file

From: Pavel Roskin <proski@gnu.org>


---

 git-fetch.sh |   21 +++++++++++++++++----
 1 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/git-fetch.sh b/git-fetch.sh
index 280f62e..a5ea92b 100755
--- a/git-fetch.sh
+++ b/git-fetch.sh
@@ -61,12 +61,25 @@ do
 	shift
 done
 
+get_config_rem_branch() {
+	fetch_branch=origin
+	cur_branch=$(expr $(git-symbolic-ref HEAD) : 'refs/heads/\(.*\)')
+	test -z "$cur_branch" && return
+	cur_branch_esc=$(echo $cur_branch | sed 's/\./\\./')
+	branch_map=$(git-repo-config --get branch.fetch "^$cur_branch_esc:")
+	test -z "$branch_map" && return
+	rem_branch=$(expr "$branch_map" : "$cur_branch_esc:\(.*\)")
+	test -z "$rem_branch" && return
+	fetch_branch="$rem_branch"
+}
+
 case "$#" in
 0)
-	test -f "$GIT_DIR/branches/origin" ||
-		test -f "$GIT_DIR/remotes/origin" ||
-			die "Where do you want to fetch from today?"
-	set origin ;;
+	get_config_rem_branch
+	test -f "$GIT_DIR/branches/$fetch_branch" ||
+		test -f "$GIT_DIR/remotes/$fetch_branch" ||
+			die "No remote branch \"$fetch_branch\""
+	set "$fetch_branch" ;;
 esac
 
 remote_nick="$1"


-- 
Regards,
Pavel Roskin
