From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v8 04/44] refs.c: add an err argument to
 repack_without_refs
Date: Thu, 15 May 2014 11:38:36 -0700
Message-ID: <20140515183836.GD26471@google.com>
References: <1400174999-26786-1-git-send-email-sahlberg@google.com>
 <1400174999-26786-5-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Thu May 15 20:38:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wl0YF-0000Ni-Qe
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 20:38:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755715AbaEOSik (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 14:38:40 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:48137 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755073AbaEOSij (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 14:38:39 -0400
Received: by mail-pa0-f41.google.com with SMTP id lj1so1432108pab.0
        for <git@vger.kernel.org>; Thu, 15 May 2014 11:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=xAvTRs4Ag4E9plG64ZUJ8TFGVWW3f9tZN63xo2JAd/g=;
        b=lk/UOpvtoy8uLWUJAGtJIcXXxw9fwHOzvPJDOiSI+/VtW8kVHACOxM0VnYBCzqjt2i
         ajQaMcQY7+NeTz7kiVO8RpbizoJZHai95nukvmgj/opyQLyt89AvnGTzrA6blz8CFjaJ
         qsGGJ+ZWalGDKd5HoxFJpuroDz7Z9Isqkpl3/gtT06PDHSxwtvIPxNymjv/VeG2q3/C/
         wtzTughhs/5p0DMOx94qsRn2/SrYk37iIPEBHkm80FqUgcrbaZUhu9GgAlhwywqfTpi2
         /igeMwxG1YSLtCqVGhA9H/laZwgPFdLpZC285z7vNF07KT6ZuwX0eDPde3GNVkzPke07
         huMw==
X-Received: by 10.69.31.107 with SMTP id kl11mr14548625pbd.142.1400179119013;
        Thu, 15 May 2014 11:38:39 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id vg1sm10339275pbc.44.2014.05.15.11.38.38
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 15 May 2014 11:38:38 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1400174999-26786-5-git-send-email-sahlberg@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249178>

Ronnie Sahlberg wrote:
> --- a/refs.c
> +++ b/refs.c
> @@ -2427,12 +2427,12 @@ static int curate_packed_ref_fn(struct ref_entry *entry, void *cb_data)
>  	return 0;
>  }
>  
> -static int repack_without_refs(const char **refnames, int n)
> +static int repack_without_refs(const char **refnames, int n, struct strbuf *err)

Should this also get an onerr flag to suppress the message to stderr,
or unconditionally suppress the message to stderr when err != NULL?

[...]
> @@ -2445,6 +2445,9 @@ static int repack_without_refs(const char **refnames, int n)
>  
>  	if (lock_packed_refs(0)) {
>  		unable_to_lock_error(git_path("packed-refs"), errno);
> +		if (err)
> +			strbuf_addf(err, "cannot delete '%s' from packed refs",
> +				    refnames[i]);

unable_to_lock_error is able to come up with a message with more
detail (path so the sysadmin can hunt down the problem even if this
was run e.g. from a cronjob where the path is not obvious, errno
hinting at the nature of the problem).

[...]
> @@ -2470,12 +2473,15 @@ static int repack_without_refs(const char **refnames, int n)
>  	}
>  
>  	/* Write what remains */
> -	return commit_packed_refs();
> +	ret = commit_packed_refs();
> +	if (ret && err)
> +		strbuf_addf(err, "unable to overwrite old ref-pack file");

After commit_lock_file sets errno, amazingly no one clobbers it
until we get to this point.  The only calls in between are to
free().

It would be nice to make that more explicit in commit_packed_refs:

	int save_errno;

	...
	if (commit_lock_file(packed_ref_cache->lock)) {
		save_errno = errno;
		error = -1;
	}

	packed_ref_cache->lock = NULL;
	release_packed_ref_cache(packed_ref_cache);

	errno = save_errno;
	return error;

Even without that, this message could include strerror(errno).

> +	return ret;
>  }

Thanks,
Jonathan
