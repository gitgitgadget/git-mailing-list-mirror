Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: *
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=1.7 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: (qmail 15406 invoked by uid 111); 19 Sep 2008 09:55:24 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.176.167)
    by peff.net (qpsmtpd/0.32) with ESMTP; Fri, 19 Sep 2008 05:55:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751182AbYISJzN (ORCPT <rfc822;peff@peff.net>);
	Fri, 19 Sep 2008 05:55:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751161AbYISJzN
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Sep 2008 05:55:13 -0400
Received: from mu-out-0910.google.com ([209.85.134.185]:21749 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751139AbYISJzK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Sep 2008 05:55:10 -0400
Received: by mu-out-0910.google.com with SMTP id g7so284997muf.1
        for <git@vger.kernel.org>; Fri, 19 Sep 2008 02:55:07 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:to;
        bh=i7TdXZjGHGii3M/BctlVXNH1uZg0SNSaz5zTI2xd1pQ=;
        b=LmGm54AlxYOHpHkhVF3czdIyczAcEnhhP5hc5pUpu+5UPHwJ0/xrcris/kBBHe7b9m
         hkVf9+O5Yg1vYEbGjIVIlSJzxdYiO86X/yOWecfFSTIEhDp1zMTucQwGcQXdibOwlKsH
         yqY0N76vmGDMud7RowkwwYbMHQrNYflMySk9g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=aoJFHhBr6Pl9lQuCCyaQ7d+tlA6VmxlfSuxOwjvjh730LpAhsNtYBR7YdRb8bSJQJb
         AaSRjWFohUyi4F7GXOqhCDU5AK2an69m1IQR5iflRd3uBe1ui58n2XnstwwiqSy+d3oQ
         Uxjdw/vl2P/1qOqGPfxePStGwDSVoprxh8Yho=
Received: by 10.103.176.2 with SMTP id d2mr3801651mup.112.1221818107376;
        Fri, 19 Sep 2008 02:55:07 -0700 (PDT)
Received: from localhost ( [91.15.64.191])
        by mx.google.com with ESMTPS id u9sm3486841muf.9.2008.09.19.02.55.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 19 Sep 2008 02:55:06 -0700 (PDT)
From:	Bert Wesarg <bert.wesarg@googlemail.com>
To:	Petr Baudis <pasky@suse.cz>
Cc:	Bert Wesarg <bert.wesarg@googlemail.com>, git@vger.kernel.org
Subject: [TopGit PATCH] prev/next/tsort: commands to explore dependencies
Date:	Fri, 19 Sep 2008 11:55:00 +0200
Message-Id: <1221818101-14333-1-git-send-email-bert.wesarg@googlemail.com>
X-Mailer: git-send-email 1.6.0.1
To:	Petr Baudis <pasky@suse.cz>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

I hacked 3 commands to explore the dependencies of TopGit patches:

  I) tg prev [NAME]
     outputs the dependencies of NAME

 II) tg next [NAME]
     outputs patches that depends on NAME

III) tg tsort [PATTERN]
     outputs a topological order of all patches starting with PATTERN

I'm more than open for improvments.

Regards
Bert
   
Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>

---
 .gitignore  |    6 ++++++
 tg-next.sh  |   33 +++++++++++++++++++++++++++++++++
 tg-prev.sh  |   27 +++++++++++++++++++++++++++
 tg-tsort.sh |   57 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 123 insertions(+), 0 deletions(-)

diff --git a/.gitignore b/.gitignore
index 8868f2d..b7fb70b 100644
--- a/.gitignore
+++ b/.gitignore
@@ -18,3 +18,9 @@ tg-import.txt
 tg-remote
 tg-remote.txt
 tg
