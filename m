From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [TopGit PATCH] pre-commit: check .top* files in the to-be-commited tree
Date: Mon,  4 Oct 2010 20:54:57 +0200
Message-ID: <1286218497-18036-1-git-send-email-bert.wesarg@googlemail.com>
Cc: git@vger.kernel.org, pasky@suse.cz,
	martin f krafft <madduck@madduck.net>,
	Bert Wesarg <bert.wesarg@googlemail.com>,
	martin f krafft <madduck@debian.org>
X-From: git-owner@vger.kernel.org Mon Oct 04 20:56:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2qCX-0006XY-3I
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 20:55:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932172Ab0JDSzm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Oct 2010 14:55:42 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:40278 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757062Ab0JDSzD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Oct 2010 14:55:03 -0400
Received: by bwz11 with SMTP id 11so3876179bwz.19
        for <git@vger.kernel.org>; Mon, 04 Oct 2010 11:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:to;
        bh=bQ+lazZ9KiXj1WR/1cvVju2g6Cs8SwBAuEp4dgyaEuE=;
        b=gcT86Hi8yERE/RTNlmjc2TcCYm7FDhdXFxFJwAJUqmW4sjkrRv/eIVwtCZ4h2EeYvX
         zV1wlXOpDQbPrhNhS2FtGOFZKoQfukA8kz2PJtWTWshlvHb0HSMZVGzWKCiHEgYQ5G+s
         glpevaqqQlpicgMcjfJ6F8NYuzFo2fAreVoGw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=Ft6qHjXIPbBjdinuhNnllvpKfwqy0ukKgtxg/xar1o0tNCU8pypCBP2TZxynYtiCeY
         bEwg8H086OfbbvUuoEXKkQ/UmS3naYohR8PVGnIzUEwvdXpy5R7KxY/wo+QJ7lRp7U5U
         gosvFCM50SPI10ULJBKiiPNRsxcMaIe4k4/0k=
Received: by 10.204.79.199 with SMTP id q7mr7431850bkk.76.1286218501892;
        Mon, 04 Oct 2010 11:55:01 -0700 (PDT)
Received: from localhost (p5B0F7A6E.dip.t-dialin.net [91.15.122.110])
        by mx.google.com with ESMTPS id 11sm4040855bkj.11.2010.10.04.11.54.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 04 Oct 2010 11:55:00 -0700 (PDT)
To: Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 1.7.1.1067.g5aeb7
To: Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158091>

We currently check fo these files only in the working tree. But we should check
what would be commited. We use write-tree to be able to utilize ls-tree and
check the result.

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>

---
 hooks/pre-commit.sh |   36 +++++++++++++++++++++++++++++++-----
 1 files changed, 31 insertions(+), 5 deletions(-)

diff --git a/hooks/pre-commit.sh b/hooks/pre-commit.sh
index 9d677e9..7f66c75 100644 hooks/pre-commit.sh
--- a/hooks/pre-commit.sh
+++ b/hooks/pre-commit.sh
@@ -29,10 +29,36 @@ else
 	exit 0;
 fi
 
-# TODO: check the index, not the working copy
-[ -s "$root_dir/.topdeps" ] ||
-	die ".topdeps is missing"
-[ -s "$root_dir/.topmsg" ] ||
-	die ".topmsg is missing"
+check_topfile()
+{
+	local tree=$1
+	local file=$2
+
+	local ls_line="$(git ls-tree --long "$tree" "$file")" ||
+		die "Can't ls tree for $file"
+
+	[ -n "$ls_line" ] ||
+		die "$file is missing"
+
+	# check for type and size
+	set -- $ls_line
+	local type=$2
+	local size=$4
+
+	# check file is of type blob (file)
+	[ "x$type" = "xblob" ] ||
+		die "$file is not a file"
+
+	# check for positive size
+	[ "$size" -gt 0 ] ||
+		die "$file has empty size"
+}
+
+# I suspect this can't fail, but who knows
+tree=$(git write-tree) ||
+	die "Can't write tree"
+
+check_topfile "$tree" ".topdeps"
+check_topfile "$tree" ".topmsg"
 
 # TODO: Verify .topdeps for valid branch names and against cycles
-- 
tg: (ff59ac7..) bw/pre-commit-check-.top-files (depends on: master)
