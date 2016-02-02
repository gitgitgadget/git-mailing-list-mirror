From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v1 2/6] convert.c: Remove path when not needed
Date: Tue, 02 Feb 2016 13:32:58 -0800
Message-ID: <xmqqfuxare5x.fsf@gitster.mtv.corp.google.com>
References: <Message-Id=1453558101-6858-1-git-send-email-tboegi@web.de>
	<1454431990-1980-1-git-send-email-tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: tboegi@web.de
X-From: git-owner@vger.kernel.org Tue Feb 02 22:33:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQiZQ-0002ob-Dc
	for gcvg-git-2@plane.gmane.org; Tue, 02 Feb 2016 22:33:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932782AbcBBVdD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2016 16:33:03 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:63519 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755365AbcBBVdA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Feb 2016 16:33:00 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E0B524145D;
	Tue,  2 Feb 2016 16:32:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4+a6NZDzhnAMd+H3QLJlz/n2umY=; b=MsJu5r
	2UsCBzgb0SszXPoBtDCB9IoA+r43BaOM4EcGthCGKI5ci5HMt74wkiVo7RO9sVL6
	jZLvY3JFSXm4t2fdZQq9gsDXvwipKaFickhwh5pCy7FGR7bgrdMTBks6d1vd6mJ6
	dqI9OF/oCC6eYawBiieSccHZ7CB4ebKVbAETY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cf4MVV/gHqcnfiBpU6i4NndrJJaSVvoB
	PKzIPrEWVUyYrof3bcZ+QODmWNBrufGKaaDrmgCpfP3JrEIsY8ZxlUxXdKarcu3r
	czApxg++GaqYDfQ2CXN510cGLURcm8G/QT5vAJTLp/8LyL/tzcZLLAect04bRUsm
	3a1DhlWYAmk=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D60F24145C;
	Tue,  2 Feb 2016 16:32:59 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 542394145B;
	Tue,  2 Feb 2016 16:32:59 -0500 (EST)
In-Reply-To: <1454431990-1980-1-git-send-email-tboegi@web.de> (tboegi@web.de's
	message of "Tue, 2 Feb 2016 17:53:10 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 87E1A7D0-C9F4-11E5-AD29-04C16BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285310>

tboegi@web.de writes:


> Subject: Re: [PATCH v1 2/6] convert.c: Remove path when not needed

At least s/: Remove/: remove/, but I think

s/: Remove.*/: remove unused parameter 'path'/

would be easier to read.

All of these functions seem to have "path" in their name, sounding
as if they meant to ask "What is the crlf-ness for THIS PATH?"  Is
it still sensible to have "path" in their names?

The necessary information that is specific to the path was already
gathered when we prepared the 'check' thing, so they are still
asking and answering their questions specific to the path by
accepting 'check', but it still feels somewhat funny.

With or without "path" in their names, they are horribly misnamed
(e.g. "check crlf---are we asking if the file has crlf?  if the
file must be written out with crlf?  something else?").

Your later patches seem to refactor and reorganize this internal
calling mess in some way, so let's read on and see how the whole
thing improves ;-)

> -static enum crlf_action git_path_check_crlf(const char *path, struct git_attr_check *check)
> +static enum crlf_action git_path_check_crlf(struct git_attr_check *check)
>  {
>  	const char *value = check->value;
>  
> @@ -713,7 +713,7 @@ static enum crlf_action git_path_check_crlf(const char *path, struct git_attr_ch
>  	return CRLF_GUESS;
>  }
>  
> -static enum eol git_path_check_eol(const char *path, struct git_attr_check *check)
> +static enum eol git_path_check_eol(struct git_attr_check *check)
>  {
>  	const char *value = check->value;
>  
> @@ -726,8 +726,7 @@ static enum eol git_path_check_eol(const char *path, struct git_attr_check *chec
>  	return EOL_UNSET;
>  }
>  
> -static struct convert_driver *git_path_check_convert(const char *path,
> -					     struct git_attr_check *check)
> +static struct convert_driver *git_path_check_convert(struct git_attr_check *check)
>  {
>  	const char *value = check->value;
>  	struct convert_driver *drv;
> @@ -740,7 +739,7 @@ static struct convert_driver *git_path_check_convert(const char *path,
>  	return NULL;
>  }
>  
> -static int git_path_check_ident(const char *path, struct git_attr_check *check)
> +static int git_path_check_ident(struct git_attr_check *check)
>  {
>  	const char *value = check->value;
>  
> @@ -783,12 +782,12 @@ static void convert_attrs(struct conv_attrs *ca, const char *path)
>  	}
>  
>  	if (!git_check_attr(path, NUM_CONV_ATTRS, ccheck)) {
> -		ca->crlf_action = git_path_check_crlf(path, ccheck + 4);
> +		ca->crlf_action = git_path_check_crlf( ccheck + 4);
>  		if (ca->crlf_action == CRLF_GUESS)
> -			ca->crlf_action = git_path_check_crlf(path, ccheck + 0);
> -		ca->ident = git_path_check_ident(path, ccheck + 1);
> -		ca->drv = git_path_check_convert(path, ccheck + 2);
> -		ca->eol_attr = git_path_check_eol(path, ccheck + 3);
> +			ca->crlf_action = git_path_check_crlf(ccheck + 0);
> +		ca->ident = git_path_check_ident(ccheck + 1);
> +		ca->drv = git_path_check_convert(ccheck + 2);
> +		ca->eol_attr = git_path_check_eol(ccheck + 3);
>  	} else {
>  		ca->drv = NULL;
>  		ca->crlf_action = CRLF_GUESS;
