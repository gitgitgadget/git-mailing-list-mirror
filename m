From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v8 03/12] Move lower case functions into wrapper.c
Date: Wed, 26 Mar 2014 16:07:34 -0700
Message-ID: <xmqqppl8ftjd.fsf@gitster.dls.corp.google.com>
References: <20140326215858.11352.89243.chriscool@tuxfamily.org>
	<20140326221531.11352.86408.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Thu Mar 27 00:07:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSwvB-0008DA-LC
	for gcvg-git-2@plane.gmane.org; Thu, 27 Mar 2014 00:07:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756671AbaCZXHi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Mar 2014 19:07:38 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51772 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756652AbaCZXHg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Mar 2014 19:07:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 627D478021;
	Wed, 26 Mar 2014 19:07:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=50GF7GfvI+PWSU1wbDWtDDbBCfw=; b=dg5/wueWRe2z17d9NQuk
	0CHvMqIQsSK9DqMCLDE5irzmKHg1H3zOEO/cBZGn/Q+rrnmlr+WKg28QlmWMQZ9g
	syFU+l3UXBMsrUZrlsCwHZmUCOgmYKGM3IqK8qC0E2zZDSZivYxVuKe/OdWgyMch
	nCf00pM/fdaQDwT/w0FZFbM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=IPBz+o4OkKAyijiAg4cb6qtE1zJiA/7/wF7tp8YqXXTTaD
	Oc9XcmbWpiZ6BOzAHcNHSH6sbv5GtjS9VOuqpXxo10qba9TwsDfLQniqEHb/AN8g
	scHHCXuxDSz4dDjQvD6vsHeQ0rJQE54CEvMNWlOeEpp8yGoj6BQB/YoqUxHYE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 506197801F;
	Wed, 26 Mar 2014 19:07:36 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 936C27801D;
	Wed, 26 Mar 2014 19:07:35 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 6B28F64A-B53B-11E3-9279-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245255>

Christian Couder <chriscool@tuxfamily.org> writes:

> diff --git a/wrapper.c b/wrapper.c
> index 0cc5636..c46026a 100644
> --- a/wrapper.c
> +++ b/wrapper.c
> @@ -455,3 +455,17 @@ struct passwd *xgetpwuid_self(void)
>  		    errno ? strerror(errno) : _("no such user"));
>  	return pw;
>  }
> +
> +void lowercase(char *p)
> +{
> +	for (; *p; p++)
> +		*p = tolower(*p);
> +}
> +
> +char *xstrdup_tolower(const char *str)
> +{
> +	char *dup = xstrdup(str);
> +	lowercase(dup);
> +	return dup;
> +}
> +

As a pure code-movement step, this may be OK, but I am not sure if
both of them want to be public functions in this shape.

Perhaps

char *downcase_copy(const char *str)
{
	char *copy = xmalloc(strlen(str) + 1);
        int i;
        for (i = 0; str[i]; i++)
        	copy[i] = tolower(str[i]);
	copy[i] = '\0';
        return copy;
}

may avoid having to copy things twice.  Do you need the other
function exposed?
