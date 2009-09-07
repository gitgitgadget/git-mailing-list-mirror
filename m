From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] grep: fix exit status if external_grep() returns error
Date: Mon, 07 Sep 2009 11:13:55 -0700
Message-ID: <7vskeyvd0c.fsf@alter.siamese.dyndns.org>
References: <20090902080305.GA11549@neumann>
 <20090902081917.GA5447@coredump.intra.peff.net>
 <20090904070216.GA3996@darc.dnsalias.org>
 <20090905061804.GB29863@coredump.intra.peff.net>
 <7v8wgt98ms.fsf@alter.siamese.dyndns.org>
 <20090905072017.GA5152@coredump.intra.peff.net>
 <7v3a717rgl.fsf@alter.siamese.dyndns.org>
 <20090905123117.GA3099@darc.dnsalias.org>
 <7v3a6zu1dk.fsf@alter.siamese.dyndns.org> <20090907084801.GB10797@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	git@vger.kernel.org
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Mon Sep 07 20:14:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MkijJ-0003MM-K9
	for gcvg-git-2@lo.gmane.org; Mon, 07 Sep 2009 20:14:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753454AbZIGSOH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Sep 2009 14:14:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752198AbZIGSOH
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Sep 2009 14:14:07 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:61907 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752164AbZIGSOG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Sep 2009 14:14:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 33971230F9;
	Mon,  7 Sep 2009 14:14:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BbN7vKkHuKJFKfYK84y3DKrhyxI=; b=H6i5u/
	Z2jTD5jbHAa/SvNhmBLeA+nIaBMdgitAQdSu6Dw7NdPjrSwbtgV1kA6QwlSkUhX/
	uJyn8hLoLX2x0wxXJNTWjEy3U7rGRUR3oO0v7FKEKDdG0om/K2WHsXYI4hPMseoC
	ReaI0wUL9Sh0qMYGwmD+UZTBtKgX1MdUeFwn0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fH3+VlGlhOs5YqMVpZyk/ZTH/6iw2HBi
	ujKX3xcaagZ9GrObPGQxD9vsFmvQ0HAp5T2erXNDb//y069yZSyeW+2mp0iGu0G5
	ZYnEDg52rlZ6XCUJMEfQTyqVdrTkrWe0pBUczJKvqNpKOMexMHls6ZrSg0mRPFm4
	zsjrFQ+bg44=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id DE168230F4;
	Mon,  7 Sep 2009 14:14:01 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F2599230F3; Mon,  7 Sep
 2009 14:13:56 -0400 (EDT)
In-Reply-To: <20090907084801.GB10797@localhost> (Clemens Buchacher's message
 of "Mon\, 7 Sep 2009 10\:48\:01 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 385F82D0-9BDA-11DE-98A6-A13518FFA523-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127941>

Clemens Buchacher <drizzd@aon.at> writes:

> diff --git a/builtin-grep.c b/builtin-grep.c
> index ad0e0a5..b577738 100644
> --- a/builtin-grep.c
> +++ b/builtin-grep.c
> @@ -500,9 +500,9 @@ static int grep_cache(struct grep_opt *opt, const char **paths, int cached,
>  	 * be a lot more optimized
>  	 */
>  	if (!cached && external_grep_allowed) {
> -		hit = external_grep(opt, paths, cached);
> -		if (hit >= 0)
> -			return hit;
> +		int ret = external_grep(opt, paths, cached);
> +		if (ret >= 0)
> +			return ret;

Well caught, and this deserves to go to maint.

An alternative would be to reset hit to zero if we decide to use the
internal one after this conditional.

Thanks.
