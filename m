Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0596DC433F5
	for <git@archiver.kernel.org>; Tue, 14 Dec 2021 15:37:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234664AbhLNPht (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Dec 2021 10:37:49 -0500
Received: from cloud.peff.net ([104.130.231.41]:51690 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234470AbhLNPht (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Dec 2021 10:37:49 -0500
Received: (qmail 14198 invoked by uid 109); 14 Dec 2021 15:37:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 14 Dec 2021 15:37:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25728 invoked by uid 111); 14 Dec 2021 15:37:48 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 14 Dec 2021 10:37:48 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 14 Dec 2021 10:37:47 -0500
From:   Jeff King <peff@peff.net>
To:     Jacob Vosmaer <jacob@gitlab.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/1] upload-pack.c: make output buffer size configurable
Message-ID: <Ybi6SwndUHLs27bO@coredump.intra.peff.net>
References: <20211213132345.26310-1-jacob@gitlab.com>
 <20211213132345.26310-2-jacob@gitlab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211213132345.26310-2-jacob@gitlab.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 13, 2021 at 02:23:45PM +0100, Jacob Vosmaer wrote:

> The current size of the buffer is 8192+1. The '+1' is a technical
> detail orthogonal to this change. On GitLab.com we use GitLab's
> pack-objects cache which does writes of 65515 bytes. Because of the
> default 8KB buffer size, propagating these cache writes requires 8
> pipe reads and 8 pipe writes from git-upload-pack, and 8 pipe reads
> from Gitaly (our Git RPC service). If we increase the size of the
> buffer to the maximum Git packet size, we need only 1 pipe read and 1
> pipe write in git-upload-pack, and 1 pipe read in Gitaly to transfer
> the same amount of data. In benchmarks with a pure fetch and 100%
> cache hit rate workload we are seeing CPU utilization reductions of
> over 30%.

I was curious to reproduce this locally, so I came up with:

  (
    printf "003fwant %s side-band-64k" $(git rev-parse HEAD)
    printf 0000
    echo '0009done'
  ) |
  git -c uploadpack.packobjectsHook='cat objects/pack/pack-*.pack; :' upload-pack . |
  pv >/dev/null

which hackily simulates the server side of your "cached" case. :) I ran
it on a fully-packed clone of linux.git.

It gets about 2.3GB/s with the tip of 'master' and 3.2GB/s with the
equivalent of your patch (using LARGE_PACKET_DATA_MAX). So definitely an
improvement.

Without the cached case (so actually running pack-objects, albeit a
pretty quick one because of bitmaps and pack-reuse), the timings are
about the same (171MB/s versus 174MB/s, but really it's just pegging a
CPU running pack-objects). So it would be fine to just do this
unconditionally, I think.

Looking at strace, the other thing I notice is that we write() the
packet header separately in send_sideband(), which doubles the number of
syscalls. I hackily re-wrote this to use writev() instead (patch below),
but it doesn't seem to actually help much (maybe a curiosity to explore
further, but definitely not something to hold up your patch).

-Peff

---
diff --git a/sideband.c b/sideband.c
index 85bddfdcd4..d0945507a3 100644
--- a/sideband.c
+++ b/sideband.c
@@ -5,6 +5,11 @@
 #include "help.h"
 #include "pkt-line.h"
 
+/* hack; should go in git-compat-util, and should provide compat
+ * wrapper around regular write()
+ */
+#include <sys/uio.h>
+
 struct keyword_entry {
 	/*
 	 * We use keyword as config key so it should be a single alphanumeric word.
@@ -257,6 +262,7 @@ void send_sideband(int fd, int band, const char *data, ssize_t sz, int packet_ma
 
 	while (sz) {
 		unsigned n;
+		struct iovec iov[2];
 		char hdr[5];
 
 		n = sz;
@@ -265,12 +271,17 @@ void send_sideband(int fd, int band, const char *data, ssize_t sz, int packet_ma
 		if (0 <= band) {
 			xsnprintf(hdr, sizeof(hdr), "%04x", n + 5);
 			hdr[4] = band;
-			write_or_die(fd, hdr, 5);
+			iov[0].iov_base = hdr;
+			iov[0].iov_len = 5;
 		} else {
 			xsnprintf(hdr, sizeof(hdr), "%04x", n + 4);
-			write_or_die(fd, hdr, 4);
+			iov[0].iov_base = hdr;
+			iov[0].iov_len = 4;
 		}
-		write_or_die(fd, p, n);
+		iov[1].iov_base = (void *)p;
+		iov[1].iov_len = n;
+		/* should check for errors, but also short writes and EINTR, etc */
+		writev(fd, iov, 2);
 		p += n;
 		sz -= n;
 	}
diff --git a/upload-pack.c b/upload-pack.c
index c78d55bc67..111de8c60c 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -194,7 +194,7 @@ static int write_one_shallow(const struct commit_graft *graft, void *cb_data)
 }
 
 struct output_state {
-	char buffer[8193];
+	char buffer[LARGE_PACKET_DATA_MAX];
 	int used;
 	unsigned packfile_uris_started : 1;
 	unsigned packfile_started : 1;
