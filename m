From: Andreas Ericsson <ae@op5.se>
Subject: [PATCH] update-hook: Major overhaul (handling tags, mainly).
Date: Wed, 4 Jan 2006 16:17:59 +0000 (UTC)
Message-ID: <20060104161729.7FD9C5BE85@nox.op5.se>
X-From: git-owner@vger.kernel.org Wed Jan 04 17:17:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EuBKf-0002Tu-C7
	for gcvg-git@gmane.org; Wed, 04 Jan 2006 17:17:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932204AbWADQRb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Jan 2006 11:17:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932213AbWADQRb
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jan 2006 11:17:31 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:59618 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S932204AbWADQRa
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 4 Jan 2006 11:17:30 -0500
Received: from nox.op5.se (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP id AE79D6BCBE
	for <git@vger.kernel.org>; Wed,  4 Jan 2006 17:17:29 +0100 (CET)
Received: by nox.op5.se (Postfix, from userid 500)
	id 7FD9C5BE85; Wed,  4 Jan 2006 17:17:29 +0100 (CET)
Date: 1136391359 +0100
To: undisclosed-recipients:;
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14177>

This is the update hook we use in all our git-repos.

It has some improvements over the original version, namely:
* Don't send every commit since dawn of time when adding a new tag.
* When updating an annotated tag, just send the diffs since the last tag.
* Add diffstat output for 'normal' commits (top) and annotated tags (bottom).
* Block un-annotated tags in shared repos.

I'm a bit uncertain about that last one, but it demonstrates how to
disallow updates of a ref which we use, so I kept it.

Note that git-describe is needed for the "changes since last annotated tag"
thing to work.

Signed-off-by: Andreas Ericsson <ae@op5.se>

---

 templates/hooks--update |   71 +++++++++++++++++++++++++++++++++++++++++++----
 1 files changed, 65 insertions(+), 6 deletions(-)

f10cd7de04bb84f381cc7a3d65ede0233900de44
diff --git a/templates/hooks--update b/templates/hooks--update
index 6db555f..27cea17 100644
--- a/templates/hooks--update
+++ b/templates/hooks--update
@@ -1,6 +1,7 @@
 #!/bin/sh
 #
 # An example hook script to mail out commit update information.
+# It also blocks tags that aren't annotated.
 # Called by git-receive-pack with arguments: refname sha1-old sha1-new
 #
 # To enable this hook:
@@ -8,16 +9,74 @@
 # (2) make this file executable by "chmod +x update".
 #
 
-recipient="commit-list@example.com"
+project=$(cat $GIT_DIR/description)
+recipients="commit-list@somewhere.com commit-list@somewhereelse.com"
 
-if expr "$2" : '0*$' >/dev/null
+ref_type=$(git cat-file -t "$3")
+
+# Only allow annotated tags in a shared repo
+# Remove this code to treat dumb tags the same as everything else
+case "$1","$ref_type" in
+refs/tags/*,commit)
+	echo "*** Un-annotated tags are not allowed in this repo" >&2
+	echo "*** Use 'git tag [ -a | -s ]' for tags you want to propagate."
+	exit 1;;
+refs/tags/*,tag)
+	echo "### Pushing version '${1##refs/tags/}' to the masses" >&2
+	# recipients="release-announce@somwehere.com announce@somewhereelse.com"
+	;;
+esac
+
+# set this  to 'cat' to get a very detailed listing.
+# short only kicks in when an annotated tag is added
+short='git shortlog'
+
+# see 'date --help' for info on how to write this
+# The default is a human-readable iso8601-like format with minute
+# precision ('2006-01-25 15:58 +0100' for example)
+date_format="%F %R %z"
+
+(if expr "$2" : '0*$' >/dev/null
 then
-	echo "Created a new ref, with the following commits:"
-	git-rev-list --pretty "$3"
+	# new ref
+	case "$1" in
+	refs/tags/*)
+		# a pushed and annotated tag (usually) means a new version
+		tag="${1##refs/tags/}"
+		if [ "$ref_type" = tag ]; then
+			eval $(git cat-file tag $3 | \
+				sed -n '4s/tagger \([^>]*>\)[^0-9]*\([0-9]*\).*/tagger="\1" ts="\2"/p')
+			date=$(date --date="1970-01-01 00:00:00 $ts seconds" +"$date_format")
+			echo "Tag '$tag' created by $tagger at $date"
+			git cat-file tag $3 | sed -n '5,$p'
+			echo
+		fi
+		prev=$(git describe "$3^" | sed 's/-g.*//')
+		# the first tag in a repo will yield no $prev
+		if [ -z "$prev" ]; then
+			echo "Changes since the dawn of time:"
+			git rev-list --pretty $3 | $short
+		else
+			echo "Changes since $prev:"
+			git rev-list --pretty $prev..$3 | $short
+			echo ---
+			git diff $prev..$3 | diffstat -p1
+			echo ---
+		fi
+		;;
+
+	refs/heads/*)
+		branch="${1##refs/heads/}"
+		echo "New branch '$branch' available with the following commits:"
+		git-rev-list --pretty "$3"
+		;;
+	esac
 else
 	base=$(git-merge-base "$2" "$3")
 	case "$base" in
 	"$2")
+		git diff "$3" "^$base" | diffstat -p1
+		echo
 		echo "New commits:"
 		;;
 	*)
@@ -25,6 +84,6 @@ else
 		;;
 	esac
 	git-rev-list --pretty "$3" "^$base"
-fi |
-mail -s "Changes to ref $1" "$recipient"
+fi) |
+mail -s "$project: Changes to '${1##refs/heads/}'" $recipients
 exit 0
-- 
1.0.6-g58e3
