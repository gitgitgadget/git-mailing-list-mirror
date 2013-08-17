From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH] xread(): Fix read error when filtering >= 2GB on Mac OS X
Date: Sat, 17 Aug 2013 16:27:29 +0100
Message-ID: <20130817152729.GR2337@serenity.lan>
References: <1376743205-12618-1-git-send-email-prohaska@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Sat Aug 17 17:27:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VAiPv-0003rG-7H
	for gcvg-git-2@plane.gmane.org; Sat, 17 Aug 2013 17:27:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753574Ab3HQP1i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Aug 2013 11:27:38 -0400
Received: from coyote.aluminati.org ([72.9.247.114]:58991 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753509Ab3HQP1i (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Aug 2013 11:27:38 -0400
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 4C4B5606501;
	Sat, 17 Aug 2013 16:27:37 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -2.899
X-Spam-Level: 
X-Spam-Status: No, score=-2.899 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9, URIBL_BLOCKED=0.001]
	autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yxvq6pDfglsN; Sat, 17 Aug 2013 16:27:36 +0100 (BST)
Received: from serenity.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by coyote.aluminati.org (Postfix) with ESMTPSA id 23EE3198003;
	Sat, 17 Aug 2013 16:27:31 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <1376743205-12618-1-git-send-email-prohaska@zib.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232459>

On Sat, Aug 17, 2013 at 02:40:05PM +0200, Steffen Prohaska wrote:
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

Please don't use unnecessary curly braces here (see
Documentation/CodingGuidelines).

> +#endif
>  		nr = read(fd, buf, len);
>  		if ((nr < 0) && (errno == EAGAIN || errno == EINTR))
>  			continue;
> -- 
> 1.8.4.rc3.5.gfcb973a
