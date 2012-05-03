From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 05/18] refs.c: extract function search_for_subdir()
Date: Thu, 03 May 2012 12:48:05 -0700
Message-ID: <7v4nrxf3m2.fsf@alter.siamese.dyndns.org>
References: <1335479227-7877-1-git-send-email-mhagger@alum.mit.edu>
 <1335479227-7877-6-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Christian Couder <chriscool@tuxfamily.org>
To: mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu May 03 21:48:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQ20c-0004ky-UI
	for gcvg-git-2@plane.gmane.org; Thu, 03 May 2012 21:48:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758409Ab2ECTsK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 May 2012 15:48:10 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34821 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754439Ab2ECTsJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 May 2012 15:48:09 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E73CA641A;
	Thu,  3 May 2012 15:48:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZsS5Jvot5XU+WwW3lP1u3Dqs6lY=; b=a+Bs1X
	uqBE+uF9KI73YHJZaeIpGDhK7Nh4RK83kTekcpitwPgIBjCgYmCVS5xX6ZLbtlNz
	25HszvCcaCRicK9BlVYDCs5cOSeaYr9R7EDjhjAJWkJa2Qhe+L/Lk5B+HHHXAsyW
	00QPksOzUVVb6qBK6tftgV5n8bYeEBX0tzkD8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BHVWJszGVwkcdVQ7Mx/fS9i7J4LbWo+z
	vaTA93nnNu8WerSh1Pnz5lroFvMFyhYqqqHIUl3eanrOs+5mZTDjBOkIxNIxs8mJ
	xLKriKhYqwgsHu0q18ZFu6dh5zpKY2lCUH/5V5HcJTZj6X23KhZKXTATmngDwDsM
	P35PcLxIsmw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DE9E16419;
	Thu,  3 May 2012 15:48:07 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 677D76418; Thu,  3 May 2012
 15:48:07 -0400 (EDT)
In-Reply-To: <1335479227-7877-6-git-send-email-mhagger@alum.mit.edu>
 (mhagger@alum.mit.edu's message of "Fri, 27 Apr 2012 00:26:54 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E7B1064E-9558-11E1-B97F-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196951>

mhagger@alum.mit.edu writes:

> From: Michael Haggerty <mhagger@alum.mit.edu>
>
>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
>  refs.c |   34 ++++++++++++++++++++++++----------
>  1 file changed, 24 insertions(+), 10 deletions(-)
>
> diff --git a/refs.c b/refs.c
> index 01fcdc7..5e51c10 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -277,6 +277,27 @@ static struct ref_entry *search_ref_dir(struct ref_dir *dir, const char *refname
>  }
>  
>  /*
> + * Search for a directory entry directly within dir (without
> + * recursing).  Sort dir if necessary.  subdirname must be a directory
> + * name (i.e., end in '/').  If mkdir is set, then create the
> + * directory if it is missing; otherwise, return NULL if the desired
> + * directory cannot be found.
> + */
> +static struct ref_entry *search_for_subdir(struct ref_dir *dir,
> +					   const char *subdirname, int mkdir)
> +{
> +	struct ref_entry *entry = search_ref_dir(dir, subdirname);
> +	if (!entry) {
> +		if (!mkdir)
> +			return NULL;
> +		entry = create_dir_entry(subdirname);
> +		add_entry_to_dir(dir, entry);
> +	}
> +	assert(entry->flag & REF_DIR);
> +	return entry;
> +}
> +
> +/*
>   * If refname is a reference name, find the ref_dir within the dir
>   * tree that should hold refname.  If refname is a directory name
>   * (i.e., ends in '/'), then return that ref_dir itself.  dir must
> @@ -294,17 +315,10 @@ static struct ref_dir *find_containing_dir(struct ref_dir *dir,
>  	for (slash = strchr(refname_copy, '/'); slash; slash = strchr(slash + 1, '/')) {
>  		char tmp = slash[1];
>  		slash[1] = '\0';
> -		entry = search_ref_dir(dir, refname_copy);
> -		if (!entry) {
> -			if (!mkdir) {
> -				dir = NULL;
> -				break;
> -			}
> -			entry = create_dir_entry(refname_copy);
> -			add_entry_to_dir(dir, entry);
> -		}
> +		entry = search_for_subdir(dir, refname_copy, mkdir);
>  		slash[1] = tmp;
> -		assert(entry->flag & REF_DIR);
> +		if (!entry)
> +			break;
>  		dir = &entry->u.subdir;
>  	}

Hrm.  The old code used to reset "dir" to NULL before breaking, so the
entire function used to return NULL.  Now, it calls search_for_subdir(),
which calls search_ref_dir() and gets NULL in entry, and returns NULL.

Wouldn't we end up returning the original parameter "dir" instead of NULL
in that case?  Would that make a difference?
