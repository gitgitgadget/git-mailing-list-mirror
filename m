From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitweb: hack around CGI's list-context param() handling
Date: Tue, 18 Nov 2014 09:58:26 -0800
Message-ID: <xmqqfvdgwful.fsf@gitster.dls.corp.google.com>
References: <20141118171022.GA18799@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Nov 18 18:58:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xqn2w-0005uO-8I
	for gcvg-git-2@plane.gmane.org; Tue, 18 Nov 2014 18:58:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753848AbaKRR6a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Nov 2014 12:58:30 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:64168 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753650AbaKRR6a (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Nov 2014 12:58:30 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 34AF21E308;
	Tue, 18 Nov 2014 12:58:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZPbAMKdgATKhBsCM2Fy36jgYuHs=; b=DmRU71
	wTpvJxPwT/ljN27zQabn8uR0aKxQ1QGu3RsfYfE4nxrz1zwESouZ7oT6zdALMWYh
	+OgVHiXivHGP3xaBAlyNjE/XKzLEdICgAuRSxJuTQ6PQitYpQZGSwfA4nnjKiVD7
	UC7mQu6nxghRGIBznJuwPlCFSaeZ6gMQR6FRM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=J7KrKiDLqrY3BxP3Zahsh28QUUZ68/Ae
	EgyApqNX5U/+Vqwrr+RB60hWkNWe91Hkj3gicNSybL54XYysifyk3e1Ajp3WntiL
	xhRCdTXg7lP0KEOKhCD0mB36ha/7VqWVL1Q2A7LwoAKCtzlZONGQVEtxtb3/T7bR
	tPAXgB9ZJH0=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2A8D61E306;
	Tue, 18 Nov 2014 12:58:31 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9C5381E303;
	Tue, 18 Nov 2014 12:58:30 -0500 (EST)
In-Reply-To: <20141118171022.GA18799@peff.net> (Jeff King's message of "Tue,
	18 Nov 2014 12:10:22 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 815D2E10-6F4C-11E4-94B0-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> As of CGI.pm's 4.08 release, the behavior to call
> CGI::param() in a list context is deprecated (because it can
> be potentially unsafe if called inside a hash constructor).
> This cause gitweb to issue a warning for some of our code,
> which in turn causes the tests to fail.
>
> Our use is in fact _not_ one of the dangerous cases, as we
> are intentionally using a list context. The recommended
> route by 4.08 is to use the new CGI::multi_param() call to
> make it explicit that we know what we are doing.
> However, that function is only available in 4.08, which is
> about a month old; we cannot rely on having it.
>
> One option would be to set $CGI::LIST_CONTEXT_WARN globally,
> which turns off the warning. However, that would eliminate
> the protection these newer releases are trying to provide.
> We want to annotate each site as OK using the new function.
>
> So instead, let's check whether CGI provides the
> multi_param() function, and if not, provide an
> implementation that just wraps param(). That will work on
> both old and new versions of CGI. Sadly, we cannot just
> check defined(\&CGI::multi_param), because CGI uses the
> autoload feature, which claims that all functions are
> defined. Instead, we just do a version check.

The solution does look like the best in the messy situation.  Thanks
for looking into it.


> +if (!defined($CGI::VERSION) || $CGI::VERSION < 4.08) {
> +	eval 'sub CGI::multi_param { CGI::param(@_) }'
> +}
> +
>  our $t0 = [ gettimeofday() ];
>  our $number_of_git_cmds = 0;
>  
> @@ -871,7 +875,7 @@ sub evaluate_query_params {
>  
>  	while (my ($name, $symbol) = each %cgi_param_mapping) {
>  		if ($symbol eq 'opt') {
> -			$input_params{$name} = [ map { decode_utf8($_) } $cgi->param($symbol) ];
> +			$input_params{$name} = [ map { decode_utf8($_) } $cgi->multi_param($symbol) ];
>  		} else {
>  			$input_params{$name} = decode_utf8($cgi->param($symbol));
>  		}
