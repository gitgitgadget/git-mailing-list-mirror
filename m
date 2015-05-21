From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 08/14] remote.c: report specific errors from branch_get_upstream
Date: Thu, 21 May 2015 11:33:58 -0700
Message-ID: <xmqq7fs1kcfd.fsf@gitster.dls.corp.google.com>
References: <20150521044429.GA5857@peff.net> <20150521044532.GH23409@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 21 20:34:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvVIE-0000UG-Gl
	for gcvg-git-2@plane.gmane.org; Thu, 21 May 2015 20:34:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932209AbbEUSeA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 May 2015 14:34:00 -0400
Received: from mail-ig0-f170.google.com ([209.85.213.170]:36205 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932078AbbEUSeA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 May 2015 14:34:00 -0400
Received: by igbpi8 with SMTP id pi8so17256955igb.1
        for <git@vger.kernel.org>; Thu, 21 May 2015 11:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=pztpsHLK8juEdXL4rurWYyN35qhFT4fKJZ9Z4iC11vE=;
        b=mRanreteCrDfHMLiK+Tb3Fx07h+TCDWkeIfiQannXVnmbFemFD1135rXtL6YJjnBcJ
         kyNHZndKUNuACVyTst0OeF8JbueCyPUvVfeBikEmYIAYNb0yJ3GzBP3hbAaU3EFaDL2S
         +KcUQ5t0ilEFEjJhvto28e2GDiJKty2j89C5x6oD7dFUmHqaA4h6u2EHr28rjIMIEiv2
         AW52Fm9dJfXRa8M8dZldY6sHQMsIZ21Fu37tR8nNmDgS5Jhr6LLW7DEP5UT3fn6PlTMB
         8EzxcTo+fojPsN700kI+5kTyF1coUuUI+zeISMfCNSUItoQO7O4rE8e8Slc44X1Hi6Bz
         I4nQ==
X-Received: by 10.107.12.229 with SMTP id 98mr5287340iom.73.1432233239687;
        Thu, 21 May 2015 11:33:59 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:c1e1:e830:c078:d79d])
        by mx.google.com with ESMTPSA id y124sm15466551iod.13.2015.05.21.11.33.58
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 21 May 2015 11:33:59 -0700 (PDT)
In-Reply-To: <20150521044532.GH23409@peff.net> (Jeff King's message of "Thu,
	21 May 2015 00:45:32 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269638>

Jeff King <peff@peff.net> writes:

> diff --git a/remote.c b/remote.c
> index dca3442..1b7051a 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -1705,10 +1705,35 @@ int branch_merge_matches(struct branch *branch,
>  	return refname_match(branch->merge[i]->src, refname);
>  }
>  
> -const char *branch_get_upstream(struct branch *branch)
> +__attribute((format (printf,2,3)))
> +static const char *error_buf(struct strbuf *err, const char *fmt, ...)
>  {
> -	if (!branch || !branch->merge || !branch->merge[0])
> -		return NULL;
> +	if (err) {
> +		va_list ap;
> +		va_start(ap, fmt);
> +		strbuf_vaddf(err, fmt, ap);
> +		va_end(ap);
> +	}
> +	return NULL;
> +}

Many of our functions return -1 to signal an error, and that is why
it makes sense for our error() helper to return -1 to save code in
the caller, but only because the callers of this private helper use
a NULL to signal an error, this also returns NULL.  If we were to
use the "callers can opt into detailed message by passing strbuf"
pattern more widely, we would want a variant of the above that
returns -1, too.  And such a helper would do the same thing as
above, with only difference from the above is to return -1.

It's a shame that we have to return something from this function,
whose primary purpose is "we may or may not want an error message in
a strbuf, so format the message when and only when we give you a
strbuf", but C forces us to make it "always return NULL to signal an
error to the caller, and optionally format the message into a strbuf
if given".

And the name of this helper function only captures the "optionally
format the message" part, not the "always return NULL" part.

> +const char *branch_get_upstream(struct branch *branch, struct strbuf *err)
> +{
> +	if (!branch)
> +		return error_buf(err, _("HEAD does not point to a branch"));
> +	if (!branch->merge || !branch->merge[0] || !branch->merge[0]->dst) {
> +		if (!ref_exists(branch->refname))
> +			return error_buf(err, _("no such branch: '%s'"),
> +					 branch->name);
> +		if (!branch->merge)
> +			return error_buf(err,
> +					 _("no upstream configured for branch '%s'"),
> +					 branch->name);
> +		return error_buf(err,
> +				 _("upstream branch '%s' not stored as a remote-tracking branch"),
> +				 branch->merge[0]->src);
> +	}
> +
>  	return branch->merge[0]->dst;
>  }

This is a faithful conversion of what the get_upstream_branch() used
to do, but that ref_exists() check and the error checking there look
somewhat out of place.

It makes the reader wonder what should happen when "branch->refname"
does not exist as a ref, but "branch->merge[0]->dst" can be fully
dereferenced.  Should it be an error, or if it is OK, the reason why
it is OK is...?
