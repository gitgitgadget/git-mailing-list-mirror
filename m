From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] howto: document more tools for recovery corruption
Date: Wed, 01 Apr 2015 15:21:16 -0700
Message-ID: <xmqq4mozmqw3.fsf@gitster.dls.corp.google.com>
References: <20131016083400.GA31266@sigill.intra.peff.net>
	<20150401210856.GA23050@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 02 00:21:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YdR0m-0002pi-Ld
	for gcvg-git-2@plane.gmane.org; Thu, 02 Apr 2015 00:21:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752119AbbDAWVU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Apr 2015 18:21:20 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:63472 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751688AbbDAWVT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Apr 2015 18:21:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 50AB4445DF;
	Wed,  1 Apr 2015 18:21:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TNSH1jdy1kdFiolT/zhyEq/mEmk=; b=YLDQvm
	GzgWSa5pwflqrjPNORCTJOaXYX+HmdDXU42+dbX/WI3yuYHoUsEF4+kwEjSLnzpr
	KZHKJjoy8wmHp3UxRR1FvFIp/NjVYWV8WwfutyLv6jIEPNNPPMh6uxQDxJbE7hsT
	ZlBbFgXKUFHzBGwTdPTzMm1k7k/8mXfCAVS5w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HZe9Vbm/hO/lINDyiA9XPLR9Bptr0okK
	kYqjXz8K8OzQYjimRX3Cyuy23v08Chlb5fySF5tK3RTM1koIvGAE5uQJV8gvwzMi
	Z7wyn87yaTK8ecQ4q+IO9Ae68J41jKF6XUZKagUdmz2ouBFKhib0ZcUJ6XuUp4BZ
	UqcuLW1/rOc=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4702D445DE;
	Wed,  1 Apr 2015 18:21:18 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9A388445DD;
	Wed,  1 Apr 2015 18:21:17 -0400 (EDT)
