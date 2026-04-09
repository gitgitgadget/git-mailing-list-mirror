Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C8B3D170E
	for <git@vger.kernel.org>; Thu,  9 Apr 2026 13:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775742429; cv=none; b=Gs6deIUvnvSAogeD1n8Y02qsWYG6Lz46cDvl4v/8qD9P/wjvm6b8JvjIGIOHWDbDBDlbu/Py91YkDQ99QkNtcGHsBSvBsTfVPiLDeMQgls/c22dbmN7ovwARM9ma1DFl4Ad4oblE2JqWPuH8TiSI/S2X8WgU41inycJgWTj925A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775742429; c=relaxed/simple;
	bh=tvgBvmgiYBfzIa3HyvaOfHItFMb/kEOigryzT1ZYUKY=;
	h=From:To:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=QC6IYVbmvJQpksAMrtu9yWqo0OnvVHtwZFR/OHYObD2CpcoIvZASWkurLIM9XyiD1A5pR4LNhYPOZ9jlPQ+jGb3YgcnGX2++LrrScBTEWju8f/5fiT+UN7KX9TyhgVJMRi7XArXi2c6gUIPq75Worp5REZF8B7Uay2a2t9A4qJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 639DkjTR3584558
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 9 Apr 2026 13:46:46 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Patrick Steinhardt'" <ps@pks.im>,
        "'brian m. carlson'" <sandals@crustytoothpaste.net>,
        "'Jeff King'" <peff@peff.net>, "'Junio C Hamano'" <gitster@pobox.com>,
        <git@vger.kernel.org>
References: <011701dcc767$8c2ab400$a4801c00$@nexbridge.com> <013301dcc774$5e9fffb0$1bdfff10$@nexbridge.com> <20260408173949.GB2850002@coredump.intra.peff.net> <xmqq4illz5g9.fsf@gitster.g> <014e01dcc793$8a9bab90$9fd302b0$@nexbridge.com> <xmqqqzopxkxa.fsf@gitster.g> <016b01dcc79e$87472860$95d57920$@nexbridge.com> <xmqqcy09xh53.fsf@gitster.g> <20260408223233.GB2873736@coredump.intra.peff.net> <adbwyvQ-R2Ag1vox@fruit.crustytoothpaste.net> <addgkjiB80pgKw69@pks.im>
In-Reply-To: <addgkjiB80pgKw69@pks.im>
Subject: RE: Git 2.54.0-rc1, subtests of t5310, t5326, t5327
Date: Thu, 9 Apr 2026 09:46:39 -0400
Organization: Nexbridge Inc.
Message-ID: <021a01dcc827$4e6342c0$eb29c840$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQKJglDL+YEcfVjvUpAizvx0PQ10yAJPLLUsAZnbLOUCUYPMdwGXJ4LTAiA9CNYCy2JSNAHcpbiQAj1lYt8CnD6ukAHUdicps9MI7OA=
X-Antivirus: Norton (VPS 260409-4, 4/9/2026), Outbound message
X-Antivirus-Status: Clean

