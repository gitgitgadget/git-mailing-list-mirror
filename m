From: Bryan Larsen <bryanlarsen@yahoo.com>
Subject: [PATCH 4/6] cogito-gnu-progs: parameterize cogito
Date: Mon, 11 Jul 2005 06:15:12 -0400
Message-ID: <20050711101507.10318.54730.sendpatchset@bryan-larsens-ibook-g4.local>
References: <20050711101417.10318.64006.sendpatchset@bryan-larsens-ibook-g4.local>
Cc: junkio@cox.net, torvalds@osdl.org,
	Bryan Larsen <bryanlarsen@yahoo.com>, pasky@suse.cz,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 11 12:15:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DrvJx-000087-LW
	for gcvg-git@gmane.org; Mon, 11 Jul 2005 12:15:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261592AbVGKKPS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jul 2005 06:15:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261598AbVGKKPS
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jul 2005 06:15:18 -0400
Received: from smtp108.mail.sc5.yahoo.com ([66.163.170.6]:1879 "HELO
	smtp108.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261592AbVGKKPM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2005 06:15:12 -0400
Received: (qmail 36740 invoked from network); 11 Jul 2005 10:15:12 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Received:From:To:Cc:Message-Id:In-Reply-To:References:Subject;
  b=MeUiza3kB/Dvx7euoYgCOM1SA43TJujj+8FJ+B6Y4uhHPL2FjaWcpBQkIh2i05QZocrGkBPNMgGJIG/+3j7UCfRbxZJS4ujWWDTzEApZKwPPgESyXcZ75298DJ+J+dP0oy5fjP9F8EGswYAHxywm3ta7owBKhAIxqsTSiqj1jH0=  ;
Received: from unknown (HELO bryan-larsens-ibook-g4.local) (bryanlarsen@70.26.43.137 with plain)
  by smtp108.mail.sc5.yahoo.com with SMTP; 11 Jul 2005 10:15:11 -0000
To: bryan.larsen@gmail.com
In-Reply-To: <20050711101417.10318.64006.sendpatchset@bryan-larsens-ibook-g4.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Patch cogito so that the utilities 'cp' 'stat' 'xargs' and 'date' are configurable.  Cogito requires the gnu versions of these tools, and on some BSD derived systems, the gnu versions of these tools have a different name.

Signed-off-by: Bryan Larsen <bryan.larsen@gmail.com>
---

 cg-Xlib    |   15 ++++++++++-----
 cg-Xnormid |    2 +-
 cg-add     |    2 +-
 cg-commit  |    4 ++--
 cg-diff    |    4 ++--
 cg-init    |    4 ++--
 cg-patch   |    2 +-
 cg-pull    |    2 +-
 8 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/cg-Xlib b/cg-Xlib
--- a/cg-Xlib
+++ b/cg-Xlib
@@ -6,6 +6,11 @@
 # This file provides a library containing common code shared with all the
 # Cogito programs.
 
+DATE=date
+CP=cp
+XARGS=xargs
+STAT=stat
+
 _cg_cmd=${0##*/}
 
 _git=${GIT_DIR:-.git}
@@ -70,9 +75,9 @@ showdate () {
 	secs=$(($secs + $tzhours * 3600 + $tzmins * 60))
 	[ "$format" ] || format="+%a, %d %b %Y %H:%M:%S $2"
 	if [ "$has_gnudate" ]; then
-		LANG=C date -ud "1970-01-01 UTC + $secs sec" "$format"
+		LANG=C ${DATE} -ud "1970-01-01 UTC + $secs sec" "$format"
 	else
-		LANG=C date -u -r $secs "$format"
+		LANG=C ${DATE} -u -r $secs "$format"
 	fi
 }
 
@@ -104,7 +109,7 @@ tree_timewarp () {
 	[ "$no_head_update" ] || echo "$branch" > $_git/HEAD
 
 	# Kill gone files
-	git-diff-tree -z -r $base $branch | xargs -0 bash -c '
+	git-diff-tree -z -r $base $branch | ${XARGS} -0 bash -c '
 		while [ "$1" ]; do
 			header="$1"; shift
 			file="$1"; shift
@@ -234,5 +239,5 @@ fi
 
 export BROKEN_MKTEMP=1
 del=$($(which mktemp) -t 2>/dev/null) && { rm $del; export BROKEN_MKTEMP=; }
-has_stat=$(which stat 2>/dev/null)
-has_gnudate=$(date -Rud "1970-01-01 UTC" 2>/dev/null)
+has_stat=$(which ${STAT} 2>/dev/null)
+has_gnudate=$(${DATE} -Rud "1970-01-01 UTC" 2>/dev/null)
diff --git a/cg-Xnormid b/cg-Xnormid
--- a/cg-Xnormid
+++ b/cg-Xnormid
@@ -50,7 +50,7 @@ fi
 
 valid=; [ ${#id} -eq 40 ] && [ "$(git-rev-parse --revs-only "$id")" ] && valid=1
 if ([ "$id" ] && [ "$id" != " " ]) && [ ! "$valid" ]; then
-	reqsecs=$(date --date="$id" +'%s' 2>/dev/null)
+	reqsecs=$(${DATE} --date="$id" +'%s' 2>/dev/null)
 
 	if [ "$reqsecs" ]; then
 		id=$(git-rev-list --min-age=$reqsecs --max-count=1 HEAD)
diff --git a/cg-add b/cg-add
--- a/cg-add
+++ b/cg-add
@@ -43,6 +43,6 @@ find "${ARGS[@]}" -type f -print0 > $TMP
 }
 
 cat $TMPFILE | tr '\0' '\n' | sed 's/^/Adding file /'
-cat $TMPFILE | xargs -0r git-update-cache --add ${infoonly} --
+cat $TMPFILE | ${XARGS} -0r git-update-cache --add ${infoonly} --
 
 rm $TMPFILE
diff --git a/cg-commit b/cg-commit
--- a/cg-commit
+++ b/cg-commit
@@ -168,7 +168,7 @@ written=
 if [ "$merging" ]; then
 	echo -n 'Merge with ' >>$LOGMSG
 	[ "$msgs" ] && echo -n 'Merge with '
-	[ -s $_git/merging-sym ] || cp $_git/merging $_git/merging-sym
+	[ -s $_git/merging-sym ] || ${CP} $_git/merging $_git/merging-sym
 	for sym in $(cat $_git/merging-sym); do
 		uri=$(cat $_git/branches/$sym)
 		[ "$uri" ] || uri="$sym"
@@ -229,7 +229,7 @@ fi
 echo "CG: -----------------------------------------------------------------------" >>$LOGMSG
 echo "CG: vim: textwidth=75" >>$LOGMSG
 
-cp $LOGMSG $LOGMSG2
+${CP} $LOGMSG $LOGMSG2
 if tty -s; then
 	if ! [ "$msgs" ] || [ "$forceeditor" ]; then
 		${EDITOR:-vi} $LOGMSG2
diff --git a/cg-diff b/cg-diff
--- a/cg-diff
+++ b/cg-diff
@@ -155,7 +155,7 @@ if [ "$id2" = " " ]; then
 	# FIXME: Update ret based on what did we match. And take "$@"
 	# to account after all.
 	ret=
-	cat $filter | xargs git-diff-cache -r -p $tree | colorize | pager
+	cat $filter | ${XARGS} git-diff-cache -r -p $tree | colorize | pager
 
 	rm $filter
 
@@ -169,7 +169,7 @@ id2=$(tree-id "$id2") || exit 1
 
 [ "$id1" = "$id2" ] && die "trying to diff $id1 against itself"
 
-cat $filter | xargs git-diff-tree -r -p $id1 $id2 | colorize | pager
+cat $filter | ${XARGS} git-diff-tree -r -p $id1 $id2 | colorize | pager
 
 rm $filter
 exit 0
diff --git a/cg-init b/cg-init
--- a/cg-init
+++ b/cg-init
@@ -47,7 +47,7 @@ if [ "$uri" ]; then
 	echo "$uri" >$_git/branches/origin
 	cg-pull origin || die "pull failed"
 
-	cp $_git/refs/heads/origin $_git/refs/heads/master
+	${CP} $_git/refs/heads/origin $_git/refs/heads/master
 	git-read-tree HEAD
 	git-checkout-cache -a
 	git-update-cache --refresh
@@ -55,7 +55,7 @@ if [ "$uri" ]; then
 	echo "Cloned (origin $uri available as branch \"origin\")"
 else
 	git-read-tree # Seed the dircache
-	find * \( -type f -o -type l \) -print0 | xargs -0r cg-add ${infoonly}
+	find * \( -type f -o -type l \) -print0 | ${XARGS} -0r cg-add ${infoonly}
 	cg-commit -C -m"Initial commit" -E ${infoonly}
 fi
 
diff --git a/cg-patch b/cg-patch
--- a/cg-patch
+++ b/cg-patch
@@ -129,7 +129,7 @@ wait
 touchfiles="$(git-ls-files --deleted | join -v 2 $gonefile -)"
 [ "$touchfiles" ] && touch $touchfiles
 
-cat $todo | xargs -0 bash -c '
+cat $todo | ${XARGS} -0 bash -c '
 while [ "$1" ]; do
 	op="$1"; shift;
 	case "$op" in
diff --git a/cg-pull b/cg-pull
--- a/cg-pull
+++ b/cg-pull
@@ -233,7 +233,7 @@ fetch_local () {
 	dest="$2"
 	[ "$cut_last" ] && dest=${dest%/*}
 
-	cp $cp_flags_l "$src" "$dest"
+	${CP} $cp_flags_l "$src" "$dest"
 }
 
 pull_local () {
