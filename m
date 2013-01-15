From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] am: invoke perl's strftime in C locale
Date: Tue, 15 Jan 2013 11:14:42 -0800
Message-ID: <7v1udm45st.fsf@alter.siamese.dyndns.org>
References: <20130114205933.GA25947@altlinux.org>
 <20130115155953.GB21815@sigill.intra.peff.net>
 <CALWbr2w+q5=Z8__g+J_s2NtTMgziHrntFqsi8vCJyvfO2qi81A@mail.gmail.com>
 <20130115165058.GA29301@sigill.intra.peff.net>
 <20130115174015.GA7471@altlinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Antoine Pelisse <apelisse@gmail.com>,
	git <git@vger.kernel.org>
To: "Dmitry V. Levin" <ldv@altlinux.org>
X-From: git-owner@vger.kernel.org Tue Jan 15 20:15:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvByU-0003oj-CC
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jan 2013 20:15:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756559Ab3AOTOq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2013 14:14:46 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52955 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755989Ab3AOTOp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2013 14:14:45 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5022599ED;
	Tue, 15 Jan 2013 14:14:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ztINre8F/0CynogAVtxGbGIX/QE=; b=qqbkEI
	w8ITXYd6souW3TPkCO06E8fUOE55WMWKqePc5rDFVrvqYfIxjGifQkDKyV8eYoLf
	F8rdqOoPUG4L1LOECFodswjP55m47lf6hvYOJfJD+SmswWPSzaRxVf4vSMZuU1lh
	5y9aiLwPHvX5PRybOmx0JO/yVBbG+dn/l81Os=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=t2hNwvOIpVKVux2bOCazalsTDazc0qjc
	nM3bGHej5vnkPjak2Ev6onK2+xWDV3m1ZsxwtCqzwZc8DxG9ml7lhS4vvoIfBgZR
	6JzRTGW1TO/3XqYp3UJwSSX1sODdWnTf1tyI1+arX48bWulWZ2wc036jWKmLrmjD
	06Orf6tTp4o=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 29D8599EC;
	Tue, 15 Jan 2013 14:14:45 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 765CC99E7; Tue, 15 Jan 2013
 14:14:44 -0500 (EST)
In-Reply-To: <20130115174015.GA7471@altlinux.org> (Dmitry V. Levin's message
 of "Tue, 15 Jan 2013 21:40:16 +0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D1FDFC58-5F47-11E2-84C0-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213663>

"Dmitry V. Levin" <ldv@altlinux.org> writes:

> On Tue, Jan 15, 2013 at 08:50:59AM -0800, Jeff King wrote:
>> On Tue, Jan 15, 2013 at 05:42:12PM +0100, Antoine Pelisse wrote:
>> 
>> > > This puts all of perl into the C locale, which would mean error messages
>> > > from perl would be in English rather than the user's language. It
>> > > probably isn't a big deal, because that snippet of perl is short and not
>> > > likely to produce problems, but I wonder how hard it would be to set the
>> > > locale just for the strftime call.
>> > 
>> > Maybe just setting LC_TIME to C would do ...
>> 
>> Yeah, that is a nice simple solution. Dmitry, does just setting LC_TIME
>> fix the problem for you?
>
> Just setting LC_TIME environment variable instead of LC_ALL would end up
> with unreliable solution because LC_ALL has the highest priority.
>
> If keeping error messages from perl has the utmost importance, it could be
> achieved by
> -			perl -M'POSIX qw(strftime)' -ne 'BEGIN { $subject = 0 }
> +			perl -M'POSIX qw(strftime :locale_h)' -ne '
> +				BEGIN { setlocale(LC_TIME, "C"); $subject = 0 }
> but the little perl helper script we are talking about hardly worths so
> much efforts.

Yeah I agree that this is not worth it, I would think.
