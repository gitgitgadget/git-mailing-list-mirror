From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH] cherry-pick/revert: transparently refresh index
Date: Sun, 31 Oct 2010 14:59:33 -0500
Message-ID: <20101031195933.GA21240@burratino>
References: <20101031174430.GA30236@arf.padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	Junio C Hamano <gitster@pobox.com>
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Sun Oct 31 20:59:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PCe4I-0007vo-Gi
	for gcvg-git-2@lo.gmane.org; Sun, 31 Oct 2010 20:59:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756662Ab0JaT7t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Oct 2010 15:59:49 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:38019 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751381Ab0JaT7s (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Oct 2010 15:59:48 -0400
Received: by yxk8 with SMTP id 8so2472530yxk.19
        for <git@vger.kernel.org>; Sun, 31 Oct 2010 12:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=D/h2JU3T7Ons2FAwFar+4g2PTzCJrxHkYymCTH7rCNs=;
        b=Qso29pTjq45UbPi0Issxmu9IyC5K39xKvrzhAvHXXX5TXfgU/dhj7tbSToyypglc+E
         wKYwWEVgQz4JhxhW01XeZ//ed+PlFyMWVu35TkckHroUHPPRxMeLc36sEcM6b5yTGBSC
         xcxnNDijv7i76AmUL1oUAQRWb3Av18UWUh+oY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=VSOyXl6NSt7EI8MIUHWKLHjMlSsV/gpUKm8PUSKwFdHygMijpqEuq393kIHzyZV3k3
         UGfuwp/tVGsahAP7naA76BKp5Xm5lrOrkklFN8/ewf3kzBHKQdHYY3KboQig7lxwr2ZX
         PYmw0yX3vTFk0WR2hxT8e0vkKtIB1DckPWxbg=
Received: by 10.151.149.18 with SMTP id b18mr17545089ybo.197.1288555187656;
        Sun, 31 Oct 2010 12:59:47 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id z30sm4358039yhc.9.2010.10.31.12.59.45
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 31 Oct 2010 12:59:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101031174430.GA30236@arf.padd.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160448>

A stat-dirty index is not a detail that ought to concern the operator
of porcelain such as "git cherry-pick".

Without this change, a cherry-pick after copying a worktree with rsync
errors out with a misleading message.

	$ git cherry-pick build/top
	error: Your local changes to 'file.h' would be overwritten by merge.  Aborting.
	Please, commit your changes or stash them before you can merge.

Noticed-by: Pete Wyckoff <pw@padd.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Pete Wyckoff wrote:

> P.S.  The user-observable problem that occurs if I do not
> rebuild the index is, e.g.:
> 
>     $ git cherry-pick build/top
>     error: Your local changes to 'file.h' would be overwritten by merge.  Aborting.
>     Please, commit your changes or stash them before you can merge.

Maybe this would help?

 builtin/revert.c              |   18 ++++++++++++++++--
 t/t3501-revert-cherry-pick.sh |   13 +++++++++++++
 2 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 57b51e4..bb6e9e8 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -547,6 +547,21 @@ static void prepare_revs(struct rev_info *revs)
 		die("empty commit set passed");
 }
 
+static void read_and_refresh_cache(const char *me)
+{
+	static struct lock_file index_lock;
+	int index_fd = hold_locked_index(&index_lock, 0);
+	if (read_index_preload(&the_index, NULL) < 0)
+		die("git %s: failed to read the index", me);
+	refresh_index(&the_index, REFRESH_QUIET|REFRESH_UNMERGED, NULL, NULL, NULL);
+	if (the_index.cache_changed) {
+		if (write_index(&the_index, index_fd) ||
+		    commit_locked_index(&index_lock))
+			die("git %s: failed to refresh the index", me);
+	}
+	rollback_lock_file(&index_lock);
+}
+
 static int revert_or_cherry_pick(int argc, const char **argv)
 {
 	struct rev_info revs;
@@ -567,8 +582,7 @@ static int revert_or_cherry_pick(int argc, const char **argv)
 			die("cherry-pick --ff cannot be used with --edit");
 	}
 
-	if (read_cache() < 0)
-		die("git %s: failed to read the index", me);
+	read_and_refresh_cache(me);
 
 	prepare_revs(&revs);
 
diff --git a/t/t3501-revert-cherry-pick.sh b/t/t3501-revert-cherry-pick.sh
index bc7aedd..b210188 100755
--- a/t/t3501-revert-cherry-pick.sh
+++ b/t/t3501-revert-cherry-pick.sh
@@ -81,6 +81,19 @@ test_expect_success 'revert after renaming branch' '
 
 '
 
+test_expect_success 'revert on stat-dirty working tree' '
+	git clone . repo &&
+	(
+		cd repo &&
+		git checkout initial
+	) &&
+	cp -R repo copy &&
+	(
+		cd copy &&
+		git cherry-pick added
+	)
+'
+
 test_expect_success 'revert forbidden on dirty working tree' '
 
 	echo content >extra_file &&
-- 
1.7.2.3.557.gab647.dirty
