From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 13/22] config: change write_error() to take a (struct lock_file *) argument
Date: Wed, 02 Apr 2014 10:29:41 -0700
Message-ID: <xmqqob0jvdve.fsf@gitster.dls.corp.google.com>
References: <1396367910-7299-1-git-send-email-mhagger@alum.mit.edu>
	<1396367910-7299-14-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Apr 03 13:09:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WVeT6-0000xS-QW
	for gcvg-git-2@plane.gmane.org; Thu, 03 Apr 2014 12:01:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932627AbaDBR3q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Apr 2014 13:29:46 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45635 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932501AbaDBR3p (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Apr 2014 13:29:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C01E578606;
	Wed,  2 Apr 2014 13:29:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=lpynnypK1UUyqu0loVt0heFtaK0=; b=HfwTDW2kM1qQ/PiYctey
	678f1fshIPLMGETgMbF/U9MpfgaNE0ol7/Z6Lqd0m3mZT1nk0F5aFIugNqThFRyW
	aFGS04Bf/9D/RgFrveHq+hBSpHdwa+k6uTCm3Wi63Yq363UjW2Rrfn3+nOHpO3SN
	Q/8NZyPvTSWjwmfHqeNodFw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=sFNoEXyTDqsK2PidCkzL0viCXT0qTMAA2NxOWqa+j51ZDL
	p3HFUuDp+xBNv2Q291b5jMneZKMwCH/CKh/tyGx9325BlDaYZph4jVrNlxTt9gKb
	hNs++4VreZZxQ9PVQYRRyE+0sGzmZGQ3b8zyvE99OpafgJWvSityD92EnxwZ0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AB7A678604;
	Wed,  2 Apr 2014 13:29:44 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 06CBA78601;
	Wed,  2 Apr 2014 13:29:42 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 609DD316-BA8C-11E3-A99D-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245706>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> Reduce the amount of code that has to know about the lock_file's
> filename field.
>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
>  config.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/config.c b/config.c
> index 6821cef..1ea3f39 100644
> --- a/config.c
> +++ b/config.c
> @@ -1303,9 +1303,9 @@ static int store_aux(const char *key, const char *value, void *cb)
>  	return 0;
>  }
>  
> -static int write_error(const char *filename)
> +static int write_error(struct lock_file *lk)
>  {

The earlier one would have been usable for reporting an error while
writing any file, but the caller must hold a lock file on it with a
new one.  Would this change warrant a renaming of the function, I
wonder.

It is a file-scope static, so all callers know about how they are
supposed to call it, hence the keeping the original name would be
OK, I would think.

This hunk triggered my smello-meter, primarily because "write-error"
would not be the name I would pick for this function if I were
writing everything in this file from scratch (before or after this
particular patch).

> -	error("failed to write new configuration file %s", filename);
> +	error("failed to write new configuration file %s", lk->filename);
>  
>  	/* Same error code as "failed to rename". */
>  	return 4;
> @@ -1706,7 +1706,7 @@ out_free:
>  	return ret;
>  
>  write_err_out:
> -	ret = write_error(lock->filename);
> +	ret = write_error(lock);
>  	goto out_free;
>  
>  }
> @@ -1821,7 +1821,7 @@ int git_config_rename_section_in_file(const char *config_filename,
>  				}
>  				store.baselen = strlen(new_name);
>  				if (!store_write_section(out_fd, new_name)) {
> -					ret = write_error(lock->filename);
> +					ret = write_error(lock);
>  					goto out;
>  				}
>  				/*
> @@ -1847,7 +1847,7 @@ int git_config_rename_section_in_file(const char *config_filename,
>  			continue;
>  		length = strlen(output);
>  		if (write_in_full(out_fd, output, length) != length) {
> -			ret = write_error(lock->filename);
> +			ret = write_error(lock);
>  			goto out;
>  		}
>  	}
