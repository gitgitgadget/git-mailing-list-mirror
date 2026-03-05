Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C68A1D6DA9
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 00:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772671076; cv=none; b=qNmEZ2EySdYSnwrhGTR+z6lR+kFnB0bCix1juJqeZCudmLhjHGKc/AHv0eH6o5wJ4m+zDXL/g7ky8vfKj2a5LbUshf3MT9n1BBxncTrWw4bG5cRgE+MCnGRBRZPYTWluPmzpBlIdcDcuYHxuuNFp6lJ05yKNdlQcMM027rPajak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772671076; c=relaxed/simple;
	bh=wS48f3PjRMdnzvJJUe2jPq1SsAycGRQd4M6LmRqunH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kyCwiTNcLqgiyUMbph+HM/4K2SRdSqTfsIdnHi3/9Riff1fvRlCz89E3mZn5zVfBdeb4r0MPFQoK9Y99WciB1PHJl2FxTQLFFFFcRBaQF6FG6qKk+75kXcYKGij4HbVwttKPY+ARThKHKRyVmeUGLNC/qY9kNteRca/swghkxoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=QLiQecCw; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="QLiQecCw"
Received: (qmail 1643 invoked by uid 106); 5 Mar 2026 00:37:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=wS48f3PjRMdnzvJJUe2jPq1SsAycGRQd4M6LmRqunH0=; b=QLiQecCwOAq//wrd0wMSic8CtuDWujBIvU4avhvl+wK3M3YL6MBursvKNrN0h7p8KENnpZMbGKQZzvmJiDYt1n7rklHzFOwzMO6w1GLWdbnetSkhC57AXZY+x/TtX2Wuzd0JPBOgQczbNukYPUKu9QfDSmwY02Ly2hTa83qHUziYdBsqsUkXvlgoDhRXcNH/tHgWUNvk+f5/OPtJtoPYKATsugnLPwINVF1w4ttMBQxCmASl+sfVCJNtl0X55sqjIrGh+DrEkq2MOszIx3wwJm15P/xxXZWK3w9VewVxsuiY3Ucd6NCrdoJNWIB8aGsNH9VFKaqXYbVYAjJ7VFGokg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 05 Mar 2026 00:37:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 375719 invoked by uid 111); 5 Mar 2026 00:37:47 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 04 Mar 2026 19:37:47 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 4 Mar 2026 19:37:45 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	Matt Smiley <msmiley@gitlab.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 05/10] compat/posix: introduce writev(3p) wrapper
Message-ID: <20260305003745.GA4943@coredump.intra.peff.net>
References: <20260303-pks-upload-pack-write-contention-v2-0-7321830f08fe@pks.im>
 <20260303-pks-upload-pack-write-contention-v2-5-7321830f08fe@pks.im>
 <xmqqseaf5k5t.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqseaf5k5t.fsf@gitster.g>

On Wed, Mar 04, 2026 at 02:01:18PM -0800, Junio C Hamano wrote:

> Because we do not check the accumulation of bytes_written in the two
> accumulator variables inside the inner loop, it is very possible for
> total_written to wraparound size_t and end up below the largest
> value possible to be stored in ssize_t type.

Coverity complained about it, too.

> IOW, the cast_size_t_to_ssize_t() introduced in the previous step is
> pointless, isn't it?
> 
> According to [*1*], the real
> 
>     ssize_t writev(int fd, const struct iovec *iov, int iovcnt)
> 
> is supposed to report error with errno set to EINVAL when the sum of
> iov_len member of the iov[] array elements exceed half of the
> maximum size_t.
> 
>        EINVAL The sum of the iov_len values overflows an ssize_t value.
> 
> So instead of dying with cast_size_t_to_ssize_t(), we probably would
> want the check done in a more stupid and straight-forward way?
> Adding up iov[i].iov_len while the addition would not wraparound in
> each and every step, and return error with EINVAL before attempting
> even a single call to xwrite(), and then have the above double loop
> that does not care about integer wraparound at all, and return
> total_written with simple cast to (ssize_t)?

I like that writev() can work as a drop-in replacement for write() at
the lowest level. But given that our main use is likely to be pkt-lines,
I do kind of wonder if we should just try to be more clever in forming
our buffers. That makes all of the portability and compat questions go
away (and gives the benefit to platforms that don't even have writev).

E.g., the somewhat ugly patch below is enough to do single write()s for
the pack data in upload-pack. I think if the pkt-writing API were less
ad-hoc (and had an actual buffer in "struct packet_writer"), this could
be made a bit more universal.

diff --git a/upload-pack.c b/upload-pack.c
index 1b1c81ea63..d01b547b10 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -179,11 +179,32 @@ static void reset_timeout(unsigned int timeout)
 	alarm(timeout);
 }
 
-static void send_client_data(int fd, const char *data, ssize_t sz,
-			     int use_sideband)
+#define send_client_data(fd, data, sz, use_sideband) \
+	send_client_data_1((fd), (data), (sz), (use_sideband), NULL)
+static void send_client_data_1(int fd, const char *data, ssize_t sz,
+			       int use_sideband, char *hdr_buf)
 {
 	if (use_sideband) {
-		send_sideband(1, fd, data, sz, use_sideband);
+		/*
+		 * If we don't have a contiguous header buf, or if the data is
+		 * too big for a single packet (which I don't think happens
+		 * with any of our current callers), bail to the old-style
+		 * send_sideband.
+		 */
+		if (!hdr_buf || sz > LARGE_PACKET_DATA_MAX - 1) {
+			send_sideband(1, fd, data, sz, use_sideband);
+			return;
+		}
+
+		if (hdr_buf + 5 != data)
+			BUG("hdr_buf should be contiguous with pkt data");
+
+		if (use_sideband < 0)
+			BUG("negative sideband!?");
+
+		set_packet_header(hdr_buf, sz + 5);
+		hdr_buf[4] = 1; /* sideband 1 */
+		write_or_die(fd, hdr_buf, sz + 5);
 		return;
 	}
 	if (fd == 3)
@@ -211,7 +232,14 @@ struct output_state {
 	 * sideband-64k the band designator takes up 1 byte of space. Because
 	 * relay_pack_data keeps the last byte to itself, we make the buffer 1
 	 * byte bigger than the intended maximum write size.
+	 *
+	 * However, we also reserve 5 bytes before the buffer so we can format
+	 * a packet header and send it with a single write(). We may be pushing
+	 * our luck on assuming there will be no padding here (though we do
+	 * check it with a BUG(), but there are other ways to write it
+	 * (e.g., a single large buffer with "buffer" as a pointer into it).
 	 */
+	char hdr[5];
 	char buffer[(LARGE_PACKET_DATA_MAX - 1) + 1];
 	int used;
 	unsigned packfile_uris_started : 1;
@@ -284,7 +312,7 @@ static int relay_pack_data(int pack_objects_out, struct output_state *os,
 		return readsz;
 
 	if (os->used > 1) {
-		send_client_data(1, os->buffer, os->used - 1, use_sideband);
+		send_client_data_1(1, os->buffer, os->used - 1, use_sideband, os->hdr);
 		os->buffer[0] = os->buffer[os->used - 1];
 		os->used = 1;
 	} else {

-Peff
