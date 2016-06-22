Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 58D7C1FF40
	for <e@80x24.org>; Wed, 22 Jun 2016 05:46:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751505AbcFVFqk (ORCPT <rfc822;e@80x24.org>);
	Wed, 22 Jun 2016 01:46:40 -0400
Received: from mout.web.de ([212.227.17.11]:55798 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751084AbcFVFqk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jun 2016 01:46:40 -0400
Received: from [192.168.178.36] ([79.237.51.220]) by smtp.web.de (mrweb103)
 with ESMTPSA (Nemesis) id 0M8hsl-1bbXgk0EuB-00wFhR; Wed, 22 Jun 2016 07:46:29
 +0200
Subject: Re: [PATCH 1/2] archive-tar: write extended headers for file sizes >=
 8GB
To:	Jeff King <peff@peff.net>
References: <20160616043523.GA13615@sigill.intra.peff.net>
 <20160616043733.GA18323@sigill.intra.peff.net> <57687413.3030609@web.de>
 <20160621155920.GA7549@sigill.intra.peff.net> <5769A6CC.9030001@web.de>
 <5769AA47.4020806@web.de> <20160621210454.GC4747@sigill.intra.peff.net>
Cc:	git@vger.kernel.org
From:	=?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <576A262E.6090703@web.de>
Date:	Wed, 22 Jun 2016 07:46:22 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.2
MIME-Version: 1.0
In-Reply-To: <20160621210454.GC4747@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:Notx8L8oJn7oA0YEH9Mggsbs6UHHBTPdm2xq3bwDPA5yNeeB6xc
 4fs0AvuL+m1Vtxs6zUNjlCyFO7r/F+LSOED9O6z8ovetxo9BJYsITwxpJob5yFER473OQHa
 rBKwcpJgon/LAkd7Dk/ST4nY7IG3kMHse0WR6Yo6rQxRngU+C2B63ApboLo2aFF99Uosvv/
 Hu6oNoogUgzQRGZegMP+A==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:ItQZqxQB/RY=:vdYYpJpL4bPmJcC2efSPxJ
 pqcS84V0KjFdgxygJjyt8qbJMDYWibyo8dvP3Vc0zvmNNh2OXd9Q4l71gEQZjwGVuzm9Dr8mm
 iAspPooX0IlRXWRGHBkdBShp6X91tlgjT/0FiU4nZs80gS6rAbmqLuyfkDAkx3SqTG3xa0B8r
 uinNpn3boY7NZ2cVbi3Ak5nLDwg5tTqLVToXSpWIYiKSF8E0L51JnnBO4uSIY9Z4sUnVjE0SB
 ImMZFwY1PSnPDLx/dOLT87Rt4ScYMWmcQQEif+zeIplhuOXJqD/wqu2QxdvVsWcSSsxGbxmTg
 r1d34zCjpqeapoWwSuPw3ciuT6Fqnsof0m9wpA7YK79pjcxBjTq5mgJoO/esqr+LT04H8QRSh
 L93rBeDS5nTLZFM0pcIhMaa+OK7sEMqa80IfLcIcJWTEzvuiANeC93GYzYLF74H3bB9/T0Nit
 zFdc5wnNHUgBtUYIfsbCaqVEMFw53XC9u/fGJonmoKBFbiv5uLFRED4rw7IlQXYtdB2yQqGec
 itptb8HG3SA6QJf6Bn1L79XqseRVljgPyFQanldQSZ/Ld+ey/zLo3KwqJaY6fkbYrfexVXTjc
 wKW2IqbJKCKGNgk2pBNJDBwdv5B5xUSp0WhkfNFubBYUW08jl5LR2jfRCh95VrjDc2Eh9aU75
 3rHCMvfr3SgoCUlmVjwhw9JGrOHs3+G/VLek8kuiX7mWlaJA2VQSs76IWzue7XbxVK3uSAuuP
 fKRlyEyRjX/b6W/+jh4TzpdOjTGAFgcxK5+oXG2b7KID6swtT1979ggATe0sO4CfxZ33WGhDn
 yN/bGWO
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Am 21.06.2016 um 23:04 schrieb Jeff King:
> On Tue, Jun 21, 2016 at 10:57:43PM +0200, René Scharfe wrote:
> 
>> Am 21.06.2016 um 22:42 schrieb René Scharfe:
>>> The value 120 is magic; we need it to pass the tests.  That's
>>> because prepare_header() is used for building extended header
>>> records as well and we don't create extended headers for extended
>>> headers (not sure if that would work anyway), so they simply
>>> vanish when they're over the limit as their size field is set to
>>> zero.
>>
>> So how about something like this to make sure extended headers are
>> only written for regular files and not for other extended headers?
> 
> This is quite similar to what I wrote originally, but I moved to the
> ustar_size() format to better match the mtime code (which needs
> something like that, because we pass around args->time).
> 
> I think you could drop ustar_size() completely here and just put the
> "if" into write_tar_entry().

Which would look like this:

---
 archive-tar.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/archive-tar.c b/archive-tar.c
index cb99df2..274bdfa 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -137,6 +137,20 @@ static void strbuf_append_ext_header(struct strbuf *sb, const char *keyword,
 	strbuf_addch(sb, '\n');
 }
 
+/*
+ * Like strbuf_append_ext_header, but for numeric values.
+ */
+static void strbuf_append_ext_header_uint(struct strbuf *sb,
+					  const char *keyword,
+					  uintmax_t value)
+{
+	char buf[40]; /* big enough for 2^128 in decimal, plus NUL */
+	int len;
+
+	len = xsnprintf(buf, sizeof(buf), "%"PRIuMAX, value);
+	strbuf_append_ext_header(sb, keyword, buf, len);
+}
+
 static unsigned int ustar_header_chksum(const struct ustar_header *header)
 {
 	const unsigned char *p = (const unsigned char *)header;
@@ -208,7 +222,7 @@ static int write_tar_entry(struct archiver_args *args,
 	struct ustar_header header;
 	struct strbuf ext_header = STRBUF_INIT;
 	unsigned int old_mode = mode;
-	unsigned long size;
+	unsigned long size, size_in_header;
 	void *buffer;
 	int err = 0;
 
@@ -267,7 +281,13 @@ static int write_tar_entry(struct archiver_args *args,
 			memcpy(header.linkname, buffer, size);
 	}
 
-	prepare_header(args, &header, mode, size);
+	size_in_header = size;
+	if (S_ISREG(mode) && size > 077777777777UL) {
+		size_in_header = 0;
+		strbuf_append_ext_header_uint(&ext_header, "size", size);
+	}
+
+	prepare_header(args, &header, mode, size_in_header);
 
 	if (ext_header.len > 0) {
 		err = write_extended_header(args, sha1, ext_header.buf,
-- 
2.9.0
