Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46454C433EF
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 05:45:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DF5863219
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 05:45:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236154AbhKPFsI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Nov 2021 00:48:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236211AbhKPFrn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Nov 2021 00:47:43 -0500
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F802C0431A3
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 19:35:49 -0800 (PST)
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id C8CDE5B466
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 03:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1637033748;
        bh=34AFOgQNSV+PkwQJTKFLhrvpqXv112kKqnjqPDpuHVs=;
        h=From:To:Subject:Date:From:Reply-To:Subject:Date:To:CC:Resent-Date:
         Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=veI4hlUPTZdvY53LAshrrnj3UybipOZvrQM7aG0smQbElwGL9D3YWgCnRpYjM5I6B
         Z2xSbjl4oSdfSDoaDZGVphuypv8u/m8cEayFLTRVHvMEU2pW5nj0epU1Bdnm3rtRs8
         KzMAPTvfB2cXKpLOUp8ztT6CGnwgEgVJWgH69bZNzqZCODmivVDBKI9h81/+Oa1mKi
         r36JdF6Xetd5unMg2mO3IM1CNjsuDqOunk4i2xVQdfwFqK/253cgMwaLcXAsW1lWE9
         n8nDkUEruZFkaT7C1fYZU9LJxRJlSJMP6kOKkQ0F9Pk253j1JXZnURUT9WUFFvkTEs
         bxV2Knv+fUv12ZXDtI1NtPnhHRy+vNiSwqlThlSH/p93JSL0f0hB3L8+c6cq/TM7L2
         A6uIieM3thAGqvmAGnQSu3C0de7GS2QGGnaS/xvBC/Yi1URHb72OwRTLYDeWzFI6fs
         xkNb18z2U5hC2c3x792VgWE9RlVK+0aOUWwk8HK5Y/QgqcRcfIW
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Subject: [PATCH 0/2] Generate temporary files using a CSPRNG
Date:   Tue, 16 Nov 2021 03:35:40 +0000
Message-Id: <20211116033542.3247094-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.33.1.1089.g2158813163f
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, when we generate a temporary file name, we use the seconds,
microseconds, and the PID to generate a unique value.  The resulting
value, while changing frequently, is actually predictable and on some
systems, it may be possible to cause a DoS by creating all potential
temporary files when the temporary file is being created in TMPDIR.

The solution to this is to use the system CSPRNG to generate the
temporary file name.  This is the approach taken by FreeBSD, NetBSD, and
OpenBSD, and glibc also recently switched to this approach from an
approach that resembled ours in many ways.

Even if this is not practically exploitable on many systems, it seems
prudent to be at least as careful about temporary file generation as
libc is.

This issue was mentioned on the security list and it was decided that
this was not sensitive enough to warrant a coordinated disclosure, a
sentiment with which I agree.  This is difficult to exploit on most
systems, but I think it's still worth fixing.

This series introduces two commits.  The first implements a generic
function which calls the system CSPRNG.  A reasonably exhaustive attempt
is made to pick from the options with a preference for performance.  The
second changes our temporary file code to use the CSPRNG.

I have added a test helper that can emit bytes from the CSPRNG, as well
as a self-test mode.  The former is not used, but I anticipated it could
find utility in the testsuite, and it was useful for testing by hand, so
I included it.

The careful reader will notice that the sole additional test is added to
t0000.  That's because temporary file generation is fundamental to how
Git operates and if it fails, the entire testsuite is broken.  Thus, a
simple test to verify that it's working seems prudent as part of t0000.
I was also unable to find a better place to put it, but am open to
suggestions if folks have ideas.

This passes our CI, including on Windows, and I have manually verified
the correctness of the other four branches on Linux (the HAVE_ARC4RANDOM
branch requiring a small patch which is not necessary on systems which
have it in libc and which is therefore not included here).

I am of course interested in hearing from anyone who lacks one of the
CSPRNG interfaces we have here.  Looking at the Go standard library,
/dev/urandom should be available on at least AIX, Darwin (macOS),
DragonflyBSD, FreeBSD, Linux, NetBSD, OpenBSD, and Solaris, and I
believe it is available on most other Unix systems as well.
RtlGenRandom is available on Windows back to XP, which we no longer
support.  The bizarre header contortion on Windows comes from Mozilla,
but is widely used in other codebases with no substantial changes.

For those who are interested, I computed the probability of spurious
failure for the self-test mode like so:

  256 * (255/256)^65536

This Ruby one-liner estimates the probability at approximately 10^-108:

  ruby -e 'a = 255 ** 65536; b = 256 ** 65536; puts b.to_s.length - a.to_s.length - 3'

If I have made an error in the calculation, please do feel free to point
it out.

brian m. carlson (2):
  wrapper: add a helper to generate numbers from a CSPRNG
  wrapper: use a CSPRNG to generate random file names

 Makefile                            | 25 ++++++++++
 compat/winansi.c                    |  6 +++
 config.mak.uname                    |  9 ++++
 contrib/buildsystems/CMakeLists.txt |  2 +-
 git-compat-util.h                   | 16 +++++++
 t/helper/test-csprng.c              | 63 +++++++++++++++++++++++++
 t/helper/test-tool.c                |  1 +
 t/helper/test-tool.h                |  1 +
 t/t0000-basic.sh                    |  4 ++
 wrapper.c                           | 71 ++++++++++++++++++++++++-----
 10 files changed, 186 insertions(+), 12 deletions(-)
 create mode 100644 t/helper/test-csprng.c

