From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] submodule: port resolve_relative_url from shell to C
Date: Thu, 18 Feb 2016 12:23:38 -0800
Message-ID: <xmqqsi0pg439.fsf@gitster.mtv.corp.google.com>
References: <1455320356-15778-1-git-send-email-sbeller@google.com>
	<1455320356-15778-2-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, jrnieder@gmail.com, Jens.Lehmann@web.de
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Feb 18 21:23:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWV79-0004of-6Q
	for gcvg-git-2@plane.gmane.org; Thu, 18 Feb 2016 21:23:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1948140AbcBRUXn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Feb 2016 15:23:43 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:53635 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1948118AbcBRUXl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Feb 2016 15:23:41 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E979A45301;
	Thu, 18 Feb 2016 15:23:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kx42L/HKtyXyzdTQPKuaNmlhk74=; b=nQUMh5
	5YUk5zI/VUTX51yGJyRpdMJoHX/x4SkMVw9L9oM/GtidFc7tbFu64BQfV341P3Dn
	J7G6CwTJMqc3N6AmJ4s6OwO9VYg9ecBqYB5GhWv75h+ffKqO8q9TOPnq1+Jv6eHI
	IN7Pn3mDQOp3zHWkcDSPSZp79kvHxXGXXWsNc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NW7J6ZOKxgsdkAOT62y82BgoYBQYp3A1
	/toX8eo57PcJq0YrL41LBpCLZEO3peM6dP28vVFJ47TiJWY78u/lwc95j9RQEgxu
	qmK0af4Qcd+WE3pYxTZPHQrKfM8feQtdDPQnLutXfGAxbliDuDHISMs5hftNAHEw
	ijMjMJmHaNY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D504845300;
	Thu, 18 Feb 2016 15:23:39 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 53340452F9;
	Thu, 18 Feb 2016 15:23:39 -0500 (EST)
In-Reply-To: <1455320356-15778-2-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Fri, 12 Feb 2016 15:39:15 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 7EEFF434-D67D-11E5-863B-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286618>

Stefan Beller <sbeller@google.com> writes:

> +static int starts_with_dot_slash(const char *str)
> +{
> +	return str[0] == '.' && is_dir_sep(str[1]);
> +}
> +
> +static int starts_with_dot_dot_slash(const char *str)
> +{
> +	return str[0] == '.' && str[1] == '.' && is_dir_sep(str[2]);
> +}
> +
> +/*
> + * Returns 1 if it was the last chop before ':'.
> + */
> +static int chop_last_dir(char **remoteurl, int is_relative)
> +{
> +	char *rfind = find_last_dir_sep(*remoteurl);
> +	if (rfind) {
> +		*rfind = '\0';
> +		return 0;
> +	}
> +
> +	rfind = strrchr(*remoteurl, ':');
> +	if (rfind) {
> +		*rfind = '\0';
> +		return 1;
> +	}
> +
> +	if (is_relative || !strcmp(".", *remoteurl))
> +		die(_("cannot strip one component off url '%s'"),
> +			*remoteurl);
> +
> +	free(*remoteurl);
> +	*remoteurl = xstrdup(".");
> +	return 0;
> +}
> +
> +/*
> + * The `url` argument is the URL that navigates to the submodule origin
> + * repo. When relative, this URL is relative to the superproject origin
> + * URL repo. The `up_path` argument, if specified, is the relative
> + * path that navigates from the submodule working tree to the superproject
> + * working tree. Returns the origin URL of the submodule.
> + *
> + * Return either an absolute URL or filesystem path (if the superproject
> + * origin URL is an absolute URL or filesystem path, respectively) or a
> + * relative file system path (if the superproject origin URL is a relative
> + * file system path).
> + *
> + * When the output is a relative file system path, the path is either
> + * relative to the submodule working tree, if up_path is specified, or to
> + * the superproject working tree otherwise.
> + *
> + * NEEDSWORK: This works incorrectly on the domain and protocol part.
> + * remote_url      url              outcome          correct
> + * http://a.com/b  ../c             http://a.com/c   yes
> + * http://a.com/b  ../../c          http://c         no (domain should be kept)
> + * http://a.com/b  ../../../c       http:/c          no
> + * http://a.com/b  ../../../../c    http:c           no
> + * http://a.com/b  ../../../../../c    .:c           no
> + */

Not just "no" but we should say what the expected outcome is.  I
think all of them should error out?

Given how chop_last_dir() works, I think this function is broken
when a local part has a colon in its path component, too.  I do not
think the scripted version did any better on such a URL; just
another thing that NEEDSWORK comment should list as a thing to be
fixed in the future.
