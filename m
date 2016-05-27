From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] add: add --chmod=+x / --chmod=-x options
Date: Fri, 27 May 2016 11:35:00 -0700
Message-ID: <xmqqinxzqrhn.fsf@gitster.mtv.corp.google.com>
References: <20160525020609.GA20123@zoidberg>
	<alpine.DEB.2.20.1605250923120.4449@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Edward Thomson <ethomson@edwardthomson.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri May 27 20:35:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b6MbJ-0003x9-3j
	for gcvg-git-2@plane.gmane.org; Fri, 27 May 2016 20:35:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756221AbcE0SfG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 May 2016 14:35:06 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50422 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753300AbcE0SfF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 May 2016 14:35:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 281981E6DC;
	Fri, 27 May 2016 14:35:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=c32jKji+akuKpgNojt5JMdOAmxw=; b=FJfunr
	C3mPaaQp97joylIryUrCPiucdokeqlTtP0ITnNi9FvxqP5xybp94gn7hOgykPkLT
	PU4smNapgN+34JF8hFLiqUSvZTdyGW4PUToR6rjJCnfpy4SEELngoSZMHAyVV2sz
	ZWmVeuRTpMRM+I/10PohnpuLoZQzyPjuDz2LE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Q9jEad+m5xDkN2og5RxINqdKzoC6tCQZ
	aJm9dvnOIQKGFAy+tVl/WGSdvXSVWhuarj+Af3LuX2VDXHDrtzRw5R8tvn9cy/Uz
	NTDUYWrER7cK9EJWZtRxijwR5hi8Uw2JPSoE7q5Xs0JiqzrkxfMy1LhteHsPUuxJ
	usWVYcjB1NE=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1EE421E6DB;
	Fri, 27 May 2016 14:35:03 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 883901E6D8;
	Fri, 27 May 2016 14:35:02 -0400 (EDT)
In-Reply-To: <alpine.DEB.2.20.1605250923120.4449@virtualbox> (Johannes
	Schindelin's message of "Wed, 25 May 2016 09:46:17 +0200 (CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B986CE7E-2439-11E6-A71E-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295783>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> I wonder, however, whether it would be "cleaner" to simply make this an
> OPT_STRING and perform the validation after the option parsing.

Yes, I think I touched on this in my comments in a bit more detail.

> Hmm. This change uses up 2 out of 31 available bits. I wonder whether a
> better idea would be to extend struct update_callback_data to include a
> `force_mode` field, pass a parameter of the same name to
> add_files_to_cache() and then handle that in the update_callback().

Maybe.  I am not sure if it is a good idea to do lstat(2) on the
calling side, though.  Assuming it is, your "something like this"
needs to be duplicated for the codepath that adds a new file, which
is separate from the one we see below (i.e. add_files()).

> Something like this:
>
>                 case DIFF_STATUS_MODIFIED:
> -               case DIFF_STATUS_TYPE_CHANGED:
> +               case DIFF_STATUS_TYPE_CHANGED: {
> +			struct stat st;
> +			if (lstat(path, &st))
> +				die_errno("unable to stat '%s'", path);
> +			if (S_ISREG(&st.st_mode) && data->force_mode)
> +				st.st_mode = data->force_mode;
> -                       if (add_file_to_index(&the_index, path, data->flags)) {
> +                       if (add_to_index(&the_index, path, &st, data->flags)) {
>                                 if (!(data->flags & ADD_CACHE_IGNORE_ERRORS))
>                                         die(_("updating files failed"));
>                                 data->add_errors++;
>                         }
>                         break;
> +		}
