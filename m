From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] verify-tag: Parse GPG configuration options.
Date: Thu, 08 Mar 2012 14:01:46 -0800
Message-ID: <7vmx7qbvlh.fsf@alter.siamese.dyndns.org>
References: <20120308200720.GA93880@blarf>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alex Zepeda <alex@inferiorhumanorgans.com>
X-From: git-owner@vger.kernel.org Thu Mar 08 23:01:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5lPI-0007D6-Rh
	for gcvg-git-2@plane.gmane.org; Thu, 08 Mar 2012 23:01:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758721Ab2CHWBw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Mar 2012 17:01:52 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40957 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758604Ab2CHWBv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Mar 2012 17:01:51 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CDC836075;
	Thu,  8 Mar 2012 17:01:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hPmyhDTUpTZqGoL1IRbTVk1vNNQ=; b=Ke+5B2
	KpMrEomlcZoeNWi8VKP1nSBQBQZ30XIW4rDMkWoFHwKcGAUe422PMQlm+hs3h2FQ
	kBXe493ockWDCuVTXYQnrM9A9j9b37emK+6nB3s8fmMZDFXxkJgp9VJj7X4K2an1
	HMVLAkRniQYYvrrnh6YhtlCSGHtf4zon9L9O8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=F+bnOqsx8702bIHMf+tmqZbY9dXMpU0W
	fh/15KFBO4WhUcoErTEaz+vunlGiLQF0OjMVwaw13BMlsNGVIse4xBhEC8pmqU3a
	aD6o5mQYAb6E0/7oXzV1fcKwUQsKDBdr9+Heh2nSKSZp6jchVbfS8zK+CriyVsSP
	VaGDSXuXJMI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C58C46074;
	Thu,  8 Mar 2012 17:01:48 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5B7456072; Thu,  8 Mar 2012
 17:01:48 -0500 (EST)
In-Reply-To: <20120308200720.GA93880@blarf> (Alex Zepeda's message of "Thu, 8
 Mar 2012 12:07:20 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4D66D36C-696A-11E1-9110-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192657>

Alex Zepeda <alex@inferiorhumanorgans.com> writes:

> Modify verify-tag to load relevant GPG variables from the git
> configuratio file.  This allows git tag -v to use an alternative
> GPG binary in the same way that git tag -s does.
>
> Signed-off-by: Alex Zepeda <alex@inferiorhumanorgans.com>
> ---

Makes sense; thanks.

>  builtin/verify-tag.c |   10 +++++++++-
>  1 files changed, 9 insertions(+), 1 deletions(-)
>
> diff --git a/builtin/verify-tag.c b/builtin/verify-tag.c
> index 28c2174..986789f 100644
> --- a/builtin/verify-tag.c
> +++ b/builtin/verify-tag.c
> @@ -58,6 +58,14 @@ static int verify_tag(const char *name, int verbose)
>  	return ret;
>  }
>  
> +static int git_verify_tag_config(const char *var, const char *value, void *cb)
> +{
> +	int status = git_gpg_config(var, value, cb);
> +	if (status)
> +		return status;
> +	return git_default_config(var, value, cb);
> +}
> +
>  int cmd_verify_tag(int argc, const char **argv, const char *prefix)
>  {
>  	int i = 1, verbose = 0, had_error = 0;
> @@ -66,7 +74,7 @@ int cmd_verify_tag(int argc, const char **argv, const char *prefix)
>  		OPT_END()
>  	};
>  
> -	git_config(git_default_config, NULL);
> +	git_config(git_verify_tag_config, NULL);
>  
>  	argc = parse_options(argc, argv, prefix, verify_tag_options,
>  			     verify_tag_usage, PARSE_OPT_KEEP_ARGV0);
