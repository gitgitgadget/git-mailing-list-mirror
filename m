From: Junio C Hamano <gitster@pobox.com>
Subject: Re: t0008 hang on streaming test (OS X)
Date: Thu, 11 Jul 2013 09:09:55 -0700
Message-ID: <7vli5drsbw.fsf@alter.siamese.dyndns.org>
References: <6050FACA-CAD4-4E41-B7DC-D7A2036AA233@gernhardtsoftware.com>
	<20130711133414.GF6015@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brian Gernhardt <brian@gernhardtsoftware.com>,
	"git\@vger.kernel.org List" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jul 11 18:10:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UxJRT-000670-HD
	for gcvg-git-2@plane.gmane.org; Thu, 11 Jul 2013 18:10:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932413Ab3GKQJ7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jul 2013 12:09:59 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48018 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755817Ab3GKQJ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jul 2013 12:09:58 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F3C692F962;
	Thu, 11 Jul 2013 16:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jmLwnPf3jkzV1keRGxziB7Eko1U=; b=aWPERc
	7OSRQF7OVOpzKhYdLG2hAkt+sQbPo7WgeWOXnE8obKzYHAJ45qyAq29wO3jfnvTd
	B+zguob0zAghaqWG7QV3nTzypNgObmYekzP4qUR77/xdfZElkTCDg1hPpRgCzfJV
	0k6YXEWr/vin35eG230S5LGeJ8wG3ql3Ksn88=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hw9Rn4Qnmrq3bhr8Pq1qUvUAlc7CNKHV
	mxzX4VU8j3EjoSjX2JFrZnVS/8tPw9e2/N2SsOB9grKoASJvYdEAUoeMWStnt3RO
	wTL6V2DeEL7GN1avWJ9AYCxoaiVabL8sGbR8IoRXrbW9vt/R6JU/lOXoKJMjowm1
	8i/puH2eYO8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EAE802F961;
	Thu, 11 Jul 2013 16:09:57 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 44D312F959;
	Thu, 11 Jul 2013 16:09:57 +0000 (UTC)
In-Reply-To: <20130711133414.GF6015@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 11 Jul 2013 09:34:14 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 549EDBC8-EA44-11E2-9A1D-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230111>

Jeff King <peff@peff.net> writes:

> On Wed, Jul 10, 2013 at 12:36:40PM -0400, Brian Gernhardt wrote:
>
>> The newest test in t0008 "streaming support for --stdin", seems to
>> hang sporadically on my MacBook Pro (running 10.8.4).  The hang seems
>> to be related to running it in parallel with other tests, as I can
>> only reliably cause it by running with prove  and -j 3.  However, once
>> that has hung I am able to semi-reliably have it occur by running the
>> test separately (with the test hung in the background, using separate
>> trash directories via the --root option).
>
> I can't replicate the hang here (on Linux) doing:
>
>   for i in `seq 1 30`; do
>       ./t0008-ignores.sh --root=/tmp/foo/$i &
>   done

It seems to hang on me with bash, but not dash, here.

> Do you know which test it is hanging on? You mentioned that you can
> replicate it outside of "prove"; what does running with "-v" say?
>
> The last test in t0008, with the fifos, would make me the most
> suspicious. The way we do it _should_ be fine, but I'm wondering if the
> shell is blocking in exec here:
>
>   mkfifo in out &&
>   (git check-ignore -n -v --stdin <in >out &) &&
>   exec 9>in &&
>
> That is, if the fifo is not opened for some reason by the backgrounded
> process (there's a race, of course, but the outer shell should just
> block until the sub-shell actually opens it). I wonder if the
> descriptor-opening behavior of:
>
>   cmd <in >out &
>
> is different between shells (that is, if it backgrounds the opening of
> in and out on some shells, but not on others). But then I would expect
> it to fail consistently.
>
> Just for fun, does switching the middle line there to:
>
>   (sh -c "git check-ignore -n -v --stdin <in >out" &) &&
>
> have any effect?
>
> -Peff
