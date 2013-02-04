From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add contrib/credentials/netrc with GPG support, try #2
Date: Mon, 04 Feb 2013 15:36:09 -0800
Message-ID: <7v38xb1wk6.fsf@alter.siamese.dyndns.org>
References: <87ehgvua6h.fsf@lifelogs.com>
 <20130204211726.GB13186@sigill.intra.peff.net>
 <87mwvjsqjc.fsf_-_@lifelogs.com> <7vd2wf1yex.fsf@alter.siamese.dyndns.org>
 <20130204232317.GA17705@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ted Zlatanov <tzz@lifelogs.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 05 00:36:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2VaW-0001MQ-47
	for gcvg-git-2@plane.gmane.org; Tue, 05 Feb 2013 00:36:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754967Ab3BDXgN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2013 18:36:13 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60139 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754629Ab3BDXgM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2013 18:36:12 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A0B87DF7A;
	Mon,  4 Feb 2013 18:36:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=x2tld9qRCeDQeCX+jdhC7+ZLLzQ=; b=HLaoQm
	rqAUQKpIJrCitg1LgeZ0vxDqt/QQKB5ZNdIGnH+buP7IoTgPKg1YWiENKnrgNRmA
	Dl6kP8H0PLEYwW64ABFb4Q4HCwIM8PazjjJCHMF8qQ/iRaOqH0IEotLCfzEwHI8a
	YuhWMXmsmfJboaDASnaADdCpsv4H+DTAB06os=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BumJO9aeJknThaO+7poBebfsHR5ZuYvt
	VIOoSveTY3F8Czh3bd99kyyeLjP95691qODJxixTZw0Frjh7lHjCHSdJyE1yveKA
	sHNwruMaiZGrCxFgTL/ezPbCVgp/FqHy6LNRP1u0wBpbqc5l7DHAWq18dS78rx5z
	C/My0bwYOtc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 95033DF79;
	Mon,  4 Feb 2013 18:36:11 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D9CBBDF74; Mon,  4 Feb 2013
 18:36:10 -0500 (EST)
In-Reply-To: <20130204232317.GA17705@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 4 Feb 2013 18:23:17 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A814CE76-6F23-11E2-9610-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215432>

Jeff King <peff@peff.net> writes:

> On Mon, Feb 04, 2013 at 02:56:06PM -0800, Junio C Hamano wrote:
>
>> > +my $mode = shift @ARGV;
>> > +
>> > +# credentials may get 'get', 'store', or 'erase' as parameters but
>> > +# only acknowledge 'get'
>> > +die "Syntax: $0 [-f AUTHFILE] [-d] get" unless defined $mode;
>> > +
>> > +# only support 'get' mode
>> > +exit unless $mode eq 'get';
>> 
>> The above looks strange.  Why does the invoker get the error message
>> only when it runs this without arguments?  Did you mean to say more
>> like this?
>> 
>> 	unless (defined $mode && $mode eq 'get') {
>> 		die "...";
>> 	}
>
> Not having a mode is an invocation error; the credential-helper
> documentation indicates that the helper will always be invoked with an
> action. The likely culprit for not having one is the user invoking it
> manually, and showing the usage there is a sensible action.
>
> Whereas invoking it with a mode other than "get" is not an error at all.
> Git will run it with the "store" and "erase" actions, too. Those happen
> to be no-ops for this helper, so it exits silently. The credential docs
> specify that any other actions should be ignored, too, to allow for
> future expansion.

OK.  The code didn't express the above reasoning clearly enough.

> I was trying not to be too nit-picky with my review,...

I wasn't either.  Mine was still at design level review to get the
semantics right (e.g. what to consider as errors, the input is _not_
one entry per line, etc.), before reviewing the details of the
implementation.

> but here is how I
> would have written the outer logic of the script:
>
>   my $tokens = read_credential_data_from_stdin();
>   if ($options{file}) {
>           my @entries = load_netrc($options{file})
>                   or die "unable to open $options{file}: $!";
>           check_netrc($tokens, @entries);
>   }
>   else {
>           foreach my $ext ('.gpg', '') {
>                   foreach my $base (qw(authinfo netrc)) {
>                           my @entries = load_netrc("$base$ext")
>                                   or next;
>                           if (check_netrc($tokens, @entries)) {
>                                   last;
>                           }
>                   }
>           }
>   }
>
> I.e., to fail on "-f", but otherwise treat unreadable auto-selected
> files as a no-op, for whatever reason. I'd also consider checking all
> files if they are available, in case the user has multiple (e.g., they
> keep low-quality junk unencrypted but some high-security passwords in a
> .gpg file). Not that likely, but not any harder to implement.

Yeah, I think that looks like the right top-level codeflow.
