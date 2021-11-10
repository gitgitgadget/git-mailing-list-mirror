Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFC4DC433F5
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 06:00:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A43EF6113E
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 06:00:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbhKJGDf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Nov 2021 01:03:35 -0500
Received: from cloud.peff.net ([104.130.231.41]:56392 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229717AbhKJGDf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Nov 2021 01:03:35 -0500
Received: (qmail 26565 invoked by uid 109); 10 Nov 2021 06:00:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 10 Nov 2021 06:00:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10016 invoked by uid 111); 10 Nov 2021 06:00:49 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 10 Nov 2021 01:00:49 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 10 Nov 2021 01:00:47 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Fabian Stelzer <fs@gigacodes.de>, git@vger.kernel.org,
        git-packagers@googlegroups.com
Subject: Re: [ANNOUNCE] Git v2.34.0-rc2
Message-ID: <YYtgD8VT/0vuIHRX@coredump.intra.peff.net>
References: <xmqq4k8kzuz2.fsf@gitster.g>
 <YYtbdkLsCSFFE5io@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YYtbdkLsCSFFE5io@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 10, 2021 at 12:41:11AM -0500, Jeff King wrote:

> So it may not be a bug we need to fix in Git. But shipping v2.34 with
> lots of test failures may cause some headaches. Maybe we need to tighten
> up the GPGSSH prereq checks to block broken versions?

This is what I came up with, but I'm not sure it there's a better way to
find the broken version. I don't think there's a way to get a version
number out of ssh-keygen (and anyway, checking the behavior of the
command is a more robust test). My fears are:

  - this does cause several segfaults per test run on affected
    platforms, which will pollute the kernel log, etc.

  - we're not really testing the desired behavior, just looking for a
    known-problem. The segfault may get fixed but we'd still have other
    bugs.

So it would be nice to have a more exact test, but without understanding
the openssh bug, I think this is the best we can do in the meantime.

-- >8 --
Subject: [PATCH] t/lib-gpg: avoid broken versions of ssh-keygen

The "-Y find-principals" option of ssh-keygen seems to be broken in
Debian's openssh-client 1:8.7p1-1, whereas it works fine in 1:8.4p1-5.
This causes several failures for GPGSSH tests. We fulfill the
prerequisite because generating the keys works fine, but actually
verifying a signature causes results ranging from bogus results to
ssh-keygen segfaulting.

We can find the broken version during the prereq check by feeding it
empty input. This should result in it complaining to stderr, but in the
broken version it triggers the segfault, causing the GPGSSH tests to be
skipped.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/lib-gpg.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/t/lib-gpg.sh b/t/lib-gpg.sh
index 1d8e5b5b7e..a3f285f515 100644
--- a/t/lib-gpg.sh
+++ b/t/lib-gpg.sh
@@ -104,6 +104,12 @@ test_lazy_prereq GPGSSH '
 	test $? != 127 || exit 1
 	echo $ssh_version | grep -q "find-principals:missing signature file"
 	test $? = 0 || exit 1;
+
+	# some broken versions of ssh-keygen segfault on find-principals;
+	# avoid testing with them.
+	ssh-keygen -Y find-principals -f /dev/null -s /dev/null
+	test $? = 139 && exit 1
+
 	mkdir -p "${GNUPGHOME}" &&
 	chmod 0700 "${GNUPGHOME}" &&
 	(setfacl -k "${GNUPGHOME}" 2>/dev/null || true) &&
-- 
2.34.0.rc1.634.g85d556ea55

