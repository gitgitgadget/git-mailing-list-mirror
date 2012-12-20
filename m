From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Dec 2012, #05; Tue, 18)
Date: Thu, 20 Dec 2012 12:26:19 -0800
Message-ID: <7vfw304gic.fsf@alter.siamese.dyndns.org>
References: <7v4njjf6fk.fsf@alter.siamese.dyndns.org>
 <20121220145941.GC27211@sigill.intra.peff.net>
 <7vwqwc617y.fsf@alter.siamese.dyndns.org>
 <20121220195837.GB21785@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Dec 20 21:26:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TlmhV-0005BB-Rp
	for gcvg-git-2@plane.gmane.org; Thu, 20 Dec 2012 21:26:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751432Ab2LTU0Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Dec 2012 15:26:24 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33068 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750933Ab2LTU0X (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Dec 2012 15:26:23 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0AC9890B9;
	Thu, 20 Dec 2012 15:26:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=l+XHtDG7bX4PWaO8g7fftj0hPus=; b=grV2A7
	hZVMCCD5kY4vfQUxZkGPT0DSjvzfZcSYrYTZW6Nz7LURPrpjW85U7277jiZYlj65
	/NY9oIvBgAKMewNjRGLydNyFxM1zz65TEjYX6NwxWbjxKMebXqe+xj/8hpSOFiLp
	RYSt2Vg9PXTTrXKoepTG4IslDH8tB4JWA/hE0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vKg4QqSlLTRF4yTfWqVFEk2UBJf9dacN
	jAVTXwSxqYKRTMiCfmgZIwnVJzIejTtHsliWnDD9FbzN5lkiMb1A6+kwQYGKYml0
	Ee6Pp8mMfD7OZf/o7droo8QzSM+zp7XX9WivAltTMYVTghOLyr2hBY7gELaKg6g9
	/37AL4ED2oM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EA39690B8;
	Thu, 20 Dec 2012 15:26:21 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 52E1490B6; Thu, 20 Dec 2012
 15:26:21 -0500 (EST)
In-Reply-To: <20121220195837.GB21785@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 20 Dec 2012 14:58:37 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 84607354-4AE3-11E2-9F35-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211925>

Jeff King <peff@peff.net> writes:

> So our attempt for more compile-time safety may actually introduce a
> run-time bug.  And it is a hard bug to find, as the preprocessor
> "magically" converts the error code into -1 without you being able to
> see it in the code.
>
> It would be safer to just unconditionally use the macros and drop the
> return values from the functions entirely, like the patch below
> (squashed on top of what is in jk/error-const-return). But it cannot
> work for error(), because the variadic nature means we need to restrict
> ourselves to __GNUC__.

While I like the general direction, I am not sure if we are OK with
the introduction of

>  #undef config_error_nonbool
> -int config_error_nonbool(const char *var)
> +void config_error_nonbool(const char *var)
>  {
> -	return error("Missing value for '%s'", var);
> +	error("Missing value for '%s'", var);
>  }

a new, arguably false, "returned value not used" warning from this
point.  Perhaps it is fine for now, as we have tons of calls that do
not cast the return value to "(void)".
