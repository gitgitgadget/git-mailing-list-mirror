Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 877AB1F89C
	for <e@80x24.org>; Tue, 24 Jan 2017 13:28:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750909AbdAXN1x (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Jan 2017 08:27:53 -0500
Received: from cloud.peff.net ([104.130.231.41]:43781 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750848AbdAXN1w (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jan 2017 08:27:52 -0500
Received: (qmail 5990 invoked by uid 109); 24 Jan 2017 13:27:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 24 Jan 2017 13:27:51 +0000
Received: (qmail 24614 invoked by uid 111); 24 Jan 2017 13:27:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 24 Jan 2017 08:27:51 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 24 Jan 2017 08:27:49 -0500
Date:   Tue, 24 Jan 2017 08:27:49 -0500
From:   Jeff King <peff@peff.net>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Jan 2017, #04; Mon, 23)
Message-ID: <20170124132749.l3ezupyitvxe4t2l@sigill.intra.peff.net>
References: <xmqqo9yxpaxk.fsf@gitster.mtv.corp.google.com>
 <0D956B23-E655-4C28-A205-14CCC0A7DEA2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0D956B23-E655-4C28-A205-14CCC0A7DEA2@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 24, 2017 at 11:04:21AM +0100, Lars Schneider wrote:

> "fsck: prepare dummy objects for --connectivity-check" seems to
> make t1450-fsck.sh fail on macOS with TravisCI:
> 
> Initialized empty Git repository in /Users/travis/build/git/git/t/trash directory.t1450-fsck/connectivity-only/.git/
> [master (root-commit) 86520b7] empty
>  Author: A U Thor <author@example.com>
>  2 files changed, 1 insertion(+)
>  create mode 100644 empty
>  create mode 100644 empty.t
> override r--r--r--  travis/staff for .git/objects/e6/9de29bb2d1d6434b8b29ae775ad8c2e48c5391? (y/n [n]) not overwritten
> dangling blob c21c9352f7526e9576892a6631e0e8cf1fccd34d

Looks like "mv" prompts and then fails to move the file (so we get the
dangling blob for the source blob, and fsck doesn't report failure because
we didn't actually corrupt the destination blob).

If I'm understanding the behavior correctly, this violates POSIX, which
says:

  1. If the destination path exists, the −f option is not specified, and
     either of the following conditions is true:

     a. The permissions of the destination path do not permit writing
     and the standard input is a terminal.

     b. The −i option is specified.

     the mv utility shall write a prompt to standard error and read a
     line from standard input. If the response is not affirmative,
     mv shall do nothing more with the current source_file and go on
     to any remaining source_files.

Our stdin isn't a terminal, and we do not specify "-i", so I think it
shouldn't prompt.  It also exits with code 0 after failing to move,
which is another surprise.

Here's a patch (tested by me that it works on Linux, but I don't know
for sure that it fixes the Travis problem).

-- >8 --
Subject: [PATCH] t1450: use "mv -f" within loose object directory

The loose objects are created with mode 0444. That doesn't
prevent them being overwritten by rename(), but some
versions of "mv" will be extra careful and prompt the user,
even without "-i".

Reportedly macOS does this, at least in the Travis builds.
The prompt reads from /dev/null, defaulting to "no", and the
object isn't moved. Then to make matters even more
interesting, it still returns "0" and the rest of the test
proceeds, but with a broken setup.

We can work around it by using "mv -f" to override the
prompt. This should work as it's already used in t5504 for
the same purpose.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t1450-fsck.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index efaf41b68..33a51c9a6 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -536,7 +536,7 @@ test_expect_success 'fsck --connectivity-only' '
 		# free to examine the type if it chooses.
 		empty=.git/objects/e6/9de29bb2d1d6434b8b29ae775ad8c2e48c5391 &&
 		blob=$(echo unrelated | git hash-object -w --stdin) &&
-		mv $(sha1_file $blob) $empty &&
+		mv -f $(sha1_file $blob) $empty &&
 
 		test_must_fail git fsck --strict &&
 		git fsck --strict --connectivity-only &&
-- 
2.11.0.840.gd37c5973a

