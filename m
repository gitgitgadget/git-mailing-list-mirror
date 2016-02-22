From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] convert.c: correct attr_action
Date: Mon, 22 Feb 2016 00:20:17 -0800
Message-ID: <xmqq8u2d88ce.fsf@gitster.mtv.corp.google.com>
References: <Message-Id=1453558101-6858-1-git-send-email-tboegi@web.de>
	<1456117898-30357-1-git-send-email-tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: tboegi@web.de
X-From: git-owner@vger.kernel.org Mon Feb 22 09:20:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXljL-0000RE-48
	for gcvg-git-2@plane.gmane.org; Mon, 22 Feb 2016 09:20:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753634AbcBVIUY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2016 03:20:24 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:56478 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753566AbcBVIUU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2016 03:20:20 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6616443304;
	Mon, 22 Feb 2016 03:20:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=G0a1+Gp1rrK4/Tew3Wz2u7yF+Ho=; b=AcjH94
	AV2WqAPjD1ajN5ktV3Zsb6a4hWBcZWpC+9Zz7O5fMyCg6p32FJOkrR99nhNdfNBk
	lklEyQwKPTw470MSZbbFPymOvwF/chXLTgHEQVOi5HFI8Pt6czdu/q4wuzlGkN/n
	sAJyo57LxNBZsi0oAPDned0m4dVH25z9rdEOM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aew/ThuQzMTDkUt2+HwynHu+WIl0jjlS
	Dx5fYrmzwFHf8cUIlE4N01fKR8S1NxgBgqkJ3WaSTLE6xYGqNW3xEPIRKsl74Hxw
	BXgcCh+0Ij8mA16iTO8kn3S8LA+Q3omHEm83RE2IWgjlExZdnBY15fDicuOGtpst
	NYnE91rhlxQ=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5BE6E43303;
	Mon, 22 Feb 2016 03:20:19 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id CED1043302;
	Mon, 22 Feb 2016 03:20:18 -0500 (EST)
In-Reply-To: <1456117898-30357-1-git-send-email-tboegi@web.de>
	(tboegi@web.de's message of "Mon, 22 Feb 2016 06:11:38 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1BE0935E-D93D-11E5-93D8-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286894>

tboegi@web.de writes:

> diff --git a/convert.c b/convert.c
> index 18af685..0bc32ec 100644
> --- a/convert.c
> +++ b/convert.c
> @@ -708,7 +708,7 @@ static enum crlf_action git_path_check_crlf(struct git_attr_check *check)
>  	const char *value = check->value;
>  
>  	if (ATTR_TRUE(value))
> -		return text_eol_is_crlf() ? CRLF_TEXT_CRLF : CRLF_TEXT_INPUT;
> +		return CRLF_TEXT;
>  	else if (ATTR_FALSE(value))
>  		return CRLF_BINARY;
>  	else if (ATTR_UNSET(value))

Hmph, this function has exactly two callers, and they call it like
this:

	if (!git_check_attr(path, NUM_CONV_ATTRS, ccheck)) {
		enum eol eol_attr;
		ca->crlf_action = git_path_check_crlf(ccheck + 4);
		if (ca->crlf_action == CRLF_UNDEFINED)
			ca->crlf_action = git_path_check_crlf(ccheck + 0);
		ca->attr_action = ca->crlf_action;

where ccheck+0 refers to "crlf" and ccheck+4 refers to "text".

So, we say "first check 'text' attribute, and if it is true we say
CRLF_TEXT and stop."  We also say "first check 'text', and if it is
not there, the first call returns undef, in which case we check 'crlf'
attribute, and if it is true we say CRLF_TEXT".

And ca->attr_action retains this value.

However, immediately after this assignment to ca->attr_action, we
have this:

		ca->ident = git_path_check_ident(ccheck + 1);
		ca->drv = git_path_check_convert(ccheck + 2);
		if (ca->crlf_action == CRLF_BINARY)
			return;
		eol_attr = git_path_check_eol(ccheck + 3);
		if (eol_attr == EOL_LF)
			ca->crlf_action = CRLF_TEXT_INPUT;
		else if (eol_attr == EOL_CRLF)
			ca->crlf_action = CRLF_TEXT_CRLF;
		ca->attr_action = ca->crlf_action;

We check ident (ccheck+1) and filter (ccheck+2); if the value of
ca->crlf_action (which was determined by checking 'text' and then
'crlf') is not CRLF_BINARY, we further check eol (ccheck+3) and
update ca->crlf_action based on it.  And ca->attr_action gets
updated again.

This feels unnecessarily convoluted.  Perhaps if you get rid of the
early return for CRLF_BINARY, the flow may become a lot clearer,
i.e.

	ca->crlf_action = check 'text';
        if (ca->crlf_action == undef)
        	ca->crlf_action = check 'crlf';
	// DO NOT ASSIGN ca->attr_action HERE YET
        ca->ident = check 'ident';
        ca->drv = check 'filter';
        if (crlf_action != CRLF_BINARY) {
                eol_attr = check 'eol';
                if (eol == LF)
                        ca->crlf_action = ...
                else if (eol == EOL_CRLF)
                        ca->crlf_action = ...
	}
        ca->attr_action = ca->crlf_action;

Hmm?
