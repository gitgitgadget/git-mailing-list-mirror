From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 4/6] send-email: create email parser subroutine
Date: Wed, 08 Jun 2016 10:58:35 -0700
Message-ID: <xmqq8tyfmuk4.fsf@gitster.mtv.corp.google.com>
References: <20160607140148.23242-1-tom.russello@grenoble-inp.org>
	<20160608130142.29879-1-samuel.groot@grenoble-inp.org>
	<20160608130142.29879-5-samuel.groot@grenoble-inp.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, tom.russello@grenoble-inp.org,
	erwan.mathoniere@grenoble-inp.org, jordan.de-gea@grenoble-inp.org,
	matthieu.moy@grenoble-inp.fr, aaron@schrab.com, e@80x24.org
To: Samuel GROOT <samuel.groot@grenoble-inp.org>
X-From: git-owner@vger.kernel.org Wed Jun 08 20:16:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAhkZ-0004WT-4x
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jun 2016 19:58:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751775AbcFHR6j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2016 13:58:39 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58730 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750837AbcFHR6i (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2016 13:58:38 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 315B01F393;
	Wed,  8 Jun 2016 13:58:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WTPwv083HE1g6ogiYHbnuLOjFuw=; b=aytc4S
	fk50SQJaBuYHnfDVT1/ZFu4/JQt8EH/rV5wMnvTyQe0Bw7ZsL1NIltnZ2vI8oTGK
	tag3No5ECWgh7IhXVDx7GqGytuKxOVc6EmA1NaqQpVaJCRIYtx3ZDrThDX7Dsczm
	CzL71hfcVIk+UsJPXjp5rSrYTrSORzU5djNps=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rZHvX0hbAy/W5eh6oKVGADt+zH1uQRpc
	AJ0BHLoLGzlLdaFi5tZCzafRDVP6ssUd+r8nyaskXViC8gWSTfLZccJZgvrhNJtC
	XHZPpwrS0UClm075xDTRmpZTft+KN1s8ws2q6KyNstHgs7nKfMAh1r6nXrL6M8vH
	gE8ChOxUSPI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 287181F392;
	Wed,  8 Jun 2016 13:58:37 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A5B511F390;
	Wed,  8 Jun 2016 13:58:36 -0400 (EDT)
In-Reply-To: <20160608130142.29879-5-samuel.groot@grenoble-inp.org> (Samuel
	GROOT's message of "Wed, 8 Jun 2016 15:01:40 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 9FA2E9D0-2DA2-11E6-9A7B-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296825>

Samuel GROOT <samuel.groot@grenoble-inp.org> writes:

> +sub parse_email {
> +	my %mail = ();
> +	my $fh = shift;
> +	my $last_header;

> +	# Unfold and parse multiline header fields
> +	while (<$fh>) {
> +		last if /^\s*$/;

You stop at the end of fields before the message body starts.

> +		s/\r\n|\n|\r//;

The pattern is not anchored at the right end of the string;
intended?  Is it worth worrying about a lone '\r'?

> +		if (/^([^\s:]+):[\s]+(.*)$/) {
> +			$last_header = lc($1);
> +			@{$mail{$last_header}} = ()
> +				unless defined $mail{$last_header};
> +			push @{$mail{$last_header}}, $2;

> +		} elsif (/^\s+\S/ and defined $last_header) {
> +			s/^\s+/ /;
> +			push @{$mail{$last_header}}, $_;

Even though the comment said "unfold", you do not really do the
unfolding here and the caller can (if it wants to) figure out where
one logical header was folded in the original into multiple physical
lines, because you are returning an arrayref.

However, that means the caller still cannot tell what the original
was if you are given:

	X-header: a b
            c
	X-header: d

as you would return { 'X-header' => ["a b", "c", "d")] }

In that sense, it may be better to do a real unfolding here, so that
it would return { 'X-header' => ["a b c", "d"] } from here instead?

I.e. instead of "push @{...}, $_", append $_ to the last element of
that array?

> +		} else {
> +			die("Mail format undefined!\n");

What does that mean?  It would probably help if you included the
line that the code did not understand in the message.


> +		}
> +	}
> +
> +	# Separate body from header
> +	$mail{"body"} = [(<$fh>)];
> +
> +	return \%mail;

The name of the local thing is not observable from the caller, but
because this is "parse-email-header" and returns "header fields"
without reading the "mail", perhaps call it %header instead?

> +}
