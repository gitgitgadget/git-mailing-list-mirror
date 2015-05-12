From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 06/18] report_refname_conflict(): inline function
Date: Tue, 12 May 2015 14:21:12 -0700
Message-ID: <xmqqzj59eblj.fsf@gitster.dls.corp.google.com>
References: <1431357920-25090-1-git-send-email-mhagger@alum.mit.edu>
	<1431357920-25090-7-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue May 12 23:21:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YsHcA-0005kk-W3
	for gcvg-git-2@plane.gmane.org; Tue, 12 May 2015 23:21:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933717AbbELVVS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 May 2015 17:21:18 -0400
Received: from mail-ie0-f181.google.com ([209.85.223.181]:35326 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933135AbbELVVO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 May 2015 17:21:14 -0400
Received: by iebpz10 with SMTP id pz10so14278287ieb.2
        for <git@vger.kernel.org>; Tue, 12 May 2015 14:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=9x5iYVblJsX1HfcDGZQQB2G6ak/iASYkdBJHyxrZHeQ=;
        b=CRYqujqEtOkzPmx8XXs7wXu6w4YVfZEAeFwDShJCyqCGNtlVi90izvBfEewSX1zxYy
         Xp4bX5aZVv6/5GuJWFciN8o7PKxybSo9SmWxOOVSZUrz3Ch0hXg64/N78E4/3Bu4pxmQ
         UncMXSZ7fqy8c8o3jpLH+quzwl9JWcwTTOidL8xWQZIKqacgvQCJaKMn1O/FazVjjiYv
         3vOtIeKYK9G7aEYPZT9wWNh59XVQF+NPBpzuaYevy401UOxpKYqMQp7nLA3jYP2/RML+
         HS041EoBBwLkiBRIoKcNi9PDbhdRimGkEb3XJybr8OERoeI7z0UNL+NrhU5EjsxJ1Td3
         Gnhg==
X-Received: by 10.50.61.200 with SMTP id s8mr24066898igr.7.1431465673730;
        Tue, 12 May 2015 14:21:13 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:1d41:fac7:b879:7542])
        by mx.google.com with ESMTPSA id j20sm2045282igt.5.2015.05.12.14.21.13
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 12 May 2015 14:21:13 -0700 (PDT)
In-Reply-To: <1431357920-25090-7-git-send-email-mhagger@alum.mit.edu> (Michael
	Haggerty's message of "Mon, 11 May 2015 17:25:08 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268888>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> It wasn't pulling its weight. And we are about to need code similar to
> this where no ref_entry is available and with more diverse error
> messages. Rather than try to generalize the function, just inline it.
>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---

I am not sure "not pulling its weight" in this and also 05/18 is a
fair judgement.  A short helper function sometimes helps readability
by giving an extra abstraction.

But I agree 100% with these two steps that they weren't making them
easier to read.  A raw call to error() shows clearly that we are
reporting an error and more importantly by losing an intermediary
we do not have to wonder at the call site if there is anything else
going on in that "report" function (where there isn't).

Thanks.


>  refs.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
>
> diff --git a/refs.c b/refs.c
> index 6bdd34f..7422594 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -857,12 +857,6 @@ static int nonmatching_ref_fn(struct ref_entry *entry, void *vdata)
>  	return 1;
>  }
>  
> -static void report_refname_conflict(struct ref_entry *entry,
> -				    const char *refname)
> -{
> -	error("'%s' exists; cannot create '%s'", entry->name, refname);
> -}
> -
>  /*
>   * Return true iff a reference named refname could be created without
>   * conflicting with the name of an existing reference in dir.  If
> @@ -918,7 +912,7 @@ static int is_refname_available(const char *refname,
>  				 */
>  				return 1;
>  			}
> -			report_refname_conflict(entry, refname);
> +			error("'%s' exists; cannot create '%s'", entry->name, refname);
>  			return 0;
>  		}
>  
> @@ -969,7 +963,7 @@ static int is_refname_available(const char *refname,
>  		if (!do_for_each_entry_in_dir(dir, 0, nonmatching_ref_fn, &data))
>  			return 1;
>  
> -		report_refname_conflict(data.found, refname);
> +		error("'%s' exists; cannot create '%s'", data.found->name, refname);
>  		return 0;
>  	}
