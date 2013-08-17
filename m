From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] xread(): Fix read error when filtering >= 2GB on Mac
 OS X
Date: Sat, 17 Aug 2013 19:16:48 +0200
Message-ID: <520FB000.7020000@kdbg.org>
References: <1376743205-12618-1-git-send-email-prohaska@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Sat Aug 17 19:17:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VAk7h-0000OZ-Gq
	for gcvg-git-2@plane.gmane.org; Sat, 17 Aug 2013 19:17:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753885Ab3HQRQ5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Aug 2013 13:16:57 -0400
Received: from bsmtp1.bon.at ([213.33.87.15]:8994 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753644Ab3HQRQ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Aug 2013 13:16:56 -0400
Received: from [10.217.124.121] (178.115.248.121.wireless.dyn.drei.com [178.115.248.121])
	by bsmtp.bon.at (Postfix) with ESMTP id CA21D130054;
	Sat, 17 Aug 2013 19:16:52 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130307 Thunderbird/17.0.4
In-Reply-To: <1376743205-12618-1-git-send-email-prohaska@zib.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232463>

Am 17.08.2013 14:40, schrieb Steffen Prohaska:
> Previously, filtering more than 2GB through an external filter (see
> test) failed on Mac OS X 10.8.4 (12E55) with:
>
>      error: read from external filter cat failed
>      error: cannot feed the input to external filter cat
>      error: cat died of signal 13
>      error: external filter cat failed 141
>      error: external filter cat failed
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
>   t/t0021-conversion.sh | 9 +++++++++
>   wrapper.c             | 8 ++++++++
>   2 files changed, 17 insertions(+)
>
> diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
> index e50f0f7..aec1253 100755
> --- a/t/t0021-conversion.sh
> +++ b/t/t0021-conversion.sh
> @@ -190,4 +190,13 @@ test_expect_success 'required filter clean failure' '
>   	test_must_fail git add test.fc
>   '
>
> +test_expect_success 'filter large file' '
> +	git config filter.largefile.smudge cat &&
> +	git config filter.largefile.clean cat &&
> +	dd if=/dev/zero of=2GB count=2097152 bs=1024 &&

We don't have /dev/zero on Windows. Even if we get a file slightly over 
2GB, we can't handle it on Windows, and other 32bit architectures will 
very likely also be handicapped.

Finally, this test (if it remains in some form) should probably be 
protected by EXPENSIVE.

> +	echo "/2GB filter=largefile" >.gitattributes &&

Drop the slash, please; it may confuse our bash on Windows (it doesn't 
currently because echo is a builtin, but better safe than sorry).

> +	git add 2GB 2>err &&
> +	! grep -q "error" err

Executive summary: drop everything starting at "2>err".

Long story: Can it happen that (1) git add succeeds, but still produces 
something on stderr, and (2) we do not care what this something is as long 
as it does not contain "error"? I don't think this combination of 
conditions makes sense; it's sufficient to check that git add does not fail.

BTW, if you add

	... &&
	rm -f 2GB &&
	git checkout -- 2GB

you would also test the smudge filter code path with a huge file, no?

BTW2, to create a file with slightly over 2GB, you can use

	for i in $(test_seq 0 128); do printf "%16777216d" 1; done >2GB

> +'
> +
>   test_done
> diff --git a/wrapper.c b/wrapper.c
> index 6a015de..2a2f496 100644
> --- a/wrapper.c
> +++ b/wrapper.c
> @@ -139,6 +139,14 @@ ssize_t xread(int fd, void *buf, size_t len)
>   {
>   	ssize_t nr;
>   	while (1) {
> +#ifdef __APPLE__
> +		const size_t twoGB = (1l << 31);
> +		/* len >= 2GB immediately fails on Mac OS X with EINVAL when
> +		 * reading from pipe. */
> +		if (len >= twoGB) {
> +			len = twoGB - 1;
> +		}
> +#endif
>   		nr = read(fd, buf, len);
>   		if ((nr < 0) && (errno == EAGAIN || errno == EINTR))
>   			continue;
>

-- Hannes
