From: Ingo Molnar <mingo@elte.hu>
Subject: [patch] git: fix memory leaks in update-cache.c
Date: Thu, 14 Apr 2005 15:03:09 +0200
Message-ID: <20050414130309.GA18703@elte.hu>
References: <20050414112638.GA12593@elte.hu> <20050414120834.GA14290@elte.hu> <20050414121819.GA14380@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Thu Apr 14 15:02:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DM3xU-0006Og-VW
	for gcvg-git@gmane.org; Thu, 14 Apr 2005 15:00:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261496AbVDNNDu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Apr 2005 09:03:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261497AbVDNNDu
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Apr 2005 09:03:50 -0400
Received: from mx2.elte.hu ([157.181.151.9]:45710 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261496AbVDNND0 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Apr 2005 09:03:26 -0400
Received: from chiara.elte.hu (chiara.elte.hu [157.181.150.200])
	by mx2.elte.hu (Postfix) with ESMTP id 8475031986B;
	Thu, 14 Apr 2005 15:02:23 +0200 (CEST)
Received: by chiara.elte.hu (Postfix, from userid 17806)
	id 405801FC2; Thu, 14 Apr 2005 15:03:12 +0200 (CEST)
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20050414121819.GA14380@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


this patch fixes two memory leaks in update-cache.c: we didnt free the 
temporary input and output buffers used for compression.

	Ingo

Signed-off-by: Ingo Molnar <mingo@elte.hu>

--- update-cache.c.orig
+++ update-cache.c
@@ -23,13 +23,17 @@ static int index_fd(const char *path, in
 	void *metadata = malloc(namelen + 200);
 	void *in;
 	SHA_CTX c;
+	int ret;
 
 	in = "";
 	if (size)
 		in = mmap(NULL, size, PROT_READ, MAP_PRIVATE, fd, 0);
 	close(fd);
-	if (!out || (int)(long)in == -1)
+	if (!out || (int)(long)in == -1) {
+		free(out);
+		free(metadata);
 		return -1;
+	}
 
 	memset(&stream, 0, sizeof(stream));
 	deflateInit(&stream, Z_BEST_COMPRESSION);
@@ -58,7 +62,12 @@ static int index_fd(const char *path, in
 	SHA1_Update(&c, out, stream.total_out);
 	SHA1_Final(ce->sha1, &c);
 
-	return write_sha1_buffer(ce->sha1, out, stream.total_out);
+	ret = write_sha1_buffer(ce->sha1, out, stream.total_out);
+		
+	free(out);
+	free(metadata);
+
+	return ret;
 }
 
 /*
