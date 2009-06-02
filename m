Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=0.9 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: (qmail 15900 invoked by uid 107); 2 Jun 2009 20:40:54 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.176.167)
    by peff.net (qpsmtpd/0.40) with ESMTP; Tue, 02 Jun 2009 16:40:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752304AbZFBUkj (ORCPT <rfc822;peff@peff.net>);
	Tue, 2 Jun 2009 16:40:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752228AbZFBUkj
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Jun 2009 16:40:39 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:7849 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751519AbZFBUkj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jun 2009 16:40:39 -0400
Received: by fg-out-1718.google.com with SMTP id d23so946023fga.17
        for <git@vger.kernel.org>; Tue, 02 Jun 2009 13:40:40 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:to;
        bh=jV73rgryhRczE9ZZjlDRU+BKApXdceq1xIU2MYjVTVQ=;
        b=p4uYFzp140BXquKqZEPm5gSFuy4hx4sWjSXUY/nAgfSZ20VWWCUwg1XsLpE0qCoaPA
         LFlSQVaOFdlZO0/aj6viaAKZUN9KZswG0yax/t+qqJriVh9dSLH7fymD1yyV7rx9e5lW
         NJCJO/mWuYuXBpTfMut9xcQuHYSywpfC8Twn8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=iWgplG4Us1XnyFGrOGqE/XI+wAW2CDMD0K1Pvo12jzKmzWpDsuRXIK6+DJpNE2iGvH
         kZPQ3a5CO0Ylbcns+Nk1XBld/8IlcPDr4geCiEE8ZWvwaD7uCw7BAkAly7FHv8sj7gWI
         Eyu09WTA+PhiNVTDNeEUMVVJtr7bo8f5JwpV8=
Received: by 10.86.58.1 with SMTP id g1mr250801fga.54.1243975240418;
        Tue, 02 Jun 2009 13:40:40 -0700 (PDT)
Received: from localhost (drsd-4db365ef.pool.einsundeins.de [77.179.101.239])
        by mx.google.com with ESMTPS id l19sm12551160fgb.7.2009.06.02.13.40.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 02 Jun 2009 13:40:39 -0700 (PDT)
From:	Bert Wesarg <bert.wesarg@googlemail.com>
To:	Petr Baudis <pasky@suse.cz>
Cc:	Bert Wesarg <bert.wesarg@googlemail.com>, git@vger.kernel.org,
	martin f krafft <madduck@debian.org>,
	Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
Subject: [TopGit PATCH] pre-commit: check .top* files in the to-be-commited tree
Date:	Tue,  2 Jun 2009 22:40:38 +0200
Message-Id: <1243975238-4807-1-git-send-email-bert.wesarg@googlemail.com>
X-Mailer: git-send-email 1.6.2.2.463.g124d4
To:	Petr Baudis <pasky@suse.cz>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

We currently check fo these files only in the working tree. But we should check
what would be commited. We use write-tree to be able to utilize ls-tree and
check the result.

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>

---
 hooks/pre-commit.sh |   36 +++++++++++++++++++++++++++++++-----
 1 files changed, 31 insertions(+), 5 deletions(-)

diff --git a/hooks/pre-commit.sh b/hooks/pre-commit.sh
index 9d677e9..7f66c75 100644
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
tg: (b725fc9..) bw/pre-commit-check-.top-files (depends on: master)
