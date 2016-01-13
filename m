From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v4 2/4] compat/basename: make basename() conform to POSIX
Date: Wed, 13 Jan 2016 00:49:03 +0000
Message-ID: <56959EFF.6050207@ramsayjones.plus.com>
References: <cover.1452536924.git.johannes.schindelin@gmx.de>
 <cover.1452585382.git.johannes.schindelin@gmx.de>
 <a7375faaba405354b30bc19c6edbdb1ef7c68ab1.1452585382.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
To: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 13 01:49:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJ9ci-0006uo-Fa
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jan 2016 01:49:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754062AbcAMAtN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jan 2016 19:49:13 -0500
Received: from avasout07.plus.net ([84.93.230.235]:34854 "EHLO
	avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754055AbcAMAtM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jan 2016 19:49:12 -0500
Received: from [10.0.2.15] ([46.208.159.221])
	by avasout07 with smtp
	id 5CpA1s0024mu3xa01CpBWC; Wed, 13 Jan 2016 00:49:11 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=QqujpgGd c=1 sm=1 tr=0
 a=Sp5fw55EgyGSOjouSGNDoQ==:117 a=Sp5fw55EgyGSOjouSGNDoQ==:17 a=0Bzu9jTXAAAA:8
 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10 a=s5jvgZ67dGcA:10 a=EBOSESyhAAAA:8
 a=N659UExz7-8A:10 a=Fdpfe9AdFL2u_w97LP8A:9 a=pILNOxqGKmIA:10
X-AUTH: ramsayjones@:2500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.4.0
In-Reply-To: <a7375faaba405354b30bc19c6edbdb1ef7c68ab1.1452585382.git.johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283864>



On 12/01/16 07:57, Johannes Schindelin wrote:
> According to POSIX, basename("/path/") should return "path", not
> "path/". Likewise, basename(NULL) and basename("") should both
> return "." to conform.
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  compat/basename.c | 20 +++++++++++++++++---
>  1 file changed, 17 insertions(+), 3 deletions(-)
> 
> diff --git a/compat/basename.c b/compat/basename.c
> index 9f00421..0f1b0b0 100644
> --- a/compat/basename.c
> +++ b/compat/basename.c
> @@ -4,10 +4,24 @@
>  char *gitbasename (char *path)
>  {
>  	const char *base;
> -	skip_dos_drive_prefix(&path);
> +
> +	if (path)
> +		skip_dos_drive_prefix(&path);
> +
> +	if (!path || !*path)
> +		return ".";
> +
>  	for (base = path; *path; path++) {
> -		if (is_dir_sep(*path))
> -			base = path + 1;
> +		if (!is_dir_sep(*path))
> +			continue;
> +		do {
> +			path++;
> +		} while (is_dir_sep(*path));
> +		if (*path)
> +			base = path;
> +		else
> +			while (--path != base && is_dir_sep(*path))
> +				*path = '\0';
>  	}
>  	return (char *)base;
>  }
> 

I don't suppose it makes much difference, but I find my version
slightly easier to read:

char *gitbasename (char *path)
{
	char *p;

	if (!path || !*path)
		return ".";
	/* skip drive designator, if any */
	if (has_dos_drive_prefix(path))
		path += 2;
	if (!*path)
		return ".";
	/* trim trailing directory separators */
	p = path + strlen(path) - 1;
	while (is_dir_sep(*p)) {
		if (p == path)
			return path;
		*p-- = '\0';
	}
	/* find begining of last path component */
	while (p > path && !is_dir_sep(*p))
		p--;
	if (is_dir_sep(*p))
		p++;
	return p;
}

ATB,
Ramsay Jones
