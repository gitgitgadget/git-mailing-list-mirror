From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [PATCH] Teach "git add" and friends to be paranoid
Date: Sun, 21 Feb 2010 10:21:42 +0300
Message-ID: <20100221072142.GA5829@dpotapov.dyndns.org>
References: <20100213133951.GA14352@Knoppix>
 <201002131539.54142.trast@student.ethz.ch>
 <20100213162924.GA14623@Knoppix>
 <37fcd2781002131409r4166e496h9d12d961a2330914@mail.gmail.com>
 <20100213223733.GP24809@gibbs.hungrycats.org>
 <20100214011812.GA2175@dpotapov.dyndns.org>
 <7vljer1gyg.fsf_-_@alter.siamese.dyndns.org>
 <20100219082813.GB17952@dpotapov.dyndns.org>
 <7v635tkta7.fsf@alter.siamese.dyndns.org>
 <7v8waniue8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Zygo Blaxell <zblaxell@esightcorp.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Thomas Rast <trast@student.ethz.ch>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 21 08:40:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nj68y-0006uJ-WB
	for gcvg-git-2@lo.gmane.org; Sun, 21 Feb 2010 08:22:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754148Ab0BUHV5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Feb 2010 02:21:57 -0500
Received: from mail-fx0-f213.google.com ([209.85.220.213]:45567 "EHLO
	mail-fx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753544Ab0BUHVt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Feb 2010 02:21:49 -0500
Received: by fxm5 with SMTP id 5so1440121fxm.29
        for <git@vger.kernel.org>; Sat, 20 Feb 2010 23:21:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=LFplFbmjwJRpOma5ohKGol6yzj0A3tIDzelfrpOAL2E=;
        b=Raq+91+xJJwzBYTxjhayp4pR82CQceyk6Kwqn4Lk9wJ3JWnkZkPrMDtSVB8Bx8xie+
         COqRPa5Ya98PlZ3ZLnJa3PAjwH15ygbHffaigZXyT3/1lylFM6Bn3RUXO9ux46vudjqn
         CoExaGAkJaXb9pgMGPYvLUizJ66U89mMLNuaQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=pTO+xzAoeII3J2K7nTdgLXJ0KgphTDHGHW+gYb87mzP2gYsR9D+m9oEFDqWopAUqxb
         pBsaW/rk8x5t0Ize+ahNrawqFvgqL+p5Ql+2/ku62JfR60LobU8w9XE7Nm+DKnU9KYKy
         bPzosUbfOzSOmCxU1XSx9T3bQv2z3zhjSlneQ=
Received: by 10.87.38.2 with SMTP id q2mr5141843fgj.0.1266736907557;
        Sat, 20 Feb 2010 23:21:47 -0800 (PST)
Received: from localhost (ppp91-76-18-217.pppoe.mtu-net.ru [91.76.18.217])
        by mx.google.com with ESMTPS id d6sm6835637fga.4.2010.02.20.23.21.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 20 Feb 2010 23:21:44 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7v8waniue8.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140600>

On Sat, Feb 20, 2010 at 11:23:11AM -0800, Junio C Hamano wrote:
> 
> There needs some benchmarking to justify it, I think.
> 
> So I'd split this hunk out when queuing.

I completely argee with your reasoning that it is a separate issue and
it needs some benchmarking to prove its usefulness. So, I have done it
today.

For that, I have created a repository up to 512Mb size and containing up
to 100,000 files (for small files the file number was the limiting
factor, for big files, the total size limit was used). I intentionally
limit the total size to 512Mb to make sure that they are in the FS cache
and no disk related effects.  The content of files have been generated
randomly by /dev/urandom and then used in all tests for one file size.
I have made 5 runs using mmap() (with git 1.7.0) and 5 runs with using
read() (after applying the patch below).

Below is the best result of 5 runs for each size. "Before" marks the
original version, which uses mmap(). "After" marks the modified version
using read(). The command used to measure time was:

cat list | time git hash-object --stdin-paths >/dev/null

So it is just calculating SHA-1 without deflating and writing the
result on the disk, which significantly depends on fsync() speed.

Tested on: Intel(R) Core(TM)2 Quad  CPU   Q9300  @ 2.50GHz

Here are results:

file size = 1Kb; Hashing 100000 files
Before:
0.63user 0.86system 0:01.49elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+100428minor)pagefaults 0swaps
After:
0.54user 0.53system 0:01.07elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+421minor)pagefaults 0swaps

file size = 2Kb; Hashing 100000 files
Before:
1.04user 0.79system 0:01.82elapsed 100%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+100428minor)pagefaults 0swaps
After:
0.95user 0.48system 0:01.43elapsed 100%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+422minor)pagefaults 0swaps

