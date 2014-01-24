From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/3] read-cache.c: Optionally tolerate missing files in make_cache_entry
Date: Fri, 24 Jan 2014 12:39:40 -0800
Message-ID: <xmqqr47xqflf.fsf@gitster.dls.corp.google.com>
References: <cover.1390574980.git.brad.king@kitware.com>
	<cover.1390592626.git.brad.king@kitware.com>
	<197b46e792c8640d19580f282834052a660d2c05.1390592626.git.brad.king@kitware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, newren@gmail.com, jrnieder@gmail.com
To: Brad King <brad.king@kitware.com>
X-From: git-owner@vger.kernel.org Fri Jan 24 21:40:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W6nXf-0003Xg-V5
	for gcvg-git-2@plane.gmane.org; Fri, 24 Jan 2014 21:39:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752584AbaAXUjw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jan 2014 15:39:52 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54256 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752288AbaAXUjv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jan 2014 15:39:51 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 49C7065BF6;
	Fri, 24 Jan 2014 15:39:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jOVS0jhVheJVxMUwQgwAYcn9oZg=; b=Gltd0Y
	v6oQpxvKHx85+WuKOKmx8VYBbIQWQfXO9r6r/AEmgGJbTvMWAhNmbejJtv1vSn4Z
	SkeMmubm+HM1f8DF64jteM6LUd1a6wUGMVFH7NmXtIriIxMvK9awGq0Nu/EkNCuu
	M0vDAUC+Md/WDu43SYhcV7VOnjSruaHCvz5AQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NaqT9gAPEpeft5MRuE2lZVRK5lWqy2Ng
	1m8nOi0lPMnWSHP+AybHCLXrqosYP9F7Bor6IWVTaETFY9R27/CssPQDTpzSaauL
	5S9ROsx2KwV9LOI0Y8PiPbRa3A4ctHHUJ5fDoP6A/gGtf3RDWADUvjpSbXEEaLWY
	cKhkt0Swb0U=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 33E5D65BF5;
	Fri, 24 Jan 2014 15:39:50 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1C42F65BF3;
	Fri, 24 Jan 2014 15:39:48 -0500 (EST)
In-Reply-To: <197b46e792c8640d19580f282834052a660d2c05.1390592626.git.brad.king@kitware.com>
	(Brad King's message of "Fri, 24 Jan 2014 15:10:48 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: AB155BCE-8537-11E3-A384-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241035>

Brad King <brad.king@kitware.com> writes:

> +extern struct cache_entry *make_cache_entry(unsigned int mode, const unsigned char *sha1, const char *path, int stage, int refresh, int refresh_flags);

Why a new parameter?  If refresh_flags can be ANY when refresh=NoThanks,
shouldn't they be a single variable that tells the callee how the entry
should be refreshed (e.g. "not at all", "normally", "missing is ok", etc.)?

> +static struct cache_entry *refresh_cache_entry(struct cache_entry *ce, int really,
> +					       int flags)
>  {
> -	return refresh_cache_ent(&the_index, ce, really, NULL, NULL);
> +	int not_new = (flags & REFRESH_IGNORE_MISSING) != 0;
> +	int cache_errno = 0;
> +	struct cache_entry *new;
> +
> +	new = refresh_cache_ent(&the_index, ce, really, &cache_errno, NULL);
> +
> +	if(!new && not_new && cache_errno == ENOENT)
> +		return ce;

I think this is still one level too high in the abstraction chain.
"int really" might be of type signed int by historical accidents,
but it is "unsigned int options" for the underlying
refresh_cache_ent().  I'd suggest renaming this to "unsigned int
refresh_options" or something, and then define a new constatnt
similar to the existing CE_MATCH_IGNORE_*.