In-Reply-To: <20150401210856.GA23050@peff.net> (Jeff King's message of "Wed, 1
	Apr 2015 17:08:56 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6A9399DC-D8BD-11E4-B826-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266624>

Jeff King <peff@peff.net> writes:

> Long ago, I documented a corruption recovery I did and gave
> some C code that I used to help find a flipped bit.  I had
> to fix a similar case recently, and I ended up writing a few
> more tools.  I hope nobody ever has to use these, but it
> does not hurt to share them, just in case.

I am having a hard time deciding if I should take the Date: header
of the patch e-mail into consideration.  The munge thing looks
serious enough, though.


> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  .../howto/recover-corrupted-object-harder.txt      | 237 +++++++++++++++++++++
>  1 file changed, 237 insertions(+)
>
> diff --git a/Documentation/howto/recover-corrupted-object-harder.txt
> b/Documentation/howto/recover-corrupted-object-harder.txt
> index 23e685d..9c4cd09 100644
> --- a/Documentation/howto/recover-corrupted-object-harder.txt
> +++ b/Documentation/howto/recover-corrupted-object-harder.txt
> @@ -240,3 +240,240 @@ But more importantly, git's hashing and checksumming noticed a problem
>  that easily could have gone undetected in another system. The result
>  still compiled, but would have caused an interesting bug (that would
>  have been blamed on some random commit).
> +
> +
> +The adventure continues...
> +--------------------------
> +
> +I ended up doing this again! Same entity, new hardware. The assumption
> +at this point is that the old disk corrupted the packfile, and then the
> +corruption was migrated to the new hardware (because it was done by
> +rsync or similar, and no fsck was done at the time of migration).
> +
> +This time, the affected blob was over 20 megabytes, which was far too
> +large to do a brute-force on. I followed the instructions above to
> +create the `zlib` file. I then used the `inflate` program below to pull
> +the corrupted data from that. Examining that output gave me a hint about
> +where in the file the corruption was. But now I was working with the
> +file itself, not the zlib contents. So knowing the sha1 of the object
> +and the approximate area of the corruption, I used the `sha1-munge`
> +program below to brute-force the correct byte.
> +
> +Here's the inflate program (it's essentially `gunzip` but without the
> +`.gz` header processing):
> +
> +--------------------------
> +#include <stdio.h>
> +#include <string.h>
> +#include <zlib.h>
> +#include <stdlib.h>
> +
> +int main(int argc, char **argv)
> +{
> +	/*
> +	 * oversized so we can read the whole buffer in;
> +	 * this could actually be switched to streaming
> +	 * to avoid any memory limitations
> +	 */
> +	static unsigned char buf[25 * 1024 * 1024];
> +	static unsigned char out[25 * 1024 * 1024];
> +	int len;
> +	z_stream z;
> +	int ret;
> +
> +	len = read(0, buf, sizeof(buf));
> +	memset(&z, 0, sizeof(z));
> +	inflateInit(&z);
> +
> +	z.next_in = buf;
> +	z.avail_in = len;
> +	z.next_out = out;
> +	z.avail_out = sizeof(out);
> +
> +	ret = inflate(&z, 0);
> +	if (ret != Z_OK && ret != Z_STREAM_END)
> +		fprintf(stderr, "initial inflate failed (%d)\n", ret);
> +
> +	fprintf(stderr, "outputting %lu bytes", z.total_out);
> +	fwrite(out, 1, z.total_out, stdout);
> +	return 0;
> +}
> +--------------------------
> +
> +And here is the `sha1-munge` program:
> +
> +--------------------------
> +#include <stdio.h>
> +#include <unistd.h>
> +#include <string.h>
> +#include <signal.h>
> +#include <openssl/sha.h>
> +#include <stdlib.h>
> +
> +/* eye candy */
> +static int counter = 0;
> +static void progress(int sig)
> +{
> +	fprintf(stderr, "\r%d", counter);
> +	alarm(1);
> +}
> +
> +static const signed char hexval_table[256] = {
> +	 -1, -1, -1, -1, -1, -1, -1, -1,		/* 00-07 */
> +	 -1, -1, -1, -1, -1, -1, -1, -1,		/* 08-0f */
> +	 -1, -1, -1, -1, -1, -1, -1, -1,		/* 10-17 */
> +	 -1, -1, -1, -1, -1, -1, -1, -1,		/* 18-1f */
> +	 -1, -1, -1, -1, -1, -1, -1, -1,		/* 20-27 */
> +	 -1, -1, -1, -1, -1, -1, -1, -1,		/* 28-2f */
> +	  0,  1,  2,  3,  4,  5,  6,  7,		/* 30-37 */
> +	  8,  9, -1, -1, -1, -1, -1, -1,		/* 38-3f */
> +	 -1, 10, 11, 12, 13, 14, 15, -1,		/* 40-47 */
> +	 -1, -1, -1, -1, -1, -1, -1, -1,		/* 48-4f */
> +	 -1, -1, -1, -1, -1, -1, -1, -1,		/* 50-57 */
> +	 -1, -1, -1, -1, -1, -1, -1, -1,		/* 58-5f */
> +	 -1, 10, 11, 12, 13, 14, 15, -1,		/* 60-67 */
> +	 -1, -1, -1, -1, -1, -1, -1, -1,		/* 68-67 */
> +	 -1, -1, -1, -1, -1, -1, -1, -1,		/* 70-77 */
> +	 -1, -1, -1, -1, -1, -1, -1, -1,		/* 78-7f */
> +	 -1, -1, -1, -1, -1, -1, -1, -1,		/* 80-87 */
> +	 -1, -1, -1, -1, -1, -1, -1, -1,		/* 88-8f */
> +	 -1, -1, -1, -1, -1, -1, -1, -1,		/* 90-97 */
> +	 -1, -1, -1, -1, -1, -1, -1, -1,		/* 98-9f */
> +	 -1, -1, -1, -1, -1, -1, -1, -1,		/* a0-a7 */
> +	 -1, -1, -1, -1, -1, -1, -1, -1,		/* a8-af */
> +	 -1, -1, -1, -1, -1, -1, -1, -1,		/* b0-b7 */
> +	 -1, -1, -1, -1, -1, -1, -1, -1,		/* b8-bf */
> +	 -1, -1, -1, -1, -1, -1, -1, -1,		/* c0-c7 */
> +	 -1, -1, -1, -1, -1, -1, -1, -1,		/* c8-cf */
> +	 -1, -1, -1, -1, -1, -1, -1, -1,		/* d0-d7 */
> +	 -1, -1, -1, -1, -1, -1, -1, -1,		/* d8-df */
> +	 -1, -1, -1, -1, -1, -1, -1, -1,		/* e0-e7 */
> +	 -1, -1, -1, -1, -1, -1, -1, -1,		/* e8-ef */
> +	 -1, -1, -1, -1, -1, -1, -1, -1,		/* f0-f7 */
> +	 -1, -1, -1, -1, -1, -1, -1, -1,		/* f8-ff */
> +};
> +
> +static inline unsigned int hexval(unsigned char c)
> +{
> +return hexval_table[c];
> +}
> +
> +static int get_sha1_hex(const char *hex, unsigned char *sha1)
> +{
> +	int i;
> +	for (i = 0; i < 20; i++) {
> +		unsigned int val;
> +		/*
> +		 * hex[1]=='\0' is caught when val is checked below,
> +		 * but if hex[0] is NUL we have to avoid reading
> +		 * past the end of the string:
> +		 */
> +		if (!hex[0])
> +			return -1;
> +		val = (hexval(hex[0]) << 4) | hexval(hex[1]);
> +		if (val & ~0xff)
> +			return -1;
> +		*sha1++ = val;
> +		hex += 2;
> +	}
> +	return 0;
> +}
> +
> +int main(int argc, char **argv)
> +{
> +	/* oversized so we can read the whole buffer in */
> +	static unsigned char buf[25 * 1024 * 1024];
> +	char header[32];
> +	int header_len;
> +	unsigned char have[20], want[20];
> +	int start, len;
> +	SHA_CTX orig;
> +	unsigned i, j;
> +
> +	if (!argv[1] || get_sha1_hex(argv[1], want)) {
> +		fprintf(stderr, "usage: sha1-munge <sha1> [start] <file.in\n");
> +		return 1;
> +	}
> +
> +	if (argv[2])
> +		start = atoi(argv[2]);
> +	else
> +		start = 0;
> +
> +	len = read(0, buf, sizeof(buf));
> +	header_len = sprintf(header, "blob %d", len) + 1;
> +	fprintf(stderr, "using header: %s\n", header);
> +
> +	/*
> +	 * We keep a running sha1 so that if you are munging
> +	 * near the end of the file, we do not have to re-sha1
> +	 * the unchanged earlier bytes
> +	 */
> +	SHA1_Init(&orig);
> +	SHA1_Update(&orig, header, header_len);
> +	if (start)
> +		SHA1_Update(&orig, buf, start);
> +
> +	signal(SIGALRM, progress);
> +	alarm(1);
> +
> +	for (i = start; i < len; i++) {
> +		unsigned char c;
> +		SHA_CTX x;
> +
> +#if 0
> +		/*
> +		 * deletion -- this would not actually work in practice,
> +		 * I think, because we've already committed to a
> +		 * particular size in the header. Ditto for addition
> +		 * below. In those cases, you'd have to do the whole
> +		 * sha1 from scratch, or possibly keep three running
> +		 * "orig" sha1 computations going.
> +		 */
> +		memcpy(&x, &orig, sizeof(x));
> +		SHA1_Update(&x, buf + i + 1, len - i - 1);
> +		SHA1_Final(have, &x);
> +		if (!memcmp(have, want, 20))
> +			printf("i=%d, deletion\n", i);
> +#endif
> +
> +		/*
> +		 * replacement -- note that this tries each of the 256
> +		 * possible bytes. If you suspect a single-bit flip,
> +		 * it would be much shorter to just try the 8
> +		 * bit-flipped variants.
> +		 */
> +		c = buf[i];
> +		for (j = 0; j <= 0xff; j++) {
> +			buf[i] = j;
> +
> +			memcpy(&x, &orig, sizeof(x));
> +			SHA1_Update(&x, buf + i, len - i);
> +			SHA1_Final(have, &x);
> +			if (!memcmp(have, want, 20))
> +				printf("i=%d, j=%02x\n", i, j);
> +		}
> +		buf[i] = c;
> +
> +#if 0
> +		/* addition */
> +		for (j = 0; j <= 0xff; j++) {
> +			unsigned char extra = j;
> +			memcpy(&x, &orig, sizeof(x));
> +			SHA1_Update(&x, &extra, 1);
> +			SHA1_Update(&x, buf + i, len - i);
> +			SHA1_Final(have, &x);
> +			if (!memcmp(have, want, 20))
> +				printf("i=%d, addition=%02x", i, j);
> +		}
> +#endif
> +
> +		SHA1_Update(&orig, buf + i, 1);
> +		counter++;
> +	}
> +
> +	alarm(0);
> +	fprintf(stderr, "\r%d\n", counter);
> +	return 0;
> +}
> +--------------------------
