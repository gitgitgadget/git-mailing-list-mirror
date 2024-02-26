Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2504063B
	for <git@vger.kernel.org>; Mon, 26 Feb 2024 10:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708943252; cv=none; b=HmiUBnu7alz0Bw/2GFQneFl0+6SOPk+MY8hOhUluYwctXd/239cCikOeGoi4QChUQXo57GLvWhDld5VBsNQt3heklW7z7bbAH8T0i+IzsaGB4e3Nd8RJiltoBD5ZjgoN1CJvsWTNvg7wXIxNIZgDld7x0X065bzAnldCEvVgbtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708943252; c=relaxed/simple;
	bh=+GLdpOIj4TxM6tu4hArbBVZz+FXbLInEBui1g6V/ftM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C4TVn54byOTnTQySeaOsstttalKHpayxbBaHdQgWKclDAFvK0zwhyHJiJzgDbKKEaINrzK4kCWRUDZOecu88jTWZP1Z3FOq8pUS7apher7jeaMKE4xw/8LI3NswvtP7TVzJDolC9AI8Lk//Wv3PH4BJU8V9yPubHG5zo2rwei4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 22277 invoked by uid 109); 26 Feb 2024 10:27:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 26 Feb 2024 10:27:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18246 invoked by uid 111); 26 Feb 2024 10:27:34 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 26 Feb 2024 05:27:34 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 26 Feb 2024 05:27:29 -0500
From: Jeff King <peff@peff.net>
To: =?utf-8?B?UGF3ZcWC?= Dominiak <dominiak.pawel@gmail.com>
Cc: git@vger.kernel.org
Subject: [PATCH] userdiff: skip textconv caching when not in a repository
Message-ID: <20240226102729.GB2685773@coredump.intra.peff.net>
References: <CACeVQwQ4MELjB8nZyeu9QDTtgwhhw0oOsL8BHdm_rxTj1vMy+A@mail.gmail.com>
 <20240226072248.GC780982@coredump.intra.peff.net>
 <CACeVQwRkoJejrWvym_BAZE-OWi+q3RZfyEpwAwA+0hGUBCeD=Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACeVQwRkoJejrWvym_BAZE-OWi+q3RZfyEpwAwA+0hGUBCeD=Q@mail.gmail.com>

On Mon, Feb 26, 2024 at 08:56:09AM +0100, Paweł Dominiak wrote:

> But it seems like something git should handle on its own, so that diff
> would accommodate use in different circumstances with the same config.

Yes, definitely. Here's my patch with a commit message and a test.

-- >8 --
Subject: userdiff: skip textconv caching when not in a repository

The textconv caching system uses git-notes to store its cache entries.
But if you're using "diff --no-index" outside of a repository, then
obviously that isn't going to work.

Since caching is just an optimization, it's OK for us to skip it.
However, the current behavior is much worse: we call notes_cache_init()
which tries to look up the ref, and the low-level ref code hits a BUG(),
killing the program. Instead, we should notice before setting up the
cache that it there's no repository, and just silently skip it.

Reported-by: Paweł Dominiak <dominiak.pawel@gmail.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 t/t4042-diff-textconv-caching.sh | 22 ++++++++++++++++++++++
 userdiff.c                       |  4 +++-
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/t/t4042-diff-textconv-caching.sh b/t/t4042-diff-textconv-caching.sh
index bf33aedf4b..8ebfa3c1be 100755
--- a/t/t4042-diff-textconv-caching.sh
+++ b/t/t4042-diff-textconv-caching.sh
@@ -118,4 +118,26 @@ test_expect_success 'log notes cache and still use cache for -p' '
 	git log --no-walk -p refs/notes/textconv/magic HEAD
 '
 
+test_expect_success 'caching is silently ignored outside repo' '
+	mkdir -p non-repo &&
+	echo one >non-repo/one &&
+	echo two >non-repo/two &&
+	echo "* diff=test" >attr &&
+	test_expect_code 1 \
+	nongit git -c core.attributesFile="$PWD/attr" \
+		   -c diff.test.textconv="tr a-z A-Z <" \
+		   -c diff.test.cachetextconv=true \
+		   diff --no-index one two >actual &&
+	cat >expect <<-\EOF &&
+	diff --git a/one b/two
+	index 5626abf..f719efd 100644
+	--- a/one
+	+++ b/two
+	@@ -1 +1 @@
+	-ONE
+	+TWO
+	EOF
+	test_cmp expect actual
+'
+
 test_done
diff --git a/userdiff.c b/userdiff.c
index e399543823..fce3a31efa 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -3,6 +3,7 @@
 #include "userdiff.h"
 #include "attr.h"
 #include "strbuf.h"
+#include "environment.h"
 
 static struct userdiff_driver *drivers;
 static int ndrivers;
@@ -460,7 +461,8 @@ struct userdiff_driver *userdiff_get_textconv(struct repository *r,
 	if (!driver->textconv)
 		return NULL;
 
-	if (driver->textconv_want_cache && !driver->textconv_cache) {
+	if (driver->textconv_want_cache && !driver->textconv_cache &&
+	    have_git_dir()) {
 		struct notes_cache *c = xmalloc(sizeof(*c));
 		struct strbuf name = STRBUF_INIT;
 
-- 
2.44.0.rc2.424.gbdbf4d014b

