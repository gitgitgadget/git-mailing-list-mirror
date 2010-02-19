From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [PATCH] Teach "git add" and friends to be paranoid
Date: Fri, 19 Feb 2010 11:28:13 +0300
Message-ID: <20100219082813.GB17952@dpotapov.dyndns.org>
References: <20100211234753.22574.48799.reportbug@gibbs.hungrycats.org>
 <20100213121238.GA2559@progeny.tock>
 <20100213133951.GA14352@Knoppix>
 <201002131539.54142.trast@student.ethz.ch>
 <20100213162924.GA14623@Knoppix>
 <37fcd2781002131409r4166e496h9d12d961a2330914@mail.gmail.com>
 <20100213223733.GP24809@gibbs.hungrycats.org>
 <20100214011812.GA2175@dpotapov.dyndns.org>
 <7vljer1gyg.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Zygo Blaxell <zblaxell@esightcorp.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Thomas Rast <trast@student.ethz.ch>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 19 09:28:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NiODo-0004Px-FL
	for gcvg-git-2@lo.gmane.org; Fri, 19 Feb 2010 09:28:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753428Ab0BSI2U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Feb 2010 03:28:20 -0500
Received: from fg-out-1718.google.com ([72.14.220.154]:18697 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752473Ab0BSI2T (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Feb 2010 03:28:19 -0500
Received: by fg-out-1718.google.com with SMTP id l26so207557fgb.1
        for <git@vger.kernel.org>; Fri, 19 Feb 2010 00:28:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=mPuAbNZgrlwhU5j3k5sNM+X4XAJWruwBJ7RQjjNoHB8=;
        b=I6cXovlmebd3B05USU0trySPMQaxLp8kU6by0Vgq4/g3j4BAg7dnOpevxOWtk+y/E1
         xB6D7AtZ3fIUeyhZ+oauc4/bNwsn10CfSEW4YnazeI8nDYVHNuQvBh77WnXOihDxfVIm
         GSwD51EWkpQbOgXKc4Mkf63Ct29MMkFdlqwfc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=X5gTWhcrG9rsNj0POyDJpfO4siGtwqBsLxJIeQ85HtDCi3E+EhGnN6K+KAY5/KUGj9
         CbEN6Yhf5THEeopzeVCrnS+BQquELIJG/ki0brWV0uBhNS9Ph83sZYduNdvIffHngaIE
         nophGy0u5bVBZoan+yn+gEqT0PompM+0euvxc=
Received: by 10.223.144.71 with SMTP id y7mr4361701fau.54.1266568096688;
        Fri, 19 Feb 2010 00:28:16 -0800 (PST)
Received: from localhost (ppp91-76-18-185.pppoe.mtu-net.ru [91.76.18.185])
        by mx.google.com with ESMTPS id f31sm1628343fkf.42.2010.02.19.00.28.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 19 Feb 2010 00:28:15 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vljer1gyg.fsf_-_@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140435>

Hi Junio,

I am sorry I have not had time to reply earlier. I think it is possible
to avoid the overhead of being on the safe side in a few common cases.
Here is a patch. I have not had time to test it, but changes appear to
trivial.

-- >8 --
From 3e53610a41c4aad458dff13135a73bb4944f456b Mon Sep 17 00:00:00 2001
From: Dmitry Potapov <dpotapov@gmail.com>
Date: Fri, 19 Feb 2010 11:00:51 +0300
Subject: [PATCH] speed up "git add" by avoiding the paranoid mode

While the paranoid mode preserve the git repository from corruption in the
case when the added file is changed simultaneously with running "git add",
it has some overhead. However, in a few common cases, it is possible to
avoid this mode and still be on the safe side:

1. If mmap() is implemented as reading the whole file in memory.

2. If the whole file was read in memory as result of applying some filter.

3. If the added file is small, it is faster to use read() than mmap().

Signed-off-by: Dmitry Potapov <dpotapov@gmail.com>
---
 sha1_file.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index d8a7722..4efeb21 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2469,6 +2469,7 @@ static int index_mem(unsigned char *sha1, void *buf, size_t size,
 		                   write_object ? safe_crlf : 0)) {
 			buf = strbuf_detach(&nbuf, &size);
 			re_allocated = 1;
+			paranoid = 0;
 		}
 	}
 
@@ -2490,7 +2491,7 @@ int index_fd(unsigned char *sha1, int fd, struct stat *st, int write_object,
 	size_t size = xsize_t(st->st_size);
 
 	flag = write_object ? INDEX_MEM_WRITE_OBJECT : 0;
-	if (!S_ISREG(st->st_mode)) {
+	if (!S_ISREG(st->st_mode) || size < 262144) {
 		struct strbuf sbuf = STRBUF_INIT;
 		if (strbuf_read(&sbuf, fd, 4096) >= 0)
 			ret = index_mem(sha1, sbuf.buf, sbuf.len,
@@ -2500,7 +2501,9 @@ int index_fd(unsigned char *sha1, int fd, struct stat *st, int write_object,
 		strbuf_release(&sbuf);
 	} else if (size) {
 		void *buf = xmmap(NULL, size, PROT_READ, MAP_PRIVATE, fd, 0);
+#ifndef NO_MMAP
 		flag |= INDEX_MEM_PARANOID;
+#endif
 		ret = index_mem(sha1, buf, size, type, path, flag);
 		munmap(buf, size);
 	} else
-- 
1.7.0

-- >8 --
