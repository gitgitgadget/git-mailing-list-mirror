From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] parse-options: introduce OPT_PATH
Date: Mon, 23 Feb 2015 11:23:05 -0800
Message-ID: <xmqqbnkktoti.fsf@gitster.dls.corp.google.com>
References: <20150223144214.GA31624@peff.net>
	<cccf3d14e5582996e5be1467849121a262f9c9f1.1424707497.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	=?utf-8?B?Tmd1eQ==?= =?utf-8?B?4buFbiBUaMOhaSBOZ+G7jWM=?= Duy 
	<pclouds@gmail.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Feb 23 20:23:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YPyb6-00023w-L8
	for gcvg-git-2@plane.gmane.org; Mon, 23 Feb 2015 20:23:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752232AbbBWTXL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Feb 2015 14:23:11 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:53900 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752117AbbBWTXK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Feb 2015 14:23:10 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7C577395E6;
	Mon, 23 Feb 2015 14:23:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lrNPuA1IXszRbO0D7H6ea0JLH30=; b=uowdd/
	klt3Y/L6wMlUELt6FOFO3/WLiPwV6Gfrgdd76MK1mgJT+2cFj4n3jITNCAUbWEAk
	ZW27Akcou9+kd63XZXOCtZALRt7h7fj+uJBFzAJ/bhyhxafdQi1+e7kLgaYl86os
	hf02WBujrwBRdZatkARC/TqJCSF1WIldXL67M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=INBUwcysHibZbQ217HOmw+Ejz8CcBTpg
	zEl/T61fYPc/3p+bhq1HVJFOvxGP5pZ1gxSMCEJBc088uOng/tl40B0PRTEbuPen
	bVmiO2h1ywmzW2bRcb/r53Lp3CtAxGJYdnw2KNZ7LVnFu7HNa+bi6fvljr397yhe
	OnFuZdOI6+M=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7447D395E5;
	Mon, 23 Feb 2015 14:23:09 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D87F6395E1;
	Mon, 23 Feb 2015 14:23:06 -0500 (EST)
In-Reply-To: <cccf3d14e5582996e5be1467849121a262f9c9f1.1424707497.git.git@drmicha.warpmail.net>
	(Michael J. Gruber's message of "Mon, 23 Feb 2015 17:17:43 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 651CCEC2-BB91-11E4-925A-A4119F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264288>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Many options are paths, but not files. Introduce OPT_PATH which does
> the same path processing as OPT_FILENAME but allows to name the argument.
> ...
> diff --git a/parse-options.h b/parse-options.h
> index 7940bc7..5127a5d 100644
> --- a/parse-options.h
> +++ b/parse-options.h
> @@ -149,6 +149,8 @@ struct option {
>  	  PARSE_OPT_NOARG | PARSE_OPT_NONEG, (f) }
>  #define OPT_FILENAME(s, l, v, h)    { OPTION_FILENAME, (s), (l), (v), \
>  				       N_("file"), (h) }
> +#define OPT_PATH(s, l, v, a, h)    { OPTION_FILENAME, (s), (l), (v), \
> +				       (a), (h) }

I am somewhat disappointed to see this implementation.

 - I expected that OPT_FILENAME will be re-implemented in terms of
   OPT_PATH(), as a thin wrapper.

 - As the original complaint was "checkout --to requires a
   directory, and a file would not work", I expected this to give
   the programmer finer controls, such as:

    - The name must refer to an existing entity on the filesystem,
      or an existing entity on the filesystem must not exist, or
      anything is fine (tristate).

    - The name refers to a diretory, or the name refers to a regular
      file, or the name refers to a symbolic link, or anything goes.

That is merely "somewhat", as the latter _can_ be coded (e.g. if you
care that the given path already exists as a directory, stat() it
and see if it is, or if you want that the given path does not exist
yet, stat() it to make sure you get ENOENT) after the option is
parsed by the program that uses the parser.

But the infrastructure to allow the latter would free you from
having to say N_("file") or N_("directory"); if a parameter can
refer to either a file or a directory, the parse-options library
could give you N_("file or directory") because you are already
telling what kind(s) of paths are allowed.

>  #define OPT_COLOR_FLAG(s, l, v, h) \
>  	{ OPTION_CALLBACK, (s), (l), (v), N_("when"), (h), PARSE_OPT_OPTARG, \
>  		parse_opt_color_flag_cb, (intptr_t)"always" }
