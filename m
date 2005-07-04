From: Junio C Hamano <junkio@cox.net>
Subject: Re: expensive local git clone
Date: Mon, 04 Jul 2005 14:40:11 -0700
Message-ID: <7v7jg6i72c.fsf@assigned-by-dhcp.cox.net>
References: <20050704.125744.59481768.davem@davemloft.net>
	<Pine.LNX.4.58.0507041327580.3570@g5.osdl.org>
	<20050704204235.GE21128@pasky.ji.cz>
	<20050704.140043.112609056.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 04 23:42:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DpYgy-00006s-Tb
	for gcvg-git@gmane.org; Mon, 04 Jul 2005 23:41:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261689AbVGDVlD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Jul 2005 17:41:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261691AbVGDVlD
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jul 2005 17:41:03 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:37824 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S261689AbVGDVkT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jul 2005 17:40:19 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050704214013.TZVX17043.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 4 Jul 2005 17:40:13 -0400
To: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20050704.140043.112609056.davem@davemloft.net> (David S. Miller's message of "Mon, 04 Jul 2005 14:00:43 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "DSM" == David S Miller <davem@davemloft.net> writes:

DSM> I keep hoping git-clone-script is going to be a good way
DSM> to clone two local trees.  Is my hope misguided?  :-)

Something along these lines?
------------
Short-cut "git fetch" when cloning locally.

Instead of calling local-pull to "do the right thing", just
hardlink or copy the object files over when we know we are doing
the clone locally.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

cd /opt/packrat/playpen/public/in-place/git/git.junio/
jit-diff
# - master: git-format-patch: Prepare patches for e-mail submission.
# + (working tree)
diff --git a/git-clone-script b/git-clone-script
--- a/git-clone-script
+++ b/git-clone-script
@@ -1,7 +1,39 @@
 #!/bin/sh
 repo="$1"
 dir="$2"
-mkdir $dir || exit 1
-cd $dir
-git-init-db
-git fetch "$repo" && ( git-rev-parse FETCH_HEAD > .git/HEAD )
+mkdir "$dir" &&
+D=$(
+    (cd "$dir" && git-init-db && pwd)
+) || exit 1
+
+# See if repo is a local directory.
+if (
+	cd "$repo/objects" 2>/dev/null
+)
+then
+	# See if we can hardlink and drop "l" if not.
+	sample_file=$(cd "$repo" && find objects -type f -print | sed -e 1q)
+
+	# objects directory should not be empty since we are cloning!
+	test -f "$repo/$sample_file" || exit 
+
+	if ln "$repo/$sample_file" "$D/.git/objects/sample" 2>/dev/null
+	then
+	    l=l
+	else
+	    l=
+	fi &&
+	rm -f "$D/.git/objects/sample" &&
+
+	cd "$repo" &&
+	find objects -type f -print |
+	cpio -puam$l "$D/.git" || exit 1
+
+	# FETCH_HEAD is always HEAD because we do not do the
+	# extra parameter to "git fetch".
+	pwd
+	cat "HEAD" >"$D/.git/FETCH_HEAD"
+	cd "$D"
+else
+	cd "$D" && git fetch "$repo"
+fi && ( git-rev-parse FETCH_HEAD > .git/HEAD )

Compilation finished at Mon Jul  4 14:37:29
