From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] builtin/remote: remove postfixcmp() and use suffixcmp() instead
Date: Mon, 04 Nov 2013 12:21:10 -0800
Message-ID: <xmqq7gcnzznt.fsf@gitster.dls.corp.google.com>
References: <20131103201303.14446.7508.chriscool@tuxfamily.org>
	<xmqqbo20ynxs.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Avery Pennarun <apenwarr@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Mon Nov 04 21:26:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VdQjF-00014Z-EO
	for gcvg-git-2@plane.gmane.org; Mon, 04 Nov 2013 21:26:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754224Ab3KDU0Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Nov 2013 15:26:24 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62235 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754127Ab3KDUVS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Nov 2013 15:21:18 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4C9F44DD26;
	Mon,  4 Nov 2013 15:21:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Be/3rAi6kaMC6pAnpP25Alfc8CU=; b=nnaEGl
	zKy+xI3woO5BtCcFJgWAtt3bIsS4pZ0pMwB0yjkENWyigd6SkJhmzpx5NlQnGWz0
	6kMrjFhS+0Bb8dDftbglw4UcJhcyzfKFnH1L0d8UOOYfYnN4K1CabNqmZcMfWD38
	AkvMSwAx4QsX+F9P1KgXD657Ld/KT/PyIss3E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=F/xP9y397AMZJBlxq35Y/Hq+2ZysNY6N
	QzBDMPJs1zQT8r1AcaVqfqh5brVxfY1p/yth8peyaW/zvJr+0NA8Ps8A+9fs8Azc
	vkgNr0rL7q1Adg76MSWOrZsZWC+rBgmxqkKNm/mw/rQ2dQqUNmiKGdpgouaKOWSq
	X44aKYslYbQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3C3104DD25;
	Mon,  4 Nov 2013 15:21:15 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8D2C74DD22;
	Mon,  4 Nov 2013 15:21:14 -0500 (EST)
In-Reply-To: <xmqqbo20ynxs.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Mon, 04 Nov 2013 11:19:43 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: A74EEF52-458E-11E3-9F74-1FFB7F2839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237300>

Junio C Hamano <gitster@pobox.com> writes:

> I do not think anybody sane uses prefixcmp() or suffixcmp() for
> anything but checking with zero; in other words, I suspect that all
> uses of Xcmp() can be replaced with !!Xcmp(), so as a separate
> clean-up patch, we may at least want to make it clear that the
> callers should not expect anything but "does str have sfx as its
> suffix, yes or no?" by doing something like this:
>
>  int suffixcmp(const char *str, const char *suffix)
>  {
>  	int len = strlen(str), suflen = strlen(suffix);
>  	if (len < suflen)
>  		return -1;
>  	else
> -		return strcmp(str + len - suflen, suffix);
> +		return !!strcmp(str + len - suflen, suffix);
>  }
>
> I am not absolutely sure about doing the same to prefixcmp(),
> though. It could be used for ordering, even though no existing code
> seems to do so.

I just realized why this suggestion is incomplete; if we were to go
this route, we should rename the function to has_suffix() or
something. anything-cmp() ought to be usable as an ordering
comparison function, but suffixcmp() clearly isn't.
