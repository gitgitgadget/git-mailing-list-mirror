From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Fix safe_create_leading_directories() for Windows
Date: Thu, 02 Jan 2014 13:51:14 -0800
Message-ID: <xmqqzjnenjcd.fsf@gitster.dls.corp.google.com>
References: <52C5A039.6030408@gmail.com>
	<alpine.DEB.1.00.1401021826120.1191@s15462909.onlinehome-server.info>
	<xmqqtxdmp39a.fsf@gitster.dls.corp.google.com>
	<52C5D0AB.7050309@gmail.com> <52C5D201.5070008@gmail.com>
	<xmqq8uuyoz5g.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 02 22:51:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VyqAk-0000aY-9Z
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jan 2014 22:51:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752059AbaABVvS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jan 2014 16:51:18 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56119 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750814AbaABVvS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jan 2014 16:51:18 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7E9655E8DC;
	Thu,  2 Jan 2014 16:51:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Amn02scIBOaeEDJx9B77yBbezao=; b=HtUkEE
	JFTreo+zKO0bij8F0uHKt6oloG673YTfNLUoHg2n2hSbAT8x/eqFbxjo7F3cDmHf
	nUYOLJ6hS3n9Y3wIvwsuQHdgQiqft54AXmkgswYE1DrpSnSAbA/xXyanD7jCiXFV
	tZrXN8IKCKgYHDK0fPy5Kh+xUeXJc28YvUY/s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dBYau7NFp/3vea3RkowVYhM3vcJ+reR9
	thN+d2R9w+ovXLoLiFcMXIVBwgwczkHj0eJVnGANxGKg2uz07cHAnMUil2u+qZK9
	4EjzhXyrPAsTB4meaK+7kzWpsTuj0SSsJAmJvUhpAYo1Y+9iVnniwMIT9JeWCJRG
	92F5W4ubKg4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4CCB55E8DB;
	Thu,  2 Jan 2014 16:51:17 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 31BFD5E8DA;
	Thu,  2 Jan 2014 16:51:16 -0500 (EST)
In-Reply-To: <xmqq8uuyoz5g.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Thu, 02 Jan 2014 13:24:27 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 014CB06A-73F8-11E3-9F16-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239889>

Junio C Hamano <gitster@pobox.com> writes:

> This has a bit of conflict with another topic in flight; I think I
> resolved it correctly, but please double check.  The following is
> how it would apply on top of 'pu'.
>
>  sha1_file.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/sha1_file.c b/sha1_file.c
> index 131ca97..9e686eb 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -113,11 +113,12 @@ int safe_create_leading_directories(char *path)
>  
>  	while (!retval && next_component) {
>  		struct stat st;
> -		char *slash = strchr(next_component, '/');
> -
> -		if (!slash)
> +		char *slash = next_component;
> +		while (!is_dir_sep(*slash))

Gaah; we need to check for the end of string here, i.e.

		while (*slash && !is_dir_sep(*slash))

will be what I'll queue on 'pu' for today.

> +			++slash;
> +		if (!*slash)
>  			return 0;
> -		while (*(slash + 1) == '/')
> +		while (is_dir_sep(*(slash + 1)))
>  			slash++;
>  		next_component = slash + 1;
>  		if (!*next_component)
