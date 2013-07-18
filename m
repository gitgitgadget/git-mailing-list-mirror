From: Drew Northup <n1xim.email@gmail.com>
Subject: Re: [PATCH] TIG: Implement mkstemps() work-around for platforms lacking
 it
Date: Thu, 18 Jul 2013 00:45:23 -0400
Message-ID: <51E772E3.20008@gmail.com>
References: <1373383992-4298-1-git-send-email-n1xim.email@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>, Jonas Fonseca <fonseca@diku.dk>
To: Drew Northup <n1xim.email@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 18 06:52:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UzgCI-0006nK-FB
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jul 2013 06:52:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751302Ab3GREvt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jul 2013 00:51:49 -0400
Received: from mail-ye0-f180.google.com ([209.85.213.180]:45342 "EHLO
	mail-ye0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751273Ab3GREvs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jul 2013 00:51:48 -0400
Received: by mail-ye0-f180.google.com with SMTP id r11so813771yen.25
        for <git@vger.kernel.org>; Wed, 17 Jul 2013 21:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=yLr/8UOUm1O6u2yAPPP/1o3+wXleRKicB8zW9xruXH4=;
        b=G1L1puok8a9KdR1QSQMWNVCbZ5fTT1aL7hedB/nGbbXj1pK/PKOq1IZd55hI29BUHY
         Y8ikOT+FQsHZFqZcSPD7okZYMFOMjTAsFyHCKECKbuYVOeDHUDDotFjLlMIzCb3F7ogl
         fk8W7Tet9XyRgPKg2oTy5dc3bjoufiqYq9QaF1XxUoGZalsJLCWBgCVG2N8m7kY2/0to
         fgXRRF7FA/vshyQ5LFWr9RySrTuT5B8JUKV93phu3WOp2CanjQQzHtJHZ73Thu85VpyW
         71DbD5LVoZNAquMItS2u21R/0IZ4f6Y3usqFtB1P3a/8PO4Mh/vBgl3PslvJ5u1Bc0q9
         RZ5Q==
X-Received: by 10.236.72.165 with SMTP id t25mr4644115yhd.47.1374122726761;
        Wed, 17 Jul 2013 21:45:26 -0700 (PDT)
Received: from [192.168.0.37] (pool-70-16-105-6.port.east.myfairpoint.net. [70.16.105.6])
        by mx.google.com with ESMTPSA id v32sm12660920yhc.12.2013.07.17.21.45.25
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 17 Jul 2013 21:45:26 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.28) Gecko/20120314 Thunderbird/3.1.20
In-Reply-To: <1373383992-4298-1-git-send-email-n1xim.email@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230676>

Giving this one last kick to make absolutely sure that nobody disagrees
with allowing this code to be included into tig, which does not limit
to a specific version of the GPL (version 2 in the case of git, any
version equal to or newer than 2 in the case of tig), pursuant to
paragraph 9 of said license.

