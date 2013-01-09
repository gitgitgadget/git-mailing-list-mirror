From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] avoid SIGPIPE warnings for aliases
Date: Wed, 09 Jan 2013 12:48:20 -0800
Message-ID: <7vr4lu3wx7.fsf@alter.siamese.dyndns.org>
References: <20130104124756.GA402@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Bart Trojanowski <bart@jukie.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 09 21:48:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tt2Zr-0000DR-5o
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jan 2013 21:48:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934166Ab3AIUsY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jan 2013 15:48:24 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41922 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934117Ab3AIUsW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jan 2013 15:48:22 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 81E63A98B;
	Wed,  9 Jan 2013 15:48:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CT0tOmCJ49TWKVkYunMIiV3zJ1A=; b=CeA8Wk
	MSvDSMu0KxdZ8HjXQ0LzOGtyZNlAQn463F2Mob5mUrPCavBd1VkaIvjan50XCfmP
	7chhGkDUWhyDJTBgLbx4a9+WiaN/p8Gd7QVBmpZW4bwWHLE3HXKK5G3Kwk5XkWqq
	ipURMSD80SdQJ/Za1qvrl9ccK/ApuUxXzEDZQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SouL5SoD0vYbWzHjvZhxaJpU8UOaZHSX
	t4eGY+l37WC/R8UtAiqjLIpUjy0nGMlA7qnHR4KHyzpv0HD6B+bXIFzq7PfIZF4u
	wu3hFwR90nfNLii6xMj89W9paBO13fOF7KgLBNGDkpV84bjrf+t01QVEtubDgQ6g
	t2qavujl1Ck=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 76B55A98A;
	Wed,  9 Jan 2013 15:48:22 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D1ADCA988; Wed,  9 Jan 2013
 15:48:21 -0500 (EST)
In-Reply-To: <20130104124756.GA402@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 4 Jan 2013 07:47:56 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E7BAA194-5A9D-11E2-8C80-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213101>

Jeff King <peff@peff.net> writes:

> When git executes an alias that specifies an external
> command, it will complain if the alias dies due to a signal.
> This is usually a good thing, as signal deaths are
> unexpected. However, SIGPIPE is not unexpected for many
> commands which produce a lot of output; it is intended that
> the user closing the pager would kill them them via SIGPIPE.
>
> As a result, the user might see annoying messages in a
> scenario like this:
>
>   $ cat ~/.gitconfig
>   [alias]
>   lgbase = log --some-options
>   lg = !git lgbase --more-options
>   lg2 = !git lgbase --other-options
>
>   $ git lg -p
>   [user hits 'q' to exit pager]
>   error: git lgbase --more-options died of signal 13
>   fatal: While expanding alias 'lg': 'git lgbase --more-options': Success
>
> Many users won't see this, because we execute the external
> command with the shell, and a POSIX shell will silently
> rewrite the signal-death exit code into 128+signal, and we
> will treat it like a normal exit code. However, this does
> not always happen:

So... with the "flip the sign of the exit code when caught a signal"
patch applied to 'next', do people still see this issue?
