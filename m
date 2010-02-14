From: Dmitry Potapov <dpotapov@gmail.com>
Subject: [PATCH v2] don't use mmap() to hash files
Date: Sun, 14 Feb 2010 06:05:04 +0300
Message-ID: <20100214030504.GA17952@dpotapov.dyndns.org>
References: <20100211234753.22574.48799.reportbug@gibbs.hungrycats.org>
 <20100213121238.GA2559@progeny.tock>
 <20100213133951.GA14352@Knoppix>
 <201002131539.54142.trast@student.ethz.ch>
 <20100213162924.GA14623@Knoppix>
 <37fcd2781002131409r4166e496h9d12d961a2330914@mail.gmail.com>
 <20100213223733.GP24809@gibbs.hungrycats.org>
 <20100214011812.GA2175@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Zygo Blaxell <zblaxell@esightcorp.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Thomas Rast <trast@student.ethz.ch>,
	Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 14 04:05:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NgUnV-0006qU-B7
	for gcvg-git-2@lo.gmane.org; Sun, 14 Feb 2010 04:05:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932151Ab0BNDFK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Feb 2010 22:05:10 -0500
Received: from mail-fx0-f227.google.com ([209.85.220.227]:51951 "EHLO
	mail-fx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758151Ab0BNDFI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Feb 2010 22:05:08 -0500
Received: by fxm27 with SMTP id 27so163755fxm.25
        for <git@vger.kernel.org>; Sat, 13 Feb 2010 19:05:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=Yqwlrl7zyrIPFzvbUPX9L3SPoLvl1TerE/iXvEqMx9I=;
        b=K7asjfr6RT6+MiIODahumNtcCYZj8Yjib2n1+65PqiONmJcHx4vw4DVQFTCHcX/bmF
         gEprO5vanKhmUKdteHMi8t1bBOvfbZXjYIObQeIEC1Z9Qg/CmEaZdakryJkEh9HM+IYr
         x6ILlWL4sDbQQ7Pl29S+1vTCOJI5ReRdB4MJs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=pmv+Zt7euDXwzbePYi9+qjEnU5lZpM8rHZ/zkD8Vyq63QmMl9FHcFLndnQg17+jdIu
         GvtP47iJaxeh4yQK1fd0dFHH1Vm5D6twOmIfVT3gXjQ0ZCA6Yw5/80ltATa6Dcl3byuI
         l5DKcNd04cNqHewUcxpBgq7dnrb+lnLe4luC0=
Received: by 10.223.5.75 with SMTP id 11mr3902950fau.46.1266116706655;
        Sat, 13 Feb 2010 19:05:06 -0800 (PST)
Received: from localhost (ppp91-76-16-167.pppoe.mtu-net.ru [91.76.16.167])
        by mx.google.com with ESMTPS id f31sm8000719fkf.12.2010.02.13.19.05.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 13 Feb 2010 19:05:06 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20100214011812.GA2175@dpotapov.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139885>

If a mmapped file is changed by another program during git-add, it
causes the repository corruption. Disabling mmap() in index_fd() does
not have any negative impact on the overall speed of Git. In fact, it
makes git hash-object to work slightly faster. Here is the best result
before and after patch based on 5 runs on the Linix kernel repository:

Before:

$ git ls-files | time git hash-object --stdin-path > /dev/null
2.15user 0.36system 0:02.52elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+103248minor)pagefaults 0swaps

After:

$ git ls-files | time ../git/git hash-object --stdin-path > /dev/null
2.09user 0.33system 0:02.42elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+1073minor)pagefaults 0swaps

Signed-off-by: Dmitry Potapov <dpotapov@gmail.com>
---

In this version, I have improved the hint value for regular files to
avoid useless re-allocation and copy.

 sha1_file.c |   27 +++++++++++----------------
 1 files changed, 11 insertions(+), 16 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 657825e..26c6231 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2438,22 +2438,17 @@ int index_fd(unsigned char *sha1, int fd, struct stat *st, int write_object,
 	     enum object_type type, const char *path)
 {
 	int ret;
-	size_t size = xsize_t(st->st_size);
-
-	if (!S_ISREG(st->st_mode)) {
-		struct strbuf sbuf = STRBUF_INIT;
-		if (strbuf_read(&sbuf, fd, 4096) >= 0)
-			ret = index_mem(sha1, sbuf.buf, sbuf.len, write_object,
-					type, path);
-		else
-			ret = -1;
-		strbuf_release(&sbuf);
-	} else if (size) {
-		void *buf = xmmap(NULL, size, PROT_READ, MAP_PRIVATE, fd, 0);
-		ret = index_mem(sha1, buf, size, write_object, type, path);
-		munmap(buf, size);
-	} else
-		ret = index_mem(sha1, NULL, size, write_object, type, path);
+	struct strbuf sbuf = STRBUF_INIT;
+	/* for regular files, we supply the real file size, otherwise
+	   `size' is just a hint */
+	size_t size = S_ISREG(st->st_mode) ? xsize_t(st->st_size) : 4096;
+
+	if (strbuf_read(&sbuf, fd, size) >= 0)
+		ret = index_mem(sha1, sbuf.buf, sbuf.len, write_object,
+				type, path);
+	else
+		ret = -1;
+	strbuf_release(&sbuf);
 	close(fd);
 	return ret;
 }
-- 
1.7.0