On 07/09/2013 11:33 AM, Drew Northup wrote:
> The function mkstemps() isn't available in all libc implementations. In
> glibc it first became available in 2.11, so platforms such as RHEL 5&
> Slackware 13 lack it. This is likely true of many non-LINUX platforms
> as well.
>
> This fixes breakage that was introduced with a0fdac29 "Create temporary
> file with name as suffix."
>
> Signed-off-by: Drew Northup<n1xim.email@gmail.com>
> ---
>
> This work-around is taken from Git and was inspired by code in libiberty.
> It is presumed that this isn't a problem due to compatible license terms.
>
> A (virtually identical) version of this available in
> https://github.com/n1xim/tig/tree/mkstemps_wkarnd (differences only in
> the commit message).
>
>   configure.ac |  4 ++++
>   io.c         | 77 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>   io.h         | 14 +++++++++++
>   3 files changed, 95 insertions(+)
>
> diff --git a/configure.ac b/configure.ac
> index 8dd2508..40e1f85 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -21,6 +21,10 @@ AC_SUBST(CURSES_LIB)
>
>   AM_ICONV
>
> +dnl  Not all platforms have mkstemps
> +AC_CHECK_FUNC([mkstemps], [AC_DEFINE([HAVE_MKSTEMPS], [1],
> +	      [Define if mkstemps is available.])])
> +
>   AC_PROG_CC
>
>   AC_CHECK_PROGS(ASCIIDOC, [asciidoc], [false])
> diff --git a/io.c b/io.c
> index 3ff1d1c..f1b6fbc 100644
> --- a/io.c
> +++ b/io.c
> @@ -237,6 +237,83 @@ encoding_convert(struct encoding *encoding, char *line)
>   }
>
>   /*
> + * Compatibility: no mkstemps()
> + */
> +
> +/* Adapted from libiberty's mkstemp.c via Git's wrapper.c. */
> +
> +#undef TMP_MAX
> +#define TMP_MAX 16384
> +
> +int tig_mkstemps_mode(char *pattern, int suffix_len, int mode)
> +{
> +	static const char letters[] =
> +		"abcdefghijklmnopqrstuvwxyz"
> +		"ABCDEFGHIJKLMNOPQRSTUVWXYZ"
> +		"0123456789";
> +	static const int num_letters = 62;
> +	uint64_t value;
> +	struct timeval tv;
> +	char *template;
> +	size_t len;
> +	int fd, count;
> +
> +	len = strlen(pattern);
> +
> +	if (len<  6 + suffix_len) {
> +		errno = EINVAL;
> +		return -1;
> +	}
> +
> +	if (strncmp(&pattern[len - 6 - suffix_len], "XXXXXX", 6)) {
> +		errno = EINVAL;
> +		return -1;
> +	}
> +
> +	/*
> +	 * Replace pattern's XXXXXX characters with randomness.
> +	 * Try TMP_MAX different filenames.
> +	 */
> +	gettimeofday(&tv, NULL);
> +	value = ((size_t)(tv.tv_usec<<  16)) ^ tv.tv_sec ^ getpid();
> +	template =&pattern[len - 6 - suffix_len];
> +	for (count = 0; count<  TMP_MAX; ++count) {
> +		uint64_t v = value;
> +		/* Fill in the random bits. */
> +		template[0] = letters[v % num_letters]; v /= num_letters;
> +		template[1] = letters[v % num_letters]; v /= num_letters;
> +		template[2] = letters[v % num_letters]; v /= num_letters;
> +		template[3] = letters[v % num_letters]; v /= num_letters;
> +		template[4] = letters[v % num_letters]; v /= num_letters;
> +		template[5] = letters[v % num_letters]; v /= num_letters;
> +
> +		fd = open(pattern, O_CREAT | O_EXCL | O_RDWR, mode);
> +		if (fd>  0)
> +			return fd;
> +		/*
> +		 * Fatal error (EPERM, ENOSPC etc).
> +		 * It doesn't make sense to loop.
> +		 */
> +		if (errno != EEXIST)
> +			break;
> +		/*
> +		 * This is a random value.  It is only necessary that
> +		 * the next TMP_MAX values generated by adding 7777 to
> +		 * VALUE are different with (module 2^32).
> +		 */
> +		value += 7777;
> +	}
> +	/* We return the null string if we can't find a unique file name.  */
> +	pattern[0] = '\0';
> +	return -1;
> +}
> +
> +int tigmkstemps(char *pattern, int suffix_len)
> +{
> +	return tig_mkstemps_mode(pattern, suffix_len, 0600);
> +}
> +
> +/*
>    * Executing external commands.
>    */
>
> diff --git a/io.h b/io.h
> index 646989d..8f43216 100644
> --- a/io.h
> +++ b/io.h
> @@ -16,6 +16,9 @@
>
>   #include "tig.h"
>
> +/* Needed for mkstemps workaround */
> +#include<stdint.h>
> +
>   /*
>    * Argument array helpers.
>    */
> @@ -41,6 +44,17 @@ struct encoding *encoding_open(const char *fromcode);
>   char *encoding_convert(struct encoding *encoding, char *line);
>
>   /*
> + * Compatibility: no mkstemps()
> + */
> +
> +#ifndef HAVE_MKSTEMPS
> +#define mkstemps tigmkstemps
> +#endif
> +
> +int tigmkstemps(char *, int);
> +int tig_mkstemps_mode(char *pattern, int suffix_len, int mode);
> +
> +/*
>    * Executing external commands.
>    */
>