+tg-next
+tg-next.txt
+tg-prev
+tg-prev.txt
+tg-tsort
+tg-tsort.txt
diff --git a/tg-next.sh b/tg-next.sh
new file mode 100644
index 0000000..8e17226
--- /dev/null
+++ b/tg-next.sh
@@ -0,0 +1,33 @@
+#!/bin/sh
+# TopGit - A different patch queue manager
+# (c) Petr Baudis <pasky@suse.cz>  2008
+# GPLv2
+
+name=
+
+
+## Parse options
+
+while [ -n "$1" ]; do
+	arg="$1"; shift
+	case "$arg" in
+	-*)
+		echo "Usage: tg next [NAME]" >&2
+		exit 1;;
+	*)
+		[ -z "$name" ] || die "name already specified ($name)"
+		name="$arg";;
+	esac
+done
+
+[ -n "$name" ] || name="$(git symbolic-ref HEAD | sed 's#^refs/heads/##')"
+base_rev="$(git rev-parse --short --verify "refs/top-bases/$name" 2>/dev/null)" ||
+	die "not a TopGit-controlled branch"
+
+git for-each-ref --format='%(refname)' refs/top-bases |
+	while read topic; do
+		topic="${topic#refs/top-bases/}"
+		if git show "${topic}":.topdeps 2>/dev/null | grep -q "^${name}\$"; then
+			echo "${topic}"
+		fi
+	done
diff --git a/tg-prev.sh b/tg-prev.sh
new file mode 100644
index 0000000..801fb3e
--- /dev/null
+++ b/tg-prev.sh
@@ -0,0 +1,27 @@
+#!/bin/sh
+# TopGit - A different patch queue manager
+# (c) Petr Baudis <pasky@suse.cz>  2008
+# GPLv2
+
+name=
+
+
+## Parse options
+
+while [ -n "$1" ]; do
+	arg="$1"; shift
+	case "$arg" in
+	-*)
+		echo "Usage: tg next [NAME]" >&2
+		exit 1;;
+	*)
+		[ -z "$name" ] || die "name already specified ($name)"
+		name="$arg";;
+	esac
+done
+
+[ -n "$name" ] || name="$(git symbolic-ref HEAD | sed 's#^refs/heads/##')"
+base_rev="$(git rev-parse --short --verify "refs/top-bases/$name" 2>/dev/null)" ||
+	die "not a TopGit-controlled branch"
+
+git show "$name:.topdeps"
diff --git a/tg-tsort.sh b/tg-tsort.sh
new file mode 100644
index 0000000..8a7376a
--- /dev/null
+++ b/tg-tsort.sh
@@ -0,0 +1,57 @@
+#!/bin/sh
+# TopGit - A different patch queue manager
+# (c) Petr Baudis <pasky@suse.cz>  2008
+# GPLv2
+
+pattern=
+
+## Parse options
+
+while [ -n "$1" ]; do
+	arg="$1"; shift
+	case "$arg" in
+	-*)
+		echo "Usage: tg tsort [PATTERN]" >&2
+		exit 1;;
+	*)
+		[ -z "$pattern" ] || die "pattern already specified ($pattern)"
+		pattern="$arg";;
+	esac
+done
+
+# remove trailing /, they wont work with for-each-ref
+pattern="$(echo "refs/top-bases/$pattern" | sed -re 's#/+$##g')"
+
+name="$(git symbolic-ref HEAD | sed 's#^refs/heads/##')"
+base_rev="$(git rev-parse --short --verify "refs/top-bases/$name" 2>/dev/null)" ||
+	die "not a TopGit-controlled branch"
+
+rev_map="$(mktemp)"
+rev_map_uniq="$(mktemp)"
+rev_map_sed="$(mktemp)"
+tsort_out="$(mktemp)"
+trap 'rm -f "$rev_map" "$rev_map_uniq" "$rev_map_sed" "$tsort_out"' EXIT
+
+(
+	exec 3>"$rev_map"
+	cd "$git_dir"
+	git for-each-ref --format='%(refname)' $pattern |
+		while read topic; do
+			topic="${topic#refs/top-bases/}"
+			topic_rev="$(git rev-parse --verify "${topic}" 2>/dev/null)"
+			printf "%s\t%q\n" "${topic_rev}" "${topic}" >&3
+			git show "${topic}":.topdeps 2>/dev/null |
+				while read dep; do
+					dep_rev="$(git rev-parse --verify "${dep}" 2>/dev/null)"
+					printf "%s\t%q\n" "${dep_rev}" "${dep}" >&3
+					printf "%s\t%s\n" "${topic_rev}" "${dep_rev}"
+				done
+		done
+) | tsort | tac > "$tsort_out"
+
+LC_ALL=C sort "$rev_map" | uniq > "$rev_map_uniq"
+while read sha1 rev; do
+	printf "s#%s#%s#\n" "$sha1" "$rev"
+done < "$rev_map_uniq" > "$rev_map_sed"
+
+sed -f "$rev_map_sed" "$tsort_out"
-- 
tg: (370a0fd..) t/queue-movement (depends on: master)
