From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [TopGit PATCH] tg-patch: fix invocation in sub working tree directory
Date: Mon, 16 Mar 2009 23:08:19 +0100
Message-ID: <1237241299-25515-1-git-send-email-bert.wesarg@googlemail.com>
Cc: Bert Wesarg <bert.wesarg@googlemail.com>, git@vger.kernel.org,
	martin f krafft <madduck@debian.org>,
	u.kleine-koenig@pengutronix.de
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Mon Mar 16 23:10:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjL1E-0007aT-4L
	for gcvg-git-2@gmane.org; Mon, 16 Mar 2009 23:10:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756531AbZCPWJK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Mar 2009 18:09:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755861AbZCPWJJ
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Mar 2009 18:09:09 -0400
Received: from mail-fx0-f176.google.com ([209.85.220.176]:40148 "EHLO
	mail-fx0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754387AbZCPWJI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Mar 2009 18:09:08 -0400
Received: by fxm24 with SMTP id 24so3689250fxm.37
        for <git@vger.kernel.org>; Mon, 16 Mar 2009 15:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=2UQY4/t+nmVxYCdr26/NMEwtf38zC+XPsSU73P9wyTA=;
        b=Uj6PUH2qniqzoLbceXn/+IDvqfwr0cAVaHdzzvZyw9mULzF2mI8GmZpXkv4fRuRu3D
         11T9M0aQWgN07lGAu4YaVHOqtQecIYBzWYX6U/O8Ur8+UawmzBm2bgnmuExAZ3yb74Qh
         zsKS5q3t7cykVlzVzVwMJtYBAbCFofEsAlRAQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=VeFUgIE76IieDfQh3K9WMsvkV7x9S/DdfwJPKZbJdo4/Myk6RT+RPdmnN5DG4RIIHU
         7vd2klNS9mOZqqd5J7tnOf4Dt5ESQcJQLFX9pxp5cC02cxpFJwwcHP9J9DBS01ggEYrd
         hOMehD76C43/h+mZqaNjlgHnc41CUPhhjb3Xc=
Received: by 10.103.138.16 with SMTP id q16mr2365794mun.7.1237241345661;
        Mon, 16 Mar 2009 15:09:05 -0700 (PDT)
Received: from localhost (p5B0F4307.dip.t-dialin.net [91.15.67.7])
        by mx.google.com with ESMTPS id s10sm11559424mue.16.2009.03.16.15.09.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 16 Mar 2009 15:09:05 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.1.148.g0b7ce
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113393>

tg patch won't work in a sub directory of the working tree, because 'git diff
--name-only' prints the names relative to the top working tree.

This is only a quick fix which prefixes all file names with 'git rev-parse
--show-cdup'. The right solution would be to cd into the top working tree
somewhere in tg.sh.

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>

---
 tg-patch.sh |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/tg-patch.sh b/tg-patch.sh
index d701c54..e33bab2 100644
--- a/tg-patch.sh
+++ b/tg-patch.sh
@@ -50,13 +50,18 @@ cat_file "$topic:.topmsg"
 echo
 [ -n "$(git grep $diff_opts '^[-]--' ${diff_committed_only:+"$name"} -- ".topmsg")" ] || echo '---'
 
+# if we are in a sub working tree dir, we need to prefix all file names from
+# git diff --name-only with this cdup
+cdup=$(git rev-parse --show-cdup)
+
 # Evil obnoxious hack to work around the lack of git diff --exclude
 git_is_stupid="$(mktemp -t tg-patch-changes.XXXXXX)"
 git diff --name-only $diff_opts "$base_rev" ${diff_committed_only:+"$name"} -- |
 	fgrep -vx ".topdeps" |
 	fgrep -vx ".topmsg" >"$git_is_stupid" || : # fgrep likes to fail randomly?
 if [ -s "$git_is_stupid" ]; then
-	cat "$git_is_stupid" | xargs git diff --patch-with-stat $diff_opts "$base_rev" ${diff_committed_only:+"$name"} --
+	sed -e "s#^#$cdup#" "$git_is_stupid" |
+		xargs git diff --patch-with-stat $diff_opts "$base_rev" ${diff_committed_only:+"$name"} --
 else
 	echo "No changes."
 fi
-- 
tg: (d145a7b..) bw/fix-tg-patch-in-sub-dir (depends on: master)
