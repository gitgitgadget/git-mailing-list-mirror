From: Junio C Hamano <junkio@cox.net>
Subject: Re: confusion over the new branch and merge config
Date: Fri, 22 Dec 2006 15:39:33 -0800
Message-ID: <7vpsabv6tm.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0612211555210.18171@xanadu.home>
	<7vd56cam66.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0612221539100.18171@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 23 00:39:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxtzG-0003YW-Bm
	for gcvg-git@gmane.org; Sat, 23 Dec 2006 00:39:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753262AbWLVXjf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Dec 2006 18:39:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753249AbWLVXjf
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Dec 2006 18:39:35 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:55306 "EHLO
	fed1rmmtao09.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753262AbWLVXjf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Dec 2006 18:39:35 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20061222233934.NWLE18767.fed1rmmtao09.cox.net@fed1rmimpo01.cox.net>;
          Fri, 22 Dec 2006 18:39:34 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 1zer1W00R1kojtg0000000; Fri, 22 Dec 2006 18:38:52 -0500
To: Nicolas Pitre <nico@cam.org>
In-Reply-To: <Pine.LNX.4.64.0612221539100.18171@xanadu.home> (Nicolas Pitre's
	message of "Fri, 22 Dec 2006 15:49:46 -0500 (EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35246>

Nicolas Pitre <nico@cam.org> writes:

> On Thu, 21 Dec 2006, Junio C Hamano wrote:
>
>> Nicolas Pitre <nico@cam.org> writes:
>> 
>> > $ git pull origin/next
>> > fatal: The remote end hung up unexpectedly
>> > Cannot get the repository state from git://git.kernel.org/pub/scm/git/git.git/next
>> >
>> > [ WTF?  Where that ...pub/scm/git/git.git/next comes from?  Hmmm... ]
>> 
>> This comes from ancient request by Linus to allow:
>> 
>> 	$ cat .git/remotes/jgarzik
>> 	URL: master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/
>> 	$ git pull jgarzik/misc-2.6
>> 
>> See http://article.gmane.org/gmane.comp.version-control.git/6181
>> for the full text.
>> 
>> Personally I thought this was confusing when I implemented it
>> the first time, and I still find it confusing.
>> 
>> I suspect nobody uses it.  I am all for removing this "URL
>> prefix shorthand" feature in v1.5.0.
>
> Please do.  I'm sure Linus can find a better way now.

Well, "request" was very inprecise word -- I should have said
"suggestion".  But I think I agree.

Seconds?  Thirds?

-- >8 --
[PATCH] Do not support "partial URL shorthand" anymore.

We used to support specifying the top part of remote URL in
remotes and use that as a short-hand for the URL.

	$ cat .git/remotes/jgarzik
	URL: git://git.kernel.org/pub/scm/linux/kernel/git/jgarzik/
	$ git pull jgarzik/misc-2.6

This is confusing when somebody attempts to do this:

	$ git pull origin/foo

which is not syntactically correct (unless you have origin/foo.git
repository) and should fail, but it resulted in a mysterious
access to the 'foo' subdirectory of the origin repository.

Which was what it was designed to do, but because this is an
oddball "feature" I suspect nobody uses, let's remove it.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 git-parse-remote.sh |   34 +++++++---------------------------
 1 files changed, 7 insertions(+), 27 deletions(-)

diff --git a/git-parse-remote.sh b/git-parse-remote.sh
index b163d22..aaef861 100755
--- a/git-parse-remote.sh
+++ b/git-parse-remote.sh
@@ -7,18 +7,7 @@ GIT_DIR=$(git-rev-parse --git-dir 2>/dev/null) || :;
 get_data_source () {
 	case "$1" in
 	*/*)
-		# Not so fast.	This could be the partial URL shorthand...
-		token=$(expr "z$1" : 'z\([^/]*\)/')
-		remainder=$(expr "z$1" : 'z[^/]*/\(.*\)')
-		if test "$(git-repo-config --get "remote.$token.url")"
-		then
-			echo config-partial
-		elif test -f "$GIT_DIR/branches/$token"
-		then
-			echo branches-partial
-		else
-			echo ''
-		fi
+		echo ''
 		;;
 	*)
 		if test "$(git-repo-config --get "remote.$1.url")"
@@ -40,12 +29,7 @@ get_remote_url () {
 	data_source=$(get_data_source "$1")
 	case "$data_source" in
 	'')
-		echo "$1" ;;
-	config-partial)
-		token=$(expr "z$1" : 'z\([^/]*\)/')
-		remainder=$(expr "z$1" : 'z[^/]*/\(.*\)')
-		url=$(git-repo-config --get "remote.$token.url")
-		echo "$url/$remainder"
+		echo "$1"
 		;;
 	config)
 		git-repo-config --get "remote.$1.url"
@@ -54,14 +38,10 @@ get_remote_url () {
 		sed -ne '/^URL: */{
 			s///p
 			q
-		}' "$GIT_DIR/remotes/$1" ;;
+		}' "$GIT_DIR/remotes/$1"
+		;;
 	branches)
-		sed -e 's/#.*//' "$GIT_DIR/branches/$1" ;;
-	branches-partial)
-		token=$(expr "z$1" : 'z\([^/]*\)/')
-		remainder=$(expr "z$1" : 'z[^/]*/\(.*\)')
-		url=$(sed -e 's/#.*//' "$GIT_DIR/branches/$token")
-		echo "$url/$remainder"
+		sed -e 's/#.*//' "$GIT_DIR/branches/$1"
 		;;
 	*)
 		die "internal error: get-remote-url $1" ;;
@@ -77,7 +57,7 @@ get_default_remote () {
 get_remote_default_refs_for_push () {
 	data_source=$(get_data_source "$1")
 	case "$data_source" in
-	'' | config-partial | branches | branches-partial)
+	'' | branches)
 		;; # no default push mapping, just send matching refs.
 	config)
 		git-repo-config --get-all "remote.$1.push" ;;
@@ -196,7 +176,7 @@ canon_refs_list_for_fetch () {
 get_remote_default_refs_for_fetch () {
 	data_source=$(get_data_source "$1")
 	case "$data_source" in
-	'' | config-partial | branches-partial)
+	'')
 		echo "HEAD:" ;;
 	config)
 		canon_refs_list_for_fetch -d "$1" \
-- 
1.4.4.3.ge228b
