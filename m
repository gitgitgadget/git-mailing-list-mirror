From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 14/14] diff_opt_parse(): use convert_i() when handling --abbrev=<num>
Date: Wed, 18 Mar 2015 23:37:06 -0700
Message-ID: <xmqqsid1jxwt.fsf@gitster.dls.corp.google.com>
References: <1426608016-2978-1-git-send-email-mhagger@alum.mit.edu>
	<1426608016-2978-15-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.org>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Mar 19 07:37:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYU4x-0002Jp-2A
	for gcvg-git-2@plane.gmane.org; Thu, 19 Mar 2015 07:37:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750928AbbCSGhK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2015 02:37:10 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:58651 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750729AbbCSGhJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2015 02:37:09 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BADD83A762;
	Thu, 19 Mar 2015 02:37:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gt7zYexm7IoMapevxfiavzR6zys=; b=PdsJwM
	s8NfpTmmmNMLg9qKRrZwG84r36f7E6pRfzfrJyrJ7y1ECb67oJmgDeh0aykmxwo8
	5ojatnFvW0VQGAwzAgv07Z688qT2/ziltHbTDTlK44ENyaLgTeDdVDeNFh6VuUpg
	AhYtgcEibbtpe9QnUBEH6zDmNlUitJdnTmAOI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=R1dn1zk5oD7x+OpdESGko3ZAZxmqR1Z8
	P8p9bIZFCjApDTKk/+sEfOxGZZ6G5RAjfwFg2iXEkKtXmjqzT0b0uMiZ3/Z3wmSJ
	TsmEfIvf0ziVUjdxRneXo+U3iQqNZsyXOIV2FFKrIxhv6CDbonpu+0ddDvsjHFae
	O8+qI3V9Yxs=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A3E0B3A761;
	Thu, 19 Mar 2015 02:37:08 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1E89F3A760;
	Thu, 19 Mar 2015 02:37:08 -0400 (EDT)
In-Reply-To: <1426608016-2978-15-git-send-email-mhagger@alum.mit.edu> (Michael
	Haggerty's message of "Tue, 17 Mar 2015 17:00:16 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5D78A1B8-CE02-11E4-A828-FAE19E42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265790>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> die() with an error message if the argument is not a non-negative
> integer. This change tightens up parsing: '+' and '-', leading
> whitespace, and trailing junk are all disallowed now.
>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
>  diff.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/diff.c b/diff.c
> index be389ae..1cc5428 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -3830,7 +3830,8 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
>  	else if (!strcmp(arg, "--abbrev"))
>  		options->abbrev = DEFAULT_ABBREV;
>  	else if (skip_prefix(arg, "--abbrev=", &arg)) {
> -		options->abbrev = strtoul(arg, NULL, 10);
> +		if (convert_i(arg, 10, &options->abbrev))
> +			die("--abbrev requires an integer argument");

Everybody leading up to this step said "a non-negative integer", but
this one is different?

>  		if (options->abbrev < MINIMUM_ABBREV)
>  			options->abbrev = MINIMUM_ABBREV;
>  		else if (40 < options->abbrev)
