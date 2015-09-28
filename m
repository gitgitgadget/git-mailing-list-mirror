From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH/RFC] read-cache: fix file time comparisons with different
 precisions
Date: Mon, 28 Sep 2015 14:52:38 +0200
Organization: gmx
Message-ID: <763be6c1331ac57cf7dee3636d82f994@dscho.org>
References: <5605D88A.20104@gmail.com> <560918F8.1080905@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>
To: Karsten Blees <karsten.blees@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 28 14:52:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZgXvD-0005pb-4l
	for gcvg-git-2@plane.gmane.org; Mon, 28 Sep 2015 14:52:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932931AbbI1Mwn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Sep 2015 08:52:43 -0400
Received: from mout.gmx.net ([212.227.17.22]:64282 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932884AbbI1Mwm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Sep 2015 08:52:42 -0400
Received: from dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MEccf-1ZrDAc0H85-00Fhzn; Mon, 28 Sep 2015 14:52:39
 +0200
In-Reply-To: <560918F8.1080905@gmail.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.2
X-Provags-ID: V03:K0:xLmY591O77GsY0PzC6WWaYkKAeNH6In1OJBP15sJ1oyvVFtt3i6
 nsGVyT4ijRp4F6pF8Jpd4fSyHfVDF7BUW5DnSMqWyCGKAlP7ogjqdqDx+J7hd4/5e6fRNEH
 VkAMF2peiUUbQJ05+xlGPx4KNGLSB85I7Aqh19AuRbl4cdIA2+4XlPP1Gh4iFISLTnrcVfx
 lxhl41+T/5kjQw5aNyFRA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:FW476KauCcs=:lTs4b72C2bm+V2ZbnPj8AQ
 i9YNjeeQ7cgRBFeuLHIPVxHBePqEfMkyJr6qqA9XouQ+/bS/E0VSRyWYYrK+mCNBSfcyXfkCk
 WONqCWeATggSgiBAqZ/anR4A/3fW+sM/DzYq2lTkoZY2Ih2FPxFo5EP5fZ7vRjUIR2/VbVqMl
 e8NDLSi43FLH3KKtObWZYC5NfgKnm3opxcrTo25lkdlMTWKmHhU3f0+OiTf6keIpeBfuk8Tpn
 WbvLAQ+NgPJI5X4X2ltr/1QWawXzxo7cCGwVTXiXgcJLYtAsXqxVJdH2XCZnoZfqSK+cET4fx
 g3Jrk/UCb0PJjzoQZMYcj96MtNqB+pv5yn1z7ePae90FradZfu5xzSlIFk3zIiJcGtN7EG3F9
 jfKGbFo9kOjt8yjZto2Wxg9Qq6GIpsXzlcVfYItPWKryRruNU1pHGriEkXElu7cscs3XRWodx
 /EDbusORIKb+o33qvk8841ZMQcn8nfMIzOMdD9Z+lAfhtVICXDZgyNQdVbbMZOjxG789LTvP2
 Rvgt8w+0BwR4wWJ4qxuCj36gzaio8bmtZFPxRtYHCYZSuATOjUdgDwn3H4oOL77i7QS2gF3+R
 5AHxJMSIrM12O5VRHHQtjnEfzE5D2GDwH619FIUOS/VhgmZm29GM5fALFjiHZcEz2//eTgDbL
 JTHZa30wTqymlOJrD8fRMlAankSVIydfGros0YUIgycWQ0hpFfM6X4/vaDdSK57oAO6PjzZTy
 +6tQXn1045NC0x80W1M4w/stfJbjVArgMYdhNQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278715>

Hi Karsten,

On 2015-09-28 12:39, Karsten Blees wrote:
> Different git variants record file times in the index with different
> precisions, according to their capabilities. E.g. git compiled with NO_NSEC
> records seconds only, JGit records the mtime in milliseconds, but leaves
> ctime blank (because ctime is unavailable in Java).
> 
> This causes performance issues in git compiled with USE_NSEC, because index
> entries with such 'incomplete' timestamps are considered dirty, triggering
> unnecessary content checks.
> 
> Add a file time comparison function that auto-detects the precision based
> on the number of trailing 0 digits, and compares with the lower precision
> of both values. This initial version supports the known precisions seconds
> (git + NO_NSEC), milliseconds (JGit) and nanoseconds (git + USE_NSEC), but
> can be easily extended to e.g. microseconds.
> 
> Use the new comparison function in both dirty and racy checks. As a side
> effect, this fixes racy detection in USE_NSEC-enabled git with
> core.checkStat=minimal, as the coreStat setting now affects racy checks as
> well.
> 
> Finally, do not check ctime if ctime.sec is 0 (as recorded by JGit).

Great analysis, and nice patch. I would like to offer one suggestion in addition:

> diff --git a/read-cache.c b/read-cache.c
> index 87204a5..3a4e6cd 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -99,23 +99,50 @@ void fill_stat_data(struct stat_data *sd, struct stat *st)
>  	sd->sd_size = st->st_size;
>  }
>  
> +/*
> + * Compares two file times. Returns 0 if equal, <0 if t1 < t2, >0 if t1 > t2.
> + * Auto-detects precision based on trailing 0 digits. Compares seconds only if
> + * core.checkStat=minimal.
> + */
> +static inline int cmp_filetime(uint32_t t1_sec, uint32_t t1_nsec,
> +			       uint32_t t2_sec, uint32_t t2_nsec) {
> +#ifdef USE_NSEC
> +	/*
> +	 * Compare seconds and return result if different, or checkStat=mimimal,
> +	 * or one of the time stamps has second precision only (nsec == 0).
> +	 */
> +	int diff = t1_sec - t2_sec;
> +	if (diff || !check_stat || !t1_nsec || !t2_nsec)
> +		return diff;
> +
> +	/*
> +	 * Check if one of the time stamps has millisecond precision only (i.e.
> +	 * the trailing 6 digits are 0). First check the trailing 6 bits so that
> +	 * we only do (slower) modulo division if necessary.
> +	 */
> +	if ((!(t1_nsec & 0x3f) && !(t1_nsec % 1000000)) ||
> +	    (!(t2_nsec & 0x3f) && !(t2_nsec % 1000000)))
> +		/* Compare milliseconds. */
> +		return (t1_nsec - t2_nsec) / 1000000;
> +
> +	/* Compare nanoseconds */
> +	return t1_nsec - t2_nsec;
> +#else
> +	return t1_sec - t2_sec;
> +#endif
> +}

As this affects only setups where the same repository is accessed via clients with different precision, would it make sense to hide this behind a config option? I.e. something like

static int cmp_filetime_precise(uint32_t t1_sec, uint32_t t1_nsec,
			        uint32_t t2_sec, uint32_t t2_nsec)
{
#ifdef USE_NSEC
	return t1_sec != t2_sec ? t1_sec - t2_sec : t1_nsec - t2_nsec;
#else
	return t1_sec - t2_sec;
#endif
}

static int cmp_filetime_mixed(uint32_t t1_sec, uint32_t t1_nsec,
			      uint32_t t2_sec, uint32_t t2_nsec)
{
#ifdef USE_NSEC
	... detect lower precision and compare with lower precision only...
#else
	return t1_sec - t2_sec;
#endif
}

static (int *)cmp_filetime(uint32_t t1_sec, uint32_t t1_nsec,
			   uint32_t t2_sec, uint32_t t2_nsec)
	= cmp_filetime_precise;

... modify cmp_filetime_precise if core.mixedTimeSpec = true...

Otherwise there would be that little loop-hole where (nsec % 1000) == 0 *by chance* and we assume the timestamps to be identical even if they are not.

Ciao,
Dscho
