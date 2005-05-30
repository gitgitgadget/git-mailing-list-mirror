From: Jonas Fonseca <fonseca@diku.dk>
Subject: Re: [PATCH] cg-pull: summarize the number of pulled objects
Date: Mon, 30 May 2005 17:18:17 +0200
Message-ID: <20050530151817.GB28681@diku.dk>
References: <20050530015650.GB10715@diku.dk> <20050530082054.GB1036@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 30 17:17:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dclzt-0004nf-3u
	for gcvg-git@gmane.org; Mon, 30 May 2005 17:16:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261255AbVE3PSg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 May 2005 11:18:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261367AbVE3PSg
	(ORCPT <rfc822;git-outgoing>); Mon, 30 May 2005 11:18:36 -0400
Received: from nhugin.diku.dk ([130.225.96.140]:35070 "EHLO nhugin.diku.dk")
	by vger.kernel.org with ESMTP id S261255AbVE3PSU (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 May 2005 11:18:20 -0400
Received: by nhugin.diku.dk (Postfix, from userid 754)
	id 77B0F6E2725; Mon, 30 May 2005 17:17:46 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 24EBB6E270D; Mon, 30 May 2005 17:17:46 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id A469561FE0; Mon, 30 May 2005 17:18:18 +0200 (CEST)
To: Petr Baudis <pasky@ucw.cz>
Content-Disposition: inline
In-Reply-To: <20050530082054.GB1036@pasky.ji.cz>
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, hits=-4.9 required=5.0 tests=BAYES_00 autolearn=ham 
	version=2.60
X-Spam-Checker-Version: SpamAssassin 2.60 (1.212-2003-09-23-exp) on 
	nhugin.diku.dk
X-Spam-Level: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Petr Baudis <pasky@ucw.cz> wrote Mon, May 30, 2005:
> Dear diary, on Mon, May 30, 2005 at 03:56:50AM CEST, I got a letter
> where Jonas Fonseca <fonseca@diku.dk> told me that...
> > Show cg-pull progress by summarizing the very verbose output of the pull
> > backends into a continously updated line specifying the number of
> > objects which have already been pulled.
> > 		     
> > Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
> > ---
> > 
> > Straight from the bloat department, perhaps, but it is nice to not have
> > the terminal backlog ruined and the object count is quite nice too. :)
> > 
> > Interesting, it counts 4950 objects when pulling over rsync and 4454
> > objects when pulling locally. Didn't test HTTP pulling other than to see
> > if the "got <sha>" lines was matched correctly.
> 
> It is nice, but actually losing information for me. It's ok for the HTTP
> and SSH "smart pulls", but if I pull over rsync, I have progress
> indication based on the first two digits - assuming roughly even
> distribution of hashes, I can see that when I cross 80/ I'm in the half
> etc. So what about showing some percentage or something in that case?

[ Ok, I've done the percentage thing. The number of bytes are also
  tracked. I also tried to return the correct exit code from the pull
  function using PIPESTATUS. ]

[PATCH] cg-pull: summarize the number of pulled objects

Show object pulling progress by summarizing the verbose output of the
pull backends into a single continously updated status line. It displays
the number of already pulled objects, the total size of the pulled
objects and for rsync the percentage done based on what object
sub-directory objects are coming from. The last thing means it might not
always get all the way up to 100%.

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>

---

 cg-pull |   55 +++++++++++++++++++++++++++++++++++++++++++++++++++----
 1 files changed, 51 insertions(+), 4 deletions(-)

diff --git a/cg-pull b/cg-pull
--- a/cg-pull
+++ b/cg-pull
@@ -29,6 +29,49 @@ if echo "$uri" | grep -q '#'; then
 	uri=$(echo $uri | cut -d '#' -f 1)
 fi
 
+pull_progress() {
+	percentage=""
+	objects=0
+	last_objects=0
+	size=0
+
+	while read line; do
+		object=
+
+		case "$line" in
+		link*|symlink*|\
+		"got "[a-f0-9][a-f0-9][a-f0-9][a-f0-9][a-f0-9][a-f0-9]*)
+			# Convert the sha to an object path
+			object=$(echo "$line" | sed 's,.* \([a-f0-9][a-f0-9]\),\1/,')
+			;;
+
+		[a-f0-9][a-f0-9]/[a-f0-9][a-f0-9][a-f0-9][a-f0-9][a-f0-9]*)
+			object="$line"
+			# Estimate percentage done using the position of
+			# the object subdir. It might not get all the way
+			# up to 100% ...
+			position=$(echo "$line" | cut -d/ -f 1)
+			percentage=", $((0x$position * 100 / 0xff))% done"
+			;;
+
+		*)
+			if [ "$last_objects" != "$objects" ]; then
+				last_objects="$objects"
+				echo;
+			fi
+			echo "$line"
+			continue
+			;;
+		esac 
+
+		object="$_git_objects/$object"
+		size=$(($size + $(stat -c '%s' "$object" 2>/dev/null)))
+		objects=$(($objects + 1));
+
+		echo -ne "progress: $objects objects, $size bytes$percentage\r"
+	done;
+	[ "$last_objects" != "$objects" ] && echo
+}
 
 fetch_rsync () {
 	redir=
@@ -62,7 +105,8 @@ fetch_rsync () {
 }
 
 pull_rsync () {
-	fetch_rsync -s -u -d "$2/objects" "$_git_objects"
+	fetch_rsync -s -u -d "$2/objects" "$_git_objects" | pull_progress
+	return ${PIPESTATUS[0]}
 }
 
 
@@ -107,7 +151,8 @@ fetch_http () {
 }
 
 pull_http () {
-	git-http-pull -a -v "$(cat "$_git/refs/heads/$1")" "$2/"
+	(git-http-pull -a -v "$(cat "$_git/refs/heads/$1")" "$2/" 2>&1 /dev/null) | pull_progress
+	return ${PIPESTATUS[0]}
 }
 
 
@@ -142,7 +187,8 @@ fetch_ssh () {
 }
 
 pull_ssh () {
-	git-rpull -a -v "$(cat "$_git/refs/heads/$1")" "$2"
+	(git-rpull -a -v "$(cat "$_git/refs/heads/$1")" "$2" 2>&1 /dev/null) | pull_progress
+	return ${PIPESTATUS[0]}
 }
 
 
@@ -170,7 +216,8 @@ fetch_local () {
 }
 
 pull_local () {
-	git-local-pull -a -l -v "$(cat "$_git/refs/heads/$1")" "$2"
+	(git-local-pull -a -l -v "$(cat "$_git/refs/heads/$1")" "$2" 2>&1 /dev/null) | pull_progress
+	return ${PIPESTATUS[0]}
 }
 
 if echo "$uri" | grep -q "^http://"; then
-- 
Jonas Fonseca
