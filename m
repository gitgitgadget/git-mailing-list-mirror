Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A1181FC44
	for <e@80x24.org>; Tue, 14 Feb 2017 06:07:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751950AbdBNGHc (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Feb 2017 01:07:32 -0500
Received: from cloud.peff.net ([104.130.231.41]:54896 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751324AbdBNGHc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2017 01:07:32 -0500
Received: (qmail 12027 invoked by uid 109); 14 Feb 2017 06:07:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 14 Feb 2017 06:07:32 +0000
Received: (qmail 763 invoked by uid 111); 14 Feb 2017 06:07:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 14 Feb 2017 01:07:32 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 14 Feb 2017 01:07:29 -0500
Date:   Tue, 14 Feb 2017 01:07:29 -0500
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: [PATCH 6/7] grep: avoid resolving revision names in --no-index case
Message-ID: <20170214060729.v4r24y5tuaov3jrh@sigill.intra.peff.net>
References: <20170214060021.einv7372exbxa23z@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170214060021.einv7372exbxa23z@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We disallow the use of revisions with --no-index, but we
don't actually check and complain until well after we've
parsed the revisions.

This is the cause of a few problems:

 1. We shouldn't be calling get_sha1() at all when we aren't
    in a repository, as it might access the ref or object
    databases. For now, this should generally just return
    failure, but eventually it will become a BUG().

 2. When there's a "--" disambiguator and you're outside a
    repository, we'll complain early with "unable to resolve
    revision". But we can give a much more specific error.

 3. When there isn't a "--" disambiguator, we still do the
    normal rev/path checks. This is silly, as we know we
    cannot have any revs with --no-index. Everything we see
    must be a path.

    Outside of a repository this doesn't matter (since we
    know it won't resolve), but inside one, we may complain
    unnecessarily if a filename happens to also match a
    refname.

This patch skips the get_sha1() call entirely in the
no-index case, and behaves as if it failed (with the
exception of giving a better error message).

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/grep.c  |  6 ++++++
 t/t7810-grep.sh | 13 +++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/builtin/grep.c b/builtin/grep.c
index e83b33bda..c4c632594 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -1176,6 +1176,12 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 			break;
 		}
 
+		if (!use_index) {
+			if (seen_dashdash)
+				die(_("--no-index cannot be used with revs"));
+			break;
+		}
+
 		if (get_sha1_with_context(arg, 0, sha1, &oc)) {
 			if (seen_dashdash)
 				die(_("unable to resolve revision: %s"), arg);
diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index a6011f9b1..c051c7ee8 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -1030,6 +1030,19 @@ test_expect_success 'grep --no-index pattern -- path' '
 	)
 '
 
+test_expect_success 'grep --no-index complains of revs' '
+	test_must_fail git grep --no-index o master -- 2>err &&
+	test_i18ngrep "no-index cannot be used with revs" err
+'
+
+test_expect_success 'grep --no-index prefers paths to revs' '
+	test_when_finished "rm -f master" &&
+	echo content >master &&
+	echo master:content >expect &&
+	git grep --no-index o master >actual &&
+	test_cmp expect actual
+'
+
 cat >expected <<EOF
 hello.c:int main(int argc, const char **argv)
 hello.c:	printf("Hello world.\n");
-- 
2.12.0.rc1.471.ga79ec8999

