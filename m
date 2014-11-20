From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v4] refs.c: use a stringlist for repack_without_refs
Date: Wed, 19 Nov 2014 18:15:40 -0800
Message-ID: <20141120021540.GF6527@google.com>
References: <1416434088-1472-1-git-send-email-sbeller@google.com>
 <1416434399-2303-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, sahlberg@google.com, git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Nov 20 03:15:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XrHHZ-0007oa-RR
	for gcvg-git-2@plane.gmane.org; Thu, 20 Nov 2014 03:15:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756183AbaKTCPi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Nov 2014 21:15:38 -0500
Received: from mail-ig0-f180.google.com ([209.85.213.180]:43637 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753629AbaKTCPh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Nov 2014 21:15:37 -0500
Received: by mail-ig0-f180.google.com with SMTP id h15so2083558igd.1
        for <git@vger.kernel.org>; Wed, 19 Nov 2014 18:15:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=XmoSAYRq34wiFaEpH5MBR0ESzfiOC6Io6Xz412r+9sM=;
        b=MXd0qweiJtutMSiSlchAxQmV563GekUo6mFGTd3HhqS+R2qZ0tUhvraxBzt1ifNYga
         9XNPDt5vfnXWQMljWANKWUUMLDDuUOMg+947c+wiKOYuxjwn7/eU3run/7hPxNiUnFHr
         tlSSXUDWhNhLjX3pk/dDLUQoIwMbQC8fZERslQ3Hfd54L1oQuKaXQGnGWCHfrfGXvkio
         lbEXD1gHRIvIgPd3vHHrKMRd/W0eFPpo3lvErTto/cUHu+1e0LozviQ/RAsKmx2v5xbG
         GUnPPW5rKkm46T8iatj4j/lCPM5wml8ZARd95G8uecnMXsQqJTUFHMPtvX0EWzwEo6qx
         6ErQ==
X-Received: by 10.50.154.33 with SMTP id vl1mr132314igb.48.1416449736741;
        Wed, 19 Nov 2014 18:15:36 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:31da:72d3:8c17:80bd])
        by mx.google.com with ESMTPSA id z9sm1800936igl.18.2014.11.19.18.15.35
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 19 Nov 2014 18:15:35 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1416434399-2303-1-git-send-email-sbeller@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller wrote:

> From: Ronnie Sahlberg <sahlberg@google.com>
>
> This patch doesn't intend any functional changes. It is just
> a refactoring, which replaces a char** array by a stringlist
> in the function repack_without_refs.
> This is easier to read and maintain as it delivers the same
> functionality with less lines of code and less pointers.

Thanks for the quick turnaround.

Nit: please wrap to a consistent width and put a blank line between
paragraphs.

That is, the above should either say

	This patch doesn't intend any functional changes.  It is just
	a refactoring to replace a char** array with a string_list
	in the function repack_without_refs.  This is easier to read
	and maintain as it delivers the same functionality with less
	code and fewer pointers.

or

	This patch doesn't intend any functional changes.  It is just
	a refactoring to replace a char** array with a string_list
	in the function repack_without_refs.

	This is easier to read and maintain as it delivers the same
	functionality with less code and fewer pointers.

Although I'm not sure the main benefit is having fewer asterisks. ;-)

[...]
> +++ b/builtin/remote.c
[...]
> @@ -1361,8 +1352,9 @@ static int prune_remote(const char *remote, int dry_run)
>  			       abbrev_ref(refname, "refs/remotes/"));
>  	}
>  
> -	warn_dangling_symrefs(stdout, dangling_msg, &delete_refs_list);
> -	string_list_clear(&delete_refs_list, 0);
> +	sort_string_list(&delete_refs);
> +	warn_dangling_symrefs(stdout, dangling_msg, &delete_refs);
> +	string_list_clear(&delete_refs, 0);
>  
>  	free_remote_ref_states(&states);
>  	return result;

Micronit: it would be clearer (and easier to remember to free the list
in other code paths if this function gains more 'return' statements)
with the string_list_clear in the same block as other code that frees
resources (i.e., if the blank line moved one line up).

[...]
> --- a/refs.h
> +++ b/refs.h
> @@ -163,8 +163,15 @@ extern void rollback_packed_refs(void);
>   */
>  int pack_refs(unsigned int flags);
>  
> -extern int repack_without_refs(const char **refnames, int n,
> -			       struct strbuf *err);
> +/*
> + * Remove the refs listed in 'without' from the packed-refs file.
> + * On error, packed-refs will be unchanged, the return value is
> + * nonzero, and a message about the error is written to the 'err'
> + * strbuf.
> + *
> + * The refs in 'without' may have any order, the err buffer must not be ommited.

Nits:

s/ommited/omitted/

Comma splice.  Long line.

The function has to be able to write to 'err' on error, so I think the
comment doesn't have to mention that err must be non-NULL.  Any caller
that tries to pass NULL will get an assertion error quickly.

With or without the changes suggested above,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
