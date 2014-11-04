From: Jeff King <peff@peff.net>
Subject: [PATCH 1/2] fetch: load all default config at startup
Date: Tue, 4 Nov 2014 08:11:19 -0500
Message-ID: <20141104131118.GA23608@peff.net>
References: <20141104131006.GA1077@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 04 14:11:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XldtR-0000AD-AE
	for gcvg-git-2@plane.gmane.org; Tue, 04 Nov 2014 14:11:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754126AbaKDNLX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Nov 2014 08:11:23 -0500
Received: from cloud.peff.net ([50.56.180.127]:36638 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751732AbaKDNLV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Nov 2014 08:11:21 -0500
Received: (qmail 25612 invoked by uid 102); 4 Nov 2014 13:11:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 04 Nov 2014 07:11:19 -0600
Received: (qmail 17720 invoked by uid 107); 4 Nov 2014 13:11:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 04 Nov 2014 08:11:26 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 04 Nov 2014 08:11:19 -0500
Content-Disposition: inline
In-Reply-To: <20141104131006.GA1077@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we start the git-fetch program, we call git_config to
load all config, but our callback only processes the
fetch.prune option; we do not chain to git_default_config at
all.

This means that we may not load some core configuration
which will have an effect. For instance, we do not load
core.logAllRefUpdates, which impacts whether or not we
create reflogs in a bare repository.

Note that I said "may" above. It gets even more exciting. If
we have to transfer actual objects as part of the fetch,
then we call fetch_pack as part of the same process. That
function loads its own config, which does chain to
git_default_config, impacting global variables which are
used by the rest of fetch. But if the fetch is a pure ref
update (e.g., a new ref which is a copy of an old one), we
skip fetch_pack entirely. So we get inconsistent results
depending on whether or not we have actual objects to
transfer or not!

Let's just load the core config at the start of fetch, so we
know we have it (we may also load it again as part of
fetch_pack, but that's OK; it's designed to be idempotent).

Our tests check both cases (with and without a pack). We
also check similar behavior for push for good measure, but
it already works as expected.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/fetch.c       |  2 +-
 t/t5516-fetch-push.sh | 40 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 6ffd023..7b84d35 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -68,7 +68,7 @@ static int git_fetch_config(const char *k, const char *v, void *cb)
 		fetch_prune_config = git_config_bool(k, v);
 		return 0;
 	}
-	return 0;
+	return git_default_config(k, v, cb);
 }
 
 static int parse_refmap_arg(const struct option *opt, const char *arg, int unset)
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 7c8a769..f4da20a 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -11,6 +11,7 @@ This test checks the following functionality:
 * hooks
 * --porcelain output format
 * hiderefs
+* reflogs
 '
 
 . ./test-lib.sh
@@ -1290,4 +1291,43 @@ test_expect_success 'pushing a tag pushes the tagged object' '
 	test_cmp expect actual
 '
 
+test_expect_success 'push into bare respects core.logallrefupdates' '
+	rm -rf dst.git &&
+	git init --bare dst.git &&
+	git -C dst.git config core.logallrefupdates true &&
+
+	# double push to test both with and without
+	# the actual pack transfer
+	git push dst.git master:one &&
+	echo "one@{0} push" >expect &&
+	git -C dst.git log -g --format="%gd %gs" one >actual &&
+	test_cmp expect actual &&
+
+	git push dst.git master:two &&
+	echo "two@{0} push" >expect &&
+	git -C dst.git log -g --format="%gd %gs" two >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'fetch into bare respects core.logallrefupdates' '
+	rm -rf dst.git &&
+	git init --bare dst.git &&
+	(
+		cd dst.git &&
+		git config core.logallrefupdates true &&
+
+		# as above, we double-fetch to test both
+		# with and without pack transfer
+		git fetch .. master:one &&
+		echo "one@{0} fetch .. master:one: storing head" >expect &&
+		git log -g --format="%gd %gs" one >actual &&
+		test_cmp expect actual &&
+
+		git fetch .. master:two &&
+		echo "two@{0} fetch .. master:two: storing head" >expect &&
+		git log -g --format="%gd %gs" two >actual &&
+		test_cmp expect actual
+	)
+'
+
 test_done
-- 
2.1.2.596.g7379948
