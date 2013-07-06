From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] send-email: introduce sendemail.smtpsslcertpath
Date: Fri, 05 Jul 2013 23:25:36 -0700
Message-ID: <7v1u7c6w7z.fsf@alter.siamese.dyndns.org>
References: <1373025947-26495-1-git-send-email-artagnon@gmail.com>
	<1373025947-26495-3-git-send-email-artagnon@gmail.com>
	<20130705124536.GU862789@vauxhall.crustytoothpaste.net>
	<7vobag7wl0.fsf@alter.siamese.dyndns.org>
	<20130705174730.GM9161@serenity.lan>
	<7vehbc7tcc.fsf@alter.siamese.dyndns.org>
	<20130705184333.GN9161@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Sat Jul 06 08:25:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UvLwG-0001ke-7o
	for gcvg-git-2@plane.gmane.org; Sat, 06 Jul 2013 08:25:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752343Ab3GFGZk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Jul 2013 02:25:40 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47417 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752106Ab3GFGZj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jul 2013 02:25:39 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3B96C28927;
	Sat,  6 Jul 2013 06:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=riKA79HiE1dD9f2AihWynvdI2U0=; b=U1bfnD
	Vphg1+I3YHxBc6k1dY9aKcsVkjhcTodXuHNev+JD1/m5KFqj36oW9s9+N5loAPBz
	koxpMC6fSfkhzFmjH1HEoGVGoKT6+x39D87vxGKOV3jWcu4pUXPvPQEiNZvJvcD5
	E8wFwuCCP16iPWptJmjg9a68MlD8al5zOgCmA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LSUq2/0jcD1vpQir2TNcxvoFvuxHgEEq
	Vqq/GJ68R+8TjRtUDszl+G4TdnAKVkO3U4EIUi6RMlCduW8xGypVbmMZZeKZ+7kN
	oAiL2Dg1lNqbL4tuL0bcavi7N876XQ4UCbOgCGqvBoMlPMqcD1PM2ssPu2sDgHdT
	pBFUBAiYg1I=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2F48928926;
	Sat,  6 Jul 2013 06:25:38 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8D83A28923;
	Sat,  6 Jul 2013 06:25:37 +0000 (UTC)
In-Reply-To: <20130705184333.GN9161@serenity.lan> (John Keeping's message of
	"Fri, 5 Jul 2013 19:43:33 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DF584324-E604-11E2-BBA3-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229695>

John Keeping <john@keeping.me.uk> writes:

> I'd rather have '$smtp_ssl_cert_path ne ""' in the first if condition
> (instead of the '-d $smtp_ssl_cert_path') ...

I agree.  The signal for "no certs" should be an explicit "nonsense"
value like an empty string, not just a string that does not name an
expected filesystem object.  Otherwise people can misspell paths and
disable the validation by accident.

> Perhaps a complete solution could allow CA files as well.

Yes, that would be a good idea.  Care to roll into a "fixup!" patch
against [2/2]?

> 	if (defined $smtp_ssl_cert_path) {
> 		if ($smtp_ssl_cert_path eq "") {
> 			return (SSL_verify_mode => SSL_VERIFY_NONE);
> 		} elsif (-f $smtp_ssl_cert_path) {
> 			return (SSL_verify_mode => SSL_VERIFY_PEER,
> 				SSL_ca_file => $smtp_ssl_cert_path);
> 		} else {
> 			return (SSL_verify_mode => SSL_VERIFY_PEER,
> 				SSL_ca_path => $smtp_ssl_cert_path);
> 		}
> 	} else {
> 		return (SSL_verify_mode => SSL_VERIFY_PEER);
> 	}

Two things that worry me a bit are:

 (1) At the end user UI level, it may look nice to accept some form
     of --no-option-name to say "I have been using SSL against my
     server with handrolled cert, and I want to keep using the
     verify-none option"; "--ssl-cert-path=" looks somewhat ugly.
     The same goes for [sendemail] ssl_cert_path = "" config.

 (2) How loudly does the new code barf when no configuration is done
     (i.e. we just pass SSL_VERIFY_PEER and let the system default
     CA path to take effect) and the server cert does not validate?
     The warning that triggered this thread, if we had the
     configuration mechanism we have been designing together, would
     have been a good reminder for the user to use it, but would we
     give a similar (less noisy is fine, as long as it is clear)
     diagnostic message?
