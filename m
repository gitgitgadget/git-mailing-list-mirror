From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 01/15] read-cache: fix memleak
Date: Fri, 20 Mar 2015 20:26:14 -0700
Message-ID: <xmqq619vc9pl.fsf@gitster.dls.corp.google.com>
References: <1426897692-18322-1-git-send-email-sbeller@google.com>
	<1426897692-18322-2-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Sat Mar 21 04:26:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZA3e-0002Nd-Qy
	for gcvg-git-2@plane.gmane.org; Sat, 21 Mar 2015 04:26:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751489AbbCUD0R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2015 23:26:17 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:51321 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750977AbbCUD0Q (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2015 23:26:16 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DAA8B42735;
	Fri, 20 Mar 2015 23:26:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=10Z/IGFFtVt4VnNpnMG2UVsI9nM=; b=MTWWan
	Y6GfTwYw8r22Qk6JKxNOHXwFJVz4QDZYDbqXmkp3ZoUJugED68ZyyoAeHfDB5r3N
	7E7lSoexKzBULQWvGalTXpoQpPgHdYk9dDAzVDT3OVsTjZ0gpLWQBptYQZBZ5MSG
	DNwBnJJr4bZwzr0R8gSwNKmK62MjPs79mSGyA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NOS91GdQMedoxbLBrluepjvjrLtOsz5W
	vmaKD2aywvVQEG0LWxMh7z0HNSNrDSBmEwGtwtHFpKMO365yJhTO8gQhs6iFvd8P
	PDW1ZVdB7cJM3NFQVLgj4E/jSrHCqV8HYJwi5pJgHkK9BMCgMtJDJlUIrER0mykT
	1Yvmf3yjD+Q=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D399642734;
	Fri, 20 Mar 2015 23:26:15 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4C58442733;
	Fri, 20 Mar 2015 23:26:15 -0400 (EDT)
In-Reply-To: <1426897692-18322-2-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Fri, 20 Mar 2015 17:27:58 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 07E33C94-CF7A-11E4-B7A7-6DD39F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266000>

Stefan Beller <sbeller@google.com> writes:

> `ce` is allocated in make_cache_entry and should be freed if it is not
> used any more. refresh_cache_entry as a wrapper around refresh_cache_ent
> will either return `ce` or a new updated cache entry which is allocated
> to new memory. In that case we need to free `ce` ourselfs.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  read-cache.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/read-cache.c b/read-cache.c
> index 8d71860..f72ea9f 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -747,6 +747,8 @@ struct cache_entry *make_cache_entry(unsigned int mode,
>  		free(ce);
>  		return NULL;
>  	} else {
> +		if (ret != ce)
> +			free(ce);
>  		return ret;
>  	}
>  }

Good, I vaguely recall that we did something similar in another
codepath that forgot the fact that refresh_cache_entry() may make
the incoming ce unnecessary.

As the rule is "if ret is different from ce, then ce must be freed"
in this codepath, I wonder if this is easier to read:

	ret = refresh_cache_entry(ce, ...);
        if (ret != ce)
        	free(ce);
	return ret;