On April 9, 2026 4:17 AM, Patrick Steinhardt wrote
>On Thu, Apr 09, 2026 at 12:20:26AM +0000, brian m. carlson wrote:
>> On 2026-04-08 at 22:32:33, Jeff King wrote:
>> > I think writev() is buying us something when it works (it is hlving
>> > the number of writes for sideband packets). And it works when either:
>> >
>> >   1. the platform is OK with writing up to 64k in a single writev()
>> >
>> >   2. the platform has a limit that is small (like NonStop here), but
>> >      writes less than MAX_IO_SIZE work and will save a write() call
>> >
>> > If we just care about (1), then the right solution is to declare
>> > that
>> > writev() isn't fully functional for us on some platforms, and they
>> > should build with NO_WRITEV. And we should probably embed that in
>> > config.mak.uname.
>
>Yeah, agreed. I think we shouldn't make ourselves a hostage to platforms
that don't
>have reasonable support for writev(3p), as it does buy us something on the
>majority of platforms that actually support it well.
>
>That of course doesn't mean that we shouldn't support such platforms.
>
>> Looking at POSIX, there doesn't seem to be any constraints on the size
>> of individual vectors other than that they must total to less than
>> SSIZE_MAX.  iovcnt can be limited to 16, but I don't think we're
>> hitting that here.  POSIX does say that SSIZE_MAX does not need to
>> exceed 32767, which may be what's going on here, although that does
>> seem like an unreasonable value for a real system.  Linux, FreeBSD,
>> and NetBSD all set SSIZE_MAX to either INT_MAX or LONG_MAX.
>>
>> I also think that 64 KiB is more than reasonable in terms of the size
>> that people should be able to send.  I'd personally expect to be able
>> to send values much larger, at least 512 KiB, and I have code that
>> expects even larger (16 MiB).
>>
>> So I'd simply say that for systems that have a constraint on the size
>> that is "too small", they should just use NO_WRITEV.
>
>I would be happy with this as an intermediate step, as Randall has
confirmed it
>would fix the issue. It is the least intrusive step and has the lowest
risk.
>
>> However, I don't have a strong opinion on this and if people want to
>> do the proposal for option 2, that's fine with me.
>
>I think in the long term this is the most sensible approach though so that
we don't
>have to special-case platforms. I've crafted the below alternative to
Peff's patch, and
>I think it's ultimately not too bad.
>
>One question to Randall though: does MAX_IO_SIZE apply to the overall size
of the
>iovec or to the individual iovec entries? I think it should be the latter,
but I cannot
>easily verify and couldn't find any docs around this. So could you please
try the
>patch at the end of this mail to verify that it works on your system?
>
>In any case, I've tested that my patch also works when defining MAX_IO_SIZE
to
>128 bytes on my system, which hopefully demonstrates that it works as
expected:
>
>diff --git a/git-compat-util.h b/git-compat-util.h index
4b4ea2498f..8e02b5f673
>100644
>--- a/git-compat-util.h
>+++ b/git-compat-util.h
>@@ -690,14 +690,8 @@ static inline uint64_t u64_add(uint64_t a, uint64_t b)
>  * to override this, if the definition of SSIZE_MAX given by the platform
>  * is broken.
>  */
>-#ifndef MAX_IO_SIZE
>-# define MAX_IO_SIZE_DEFAULT (8*1024*1024) -# if defined(SSIZE_MAX) &&
>(SSIZE_MAX < MAX_IO_SIZE_DEFAULT) -#  define MAX_IO_SIZE SSIZE_MAX -# else
-
>#  define MAX_IO_SIZE MAX_IO_SIZE_DEFAULT -# endif -#endif
>+#undef MAX_IO_SIZE
>+#define MAX_IO_SIZE 128
>
> #ifdef HAVE_ALLOCA_H
> # include <alloca.h>
>
>I'm happy to go either way, but think that we should definitely aim for the
below
>patch eventually. Just let me know which way you prefer and I'm happy to
polish up
>the patch.
>
>Patrick
>
>diff --git a/wrapper.c b/wrapper.c
>index be8fa575e6..645dbc5f20 100644
>--- a/wrapper.c
>+++ b/wrapper.c
>@@ -323,21 +323,50 @@ ssize_t write_in_full(int fd, const void *buf, size_t
count)
> 	return total;
> }
>
>+ssize_t xwritev(int fd, struct iovec *iov, int iovcnt) {
>+	ssize_t bytes_written;
>+	int i;
>+
>+	/*
>+	 * We need to make sure that no individual iovec entry exceeds
>+	 * `MAX_IO_SIZE`. If there's any entry that does exceed this limit
>+	 * we'll pass all entries up to it to `writev()`, and then process
the
>+	 * exceeding entry via a call to `xwrite()`.
>+	 */
>+	for (i = 0; i < iovcnt; i++)
>+		if (iov[i].iov_len > MAX_IO_SIZE)
>+			break;
>+	if (i < iovcnt) {
>+		/*
>+		 * The first entry exceeds MAX_IO_SIZE, so we pass it to
>+		 * xwrite, which knows to handle his case.
>+		 */
>+		if (!i)
>+			return xwrite(fd, iov->iov_base, iov->iov_len);
>+		iovcnt = i;
>+	}
>+
>+	bytes_written = writev(fd, iov, iovcnt);
>+	if (!bytes_written) {
>+		errno = ENOSPC;
>+		return -1;
>+	}
>+
>+	return bytes_written;
>+}
>+
> ssize_t writev_in_full(int fd, struct iovec *iov, int iovcnt)  {
> 	ssize_t total_written = 0;
>
> 	while (iovcnt) {
>-		ssize_t bytes_written = writev(fd, iov, iovcnt);
>-		if (bytes_written < 0) {
>+		ssize_t bytes_written = xwritev(fd, iov, iovcnt);
>+		if (bytes_written <= 0) {
> 			if (errno == EINTR || errno == EAGAIN)
> 				continue;
> 			return -1;
> 		}
>-		if (!bytes_written) {
>-			errno = ENOSPC;
>-			return -1;
>-		}
>
> 		total_written += bytes_written;
>
>diff --git a/wrapper.h b/wrapper.h
>index 27519b32d1..a6287d7f4d 100644
>--- a/wrapper.h
>+++ b/wrapper.h
>@@ -16,6 +16,7 @@ void *xmmap_gently(void *start, size_t length, int prot,
int
>flags, int fd, off_  int xopen(const char *path, int flags, ...);  ssize_t
xread(int fd, void
>*buf, size_t len);  ssize_t xwrite(int fd, const void *buf, size_t len);
>+ssize_t xwritev(int fd, struct iovec *iov, int iovcnt);
> ssize_t xpread(int fd, void *buf, size_t len, off_t offset);  int xdup(int
fd);  FILE
>*xfopen(const char *path, const char *mode);

Please do not make the change in git-compat-util. This will break xwrite().
We already have MAX_IO_SIZE working and verified from years ago. Changing
that will remove our platform from being supportable.

