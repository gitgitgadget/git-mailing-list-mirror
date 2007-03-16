From: Paolo Bonzini <paolo.bonzini@lu.unisi.ch>
Subject: [PATCH] git-fetch, git-parse-remote: Cleanup implementation of '.'
Date: Fri, 16 Mar 2007 09:38:09 +0100
Message-ID: <45FA5771.1040200@lu.unisi.ch>
References: <etavpn$ma0$1@sea.gmane.org> <7vr6rqyr60.fsf@assigned-by-dhcp.cox.net>
Reply-To: bonzini@gnu.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Mar 16 09:38:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HS7x5-000874-Bq
	for gcvg-git@gmane.org; Fri, 16 Mar 2007 09:38:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752080AbXCPIiQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Mar 2007 04:38:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752100AbXCPIiQ
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Mar 2007 04:38:16 -0400
Received: from server.usilu.net ([195.176.178.200]:22539 "EHLO mail.usilu.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752080AbXCPIiP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Mar 2007 04:38:15 -0400
Received: from [1.240.182.245] ([213.140.22.65] RDNS failed) by mail.usilu.net over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 16 Mar 2007 09:40:59 +0100
User-Agent: Thunderbird 1.5.0.10 (Macintosh/20070221)
In-Reply-To: <7vr6rqyr60.fsf@assigned-by-dhcp.cox.net>
X-OriginalArrivalTime: 16 Mar 2007 08:40:59.0937 (UTC) FILETIME=[D2A15910:01C767A6]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42334>

As per the mailing list exchanges, this applies the following changes:

- renames the data source from 'builtin' to 'self'.

- renames fetch_packs/fetch_heads to fetch_per_ref and fetch_all_at_once

- processes any remote whose URL is '.' (not only the builtin one) using
native-store (this is tested by t3200-branch.sh).

Signed-Off-By: Paolo Bonzini  <bonzini@gnu.org>
---
 git-fetch.sh        |   33 +++++++++++++--------------------
 git-parse-remote.sh |    8 ++++----
 2 files changed, 17 insertions(+), 24 deletions(-)

	The patch is a cleanup of the one you posted, and it was
	appropriately tested with no regression.

	I can see now what you meant by the split between fetch and
	merge logic making my patch more complicated than necessary.

diff --git a/git-fetch.sh b/git-fetch.sh
index 3b01f06..a650116 100755
--- a/git-fetch.sh
+++ b/git-fetch.sh
@@ -161,7 +161,7 @@ then
 	fi
 fi
 
-fetch_packs () {
+fetch_all_at_once () {
 
   eval=$(echo "$1" | git-fetch--tool parse-reflist "-")
   eval "$eval"
@@ -169,7 +169,9 @@ fetch_packs () {
     ( : subshell because we muck with IFS
       IFS=" 	$LF"
       (
-	if test -f "$remote" ; then
+	if test "$remote" = . ; then
+	    git-show-ref $rref || echo failed "$remote"
+	elif test -f "$remote" ; then
 	    test -n "$shallow_depth" &&
 		die "shallow clone with bundle is not supported"
 	    git-bundle unbundle "$remote" $rref ||
@@ -192,7 +194,7 @@ fetch_packs () {
 
 }
 
-fetch_heads () {
+fetch_per_ref () {
   reflist="$1"
   refs=
   rref=
@@ -286,10 +288,6 @@ fetch_heads () {
 	      rsync_slurped_objects=t
 	  }
 	  ;;
-      .)
-	  local_name=$remote_name
-	  head=$(git-rev-parse --verify "$local_name")
-	  ;;
       esac
 
       append_fetch_head "$head" "$remote" \
@@ -300,19 +298,14 @@ fetch_heads () {
 }
 
 fetch_main () {
-	data_source=$(get_data_source "$remote_nick")
-	if test "$data_source" = builtin; then
-		fetch_heads "$@"
-	else
-		case "$remote" in
-		http://* | https://* | ftp://* | rsync://* )
-			fetch_heads "$@"
-			;;
-		*)
-			fetch_packs "$@"
-			;;
-		esac
-	fi
+	case "$remote" in
+	http://* | https://* | ftp://* | rsync://* )
+		fetch_per_ref "$@"
+		;;
+	*)
+		fetch_all_at_once "$@"
+		;;
+	esac
 }
 
 fetch_main "$reflist" || exit
diff --git a/git-parse-remote.sh b/git-parse-remote.sh
index a94215d..f25f9c1 100755
--- a/git-parse-remote.sh
+++ b/git-parse-remote.sh
@@ -10,7 +10,7 @@ get_data_source () {
 		echo ''
 		;;
 	.)
-		echo builtin
+		echo self
 		;;
 	*)
 		if test "$(git-config --get "remote.$1.url")"
@@ -34,7 +34,7 @@ get_remote_url () {
 	'')
 		echo "$1"
 		;;
-	builtin)
+	self)
 		echo "$1"
 		;;
 	config)
@@ -63,7 +63,7 @@ get_default_remote () {
 get_remote_default_refs_for_push () {
 	data_source=$(get_data_source "$1")
 	case "$data_source" in
-	'' | branches | builtin)
+	'' | branches | self)
 		;; # no default push mapping, just send matching refs.
 	config)
 		git-config --get-all "remote.$1.push" ;;
@@ -169,7 +169,7 @@ get_remote_default_refs_for_fetch () {
 	case "$data_source" in
 	'')
 		echo "HEAD:" ;;
-	builtin)
+	self)
 	        canon_refs_list_for_fetch -d "$1" \
 			$(git-show-ref | sed -n 's,.*[      ]\(refs/.*\),\1:,p') ;;
 	config)
