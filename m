From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/6] Refactor type_from_string() to avoid die()ing in case of errors
Date: Thu, 28 Aug 2014 13:43:41 -0700
Message-ID: <xmqqzjeo8hvm.fsf@gitster.dls.corp.google.com>
References: <alpine.DEB.1.00.1408171840040.990@s15462909.onlinehome-server.info>
	<alpine.DEB.1.00.1408281646350.990@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Aug 28 22:43:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XN6Y2-0007Wy-8v
	for gcvg-git-2@plane.gmane.org; Thu, 28 Aug 2014 22:43:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752222AbaH1Unx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2014 16:43:53 -0400
Received: from smtp.pobox.com ([208.72.237.35]:61449 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751993AbaH1Unx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2014 16:43:53 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 50E48366E4;
	Thu, 28 Aug 2014 16:43:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=uA2Fw/2xGpItUQA1i/Vrvjk37DA=; b=sNi96n
	TDom9iix3lVO+jJREK7clhMoF46TO0kZ2OVOXJ1f+JMq9JFlbLbJ0jDKZeHYdYl9
	2IJtIk36lnZjuCKiajMJ1poG3nIH5HgMZBopT+kAzRDYB1VyPiqUfkLI9RaTM6Yx
	shTHUUwT9I00cLIxgbUWOADwoDHco7CFgWcAM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; q=dns; s=sasl; b=G2jjOir0rQPZEmOHRfqEmSrXTNuDxpD6
	MQvj8Q+4/+LSOWR8Zs/3Dxwbm5BNS4sPz8dfswQ/aknmmK6tkvk9oAhfVHmtfsKP
	7nTUccnjl7OSmRMJPY/SwZk3l2CVXwKbcVotGkyn2d/GVtcvkcofgdOlI4i5QoA+
	b6nZw6V0hRY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 47949366E3;
	Thu, 28 Aug 2014 16:43:52 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 65660366D4;
	Thu, 28 Aug 2014 16:43:43 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.1408281646350.990@s15462909.onlinehome-server.info>
	(Johannes Schindelin's message of "Thu, 28 Aug 2014 16:46:36 +0200
	(CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: FFF6C676-2EF3-11E4-B518-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256122>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> In the next commits, we will enhance the fsck_tag() function to check
> tag objects more thoroughly. To this end, we need a function to verify
> that a given string is a valid object type, but that does not die() in
> the negative case.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  object.c | 13 ++++++++++++-
>  object.h |  1 +
>  2 files changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/object.c b/object.c
> index a16b9f9..5eee592 100644
> --- a/object.c
> +++ b/object.c
> @@ -33,13 +33,24 @@ const char *typename(unsigned int type)
>  	return object_type_strings[type];
>  }
>  
> -int type_from_string(const char *str)
> +int type_from_string_gently(const char *str)
>  {
>  	int i;
>  
>  	for (i = 1; i < ARRAY_SIZE(object_type_strings); i++)
>  		if (!strcmp(str, object_type_strings[i]))
>  			return i;
> +
> +	return -1;
> +}
> +
> +int type_from_string(const char *str)
> +{
> +	int i = type_from_string_gently(str);
> +
> +	if (i >= 0)
> +		return i;
> +
>  	die("invalid object type \"%s\"", str);
>  }

Hmph.  The above is not wrong per-se, but I would have done

	int type_from_string_gently(const char *str, int gentle);
        #define type_from_string(str) type_from_string_gently((str), 1)

and added two lines to renamed type_from_string() function

+	if (gently)
+        	return -1;
