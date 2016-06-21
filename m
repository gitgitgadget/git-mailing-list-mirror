Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0EB081FF40
	for <e@80x24.org>; Tue, 21 Jun 2016 21:01:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751788AbcFUVBl (ORCPT <rfc822;e@80x24.org>);
	Tue, 21 Jun 2016 17:01:41 -0400
Received: from mout.web.de ([217.72.192.78]:59126 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751647AbcFUVBk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2016 17:01:40 -0400
Received: from [192.168.178.36] ([79.237.51.68]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0MgO8g-1b40ON2Pna-00Nf6Q; Tue, 21 Jun 2016 22:54:57
 +0200
Subject: Re: [PATCH 1/2] archive-tar: write extended headers for file sizes >=
 8GB
To:	Jeff King <peff@peff.net>
References: <20160616043523.GA13615@sigill.intra.peff.net>
 <20160616043733.GA18323@sigill.intra.peff.net> <57687413.3030609@web.de>
 <20160621155920.GA7549@sigill.intra.peff.net>
Cc:	git@vger.kernel.org
From:	=?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <5769A99A.9040508@web.de>
Date:	Tue, 21 Jun 2016 22:54:50 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.2
MIME-Version: 1.0
In-Reply-To: <20160621155920.GA7549@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:iJWdS/sYJXAqrC0ClYnilLPdqM+zxrFkOI7eLm0rwcOUHye1o20
 w5DEjxvfqsmCSdzQ2U56yWTUSwcFVGzWs3p6G9tMhPBM80UoZSgKT8NC3g26uRHj0BpSAEZ
 lGQ6+SjWFCFpn7SmRU85hELjphLd1x5pGkea4fGUVcuZ9ZFC0J0EIJj7lyuGE9/PGfuT7xe
 LPBDcG1kbl9QVdewoTDOg==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:qLbX/UDQkL0=:yfcEx+slXr70VOwWz0BGyt
 n4bqobJOLBglBWz6mgPZ7EUD6PqVhjZhiI150XPmA3hQD8XUEsMVGN+UJOM6YZCDwTOl7X3BB
 x0uZ1rKjb5LOORfYVbE6eJGjrhKG9CnEiUIVNMutxUHq542FsucgJWzkENSbhKydTVaLatIYd
 afTjpki7JN1LFKHJ8nemnBIKsBMh7NTRn98JMN18jZzw677Eg5j3YttlUGpyQYDNYukZTpMp/
 S1sTbWu0GBDBif39RXBl0P7cHxrBgPunXAxFVYCnToy3hanjzK/c+MmpmvGRIOjvu+urJrbvy
 ob6I1ib5RssrURc4fWIsF1qR2jGHTLV/jK3EK2anwYgiUFf2gYrMlSPFr0JP9Abg/pCQcRRiA
 u8hnAD8SygXJzqk/YWmw3phWVrJRWgtDaDYguX7F9q6Ealo2fMnHBj87wzh9kq26xql4ocbBK
 1Y5V1XakKfgjQEJ5us31AwpyQr031in2zkmyh4JS1lvOcUxHJ+itcnDPvK2BychsEaL2O+AYH
 ePBHm13n3crCiECYUau16IGCArfmjllgQw61D525d0TPaKaOtCcXz2MuiOudHRdxgjyJpMs66
 qxx4842TsEdA6ryLl/YNDkYimwdr2lXqua7VzvqP25NA4K8oo8EuAIM8YszVY4WOEhzGVAEev
 OJI9HXBNQV46tXMRsR5OA3Y5A2IbZrYIRdsfdn1GNtQiKdR2ONzGyh6C+hB/kT+tlXCB9FBwZ
 UzTqAXcWzrteewZaAjj5nig/TJSd7HFMymKym8La4dqxj7G8QpkSsPz7R1t3395fbh0JDaScN
 pIToZva
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Am 21.06.2016 um 17:59 schrieb Jeff King:
> On Tue, Jun 21, 2016 at 12:54:11AM +0200, René Scharfe wrote:
>
>>> Unfortunately, it's quite an expensive test to run. For one
>>> thing, unless your filesystem supports files with holes, it
>>> takes 64GB of disk space (you might think piping straight to
>>> `hash-object --stdin` would be better, but it's not; that
>>> tries to buffer all 64GB in RAM!). Furthermore, hashing and
>>> compressing the object takes several minutes of CPU time.
>>>
>>> We could ship just the resulting compressed object data as a
>>> loose object, but even that takes 64MB. So sadly, this code
>>> path remains untested in the test suite.
>>
>> If we could set the limit to a lower value than 8GB for testing then we
>> could at least check if the extended header is written, e.g. if ustar_size()
>> could be convinced to return 0 every time using a hidden command line
>> parameter or an environment variable or something better.
>
> Yes, we could do that, though I think it loses most of the value of the
> test. We can check that if we hit an arbitrary value we generate the pax
> header, but I think what we _really_ care about is: did we generate an
> output that somebody else's tar implementation can handle.

I agree with the last point, but don't see how that diminishes the
value of such a test.  If we provide file sizes only through extended
headers (the normal header field being set to 0) and we can extract
files with correct sizes then tar must have interpreted those header
as intended, right?

(Or it just guessed the sizes by searching for the next header magic,
but such a fallback won't be accurate for files ending with NUL
characters due to NUL-padding, so we just have to add such a file.)

René


-- >8 --
Subject: archive-tar: test creation of pax extended size headers

---
The value 120 is magic; we need it to pass the tests.  That's
because prepare_header() is used for building extended header
records as well and we don't create extended headers for extended
headers (not sure if that would work anyway), so they simply
vanish when they're over the limit as their size field is set to
zero.

 archive-tar.c       | 7 ++++++-
 t/t5000-tar-tree.sh | 7 +++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/archive-tar.c b/archive-tar.c
index f53e61c..fbbc4cc 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -14,6 +14,7 @@ static char block[BLOCKSIZE];
 static unsigned long offset;
 
 static int tar_umask = 002;
+static unsigned long ustar_size_max = 077777777777UL;
 
 static int write_tar_filter_archive(const struct archiver *ar,
 				    struct archiver_args *args);
@@ -179,7 +180,7 @@ static size_t get_path_prefix(const char *path, size_t pathlen, size_t maxlen)
 
 static inline unsigned long ustar_size(uintmax_t size)
 {
-	if (size <= 077777777777UL)
+	if (size <= ustar_size_max)
 		return size;
 	else
 		return 0;
@@ -412,6 +413,10 @@ static int git_tar_config(const char *var, const char *value, void *cb)
 		}
 		return 0;
 	}
+	if (!strcmp(var, "tar.ustarsizemax")) {
+		ustar_size_max = git_config_ulong(var, value);
+		return 0;
+	}
 
 	return tar_filter_config(var, value, cb);
 }
diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
index 4b68bba..03bb4c7 100755
--- a/t/t5000-tar-tree.sh
+++ b/t/t5000-tar-tree.sh
@@ -102,6 +102,7 @@ test_expect_success \
      echo long filename >a/four$hundred &&
      mkdir a/bin &&
      test-genrandom "frotz" 500000 >a/bin/sh &&
+     printf "\0\0\0" >>a/bin/sh &&
      printf "A\$Format:%s\$O" "$SUBSTFORMAT" >a/substfile1 &&
      printf "A not substituted O" >a/substfile2 &&
      if test_have_prereq SYMLINKS; then
@@ -157,6 +158,12 @@ test_expect_success 'git-archive --prefix=olde-' '
 
 check_tar with_olde-prefix olde-
 
+test_expect_success !TAR_NEEDS_PAX_FALLBACK 'pax extended size headers' '
+	git -c tar.ustarsizemax=120 archive HEAD >extended_size_header.tar
+'
+
+check_tar extended_size_header
+
 test_expect_success 'git archive on large files' '
     test_config core.bigfilethreshold 1 &&
     git archive HEAD >b3.tar &&
-- 
2.9.0

