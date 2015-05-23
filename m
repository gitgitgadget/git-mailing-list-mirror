From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 1/3] stat_validity: handle non-regular files
Date: Sat, 23 May 2015 13:00:06 +0200
Message-ID: <55605DB6.6040909@alum.mit.edu>
References: <20150522235116.GA4300@peff.net> <20150522235143.GA4818@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: pclouds@gmail.com, git@vger.kernel.org
To: Jeff King <peff@peff.net>, steve.norman@thomsonreuters.com
X-From: git-owner@vger.kernel.org Sat May 23 13:00:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yw7AH-0003fZ-4P
	for gcvg-git-2@plane.gmane.org; Sat, 23 May 2015 13:00:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932350AbbEWLAU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 May 2015 07:00:20 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:62596 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932329AbbEWLAS (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 May 2015 07:00:18 -0400
X-AuditID: 1207440c-f79df6d000000d2d-01-55605db99dc7
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 9A.33.03373.9BD50655; Sat, 23 May 2015 07:00:09 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB018F.dip0.t-ipconnect.de [93.219.1.143])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t4NB07J4001875
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Sat, 23 May 2015 07:00:08 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.6.0
In-Reply-To: <20150522235143.GA4818@peff.net>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJKsWRmVeSWpSXmKPExsUixO6iqLszNiHU4GGngEXXlW4mi+4pbxkt
	frT0MFs8/niU0YHFY+esu+wez3r3MHr83NXF5PF5k1wASxS3TVJiSVlwZnqevl0Cd8a+3ZvZ
	CzqEKq69lmhgnM3XxcjJISFgIjF35jw2CFtM4sK99UA2F4eQwGVGiX0fDzNCOOeYJD7On88I
	UsUroC0xYe9CoCoODhYBVYmjvVEgYTYBXYlFPc1MILaoQJBE67WpUOWCEidnPmEBsUUE7CRO
	tu9mBmllFtCS2NFSBhIWFnCQ2DN9JzuILSTgK3HpxwEwmxNo5NFZ91hBbGYBdYk/8y4xQ9jy
	Es1bZzNPYBSYhWTDLCRls5CULWBkXsUol5hTmqubm5iZU5yarFucnJiXl1qka6iXm1mil5pS
	uokREsw8Oxi/rZM5xCjAwajEw3vhcXyoEGtiWXFl7iFGSQ4mJVFeMc2EUCG+pPyUyozE4oz4
	otKc1OJDjBIczEoivCvUgHK8KYmVValF+TApaQ4WJXFe1SXqfkIC6YklqdmpqQWpRTBZGQ4O
	JQner9FAjYJFqempFWmZOSUIaSYOTpDhXFIixal5KalFiaUlGfGgKI0vBsYpSIoHaG95DMje
	4oLEXKAoROspRkUpcV4+kIQASCKjNA9uLCxFvWIUB/pSmHciSBUPML3Bdb8CGswENHjVhFiQ
	wSWJCCmpBka5CysD005rR+/3kLm+sVYmje3692d9Ptkfrws8nMbc/cWdm+G3UrW54KsP8/3X
	Z29ifPxI/ApXR+o05eylk3k2l7513bNA8GV2UwB77truY5Z7js8w2+yety5G+HyU 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269799>

On 05/23/2015 01:51 AM, Jeff King wrote:
> The stat_validity code was originally written to avoid
> re-reading the packed-refs file when it has not changed. It
> makes sure that the file continues to match S_ISREG() when
> we check it.
> 
> However, we can use the same concept on a directory to see
> whether it has been modified. Even though we still have to
> touch the filesystem to do the stat, this can provide a
> speedup even over opendir/readdir/closedir, especially on
> high-latency filesystems like NFS.
> 
> This patch adds a "mode" field to stat_validity, which lets
> us check that the mode has stayed the same (rather than
> explicitly checking that it is a regular file).

I don't have any insight about whether mtimes are reliable change
indicators for directories.

But if you make this change, you are changing the contract of the
stat_validity functions:

* Have you verified that no callers rely on the old stat_validity's
check that the file is a regular file?

* The docstrings in cache.h need to be updated.

> As a bonus cleanup, we can stop allocating the embedded
> "stat_data" on the heap. Prior to this patch, we needed to
> represent the case where the file did not exist, and we used
> "sv->sd == NULL" for that. Now we can simply check that
> "sv->mode" is 0.
> 
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  cache.h      |  3 ++-
>  read-cache.c | 16 ++++++----------
>  2 files changed, 8 insertions(+), 11 deletions(-)
> 
> diff --git a/cache.h b/cache.h
> index c97d807..2941e7e 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -1660,7 +1660,8 @@ int sane_execvp(const char *file, char *const argv[]);
>   * for the index.
>   */
>  struct stat_validity {
> -	struct stat_data *sd;
> +	struct stat_data sd;
> +	unsigned mode;
>  };

Could the mode be stored directly in stat_data?

By comparing modes, you are not only comparing file type (S_ISREG vs
S_ISDIR etc.) but also all of the file permissions. That seems OK with
me but you might want to document that fact. Plus, I don't know whether
POSIX allows additional, implementation-defined information to be stored
in st_mode. If so, you would be comparing that, too.

> [...]

Otherwise, looks OK.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