file size = 4Kb; Hashing 100000 files
Before:
1.73user 0.74system 0:02.47elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+100428minor)pagefaults 0swaps
After:
1.54user 0.57system 0:02.11elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+424minor)pagefaults 0swaps

file size = 8Kb; Hashing 64000 files
Before:
1.86user 0.63system 0:02.48elapsed 100%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+128428minor)pagefaults 0swaps
After:
1.75user 0.50system 0:02.23elapsed 100%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+424minor)pagefaults 0swaps

file size = 16Kb; Hashing 32000 files
Before:
1.73user 0.41system 0:02.14elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+128428minor)pagefaults 0swaps
After:
1.68user 0.32system 0:02.00elapsed 100%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+425minor)pagefaults 0swaps

file size = 32Kb; Hashing 16000 files
Before:
1.65user 0.32system 0:01.96elapsed 100%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+128428minor)pagefaults 0swaps
After:
1.64user 0.24system 0:01.87elapsed 100%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+431minor)pagefaults 0swaps

file size = 64Kb; Hashing 8000 files
Before:
1.71user 0.17system 0:01.87elapsed 100%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+128428minor)pagefaults 0swaps
After:
1.63user 0.18system 0:01.81elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+438minor)pagefaults 0swaps

file size = 128Kb; Hashing 4000 files
Before:
1.60user 0.20system 0:01.79elapsed 100%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+128428minor)pagefaults 0swaps
After:
1.55user 0.20system 0:01.75elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+454minor)pagefaults 0swaps

file size = 256Kb; Hashing 2000 files
Before:
1.62user 0.15system 0:01.77elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+128429minor)pagefaults 0swaps
After:
1.56user 0.16system 0:01.71elapsed 100%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+551minor)pagefaults 0swaps

file size = 512Kb; Hashing 1000 files
Before:
1.59user 0.17system 0:01.76elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+128428minor)pagefaults 0swaps
After:
1.56user 0.15system 0:01.71elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+679minor)pagefaults 0swaps

file size = 1024Kb; Hashing 500 files
Before:
1.64user 0.15system 0:01.78elapsed 100%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+128429minor)pagefaults 0swaps
After:
1.61user 0.15system 0:01.76elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+934minor)pagefaults 0swaps


As you can see, in all tests the read() version performed better than
mmap() though the difference decreases with increase of the file size.
While for 1Kb files, the speed up is 39% (based on the elapsed time),
it is mere 1% for 1Mb file size.

Note: I do not use strbuf_read(), because it is suboptimal to deal with
this case, because we know the size ahead. (In fact, strbuf_read() is
not so good even for unknown size as it does redundant strbuf_grow()
almost in every use case, which probably needs to be fixed).

-- >8 --
From 6b3f8335dece7c9b9f810b1ab08f1bcb090e4d5e Mon Sep 17 00:00:00 2001
From: Dmitry Potapov <dpotapov@gmail.com>
Date: Sun, 21 Feb 2010 09:32:19 +0300
Subject: [PATCH] hash-object: don't use mmap() for small files

Using read() instead of mmap() can be 39% speed up for 1Kb files and is
1% speed up 1Mb files. For larger files, it is better to use mmap(),
because the difference between is not significant, and when there is not
enough memory, mmap() performs much better, because it avoids swapping.

Signed-off-by: Dmitry Potapov <dpotapov@gmail.com>
---
 sha1_file.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 657825e..8a83e56 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2434,6 +2434,8 @@ static int index_mem(unsigned char *sha1, void *buf, size_t size,
 	return ret;
 }
 
+#define SMALL_FILE_SIZE (1024*1024)
+
 int index_fd(unsigned char *sha1, int fd, struct stat *st, int write_object,
 	     enum object_type type, const char *path)
 {
@@ -2448,6 +2450,14 @@ int index_fd(unsigned char *sha1, int fd, struct stat *st, int write_object,
 		else
 			ret = -1;
 		strbuf_release(&sbuf);
+	} else if (size <= SMALL_FILE_SIZE) {
+		char *buf = xmalloc(size);
+		if (size == read_in_full(fd, buf, size))
+			ret = index_mem(sha1, buf, size, write_object, type,
+					path);
+		else
+			ret = error("short read %s", strerror(errno));
+		free(buf);
 	} else if (size) {
 		void *buf = xmmap(NULL, size, PROT_READ, MAP_PRIVATE, fd, 0);
 		ret = index_mem(sha1, buf, size, write_object, type, path);
-- 
1.7.0

-- >8 --


Thanks,
Dmitry
