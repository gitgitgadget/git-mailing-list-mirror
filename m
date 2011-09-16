From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitweb: Strip non-printable characters from syntax
 highlighter output
Date: Fri, 16 Sep 2011 09:32:16 -0700
Message-ID: <7vwrd8fnxr.fsf@alter.siamese.dyndns.org>
References: <1314053923-13122-1-git-send-email-cfuhrman@panix.com>
 <7v8vqfdf0l.fsf@alter.siamese.dyndns.org>
 <201108270006.19289.jnareb@gmail.com> <201109161441.58946.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Christopher M. Fuhrman" <cfuhrman@panix.com>, git@vger.kernel.org,
	Christopher Wilson <cwilson@cdwilson.us>,
	Sylvain Rabot <sylvain@abstraction.fr>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 16 18:32:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R4bL6-0006LE-Gt
	for gcvg-git-2@lo.gmane.org; Fri, 16 Sep 2011 18:32:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754768Ab1IPQcW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Sep 2011 12:32:22 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62728 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752581Ab1IPQcU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Sep 2011 12:32:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E93A65C0B;
	Fri, 16 Sep 2011 12:32:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0tSKsn77DcZwKElEYAcINIcsb5E=; b=M7Dbbz
	0RrqN+wy/SJnCIZFKZgTd+CE2LZZmiqRsEyB9TXwDNBcc4A/bWSDZutbnv3WbvrW
	D/0mqvnCf6Rk8XEs0fx0T+KAeeh21IUK1q0f8aKD/gdsAL+CtQBOFmjtvCI+iW70
	Z6fbKUQWm05OEgoUNdZC1saGjfEk2Up0VUpo0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=a95cNWgavRCP2Ev/Q6+76G0WDeGY9AO8
	PmGa+SrXuACYIAexYx+3fOEN+7cGstr1sFYkkepMguVAJY7urWIiuvmCfHwdkqSH
	kvgmdhs3huY+AsA7z655J+dCuo5Qb+3BaYnqaqod5ogLGSXfegHoqWvFY1fZsfFW
	42+TIS3C40s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E022B5C0A;
	Fri, 16 Sep 2011 12:32:19 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 728C55C09; Fri, 16 Sep 2011
 12:32:19 -0400 (EDT)
In-Reply-To: <201109161441.58946.jnareb@gmail.com> (Jakub Narebski's message
 of "Fri, 16 Sep 2011 14:41:57 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7256CFBE-E081-11E0-9E39-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181538>

Jakub Narebski <jnareb@gmail.com> writes:

> The commit message is from Christopher, but I have replaced his solution
> of stripping non-printable characters via col(1) program by having gitweb
> strip characters not allowed in XML.
>
> Christopher, could you check that it fixes your issue?

Thanks.

Micronit:

> +# Sanitize for use in XHTML + application/xml+xhtm (valid XML 1.0)
> +sub sanitize {
> +	my $str = shift;
> +
> +	return undef unless defined $str;

Given that the _whole_ point of this subroutine is to make $str safe for
printing, wouldn't you want to either (1) die, declaring that feeding an
undef to this subroutine is a programming error, or (2) return an empty
string?

Given that the input to this function is from the result of feeding $line
to untabify, which relies on $line being defined, and that $line comes
from "while (my $line = <$fd>)" (and then chomp $line), it may be Ok for
this subroutine to make the same assumption as untabify makes.
