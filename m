From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] pathspec: allow escaped query values
Date: Wed, 01 Jun 2016 17:33:13 -0700
Message-ID: <xmqq37owwhti.fsf@gitster.mtv.corp.google.com>
References: <20160601235233.21040-1-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: pclouds@gmail.com, git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Jun 02 02:33:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8GZd-0004xo-PB
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jun 2016 02:33:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751232AbcFBAdR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jun 2016 20:33:17 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59448 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750867AbcFBAdR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2016 20:33:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 958B520440;
	Wed,  1 Jun 2016 20:33:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cB/rNb0+BkY6JgKrEdWHHKTVtoQ=; b=t/RKW4
	3ZkGvziU8GZ1+MeW6kNo5sLxqPaJZ1WTCa3UB150ebrxjYZATGHg2RiaSG2+z3dx
	5DtxBa8gda7dvHRsrmeset+OszsJbD9c0n+WbsxPloMpzTPElC9bcZ/niw9sE3w5
	TGDAs2/Px7hWjueS3PVcZqUb33JDlZas22E30=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=C+TQyG71EmqlJ53vImBT4Q19n8jF3Yql
	T67Gl9KkRfmfAcHWnrs6rDJ1nXy6hdmqUPJPKTyfCS1RtRhONM8jMPY5adhnvrx+
	vIB/5FOBsxHbrtBGr9hgooZ8iLhhz8BAlGpY3ucHdFaN449PdefdERsgH6r+Fvbu
	uowzJ9Lie/E=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 8EC1B2043F;
	Wed,  1 Jun 2016 20:33:15 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 10A8B2043B;
	Wed,  1 Jun 2016 20:33:14 -0400 (EDT)
In-Reply-To: <20160601235233.21040-1-sbeller@google.com> (Stefan Beller's
	message of "Wed, 1 Jun 2016 16:52:33 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 981FCB4A-2859-11E6-8CFC-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296180>

Stefan Beller <sbeller@google.com> writes:

> This change allows escaping characters by a backslash, such that the query
>
>     git ls-files :(attr:whitespace=indent\,trail\,space)
>
> will match all path that have the value "indent,trail,space" for the
> whitespace attribute. To accomplish this, we need to modify two places.
> First `eat_long_magic` needs to not stop early upon seeing a comma or
> closing paren that is escaped. As a second step we need to remove any
> escaping from the attr value. For now we just remove any backslashes.
>
> Caveat: This doesn't allow for querying for values that have backslashes
> in them, e.g.
>
>     git ls-files :(attr:backslashes=\\)
>
> that would ask for matches that have the `backslashes` value set to '\'.

> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>
>  * This applies on top of sb/pathspec-label
>  * Junio does this come close to what you imagine for escaped commas?

I, being lazy, would have used %44 for comma, which would have
avoided touching higher level of the callchain.  But "a backslash
always quotes the next byte, if you want to express a backslash,
double it" would probably be a more end-user friendly quoting
mechanism.

I do not offhand understand why the second example does not show the
paths with backslash attribute set to a single backslash, though.

> -				am->value = xstrdup(&attr[attr_len + 1]);
> +				am->value = attr_value_unquote(&attr[attr_len + 1]);
>  				if (strchr(am->value, '\\'))
>  					die(_("attr spec values must not contain backslashes"));

IOW, the "backslash is forbidden for now" IIUC was added there so
that we can introduce a quoting like this--once we decided that
quoting mechanism is via backslashes and have quoting support,
shouldn't the "values must not have backslash" just go?

>  	     *copyfrom && *copyfrom != ')';
>  	     copyfrom = nextat) {
>  		size_t len = strcspn(copyfrom, ",)");
> +		while (len > 0 && copyfrom[len - 1] == '\\'
> +		       && (copyfrom[len] == ',' || copyfrom[len] == ')'))
> +			len += strcspn(copyfrom + len + 1, ",)") + 1;

Good that we can use ')' in values, too, but I think this gets this
case wrong:

	:(attr:foo=\\,icase)

where the value for 'foo' wants to be a single backslash, and comma
is to introduce another magic, not part of the value for 'foo'.

If you want to do the "backslash unconditionally quotes the next
byte no matter what is quoted", you'd need to lose the strcspn()
and iterate over the string yourself, I would think.

>  		if (copyfrom[len] == ',')
>  			nextat = copyfrom + len + 1;
>  		else
