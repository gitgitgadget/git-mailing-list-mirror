From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH v3 06/24] read-cache: Don't compare uid, gid and ino on
 cygwin
Date: Sun, 18 Aug 2013 23:34:54 +0100
Message-ID: <52114C0E.4030502@ramsay1.demon.co.uk>
References: <1376854933-31241-1-git-send-email-t.gummerer@gmail.com> <1376854933-31241-7-git-send-email-t.gummerer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, trast@inf.ethz.ch, mhagger@alum.mit.edu,
	gitster@pobox.com, pclouds@gmail.com, robin.rosenberg@dewire.com,
	sunshine@sunshineco.com
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 19 00:35:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VBBZ1-0005I4-H1
	for gcvg-git-2@plane.gmane.org; Mon, 19 Aug 2013 00:35:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755468Ab3HRWfE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Aug 2013 18:35:04 -0400
Received: from mdfmta010.mxout.tch.inty.net ([91.221.169.51]:49192 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755140Ab3HRWfD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Aug 2013 18:35:03 -0400
Received: from mdfmta010.tch.inty.net (unknown [127.0.0.1])
	by mdfmta010.tch.inty.net (Postfix) with ESMTP id 79C2C4007D1;
	Sun, 18 Aug 2013 23:35:00 +0100 (BST)
Received: from mdfmta010.tch.inty.net (unknown [127.0.0.1])
	by mdfmta010.tch.inty.net (Postfix) with ESMTP id 389EA4007A6;
	Sun, 18 Aug 2013 23:35:00 +0100 (BST)
Received: from [192.168.254.1] (unknown [80.176.147.220])
	by mdfmta010.tch.inty.net (Postfix) with ESMTP;
	Sun, 18 Aug 2013 23:34:59 +0100 (BST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130801 Thunderbird/17.0.8
In-Reply-To: <1376854933-31241-7-git-send-email-t.gummerer@gmail.com>
X-MDF-HostID: 19
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232524>

On 18/08/2013 08:41 PM, Thomas Gummerer wrote:
> Cygwin doesn't have uid, gid and ino stats fields.  Therefore we should
> never check them in the match_stat_data when working on the CYGWIN
> platform.

Hmm, this is simply not true ... ;-)

The need to omit the uid, gid and ino fields from the stat checks in
your original code was caused by the "schizophrenic stat" implementation
in cygwin. (This was also before "core.checkstat" was implemented; note
the 'check_stat' conditional below ...)

However, since commit f66450ae ("cygwin: Remove the Win32 l/stat()
implementation", 22-06-2013), this patch is no longer necessary and
can simply be dropped from this series.

[I have not had time to read your new patches yet, but I seem to remember
being concerned about those platforms which have UNRELIABLE_FSTAT set.
(ie cygwin, MinGW and Windows.)]

ATB,
Ramsay Jones

> Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> ---
> 
> This patch was not tested on Cygwin yet.  I think it's needed though,
> because the re-reading of the index if it changed will no longer use
> it's own index_changed function, but use the stat_validity_check
> function instead.  Would be great if someone running Cygwin could test
> this.
> 
>  read-cache.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/read-cache.c b/read-cache.c
> index 1f827de..aa17ce7 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -82,6 +82,7 @@ int match_stat_data(const struct stat_data *sd, struct stat *st)
>  		changed |= CTIME_CHANGED;
>  #endif
>  
> +#if !defined (__CYGWIN__)
>  	if (check_stat) {
>  		if (sd->sd_uid != (unsigned int) st->st_uid ||
>  			sd->sd_gid != (unsigned int) st->st_gid)
> @@ -89,6 +90,7 @@ int match_stat_data(const struct stat_data *sd, struct stat *st)
>  		if (sd->sd_ino != (unsigned int) st->st_ino)
>  			changed |= INODE_CHANGED;
>  	}
> +#endif
>  
>  #ifdef USE_STDEV
>  	/*
> 
