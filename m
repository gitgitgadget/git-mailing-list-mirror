From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: [PATCH] Add "git push"
Date: Thu, 21 Apr 2005 22:43:33 +1000 (EST)
Message-ID: <20050421124333.AB2CE7F887@smurf.noris.de>
X-From: git-owner@vger.kernel.org Thu Apr 21 14:50:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOb7f-0002G3-OV
	for gcvg-git@gmane.org; Thu, 21 Apr 2005 14:49:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261343AbVDUMx5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Apr 2005 08:53:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261342AbVDUMx5
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Apr 2005 08:53:57 -0400
Received: from run.smurf.noris.de ([192.109.102.41]:7647 "EHLO
	server.smurf.noris.de") by vger.kernel.org with ESMTP
	id S261343AbVDUMxj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Apr 2005 08:53:39 -0400
Received: from kiste.smurf.noris.de ([192.109.102.35] ident=mail)
	by server.smurf.noris.de with smtp (Exim 4.50)
	id 1DObB9-0004vZ-HS
	for git@vger.kernel.org; Thu, 21 Apr 2005 14:53:21 +0200
Received: (nullmailer pid 1131 invoked by uid 501);
	Thu, 21 Apr 2005 12:53:11 -0000
Received: from [150.203.247.5] (helo=smurf.noris.de)
	by server.smurf.noris.de with esmtp (Exim 4.50)
	id 1DOb6J-0004lz-1L
	for smurf@smurf.noris.de; Thu, 21 Apr 2005 14:48:24 +0200
Received: by smurf.noris.de (Postfix, from userid 501)
	id AB2CE7F887; Thu, 21 Apr 2005 22:43:33 +1000 (EST)
To: git@vger.kernel.org
X-Smurf-Spam-Score: -1.3 (-)
X-Smurf-Spam-Score: -1.6 (-)
X-Smurf-Whitelist: +relay_from_hosts
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This patch adds the ability to "git push", as the obvious converse of
"git pull".

Signed-Off-By: Matthias Urlichs <smurf@smurf.noris.de>

Index: git
===================================================================
--- 42a073eb6b5bb397a3e8768a032463a7fa02e6b9/git  (mode:100755 sha1:557122dfb05580e4af2c55767f3d6f92b9110edd)
+++ 265515f9c4f089b1b61e9d2312c4b3babe189618/git  (mode:100644 sha1:c32ee037c4dd68f8fa6723cb115644d46810bc89)
@@ -42,6 +42,7 @@
 	merge		[-c] [-b BASE_ID] FROM_ID
 	patch		[COMMIT_ID]
 	pull		[RNAME]
+	push		[RNAME]
 	rm		FILE...
 	seek		[COMMIT_ID]
 	status
@@ -86,6 +87,7 @@
 "lsremote")   gitlsremote.sh "$@";;
 "merge")      gitmerge.sh "$@";;
 "pull")       gitpull.sh "$@";;
+"push")       gitpush.sh "$@";;
 "patch")      gitpatch.sh "$@";;
 "rm")         gitrm.sh "$@";;
 "seek")       gitseek.sh "$@";;
--- /dev/null  (tree:42a073eb6b5bb397a3e8768a032463a7fa02e6b9)
+++ 265515f9c4f089b1b61e9d2312c4b3babe189618/gitpush.sh  (mode:100644 sha1:0a658141991c602ca327edb9ab982d7660d7c665)
@@ -0,0 +1,59 @@
+#!/bin/sh
+#
+# Pushes changes from the local GIT repository to "remote".
+# Copyright (c) Matthias Urlichs, 2005
+#
+# Takes the remote's name.
+
+name=$1
+
+die () {
+	echo gitpush.sh: $@ >&2
+	exit 1
+}
+
+
+[ "$name" ] || name=$(cat .git/tracking 2>/dev/null)
+[ "$name" ] || die "where to push to?"
+uri=$(grep $(echo -e "^$name\t" | sed 's/\./\\./g') .git/remotes | cut -f 2)
+[ "$uri" ] || die "unknown remote"
+
+
+tracking=
+[ -s .git/tracking ] && tracking=$(cat .git/tracking)
+
+orig_head=
+if [ "$tracking" = "$name" ]; then
+	[ -s .git/HEAD.tracked ] && orig_head=$(cat .git/HEAD.tracked)
+else
+	[ -s ".git/heads/$name" ] && orig_head=$(cat ".git/heads/$name")
+fi
+
+rsync $RSYNC_FLAGS -Lr "$uri/HEAD" ".git/HEAD_$name"
+$id=$(cat ".git/HEAD_$name")
+rm .git/HEAD_$name
+
+if [ -z "$id" ] ; then
+	echo "The remote system doesn't have a HEAD file: Doing an initial upload." >&2
+	echo "." >&2
+elif [ "$(cat-file -t "$id")" != "commit" ]; then
+	echo "The remote system has stuff we don't have: pull first!" >&2
+	echo "	Commit ID: $id" >&2
+	exit 1
+fi
+
+# We already saw the MOTD, thank you very much.
+rsync $RSYNC_FLAGS --ignore-existing --whole-file \
+	-v -r ".git/objects" "$uri" | grep -v '^MOTD:'
+
+# FIXME: Warn about conflicting tag names?
+rsync $RSYNC_FLAGS --ignore-existing \
+	-v -r ".git/tags" "$uri" 2>/dev/null | grep -v '^MOTD:'
+
+# Finally, update the remote HEAD
+rsync $RSYNC_FLAGS -Lr ".git/HEAD" "$uri/HEAD" \
+	2>/dev/null | grep -v '^MOTD:'
+
+echo "Now up to date."
+exit
+
