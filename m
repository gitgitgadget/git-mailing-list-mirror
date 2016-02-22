From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 4/4] config: add '--show-origin' option to print the origin of a config value
Date: Mon, 22 Feb 2016 10:37:59 -0800
Message-ID: <xmqqmvqs7fqw.fsf@gitster.mtv.corp.google.com>
References: <1455873362-66998-1-git-send-email-larsxschneider@gmail.com>
	<1455873362-66998-5-git-send-email-larsxschneider@gmail.com>
	<xmqq4md08wua.fsf@gitster.mtv.corp.google.com>
	<20160222175843.GA4587@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: larsxschneider@gmail.com, git@vger.kernel.org,
	ramsay@ramsayjones.plus.com, Johannes.Schindelin@gmx.de
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 22 19:38:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXvN5-0000BW-Mg
	for gcvg-git-2@plane.gmane.org; Mon, 22 Feb 2016 19:38:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751238AbcBVSiH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2016 13:38:07 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:63740 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750953AbcBVSiF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2016 13:38:05 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 31B7D46B26;
	Mon, 22 Feb 2016 13:38:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iKk+U90triJojfjsi7wEpIQyyXY=; b=j2pNSs
	umuHuHWfwZEI8fAxrj2Il08u9Dh/CKvQWxs7sxzTSg3Px2g9pH+m1jLuVYnrXN9t
	0Fj/2ko2ovc+a6ahD7Uvz7V+5qwRP4CT4pJXq4k4ZWmEfeHzGPaYZHoz4RKD5nEE
	56zZ6LP0asaZ172A+B5DXHPL2bE/feHXVEoKg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mCSqc79hHlOlRW5c8saGlYKXfy/LJRsq
	FkvwZkj4VL5CTCVC9EbqCQ0U9bM2toMHsG+DnnobiYOg6PJ3YTwTjlAZxkTJMIX7
	iwsoHZBUteTLHrRyAaTYEN1VDhOwBovOjhiDtliqzZzlS+ZAVgU9icsgNlg/Zm6W
	tjjcFrd3LDg=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2672246B25;
	Mon, 22 Feb 2016 13:38:03 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 8306746B22;
	Mon, 22 Feb 2016 13:38:02 -0500 (EST)
In-Reply-To: <20160222175843.GA4587@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 22 Feb 2016 12:58:43 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 678FA06E-D993-11E5-B1F7-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286942>

Jeff King <peff@peff.net> writes:

> On Mon, Feb 22, 2016 at 09:43:25AM -0800, Junio C Hamano wrote:
>
>> larsxschneider@gmail.com writes:
>> 
>> > +test_expect_success '--show-origin with --list' '
>> > +	cat >expect <<-EOF &&
>> > +		file:$HOME/.gitconfig	user.global=true
>> > +		file:$HOME/.gitconfig	user.override=global
>> > +		file:$HOME/.gitconfig	include.path=$INCLUDE_DIR/absolute.include
>> > +		file:$INCLUDE_DIR/absolute.include	user.absolute=include
>> > +		file:.git/config	user.local=true
>> > +		file:.git/config	user.override=local
>> > +		file:.git/config	include.path=../include/relative.include
>> > +		file:.git/../include/relative.include	user.relative=include
>> > +		cmdline:	user.cmdline=true
>> > +	EOF
>> > ...
>> > +test_expect_success '--show-origin stdin' '
>> > +	cat >expect <<-\EOF &&
>> > +		stdin:	user.custom=true
>> > +	EOF
>> 
>> I do recall there was some bikeshedding^Wdesigning discussion, in
>> which I chose not to participate, on the output format, how
>> origin-type and origin-value are given in the output in an
>> unambiguous way that is easy to understand by the end users.
>> 
>> Does the above reflect the concensus from the discussion?  Just
>> double checking.
>
> Yes, I think so.

OK, thanks.
