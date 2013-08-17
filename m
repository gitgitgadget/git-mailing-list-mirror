From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH] xread(): Fix read error when filtering >= 2GB on Mac
 OS X
Date: Sat, 17 Aug 2013 17:56:16 +0200
Message-ID: <520F9D20.7000008@web.de>
References: <1376743205-12618-1-git-send-email-prohaska@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Sat Aug 17 17:56:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VAirW-0001Je-OR
	for gcvg-git-2@plane.gmane.org; Sat, 17 Aug 2013 17:56:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753682Ab3HQP4T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Aug 2013 11:56:19 -0400
Received: from mout.web.de ([212.227.15.3]:61223 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753644Ab3HQP4S (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Aug 2013 11:56:18 -0400
Received: from [192.168.209.26] ([195.67.191.23]) by smtp.web.de (mrweb001)
 with ESMTPA (Nemesis) id 0MMW5u-1VBFEc41La-008FhI for <git@vger.kernel.org>;
 Sat, 17 Aug 2013 17:56:17 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:17.0) Gecko/20130801 Thunderbird/17.0.8
In-Reply-To: <1376743205-12618-1-git-send-email-prohaska@zib.de>
X-Provags-ID: V03:K0:xVHJ6i2Iprlo6e3TiWndp/EBaYgfAn+PW7YAUBzIXLcdgFXq6cp
 Yqz7kfRDd/qEfkXiR8n/CFvn1/RAEGPqYGd6j1HPDksnr7swRsa0bAEKewhTrMMsf9KPLR6
 rSv+20zvYHZKjqcsmUj254nSBQCnn9vPgPeTzXtRJTBu/+GzAegPuCjJA+dsKKyOjmYR62L
 XGiITWDxQrcjZZUl16ujQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232461>

On 2013-08-17 14.40, Steffen Prohaska wrote:
> Previously, filtering more than 2GB through an external filter (see
> test) failed on Mac OS X 10.8.4 (12E55) with:
> 
>     error: read from external filter cat failed
>     error: cannot feed the input to external filter cat
>     error: cat died of signal 13
>     error: external filter cat failed 141
>     error: external filter cat failed
> 
> The reason is that read() immediately returns with EINVAL if len >= 2GB.
> I haven't found any information under which specific conditions this
> occurs.  My suspicion is that it happens when reading from a pipe, while
> reading from a standard file should always be fine.  I haven't tested
> any other version of Mac OS X, though I'd expect that other versions are
> affected as well.
> 
> The problem is fixed by always reading less than 2GB in xread().
> xread() doesn't guarantee to read all the requested data at once, and
> callers are expected to gracefully handle partial reads.  Slicing large
> reads into 2GB pieces should not hurt practical performance.
> 
> Signed-off-by: Steffen Prohaska <prohaska@zib.de>
> ---
>  t/t0021-conversion.sh | 9 +++++++++
>  wrapper.c             | 8 ++++++++
>  2 files changed, 17 insertions(+)
> 
> diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
> index e50f0f7..aec1253 100755
> --- a/t/t0021-conversion.sh
> +++ b/t/t0021-conversion.sh
> @@ -190,4 +190,13 @@ test_expect_success 'required filter clean failure' '
>  	test_must_fail git add test.fc
>  '
>  
> +test_expect_success 'filter large file' '
> +	git config filter.largefile.smudge cat &&
> +	git config filter.largefile.clean cat &&
> +	dd if=/dev/zero of=2GB count=2097152 bs=1024 &&
> +	echo "/2GB filter=largefile" >.gitattributes &&
> +	git add 2GB 2>err &&
> +	! grep -q "error" err
> +'
> +
>  test_done
> diff --git a/wrapper.c b/wrapper.c
> index 6a015de..2a2f496 100644
> --- a/wrapper.c
> +++ b/wrapper.c
> @@ -139,6 +139,14 @@ ssize_t xread(int fd, void *buf, size_t len)
>  {
>  	ssize_t nr;
>  	while (1) {
> +#ifdef __APPLE__
> +		const size_t twoGB = (1l << 31);
> +		/* len >= 2GB immediately fails on Mac OS X with EINVAL when
> +		 * reading from pipe. */
> +		if (len >= twoGB) {
> +			len = twoGB - 1;
> +		}
> +#endif
>  		nr = read(fd, buf, len);
>  		if ((nr < 0) && (errno == EAGAIN || errno == EINTR))
>  			continue;
> 
Thanks for the patch.
I think we can we can replace  __APPLE__ define with a more generic one.
We had a similar patch for write() some time ago:

config.mak.uname
	NEEDS_CLIPPED_WRITE = YesPlease


Makefile
ifdef NEEDS_CLIPPED_WRITE
	BASIC_CFLAGS += -DNEEDS_CLIPPED_WRITE
	COMPAT_OBJS += compat/clipped-write.o
endif
