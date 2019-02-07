Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 130FD1F453
	for <e@80x24.org>; Thu,  7 Feb 2019 02:00:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbfBGCAZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Feb 2019 21:00:25 -0500
Received: from cloud.peff.net ([104.130.231.41]:35506 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726245AbfBGCAZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Feb 2019 21:00:25 -0500
Received: (qmail 16846 invoked by uid 109); 7 Feb 2019 02:00:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 07 Feb 2019 02:00:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7736 invoked by uid 111); 7 Feb 2019 02:00:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 06 Feb 2019 21:00:33 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 06 Feb 2019 21:00:22 -0500
Date:   Wed, 6 Feb 2019 21:00:22 -0500
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] add_to_index(): convert forgotten HASH_RENORMALIZE check
Message-ID: <20190207020022.GA29974@sigill.intra.peff.net>
References: <nycvar.QRO.7.76.6.1902061123410.41@tvgsbejvaqbjf.bet>
 <20190206104243.GJ10587@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190206104243.GJ10587@szeder.dev>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 06, 2019 at 11:42:43AM +0100, SZEDER Gábor wrote:

> I reported this and Peff looked into it on the way to Git Merge, but
> not working solution yet.
> 
> https://public-inbox.org/git/20190129225121.GD1895@sigill.intra.peff.net/T/#u

Oof. Well, now I know why my attempts to fix the test failed. It was not
my new test that was failing at all, but rather the existing test. Which
implies that I severely bungled the actual code change.

Armed with that knowledge, it was pretty easy to find said bungling. The
fix is below.

Junio, this should go on top of jk/add-ignore-errors-bit-assignment-fix
as soon as possible, as the regression is already in master. And I'll go
find a brown paper bag. ;)

-- >8 --
Subject: [PATCH] add_to_index(): convert forgotten HASH_RENORMALIZE check

Commit 9e5da3d055 (add: use separate ADD_CACHE_RENORMALIZE flag,
2019-01-17) switched out using HASH_RENORMALIZE in our flags field for a
new ADD_CACHE_RENORMALIZE flag. However, it forgot to convert one of the
checks for HASH_RENORMALIZE into the new flag, which totally broke "git
add --renormalize".

To make matters even more confusing, the resulting code would racily
pass the tests!  The forgotten check was responsible for defeating the
up-to-date check of the index entry. That meant that "git add
--renormalize" would refuse to renormalize things that appeared
stat-clean. But most of the time the test commands run fast enough that
the file mtime is the same as the index mtime. And thus we err on the
conservative side and re-hash the file, which is what "--renormalize"
would have wanted.

But if you're unlucky and cross that one-second boundary between writing
the file and writing the index (which is more likely to happen on a slow
or heavily-loaded system), then the file appears stat-clean. And
"--renormalize" would effectively do nothing.

The fix is straightforward: convert this check to use the right flag.

Noticed-by: SZEDER Gábor <szeder.dev@gmail.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 read-cache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/read-cache.c b/read-cache.c
index 9783c493a3..accc059951 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -746,7 +746,7 @@ int add_to_index(struct index_state *istate, const char *path, struct stat *st,
 	if (ignore_case) {
 		adjust_dirname_case(istate, ce->name);
 	}
-	if (!(flags & HASH_RENORMALIZE)) {
+	if (!(flags & ADD_CACHE_RENORMALIZE)) {
 		alias = index_file_exists(istate, ce->name,
 					  ce_namelen(ce), ignore_case);
 		if (alias &&
-- 
2.20.1.1122.g2972e48916

