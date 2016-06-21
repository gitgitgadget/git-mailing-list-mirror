Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 83C9A1FF40
	for <e@80x24.org>; Tue, 21 Jun 2016 20:58:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751513AbcFUU6I (ORCPT <rfc822;e@80x24.org>);
	Tue, 21 Jun 2016 16:58:08 -0400
Received: from mout.web.de ([217.72.192.78]:53693 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751380AbcFUU6F (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2016 16:58:05 -0400
Received: from [192.168.178.36] ([79.237.51.68]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0MYO45-1atF2S0Yj3-00V7Dy; Tue, 21 Jun 2016 22:57:49
 +0200
Subject: Re: [PATCH 1/2] archive-tar: write extended headers for file sizes >=
 8GB
To:	Jeff King <peff@peff.net>
References: <20160616043523.GA13615@sigill.intra.peff.net>
 <20160616043733.GA18323@sigill.intra.peff.net> <57687413.3030609@web.de>
 <20160621155920.GA7549@sigill.intra.peff.net> <5769A6CC.9030001@web.de>
Cc:	git@vger.kernel.org
From:	=?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <5769AA47.4020806@web.de>
Date:	Tue, 21 Jun 2016 22:57:43 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.2
MIME-Version: 1.0
In-Reply-To: <5769A6CC.9030001@web.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:+qW7Id4EBhPL4chJ8dq5YHIDhw/FOjl8NMHf92BEE/T6irO88Np
 k2JlJy0J+99q7AGtb2WLqvcoijIoo2oGzVAVHsVZ9GkP3Z1WrnYruXvTe5PzaLBK+UzUbnA
 tTiWGqw1KNSgMJzTuGPyd4lC3Vu4Y57WcVTvesln2gCiAsUq433FcGbR56YcGRP1qA/iWAW
 dijb3NyYkNOfuWCRECQ2w==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:pVr8/JuTVJ4=:saZe23xOSx5hWyogix8FPU
 yOocoTGIRR9Q9JND454G5KR0zawDhLqtKy2YBGr9iFIdxKILHqV9jgbyghQOYRhtpcBQ04Sht
 u14/xRqaWmyrOnKWioqTEBYAwX9XiwH/hT/M2rVUlFR/VPsgoomVoV/bE+a5fgkcdk700Q+sn
 CGdcDuAa/8WEvPQ6WQuzkm1s10BfN9xR6xUKcU2VWJN7MHVANHgVrNCkgOLLjFjnsPupNBMN2
 C/pxgeIW+B1YvNVbjcO1yR/re0eaMcAz3m16fZ0dPXNt1K+M1au/PRED+69UJRvXUIeBf2y+F
 Is/p75eDSXtVntXTBerLktOy5iagdb6Z2PYnDoxFeeXaDE2G5olJWfLKWP07g2VkAia67lrPk
 OMZNMh9I5oqswEV52loRfxhWla+DToa7krPrp3amrE+2X8Fe4KWq0Sj25onNJc3HzsDclBAWQ
 6UxMlXeldKW7M2C9VmIktaJj2X0+r0/kYk+mqEV1GH8K+TFSDXklN5xMag0z7EBni7RMmX04u
 2T8vfSqNPS33LmIQPNCch3KFWnTTeEFT3a51xyDoZWn4j3Gw7aVfjFhgkKTrQSsnOxKUX6v2c
 c38ow+Pp3e1YxiEMTxrphlOjqMSVQoQH+k84xTXOfvAo961D8oTaMeeRfC4LCT4ib31gkRf75
 54E71e2G3bG0YDhdY/RlVdHl6uz9B+TJNGaVlR2CgVqb1EU5PAWQv7fXV+PPBcvA0sieNKEQ0
 fwYbFXH8WXrgKWCAfq6GrfvY2T1kxQILT/dmGqxJ5KlUMcTaGmtcqCfghyYhsM9INPYCQBp5w
 TflzOpp
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Am 21.06.2016 um 22:42 schrieb René Scharfe:
> The value 120 is magic; we need it to pass the tests.  That's
> because prepare_header() is used for building extended header
> records as well and we don't create extended headers for extended
> headers (not sure if that would work anyway), so they simply
> vanish when they're over the limit as their size field is set to
> zero.

So how about something like this to make sure extended headers are
only written for regular files and not for other extended headers?
---
 archive-tar.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/archive-tar.c b/archive-tar.c
index ed562d4..f53e61c 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -199,7 +199,7 @@ static void prepare_header(struct archiver_args *args,
 {
 	xsnprintf(header->mode, sizeof(header->mode), "%07o", mode & 07777);
 	xsnprintf(header->size, sizeof(header->size), "%011lo",
-		  S_ISREG(mode) ? ustar_size(size) : 0);
+		  S_ISREG(mode) ? size : 0);
 	xsnprintf(header->mtime, sizeof(header->mtime), "%011lo",
 		  ustar_mtime(args->time));
 
@@ -240,7 +240,7 @@ static int write_tar_entry(struct archiver_args *args,
 	struct ustar_header header;
 	struct strbuf ext_header = STRBUF_INIT;
 	unsigned int old_mode = mode;
-	unsigned long size;
+	unsigned long size, size_in_header;
 	void *buffer;
 	int err = 0;
 
@@ -299,12 +299,14 @@ static int write_tar_entry(struct archiver_args *args,
 			memcpy(header.linkname, buffer, size);
 	}
 
-	if (S_ISREG(mode) && ustar_size(size) != size)
+	size_in_header = S_ISREG(mode) ? ustar_size(size) : size;
+	if (size_in_header != size)
 		strbuf_append_ext_header_uint(&ext_header, "size", size);
+
 	if (ustar_mtime(args->time) != args->time)
 		strbuf_append_ext_header_uint(&ext_header, "mtime", args->time);
 
-	prepare_header(args, &header, mode, size);
+	prepare_header(args, &header, mode, size_in_header);
 
 	if (ext_header.len > 0) {
 		err = write_extended_header(args, sha1, ext_header.buf,
-- 
2.9.0


