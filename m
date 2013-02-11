From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATH/RFC] parse-options: report invalid UTF-8 switches
Date: Mon, 11 Feb 2013 09:54:08 -0800
Message-ID: <7vy5eun3cv.fsf@alter.siamese.dyndns.org>
References: <1360589687-9233-1-git-send-email-kusmabite@gmail.com>
 <7v7gmeok2e.fsf@alter.siamese.dyndns.org>
 <20130211171957.GG16402@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Erik Faye-Lund <kusmabite@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 11 18:54:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4xaN-0006Pw-Ag
	for gcvg-git-2@plane.gmane.org; Mon, 11 Feb 2013 18:54:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758558Ab3BKRyM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2013 12:54:12 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51452 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758461Ab3BKRyL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2013 12:54:11 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B4462C215;
	Mon, 11 Feb 2013 12:54:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xLPnBofnuaSql/jAqIoafsZQBSs=; b=d2Ttey
	8xZOTMrzt9xjak/r9P6PWcur83YKdLt4aBtJzWjiuWMSFiTX4cocd4iB0o+FMQMm
	KOQPMISLr+mQkLxu2ARflOI3pUC01oEZdNt0yaXKs9bSjoHZaLQYAMGXBQ2UpHva
	wGuTiaIP4M9OnXKbYWz0JsWpzv+UruNrTzoFk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JUdGx1c84Uf/advn32Va3a1TwOwNGu5N
	s8CCKr7SKVsapW6fz3M3omT8D0tbX5swjh0Dq7wZ/5IosdHcfoxBPz2N20MUQLZR
	T+RxuiYydrsLbVxUsh+cglPj8e6Ui9SkzmKZR9ci0lrpOr6vbsNqogeANKG1VJjW
	UTVAoIlmy8U=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A68F2C214;
	Mon, 11 Feb 2013 12:54:10 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 21D9FC210; Mon, 11 Feb 2013
 12:54:10 -0500 (EST)
In-Reply-To: <20130211171957.GG16402@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 11 Feb 2013 12:19:57 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 09A6881E-7474-11E2-90DC-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216069>

Jeff King <peff@peff.net> writes:

> On Mon, Feb 11, 2013 at 09:07:53AM -0800, Junio C Hamano wrote:
>
>> Erik Faye-Lund <kusmabite@gmail.com> writes:
>> 
>> > However, since git only looks at one byte at the time for
>> > short-options, it ends up reporting a partial UTF-8 sequence
>> > in such cases, leading to corruption of the output.
>> 
>> Isn't it a workable, easier and more robust alternative to punt and
>> use the entire ctx.argv[0] as unrecognized?
>
> Yes, but it regresses the usability:
>
>   [before]
>   $ git foobar -qrxs
>   unknown switch: x
>
>   [after]
>   $ git foobar -qrxs
>   unknown switch: -qrxs
>
> One is much more informative than the other, and you are punishing the
> common ascii case for the extremely uncommon case of utf-8. Maybe:
>
>   if (isascii(*ctx.opt))
>           error("unknown option `%c'", *ctx.opt);
>   else
>           error("unknown multi-byte short option in string: `%s'", ctx.argv[0]);
>
> which only kicks in in the uncommon case (and extends the error message
> to make it more clear why we are showing the whole string).

Yup, that is what I meant.
