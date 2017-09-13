Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D9A7320286
	for <e@80x24.org>; Wed, 13 Sep 2017 18:15:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751500AbdIMSPU (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Sep 2017 14:15:20 -0400
Received: from cloud.peff.net ([104.130.231.41]:37380 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751484AbdIMSPS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Sep 2017 14:15:18 -0400
Received: (qmail 26882 invoked by uid 109); 13 Sep 2017 18:15:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 13 Sep 2017 18:15:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18304 invoked by uid 111); 13 Sep 2017 18:15:53 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 13 Sep 2017 14:15:53 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 13 Sep 2017 14:15:16 -0400
Date:   Wed, 13 Sep 2017 14:15:16 -0400
From:   Jeff King <peff@peff.net>
To:     demerphq <demerphq@gmail.com>
Cc:     Git <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: [PATCH v2] config: avoid "write_in_full(fd, buf, len) < len" pattern
Message-ID: <20170913181515.p7u2ouine3ysblqc@sigill.intra.peff.net>
References: <20170913170807.cyx7rrpoyhaauvol@sigill.intra.peff.net>
 <20170913171104.yu7ags4aq2zdwz6r@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170913171104.yu7ags4aq2zdwz6r@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 13, 2017 at 01:11:04PM -0400, Jeff King wrote:

> I scoured the code base for cases of this, but it turns out
> that these two in git_config_set_multivar_in_file_gently()
> are the only ones. This case is actually quite interesting:
> we don't have a size_t, but rather use the subtraction of
> two pointers. Which you might think would be a signed
> ptrdiff_t, but clearly both gcc and clang treat it as
> unsigned (possibly because the conditional just above
> guarantees that the result is greater than zero).

Sorry, this is totally wrong. As Jonathan pointed out (and as I was
puzzled over here), the result of a pointer subtraction _is_ a signed
type, and works fine.

What I missed is that copy_begin and copy_end here are actually size_t
variables, not the pointers. Sorry for the confusion, and here's an
updated version of the patch with this paragraph amended (the patch
itself is identical):

-- >8 --
Subject: [PATCH] config: avoid "write_in_full(fd, buf, len) < len" pattern

The return type of write_in_full() is a signed ssize_t,
because we may return "-1" on failure (even if we succeeded
in writing some bytes). But "len" itself is may be an
unsigned type (the function takes a size_t, but of course we
may have something else in the calling function). So while
it seems like:

  if (write_in_full(fd, buf, len) < len)
	die_errno("write error");

would trigger on error, it won't if "len" is unsigned.  The
compiler sees a signed/unsigned comparison and promotes the
signed value, resulting in (size_t)-1, the highest possible
size_t (or again, whatever type the caller has). This cannot
possibly be smaller than "len", and so the conditional can
never trigger.

I scoured the code base for cases of this, but it turns out
that these two in git_config_set_multivar_in_file_gently()
are the only ones. Here our "len" is the difference between
two size_t variables, making the result an unsigned size_t.
We can fix this by just checking for a negative return value
directly, as write_in_full() will never return any value
except -1 or the full count.

There's no addition to the test suite here, since you need
to convince write() to fail in order to see the problem. The
simplest reproduction recipe I came up with is to trigger
ENOSPC:

  # make a limited-size filesystem
  dd if=/dev/zero of=small.disk bs=1M count=1
  mke2fs small.disk
  mkdir mnt
  sudo mount -o loop small.disk mnt
  cd mnt
  sudo chown $USER:$USER .

  # make a config file with some content
  git config --file=config one.key value
  git config --file=config two.key value

  # now fill up the disk
  dd if=/dev/zero of=fill

  # and try to delete a key, which requires copying the rest
  # of the file to config.lock, and will fail on write()
  git config --file=config --unset two.key

That final command should (and does after this patch)
produce an error message due to the failed write, and leave
the file intact. Instead, it silently ignores the failure
and renames config.lock into place, leaving you with a
totally empty config file!

Reported-by: demerphq <demerphq@gmail.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 config.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/config.c b/config.c
index d0d8ce823a..eee4ac0355 100644
--- a/config.c
+++ b/config.c
@@ -2608,8 +2608,7 @@ int git_config_set_multivar_in_file_gently(const char *config_filename,
 			/* write the first part of the config */
 			if (copy_end > copy_begin) {
 				if (write_in_full(fd, contents + copy_begin,
-						  copy_end - copy_begin) <
-				    copy_end - copy_begin)
+						  copy_end - copy_begin) < 0)
 					goto write_err_out;
 				if (new_line &&
 				    write_str_in_full(fd, "\n") != 1)
@@ -2631,8 +2630,7 @@ int git_config_set_multivar_in_file_gently(const char *config_filename,
 		/* write the rest of the config */
 		if (copy_begin < contents_sz)
 			if (write_in_full(fd, contents + copy_begin,
-					  contents_sz - copy_begin) <
-			    contents_sz - copy_begin)
+					  contents_sz - copy_begin) < 0)
 				goto write_err_out;
 
 		munmap(contents, contents_sz);
-- 
2.14.1.874.ge7b2e05270

