From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] builtin/help.c: fix memory leak
Date: Tue, 10 Mar 2015 15:43:37 -0700
Message-ID: <xmqqwq2oxyli.fsf@gitster.dls.corp.google.com>
References: <1425920304-22360-1-git-send-email-sbeller@google.com>
	<1425920304-22360-3-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Mar 10 23:43:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YVSsK-00046i-KN
	for gcvg-git-2@plane.gmane.org; Tue, 10 Mar 2015 23:43:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752652AbbCJWnk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Mar 2015 18:43:40 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:52849 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751762AbbCJWnj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Mar 2015 18:43:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 11F933E403;
	Tue, 10 Mar 2015 18:43:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UEgCwEmEK73hK0paUcNRmYRct+c=; b=LH7JXw
	B5rOtWOpp2lpNSsYexUQmWyVpVMyBJ3hOnbbmJ0UjaDCz2KDffGo34sDnHquCnAu
	FEZEdQXGWnRHX13U8+if3BPLm1YiJwITgw6x8jjZwNbKYPUnHaRPhcLm4oBzckPU
	wtcmIW8Nz9XmcNfevL+wA6bK7Hq0fumeF3sJE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DNX1LygK0hI/t2fQijxidU3ob+MCAIk6
	BBh2/Tie/fJMEhYINFny9curEvizskL7T1qT3xUHOaRjP7Xe/ebg/XeJ24DyJh0y
	4F89v5FViGYHzoWCoe0Ex/0aGRmUThFfvgE0pmRrriM2vFKrZdKDDSZQ0jbdj9QR
	LMh2J1rufnY=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0AB3D3E402;
	Tue, 10 Mar 2015 18:43:39 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5C5113E3FF;
	Tue, 10 Mar 2015 18:43:38 -0400 (EDT)
In-Reply-To: <1425920304-22360-3-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Mon, 9 Mar 2015 09:58:24 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E4A33F46-C776-11E4-8757-29999F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265275>

Stefan Beller <sbeller@google.com> writes:

> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  builtin/help.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/help.c b/builtin/help.c
> index 6133fe4..a1f5a0a 100644
> --- a/builtin/help.c
> +++ b/builtin/help.c
> @@ -456,7 +456,7 @@ static void list_common_guides_help(void)
>  int cmd_help(int argc, const char **argv, const char *prefix)
>  {
>  	int nongit;
> -	const char *alias;
> +	char *alias;
>  	enum help_format parsed_help_format;
>  
>  	argc = parse_options(argc, argv, prefix, builtin_help_options,
> @@ -499,6 +499,7 @@ int cmd_help(int argc, const char **argv, const char *prefix)
>  	alias = alias_lookup(argv[0]);
>  	if (alias && !is_git_command(argv[0])) {
>  		printf_ln(_("`git %s' is aliased to `%s'"), argv[0], alias);
> +		free(alias);

Hmph, does this memory belong to us, or are we peeking into the
cached data in the config cache layer?


>  		return 0;
>  	}
