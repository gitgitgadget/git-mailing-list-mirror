From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] bisect: rewrite `check_term_format` shell function in C
Date: Wed, 04 May 2016 12:10:32 -0700
Message-ID: <xmqqmvo5hc5z.fsf@gitster.mtv.corp.google.com>
References: <01020153a254974b-68f7d16a-66d7-4dc1-805d-2185ff1b3ebf-000000@eu-west-1.amazonses.com>
	<1462338472-3581-1-git-send-email-pranit.bauva@gmail.com>
	<1462338472-3581-3-git-send-email-pranit.bauva@gmail.com>
	<CAPig+cRL7QkQHpSmeKEYECd9JQO8B29OOJoGx2AQORPfmW7QQQ@mail.gmail.com>
	<CAFZEwPNKug1pvGC1fTvZzVPBGKy71fw6S3qcx_fx98nYZasR3w@mail.gmail.com>
	<alpine.DEB.2.20.1605041309430.9313@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Pranit Bauva <pranit.bauva@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	christain.couder@gmail.com,
	Lars Schneider <larsxschneider@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed May 04 21:11:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ay2CI-0000Q6-T9
	for gcvg-git-2@plane.gmane.org; Wed, 04 May 2016 21:10:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754564AbcEDTKh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2016 15:10:37 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56374 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754519AbcEDTKg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2016 15:10:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 8FE78187B9;
	Wed,  4 May 2016 15:10:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NwVTRU5nFbqb2ha3t8W2byXVn9k=; b=QHMCY4
	8rgIdPHsXvI8bWEv07FGKLELvRGrf0y9amHLzM/rVzNpwaEhXmH4C/p9I1r7UzVw
	Ymo0Xd/6YuvDus6yJTWWy3+5JSqVi13N6QfVgpq9HuPBgn8j2+y+qAPKzqEyyuPL
	/o0mSRm9JSIOpDFhnbnwmEGiKODOIYNa7rpHs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GWgOjXB0JiJM7m8Y/8RdD61z0fyAEuhH
	RWm28ekH8DDDxETO/0E1KvNlLGpVsGLJlIP+LOQ0cBVoIGBEusGHO4hKEhnZyNkK
	B8q/ZMdSv0sTI8RRVrTlWu+T2YrvxS5zV+jQEYyUuZi59ln54cXz9nPQZ8sVclQZ
	f3HXAblWA+A=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 8425C187B7;
	Wed,  4 May 2016 15:10:34 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DBB60187B6;
	Wed,  4 May 2016 15:10:33 -0400 (EDT)
In-Reply-To: <alpine.DEB.2.20.1605041309430.9313@virtualbox> (Johannes
	Schindelin's message of "Wed, 4 May 2016 13:13:18 +0200 (CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E0710402-122B-11E6-9623-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293571>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Maybe something like instead?
>
> 	static int one_of(const char *term, ...)
> 	{
> 		int res = 0;
> 		va_list matches;
> 		const char *match;
>
> 		va_start(matches, term);
> 		while (!res && (match = va_arg(matches, const char *)))
> 			res = !strcmp(term, match);
> 		va_end(matches);
>
> 		return res;
> 	}
> Ciao,
> Dscho

This looks good (even though we try to avoid assignment in
conditionals as much as possible).
