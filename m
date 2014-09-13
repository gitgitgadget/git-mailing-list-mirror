From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v4 11/32] delete_ref_loose(): don't muck around in the
 lock_file's filename
Date: Sat, 13 Sep 2014 09:41:18 +0200
Message-ID: <5413F51E.3060600@kdbg.org>
References: <1409989846-22401-1-git-send-email-mhagger@alum.mit.edu> <1409989846-22401-12-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	=?ISO-8859-15?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sat Sep 13 09:41:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XShxe-00025j-SC
	for gcvg-git-2@plane.gmane.org; Sat, 13 Sep 2014 09:41:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751684AbaIMHlX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Sep 2014 03:41:23 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:41464 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751597AbaIMHlW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Sep 2014 03:41:22 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 71856130050;
	Sat, 13 Sep 2014 09:41:19 +0200 (CEST)
Received: from dx.sixt.local (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 4B59419F364;
	Sat, 13 Sep 2014 09:41:18 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.1.0
In-Reply-To: <1409989846-22401-12-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256954>

Am 06.09.2014 um 09:50 schrieb Michael Haggerty:
> It's bad manners.  Especially since, if unlink_or_warn() failed, the
> memory wasn't restored to its original contents.

I do not see how the old code did not restore the file name. Except for
this nit, the patch looks good.

> 
> So make our own copy to work with.
> 
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
>  refs.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/refs.c b/refs.c
> index 828522d..8a63073 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -2545,12 +2545,15 @@ static int repack_without_ref(const char *refname)
>  static int delete_ref_loose(struct ref_lock *lock, int flag)
>  {
>  	if (!(flag & REF_ISPACKED) || flag & REF_ISSYMREF) {
> -		/* loose */
> -		int err, i = strlen(lock->lk->filename) - LOCK_SUFFIX_LEN;
> -
> -		lock->lk->filename[i] = 0;
> -		err = unlink_or_warn(lock->lk->filename);
> -		lock->lk->filename[i] = LOCK_SUFFIX[0];
> +		/*
> +		 * loose.  The loose file name is the same as the
> +		 * lockfile name, minus ".lock":
> +		 */
> +		char *loose_filename = xmemdupz(
> +				lock->lk->filename,
> +				strlen(lock->lk->filename) - LOCK_SUFFIX_LEN);
> +		int err = unlink_or_warn(loose_filename);
> +		free(loose_filename);
>  		if (err && errno != ENOENT)
>  			return 1;
>  	}
> 
