From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH 13/22] config: change write_error() to take a (struct
 lock_file *) argument
Date: Wed, 02 Apr 2014 08:58:33 +0200
Message-ID: <533BB519.8030307@web.de>
References: <1396367910-7299-1-git-send-email-mhagger@alum.mit.edu> <1396367910-7299-14-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Apr 03 13:21:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WVeJ5-0006sp-Kj
	for gcvg-git-2@plane.gmane.org; Thu, 03 Apr 2014 11:51:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757430AbaDBG64 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Apr 2014 02:58:56 -0400
Received: from mout.web.de ([212.227.15.4]:63950 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757330AbaDBG6z (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Apr 2014 02:58:55 -0400
Received: from [192.168.88.199] ([194.47.243.242]) by smtp.web.de (mrweb004)
 with ESMTPSA (Nemesis) id 0Lvw4L-1X7Lia3B3l-017pDC; Wed, 02 Apr 2014 08:58:45
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:17.0) Gecko/20131104 Icedove/17.0.10
In-Reply-To: <1396367910-7299-14-git-send-email-mhagger@alum.mit.edu>
X-Provags-ID: V03:K0:foh1aerZlw9Wd5dJN0tJqxCNjqSxV5/heqFwwIM+IPZoFrGqQjA
 H98iA3r/8xjSjEFPRbMR5jy2M/P0fKVPJxib1y+G86OV9BzH/dqOVD7WZXgzCX7yR93ZJPk
 3hIT5IpQWgSccTcxZL9TiEZKJzi+3kM44lIJk43lK0KoovFhGlXMB/UWQWuGapgOFb9ucEo
 uu9E4gCby7pOCh/mm1D7w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245713>

On 04/01/2014 05:58 PM, Michael Haggerty wrote:
> Reduce the amount of code that has to know about the lock_file's
> filename field.
>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
>   config.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/config.c b/config.c
> index 6821cef..1ea3f39 100644
> --- a/config.c
> +++ b/config.c
> @@ -1303,9 +1303,9 @@ static int store_aux(const char *key, const char *value, void *cb)
>   	return 0;
>   }
>   
> -static int write_error(const char *filename)
> +static int write_error(struct lock_file *lk)
Does the write_error() really need to know about  struct lock_file ?
(The name of the function does not indicate that it is doing something 
with lk)
And if, would it make sense to rename it into 
write_error_and_do_something() ?
>   {
> -	error("failed to write new configuration file %s", filename);
> +	error("failed to write new configuration file %s", lk->filename);
>   
>   	/* Same error code as "failed to rename". */
>   	return 4;
> @@ -1706,7 +1706,7 @@ out_free:
>   	return ret;
>   
>   write_err_out:
> -	ret = write_error(lock->filename);
> +	ret = write_error(lock);
>   	goto out_free;
>   
>   }
> @@ -1821,7 +1821,7 @@ int git_config_rename_section_in_file(const char *config_filename,
>   				}
>   				store.baselen = strlen(new_name);
>   				if (!store_write_section(out_fd, new_name)) {
> -					ret = write_error(lock->filename);
> +					ret = write_error(lock);
>   					goto out;
>   				}
>   				/*
> @@ -1847,7 +1847,7 @@ int git_config_rename_section_in_file(const char *config_filename,
>   			continue;
>   		length = strlen(output);
>   		if (write_in_full(out_fd, output, length) != length) {
> -			ret = write_error(lock->filename);
> +			ret = write_error(lock);
>   			goto out;
>   		}
>   	}
