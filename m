Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A5962207EC
	for <e@80x24.org>; Fri, 30 Sep 2016 19:36:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932311AbcI3TgI (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Sep 2016 15:36:08 -0400
Received: from cloud.peff.net ([104.130.231.41]:50597 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751635AbcI3TgH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2016 15:36:07 -0400
Received: (qmail 31169 invoked by uid 109); 30 Sep 2016 19:36:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 30 Sep 2016 19:36:07 +0000
Received: (qmail 13451 invoked by uid 111); 30 Sep 2016 19:36:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 30 Sep 2016 15:36:22 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 30 Sep 2016 15:36:05 -0400
Date:   Fri, 30 Sep 2016 15:36:05 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     David Turner <dturner@twosigma.com>
Subject: [PATCH 2/6] sha1_file: always allow relative paths to alternates
Message-ID: <20160930193604.hqspizasfpqa6bez@sigill.intra.peff.net>
References: <20160930193533.ynbepaago6oycg5t@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160930193533.ynbepaago6oycg5t@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We recursively expand alternates repositories, so that if A
borrows from B which borrows from C, A can see all objects.

For the root object database, we allow relative paths, so A
can point to B as "../B/objects". However, we currently do
not allow relative paths when recursing, so B must use an
absolute path to reach C.

That is an ancient protection from c2f493a (Transitively
read alternatives, 2006-05-07) that tries to avoid adding
the same alternate through two different paths. But since
5bdf0a8 (sha1_file: normalize alt_odb path before comparing
and storing, 2011-09-07), we use a normalized absolute path
for each alt_odb entry.

So this protection is no longer necessary; we will detect
the duplicate no matter how we got there.  And it's a good
idea to get rid of it, as it creates an unnecessary
complication when setting up recursive alternates (B has to
know that A is going to borrow from it and make sure to use
an absolute path).

We adjust the test script here to demonstrate that this now
works. Unfortunately, we can't demonstrate that the
duplicate is suppressed, since it has no user-visible
behavior (it's just one less place for our object lookups to
go). But you can verify it manually via gdb, with something
like:

    for i in a b c; do
            git init --bare $i
            blob=$(echo $i | git -C $i hash-object -w --stdin)
    done
    echo "../../b/objects" >a/objects/info/alternates
    echo "../../c/objects" >>a/objects/info/alternates
    echo "../../c/objects" >b/objects/info/alternates
    gdb --args git cat-file -e $blob

After prepare_alt_odb() runs, we have only a single copy of
"/path/to/c/objects/" in the alt_odb list.

Signed-off-by: Jeff King <peff@peff.net>
---
 sha1_file.c               | 7 +------
 t/t5613-info-alternate.sh | 4 ++--
 2 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index b9c1fa3..9a79c19 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -343,12 +343,7 @@ static void link_alt_odb_entries(const char *alt, int len, int sep,
 		const char *entry = entries.items[i].string;
 		if (entry[0] == '\0' || entry[0] == '#')
 			continue;
-		if (!is_absolute_path(entry) && depth) {
-			error("%s: ignoring relative alternate object store %s",
-					relative_base, entry);
-		} else {
-			link_alt_odb_entry(entry, relative_base, depth, objdirbuf.buf);
-		}
+		link_alt_odb_entry(entry, relative_base, depth, objdirbuf.buf);
 	}
 	string_list_clear(&entries, 0);
 	free(alt_copy);
diff --git a/t/t5613-info-alternate.sh b/t/t5613-info-alternate.sh
index 9cd2626..b429707 100755
--- a/t/t5613-info-alternate.sh
+++ b/t/t5613-info-alternate.sh
@@ -102,9 +102,9 @@ test_valid_repo'
 cd "$base_dir"
 
 test_expect_success \
-    'that relative alternate is only possible for current dir' '
+    'that relative alternate is recursive' '
     cd D &&
-    ! (test_valid_repo)
+    test_valid_repo
 '
 
 cd "$base_dir"
-- 
2.10.0.618.g82cc264

