From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCHv2 5/5] refs.c: enable large transactions
Date: Thu, 22 Jan 2015 12:59:11 +0000
Message-ID: <54C0F41F.2080705@ramsay1.demon.co.uk>
References: <1421893929-7447-1-git-send-email-sbeller@google.com> <1421893929-7447-6-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Stefan Beller <sbeller@google.com>, peff@peff.net,
	git@vger.kernel.org, gitster@pobox.com, mhagger@alum.mit.edu,
	loic@dachary.org
X-From: git-owner@vger.kernel.org Thu Jan 22 13:59:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YEHM2-0002IZ-0d
	for gcvg-git-2@plane.gmane.org; Thu, 22 Jan 2015 13:59:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751448AbbAVM7S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2015 07:59:18 -0500
Received: from mdfmta010.mxout.tch.inty.net ([91.221.169.51]:53392 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750916AbbAVM7R (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jan 2015 07:59:17 -0500
Received: from mdfmta010.tch.inty.net (unknown [127.0.0.1])
	by mdfmta010.tch.inty.net (Postfix) with ESMTP id 69D30401E92;
	Thu, 22 Jan 2015 12:59:13 +0000 (GMT)
Received: from mdfmta010.tch.inty.net (unknown [127.0.0.1])
	by mdfmta010.tch.inty.net (Postfix) with ESMTP id 20275401E4F;
	Thu, 22 Jan 2015 12:59:13 +0000 (GMT)
Received: from [10.0.2.15] (unknown [80.176.147.220])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mdfmta010.tch.inty.net (Postfix) with ESMTP;
	Thu, 22 Jan 2015 12:59:12 +0000 (GMT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
In-Reply-To: <1421893929-7447-6-git-send-email-sbeller@google.com>
X-MDF-HostID: 19
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262828>

On 22/01/15 02:32, Stefan Beller wrote:
> By closing the file descriptors after creating the lock file we are not
> limiting the size of the transaction by the number of available file
> descriptors.
> 
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  refs.c                | 17 +++++++++++++----
>  t/t1400-update-ref.sh |  4 ++--
>  2 files changed, 15 insertions(+), 6 deletions(-)
> 
> diff --git a/refs.c b/refs.c
> index 2013d37..9d01102 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -3055,11 +3055,18 @@ int is_branch(const char *refname)
>  static int write_sha1_to_lock_file(struct ref_lock *lock,
>  				   const unsigned char *sha1)
>  {
> -	if (fdopen_lock_file(lock->lk, "w") < 0
> -	    || fprintf(lock->lk->fp, "%s\n", sha1_to_hex(sha1)) != 41)
> +	if (lock->lk->fd == -1) {
> +		if (reopen_lock_file(lock->lk) < 0
> +		    || fdopen_lock_file(lock->lk, "w") < 0

fdopen_lock_file() returns a 'FILE *', so this causes sparse to bark:

    refs.c:3105:56: error: incompatible types for operation (<)
    refs.c:3105:56:    left side has type struct _IO_FILE [usertype] *
    refs.c:3105:56:    right side has type int

> +		    || fprintf(lock->lk->fp, "%s\n", sha1_to_hex(sha1)) != 41
> +		    || close_lock_file(lock->lk) < 0)
> +		    return -1;
> +	} else {
> +		if (fdopen_lock_file(lock->lk, "w") < 0

Similarly, sparse barks:

    refs.c:3110:53: error: incompatible types for operation (<)
    refs.c:3110:53:    left side has type struct _IO_FILE [usertype] *
    refs.c:3110:53:    right side has type int

> +		    || fprintf(lock->lk->fp, "%s\n", sha1_to_hex(sha1)) != 41)
>  		return -1;
> -	else
> -		return 0;
> +	}
> +	return 0;
>  }
>  
>  /*
> @@ -3761,6 +3768,8 @@ int ref_transaction_commit(struct ref_transaction *transaction,
>  				    update->refname);
>  			goto cleanup;
>  		}
> +		/* Do not keep all lock files open at the same time. */
> +		close_lock_file(update->lock->lk);
>  	}
>  
>  	/* Perform updates first so live commits remain referenced */
> diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
> index 47d2fe9..c593a1d 100755
> --- a/t/t1400-update-ref.sh
> +++ b/t/t1400-update-ref.sh
> @@ -979,7 +979,7 @@ run_with_limited_open_files () {
>  
>  test_lazy_prereq ULIMIT_FILE_DESCRIPTORS 'run_with_limited_open_files true'
>  
> -test_expect_failure ULIMIT_FILE_DESCRIPTORS 'large transaction creating branches does not burst open file limit' '
> +test_expect_success ULIMIT_FILE_DESCRIPTORS 'large transaction creating branches does not burst open file limit' '
>  (
>  	for i in $(test_seq 33)
>  	do
> @@ -990,7 +990,7 @@ test_expect_failure ULIMIT_FILE_DESCRIPTORS 'large transaction creating branches
>  )
>  '
>  
> -test_expect_failure ULIMIT_FILE_DESCRIPTORS 'large transaction deleting branches does not burst open file limit' '
> +test_expect_success ULIMIT_FILE_DESCRIPTORS 'large transaction deleting branches does not burst open file limit' '
>  (
>  	for i in $(test_seq 33)
>  	do
> 

ATB,
Ramsay Jones
