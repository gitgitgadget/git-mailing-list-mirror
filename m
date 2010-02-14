From: Dmitry Potapov <dpotapov@gmail.com>
Subject: [PATCH] don't use mmap() to hash files
Date: Sun, 14 Feb 2010 04:18:12 +0300
Message-ID: <20100214011812.GA2175@dpotapov.dyndns.org>
References: <20100211234753.22574.48799.reportbug@gibbs.hungrycats.org>
 <20100213121238.GA2559@progeny.tock>
 <20100213133951.GA14352@Knoppix>
 <201002131539.54142.trast@student.ethz.ch>
 <20100213162924.GA14623@Knoppix>
 <37fcd2781002131409r4166e496h9d12d961a2330914@mail.gmail.com>
 <20100213223733.GP24809@gibbs.hungrycats.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Thomas Rast <trast@student.ethz.ch>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Zygo Blaxell <zblaxell@esightcorp.com>
X-From: git-owner@vger.kernel.org Sun Feb 14 02:23:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NgTCx-0003hN-F3
	for gcvg-git-2@lo.gmane.org; Sun, 14 Feb 2010 02:23:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758268Ab0BNBXb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Feb 2010 20:23:31 -0500
Received: from mail-bw0-f216.google.com ([209.85.218.216]:38964 "EHLO
	mail-bw0-f216.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752964Ab0BNBXa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Feb 2010 20:23:30 -0500
X-Greylist: delayed 314 seconds by postgrey-1.27 at vger.kernel.org; Sat, 13 Feb 2010 20:23:29 EST
Received: by bwz8 with SMTP id 8so1936458bwz.38
        for <git@vger.kernel.org>; Sat, 13 Feb 2010 17:23:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=9vkuFAg3OrSLrY5DNdgAiqVU44L/nX0hCQB7Tasm+F8=;
        b=vhjZFKOhWO/9T7iqZht3L+h2GCv3otngpaxKGHvSLA28s2IE3/8yiXyFtgJpaib8zf
         D+5P5SdNl8fgVSGPFxj2E1RcyDUbgfrJx8e+DVwEN2AEPlMxlpSgyqnyl7TBu/wssfg2
         kYS6ilfe2Q/19d/Gx4A8Wg3E/JOTFwXRLmucY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=dWAvJj0YrYftX4IyB94u5Bt3CCEHeeofD+Gbt/MKBZFVJ/STgkXASTgTg0UiZyMLiK
         QSLJcUsLfYXJyzQ+qxGRQ3ZR6NGqkfaWosJ8TKs0slHIKO260+jFjDVaFfQQjDKu4j4h
         Sz14dQubviB+Tq0Wz5rOTCXtmXgbPDI9RA3ro=
Received: by 10.204.29.10 with SMTP id o10mr2085939bkc.82.1266110294564;
        Sat, 13 Feb 2010 17:18:14 -0800 (PST)
Received: from localhost (ppp91-76-16-167.pppoe.mtu-net.ru [91.76.16.167])
        by mx.google.com with ESMTPS id 16sm2103152bwz.7.2010.02.13.17.18.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 13 Feb 2010 17:18:14 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20100213223733.GP24809@gibbs.hungrycats.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139876>

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

I think more people should test this change to see its impact on
performance. For me, it was positive. Here is my results:

Using mmap (git version 1.7.0)

2.18user 0.33system 0:02.52elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+103248minor)pagefaults 0swaps
$ git ls-files | time git hash-object --stdin-path > /dev/null
2.23user 0.28system 0:02.53elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+103249minor)pagefaults 0swaps
$ git ls-files | time git hash-object --stdin-path > /dev/null
2.20user 0.31system 0:02.52elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+103248minor)pagefaults 0swaps
$ git ls-files | time git hash-object --stdin-path > /dev/null
2.21user 0.30system 0:02.51elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+103248minor)pagefaults 0swaps
$ git ls-files | time git hash-object --stdin-path > /dev/null
2.15user 0.36system 0:02.52elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+103248minor)pagefaults 0swaps

Using read() instead of mmap() (1.7.0 with the above patch)

$ git ls-files | time ../git/git hash-object --stdin-path > /dev/null
2.19user 0.24system 0:02.42elapsed 100%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+1073minor)pagefaults 0swaps
$ git ls-files | time ../git/git hash-object --stdin-path > /dev/null
2.15user 0.26system 0:02.42elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+1073minor)pagefaults 0swaps
$ git ls-files | time ../git/git hash-object --stdin-path > /dev/null
2.18user 0.24system 0:02.42elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+1073minor)pagefaults 0swaps
$ git ls-files | time ../git/git hash-object --stdin-path > /dev/null
2.18user 0.25system 0:02.42elapsed 100%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+1073minor)pagefaults 0swaps
$ git ls-files | time ../git/git hash-object --stdin-path > /dev/null
2.09user 0.33system 0:02.42elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+1073minor)pagefaults 0swaps


 sha1_file.c |   22 +++++++---------------
 1 files changed, 7 insertions(+), 15 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 657825e..83f82a2 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2438,22 +2438,14 @@ int index_fd(unsigned char *sha1, int fd, struct stat *st, int write_object,
 	     enum object_type type, const char *path)
 {
 	int ret;
-	size_t size = xsize_t(st->st_size);
+	struct strbuf sbuf = STRBUF_INIT;
 
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
+	if (strbuf_read(&sbuf, fd, 4096) >= 0)
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
