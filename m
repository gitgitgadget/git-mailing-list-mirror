From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/6] sha1_name: implement @{push} shorthand
Date: Tue, 31 Mar 2015 14:37:25 -0700
Message-ID: <xmqqk2xwq25m.fsf@gitster.dls.corp.google.com>
References: <20150331173339.GA17732@peff.net>
	<20150331173834.GF18912@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 31 23:37:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yd3qp-0004Y7-IZ
	for gcvg-git-2@plane.gmane.org; Tue, 31 Mar 2015 23:37:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753606AbbCaVha (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Mar 2015 17:37:30 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:62398 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753119AbbCaVh2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Mar 2015 17:37:28 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7828945AFA;
	Tue, 31 Mar 2015 17:37:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=33kmKMHF0xgvZXJNqJFklb9LtgU=; b=tHJ7sQ
	jUg0WeN99PLSiYhF/RFfJ7whktxq2zlSoSro+l9y72uxWwnQQOH8HlQLFCy1zHFn
	DnZQygXc2Ekk4+bi+GZo0bmXdhq3JvG9cNSM2OkqK6mUnZXuXjuXCua2H0Yd6IkA
	QdyQMmoppoldUw9ter9q3kqfGevJAPnpdPYC8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CELKUuwPAUOCC8Hm2pDeiYmxkvy7BXOi
	8mYCla4UOFrj729Uc1TJt8UILx4ssAg9Ihuu+7WM9VMkpYDMsOzuCdqxWvT+OGAz
	qn8MrJMYWqEJmaknT/cdkQKWKdL/V77DBgLof5bQVo2dadkpYHIlpAkZDw6NxqLf
	pmocTpINr2M=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 71C9845AF9;
	Tue, 31 Mar 2015 17:37:27 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E47F545AF8;
	Tue, 31 Mar 2015 17:37:26 -0400 (EDT)
In-Reply-To: <20150331173834.GF18912@peff.net> (Jeff King's message of "Tue,
	31 Mar 2015 13:38:35 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 2025EA8C-D7EE-11E4-976A-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266559>

Jeff King <peff@peff.net> writes:

> diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
> index 0796118..5d9df25 100644
> --- a/Documentation/revisions.txt
> +++ b/Documentation/revisions.txt
> @@ -98,6 +98,31 @@ some output processing may assume ref names in UTF-8.
>    `branch.<name>.merge`).  A missing branchname defaults to the
>    current one.
>  
> +'<branchname>@\{push\}', e.g. 'master@\{push\}', '@\{push\}'::
> +  The suffix `@{push}` reports the branch "where we would push to" if

The corresponding description for upstream begins like this:

  The suffix '@\{upstream\}' to a branchname (short form '<branchname>@\{u\}')

and makes me wonder if the existing backslashes are unnecessary, or
if you forgot to use them in the new text.

> @@ -1104,6 +1111,95 @@ static int interpret_upstream_mark(const char *name, int namelen,
>  	return len + at;
>  }
>  
> +static char *tracking_ref_for(struct remote *remote, const char *refname)
> +{
> +	char *ret;
> +
> +	ret = apply_refspecs(remote->fetch, remote->fetch_refspec_nr, refname);
> +	if (!ret)
> +		die(_("@{push} has no local tracking branch for remote '%s'"),
> +		    refname);

I would imagine that it would be very plausible that anybody with a
specific remote and the name of the ref that appears on that remote
would want to learn the local name of the remote-tracking ref we use
to track it.

But the error message limits the callers only to those who are
involved in @{push} codepath.  Shouldn't the error check be done in
the caller instead, anticipating the day this useful function ceases
to be static?

I would suspect that such a change would make it just a one-liner,
but I think this helper that takes remote and their refname is much
easier to read than four inlined calls to apply_refspecs() that have
to spell out remote->fetch, remote->fetch_refspec_nr separately.

Perhaps we would want 

	struct refspecs {
        	int nr, alloc;
                const char **refspec;
	} fetch_refspec;

in "struct remote", instead of these two separate fields, and then
make apply_refspecs() take "struct refspecs *"?  I haven't checked
and thought enough to decide if we want "struct refspec *" also in
that new struct, though.
