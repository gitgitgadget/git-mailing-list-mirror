Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0632D345736
	for <git@vger.kernel.org>; Fri, 27 Feb 2026 19:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772221092; cv=none; b=EO7PnVlRaNy2yy+gvNpRdLU8cRPbby3jiDYzPBhw+Jc+DtwzHIcjjFjLawoBvJ9Tu05IfRXseNFe79TWCEH7QTqlXIUuwU9iD1pLTfmHlJfNRn6Q0YR2yjHYBUwZuzjIkITB6KPKXj+t71DSCi3lqtwtM1saC5TYyMa/Cpxtl6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772221092; c=relaxed/simple;
	bh=SzOCVSCArREbE65HlQgCuR5UjDSfKrZueqaPuFdfOXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=La+SlCWR5HoDAuUeT6PNl1er0i1ua+4EKxNzzd6xVOQzD4jZ2DfXRxEEJI9cFc592LOJd85m+phWr0Tqz0z58ynesYcWewbdQHHIOfwwg7ctUkI1GYaNXYOOSUOLqk/ohVw5CwYyRJJ+nd67J+qZaKrTYEHfXo/y6OGNMM7YEoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=bRVou2z2; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="bRVou2z2"
Received: (qmail 80876 invoked by uid 109); 27 Feb 2026 19:38:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=SzOCVSCArREbE65HlQgCuR5UjDSfKrZueqaPuFdfOXk=; b=bRVou2z2u8K1e137qo8E6xI4Ek0A8ip7Lm94ivwSwLyQLB8QV1toZBmNm2qGhmD1YjOvkfZOm7bYOhQE/skm5Gqw2kG8EQJUfPXQA4GDO3t+vcWS1kaIk/bX9K5GxBVVuZBilXxMRaSG0rN8KgSXF8CTMbbWDti/ArhtN0mPECTiU5r/sEnlcLjddLEFbreHQvfu5hitjCpAk0bhA/deqvhL4lRPnt0H1t3MusDEk5dNF4nTtX1V9ggZkEFEM7XcxeMUOuxG9e3R/P5B9Gd6wsT42uncvroSCNsQnGA/XJFI9CpO1Y+Pyp938kTuBHXNZfFqnDScel2f+/6r1E1NuQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 27 Feb 2026 19:38:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 279468 invoked by uid 111); 27 Feb 2026 19:38:00 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 27 Feb 2026 14:38:00 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 27 Feb 2026 14:37:58 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Matt Smiley <msmiley@gitlab.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] upload-pack: reduce lock contention when writing
 packfile data
Message-ID: <20260227193758.GA2931515@coredump.intra.peff.net>
References: <20260227-pks-upload-pack-write-contention-v1-0-7166fe255704@pks.im>
 <20260227-pks-upload-pack-write-contention-v1-2-7166fe255704@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260227-pks-upload-pack-write-contention-v1-2-7166fe255704@pks.im>

On Fri, Feb 27, 2026 at 12:23:01PM +0100, Patrick Steinhardt wrote:

> Extend our use of the buffering infrastructure so that we soak up bytes
> until the buffer is filled up at least 2/3rds of its capacity. The
> change is relatively simple to implement as we already know to flush the
> buffer in `create_pack_file()` after git-pack-objects(1) has finished.

We are relaying write() calls from pack-objects here, which is writing
to us in 8kb chunks (due to csum-file.c buffering). So most of our
writes will be 8k.

Rather than buffering in upload-pack, would it not be simpler to just
increase the write size from pack-objects? Then we do not have to worry
about disrupting upload-pack's keepalive timeouts. And as a bonus, if
you are worried about the system-wide number of calls, you will likewise
be reducing the number of read() and write() calls over the pipe between
pack-objects and upload-pack.

Something like this:

diff --git a/csum-file.c b/csum-file.c
index 6e21e3cac8..94798fa429 100644
--- a/csum-file.c
+++ b/csum-file.c
@@ -206,7 +206,7 @@ struct hashfile *hashfd_throughput(const struct git_hash_algo *algop,
 	 * size so the progress indicators arrive at a more
 	 * frequent rate.
 	 */
-	return hashfd_internal(algop, fd, name, tp, 8 * 1024);
+	return hashfd_internal(algop, fd, name, tp, 32 * 1024);
 }
 
 void hashfile_checkpoint_init(struct hashfile *f,

reduces the number of write calls reported by:

  git clone \
    --upload-pack='perf stat -e syscalls:sys_enter_write git-upload-pack' \
    --bare --no-local linux.git foo.git

from ~420k to ~160k. In theory we expect ~8x reduction in our target
area, 4x for each of pack-objects and upload-pack, but of course there
are other writes going on, too, including the extra sideband ones. And
obviously we could push it further towards LARGE_PACKET_MAX to save even
more.

> Now git-upload-pack(1) already has the infrastructure in place to buffer
> some of the data it reads from git-pack-objects(1) before actually
> sending it out. We only use this infrastructure in very limited ways
> though, so we generally end up matching one read(3p) call with one
> write(3p) call. Even worse, when the sideband is enabled we end up
> matching one read with _two_ writes: one for the pkt-line length, and
> one for the packfile data.

Using writev() would be an easy-ish fix here, modulo portability
concerns (though of course it is easy to implement a fallback writev()
in terms of write()). Doing this:

diff --git a/sideband.c b/sideband.c
index ea7c25211e..b5509fbaa2 100644
--- a/sideband.c
+++ b/sideband.c
@@ -266,19 +266,25 @@ void send_sideband(int fd, int band, const char *data, ssize_t sz, int packet_ma
 	while (sz) {
 		unsigned n;
 		char hdr[5];
+		struct iovec iov[2];
 
 		n = sz;
 		if (packet_max - 5 < n)
 			n = packet_max - 5;
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
+		iov[1].iov_base = p;
+		iov[1].iov_len = n;
+		/* obviously needs looping and error detection */
+		writev(fd, iov, 2);
 		p += n;
 		sz -= n;
 	}

drops my 160k write calls down to 82k.

Another option here is teaching the packet-forming code to reserve a few
bytes at the front of the packet. There's a little discussion here:

  https://lore.kernel.org/git/YBkeYSA5UfQP1m%2Fx@coredump.intra.peff.net/

In theory it's easy and elegant to do, but I'm not sure what the
refactoring fallout would be like.

> This significantly reduces the number of write(3p) syscalls we need to
> do. Before this change, cloning the Linux repository resulted in around
> 400,000 write(3p) syscalls. With the buffering in place we only do
> around 130,000 syscalls.

Out of curiosity, how did you end up measuring? I first tried with
strace (without "-f") on the upload-pack process, but strace slowed it
enough that it ended up collecting multiple of pack-object's 8k write()
calls in a single read() call. ;) The "perf stat" above seemed to work
OK, though of course it's counting child processes, too.

-Peff
