From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 07/18] fsck: Make fsck_ident() warn-friendly
Date: Wed, 21 Jan 2015 00:56:41 -0800
Message-ID: <xmqqh9vky0ja.fsf@gitster.dls.corp.google.com>
References: <xmqqr3w7gxr4.fsf@gitster.dls.corp.google.com>
	<cover.1421682369.git.johannes.schindelin@gmx.de>
	<fd39fcf9ea878711423e03a162a9f671dcf3310c.1421682369.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jan 21 09:56:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YDr5k-0005he-2f
	for gcvg-git-2@plane.gmane.org; Wed, 21 Jan 2015 09:56:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752201AbbAUI4o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2015 03:56:44 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:50272 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752174AbbAUI4n (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2015 03:56:43 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E7086269E7;
	Wed, 21 Jan 2015 03:56:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2rHDoJ36OrcQjN1He78tlTqFYUQ=; b=WXfeMB
	dW7VWHxrqtRdg8ZB0cm6XJ6/lpFyYAWd+7NSE7KYV93Wbkn+vQGR37Rx/BdOD0ev
	QdXq4LwVrl66nz/z4uFqLvJIkGYHC5lHDtoNanJ115GqI7p+tb0bqoWH4TNuN4nm
	Z6cK/4PeuoRwFgKP1UPCAll7XCgqfWO1W4TcQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NM2LZcOBdeejA9P8571PyOS1r9loQVzS
	ANF66uA3T22Gr/e+41wPTMugy4jeof+iINkbMuWMM7DvyuVQVyi3GXURVFPtzXuL
	Dlxf6h1Ro1RQy2xqwwnRL/U6WlB3xVsW4QefI8bOSbHWQ0c8hG3h/k3dcbJxjcl4
	n7aaSEmXygs=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DEF87269E6;
	Wed, 21 Jan 2015 03:56:42 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 65E5E269E4;
	Wed, 21 Jan 2015 03:56:42 -0500 (EST)
In-Reply-To: <fd39fcf9ea878711423e03a162a9f671dcf3310c.1421682369.git.johannes.schindelin@gmx.de>
	(Johannes Schindelin's message of "Mon, 19 Jan 2015 16:50:46 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6B63809C-A14B-11E4-8D12-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262718>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> When fsck_ident() identifies a problem with the ident, it should still
> advance the pointer to the next line so that fsck can continue in the
> case of a mere warning.

Quite sensible.

>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  fsck.c | 49 +++++++++++++++++++++++++++----------------------
>  1 file changed, 27 insertions(+), 22 deletions(-)
>
> diff --git a/fsck.c b/fsck.c
> index 78944f0..233385b 100644
> --- a/fsck.c
> +++ b/fsck.c
> @@ -453,40 +453,45 @@ static int require_end_of_header(const void *data, unsigned long size,
>  
>  static int fsck_ident(const char **ident, struct object *obj, struct fsck_options *options)
>  {
> +	const char *p = *ident;
>  	char *end;
>  
> -	if (**ident == '<')
> +	*ident = strchrnul(*ident, '\n');
> +	if (**ident == '\n')
> +		(*ident)++;
> +
> +	if (*p == '<')
>  		return report(options, obj, FSCK_MSG_MISSING_NAME_BEFORE_EMAIL, "invalid author/committer line - missing space before email");
