From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH 0/4] Fetching mass of objects at once
Date: Thu, 27 Jul 2006 23:57:05 +0200
Message-ID: <20060727215705.GF13776@pasky.or.cz>
References: <20060727215326.24240.20118.stgit@machine>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: jonsmirl@gmail.com
X-From: git-owner@vger.kernel.org Thu Jul 27 23:57:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G6Dqy-0006wx-TQ
	for gcvg-git@gmane.org; Thu, 27 Jul 2006 23:57:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751337AbWG0V5J (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 27 Jul 2006 17:57:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751348AbWG0V5J
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Jul 2006 17:57:09 -0400
Received: from w241.dkm.cz ([62.24.88.241]:31694 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751337AbWG0V5I (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Jul 2006 17:57:08 -0400
Received: (qmail 25042 invoked by uid 2001); 27 Jul 2006 23:57:05 +0200
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20060727215326.24240.20118.stgit@machine>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24355>

Dear diary, on Thu, Jul 27, 2006 at 11:53:26PM CEST, I got a letter
where Petr Baudis <pasky@suse.cz> said that...
>   I will followup with a patch for Cogito to take advantage of this. It's
> now roughly on par with Git in cloning speed.

diff --git a/cg-Xfetchprogress b/cg-Xfetchprogress
index 53bcbd3..4a272db 100755
--- a/cg-Xfetchprogress
+++ b/cg-Xfetchprogress
@@ -67,7 +67,7 @@ sub getline {
 	if (m#^(link|symlink|copy|got) ([a-f0-9]{2})([a-f0-9]{38})#) {
 		$object = "$2/$3";
 
-	} elsif (m#^(walk) ([a-f0-9]{2})([a-f0-9]{38})#) {
+	} elsif (m#^(ref|walk) ([a-f0-9]{2})([a-f0-9]{38})#) {
 		return 1; # redundant information
 
 	# rsync
diff --git a/cg-fetch b/cg-fetch
index a6e6959..9277f99 100755
--- a/cg-fetch
+++ b/cg-fetch
@@ -124,16 +124,10 @@ get_rsync()
 	return ${PIPESTATUS[0]}
 }
 
-fetch_rsync()
+fetch_rsync_save()
 {
-	if [ $verbose -ge 2 ]; then
-		# We must not pipe to prevent buffered I/O
-		get_rsync -s -d "$2/objects" "$_git_objects"
-	else
-		get_rsync -s -d "$2/objects" "$_git_objects" | fetch_progress
-	fi
 	ret=${PIPESTATUS[0]}
-	if [ "$3" ] && [ "$ret" -eq "0" ]; then
+	if [ "$1" ] && [ "$ret" -eq "0" ]; then
 		if [ "$orig_head" ]; then
 			git-rev-list --objects $new_head ^$orig_head |
 				while read obj type; do
@@ -141,12 +135,29 @@ fetch_rsync()
 				done ||
 			die "rsync fetch incomplete, some objects missing"
 		fi
-		cat "$_git/refs/${3%/*}/.${3##*/}-fetching" > "$_git/refs/$3"
+		cat "$_git/refs/${3%/*}/.${3##*/}-fetching" > "$_git/refs/$1"
 	fi
 	return $ret
 }
 
 
+fetch_rsync()
+{
+	if [ $verbose -ge 2 ]; then
+		# We must not pipe to prevent buffered I/O
+		get_rsync -s -d "$2/objects" "$_git_objects"
+	else
+		get_rsync -s -d "$2/objects" "$_git_objects" | fetch_progress
+	fi
+	if [ x"$1" = x"--stdin" ]; then
+		while read c w; do
+			echo "$c" >"$_git/refs/$w"
+		done
+	else
+		fetch_rsync_save "$3"
+	fi
+}
+
 get_http()
 {
 	[ "$1" = "-b" ] && shift
@@ -229,21 +240,13 @@ fetch_tags()
 
 			# if so, fetch the tag -- which should be
 			# a cheap operation -- to complete the chain.
-			echo -n "Missing tag ${tagname#tags/}... "
-			if $fetch "$tagname" "$uri" "$tagname" 2>/dev/null >&2; then
-				echo "retrieved"
-			else
-				# 17 is code from packed transport, which
-				# will grab all of them en masse later
-				if [ "$?" -ne "17" ]; then
-					echo "unable to retrieve"
-				else
-					echo ""
-				fi
-			fi
-		done
-	[ "${PIPESTATUS[0]}" -eq "0" ] ||
-		echo "unable to get tags list (non-fatal)" >&2
+			echo "Missing tag ${tagname#tags/}..." >&2
+			echo -e "$tagname"\\t"$tagname"
+		done |
+		sort | uniq | $fetch --stdin "$uri"
+	if [ "${PIPESTATUS[0]}" -ne 0 -o "$?" -ne 0 ]; then
+		echo "unable to fetch tags (non-fatal)" >&2
+	fi
 	return 0
 }
 
@@ -364,21 +367,15 @@ if [ "$packed_transport" ]; then
 		fetch_pack_recorder "refs/heads/$name" "fetching pack failed" ||
 		exit
 
-	export _cg_taglist="$(mktemp -t gitfetch.XXXXXX)"
 	record_tags_to_fetch () {
-		echo "refs/$1" >>"$_cg_taglist"
-		return 17
-	}
-	fetch=record_tags_to_fetch
-	fetch_tags
-	if [ -s "$_cg_taglist" ]; then
-		( cat "$_cg_taglist" | tr '\n' '\0' |
+		( cut -f 1 | tr '\n' '\0' |
 			xargs -0 git-fetch-pack $cloneorfetch "$uri" ||
 		  echo "failed" "$rembranch" ) |
 
 		fetch_pack_recorder "" "unable to retrieve tags (non-fatal)"
-	fi
-	rm "$_cg_taglist"
+	}
+	fetch=record_tags_to_fetch
+	fetch_tags
 
 	rm "$dirtyfile"
 	show_changes_summary "$orig_head" "$(cg-object-id "$name")"

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Snow falling on Perl. White noise covering line noise.
Hides all the bugs too. -- J. Putnam
