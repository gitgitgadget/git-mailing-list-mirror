Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: *
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=1.2 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: (qmail 15424 invoked by uid 111); 19 Sep 2008 09:55:32 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.176.167)
    by peff.net (qpsmtpd/0.32) with ESMTP; Fri, 19 Sep 2008 05:55:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751245AbYISJzP (ORCPT <rfc822;peff@peff.net>);
	Fri, 19 Sep 2008 05:55:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751227AbYISJzO
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Sep 2008 05:55:14 -0400
Received: from fk-out-0910.google.com ([209.85.128.185]:27502 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751089AbYISJzM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Sep 2008 05:55:12 -0400
Received: by fk-out-0910.google.com with SMTP id 18so336219fkq.5
        for <git@vger.kernel.org>; Fri, 19 Sep 2008 02:55:10 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:to;
        bh=PW/BBDp7ty75UYn60/YeyUFtAxuJOBIYqgjrZXu4q+8=;
        b=e/jFjLwM2gMbAQCKTIl3QynrNxrJMHQsOQizwtp6FIajEL5mdk4NNPBH5+mG9rp93c
         WPyIDiHtjcKsWdC1jHEPi4Y4ykOR3K0weOpXeqHjWT7Grm9Ur9hPsQ7TGdKNmpIDfL4G
         VhUcbOkzzMJGBgIwhAaswhcogAPvozmzdZlXA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Cp4IeZc+2cMltWpd4C2eRJ9l79l59f6uYDByCEogMW1d2jANP7wVV9RnFQ6i68FFli
         pkxSMhnso8+Xlqnge0KdX4LZUsc4Vsg4lfD1KsQ85t/6FpxyRluW+fxTTH7rI2HpGrq/
         7EABQ37k1cVAus62H8si8Tu4oXO3YwpKhvRks=
Received: by 10.103.203.15 with SMTP id f15mr3801596muq.130.1221818110517;
        Fri, 19 Sep 2008 02:55:10 -0700 (PDT)
Received: from localhost ( [91.15.64.191])
        by mx.google.com with ESMTPS id y2sm3490341mug.2.2008.09.19.02.55.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 19 Sep 2008 02:55:09 -0700 (PDT)
From:	Bert Wesarg <bert.wesarg@googlemail.com>
To:	Petr Baudis <pasky@suse.cz>
Cc:	Bert Wesarg <bert.wesarg@googlemail.com>, git@vger.kernel.org
Subject: [TopGit PATCH] tg-patch: add From/Date: line to header and print to file
Date:	Fri, 19 Sep 2008 11:55:01 +0200
Message-Id: <1221818101-14333-2-git-send-email-bert.wesarg@googlemail.com>
X-Mailer: git-send-email 1.6.0.1
In-Reply-To: <1221818101-14333-1-git-send-email-bert.wesarg@googlemail.com>
References: <1221818101-14333-1-git-send-email-bert.wesarg@googlemail.com>
To:	Petr Baudis <pasky@suse.cz>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

To make this more similar to git format-patch, I added a 'From' and
a 'Date:' header and let 'tg patch' print to a file (which is shown as output).

Regards
Bert

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>

---
 tg-patch.sh |   25 ++++++++++++++++++++++++-
 1 files changed, 24 insertions(+), 1 deletions(-)

diff --git a/tg-patch.sh b/tg-patch.sh
index 7a24718..5fc5cfd 100644
--- a/tg-patch.sh
+++ b/tg-patch.sh
@@ -24,7 +24,26 @@ done
 base_rev="$(git rev-parse --short --verify "refs/top-bases/$name" 2>/dev/null)" ||
 	die "not a TopGit-controlled branch"
 
-git cat-file blob "$name:.topmsg"
+subject="$(git cat-file blob "$name:.topmsg" | grep '^Subject: ' | sed -e 's/^Subject: //' -e 's/\[.*\] //')"
+file_name="$(echo "$subject" | tr -c '[[:alnum:]_.]' '_').patch"
+rev="$(git rev-parse --verify "refs/heads/$name" 2>/dev/null)"
+
+echo "$file_name"
+exec 3>&1
+exec 1>"$file_name"
+
+printf "From %s Mon Sep 17 00:00:00 2001\n" "$rev"
+now="$(date --rfc-2822)"
+git cat-file blob "$name:.topmsg" |
+	awk '
+		{
+			print
+			if (/^From:/ && !date_printed) {
+				printf "Date: %s\n", "'"$now"'"
+				date_printed = 1
+			}
+		}
+	'
 echo
 [ -n "$(git grep '^[-]--' "$name" -- ".topmsg")" ] || echo '---'
 
@@ -42,5 +61,9 @@ rm "$git_is_stupid"
 
 echo '-- '
 echo "tg: ($base_rev..) $name (depends on: $(git cat-file blob "$name:.topdeps" | paste -s -d' '))"
+
+exec 1>&3
+exec 3>&-
+
 branch_contains "$name" "$base_rev" ||
 	echo "tg: The patch is out-of-date wrt. the base! Run \`$tg update\`."
-- 
tg: (7ec3927..) t/patch (depends on: t/queue-movement)
