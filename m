From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] diff: add --ignore-blank-lines option
Date: Tue, 04 Jun 2013 13:46:44 -0700
Message-ID: <7v61xt7gej.fsf@alter.siamese.dyndns.org>
References: <1369591098-11267-1-git-send-email-apelisse@gmail.com>
	<7vzjv57mwx.fsf@alter.siamese.dyndns.org>
	<CALWbr2zJCxbW8Qug0i=oGvKZV5-vcAugextxMuQp9jaoaZYpyg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 04 22:47:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ujy8E-00071e-Mx
	for gcvg-git-2@plane.gmane.org; Tue, 04 Jun 2013 22:47:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751204Ab3FDUqs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Jun 2013 16:46:48 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64306 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751178Ab3FDUqr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jun 2013 16:46:47 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4EAD4255BC;
	Tue,  4 Jun 2013 20:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GN3fZAudD07dD2uhtSqyJh7BVLY=; b=Fy0QZv
	iVwHK8bIua7ozgXhU/VYtKnXo5qGdomCAA4t5nsjDO2ohu1MaoZZ/01MP88hahW+
	RHTRnuyi3jO2zKNOF+EMWdmYfo54ZVbqhVA1lo4GkMDqEvvuHkAJ6i7dCy2oRy65
	8QzILxIRzd8yR39Iq9wwJ1H9cmV5psOlGSvjY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BUAfq951URLY3D2o5tu4vVPjuiU9xUnh
	bRsivC2FMUTQDASUJwOj/PcATJSpfA+EeZN8kLA/f0fSVgSc5zE2kQUQenL8hxne
	O/SkqpWL5BU39vN2BHwfkKrHseU/XBEJ/fzC/HdLhFGBYB/V0bUC0s9uavohi+bJ
	N5J8GRWTonk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 411BC255BB;
	Tue,  4 Jun 2013 20:46:46 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9B5C2255B3;
	Tue,  4 Jun 2013 20:46:45 +0000 (UTC)
In-Reply-To: <CALWbr2zJCxbW8Qug0i=oGvKZV5-vcAugextxMuQp9jaoaZYpyg@mail.gmail.com>
	(Antoine Pelisse's message of "Tue, 4 Jun 2013 21:08:03 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DEB05864-CD57-11E2-B9EE-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226399>

Antoine Pelisse <apelisse@gmail.com> writes:

> On Tue, Jun 4, 2013 at 8:26 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Antoine Pelisse <apelisse@gmail.com> writes:
>>
>>> +xdchange_t *xdl_get_hunk(xdchange_t **xscr, xdemitconf_t const *xecfg) {
>>>       xdchange_t *xch, *xchp;
>>>       long max_common = 2 * xecfg->ctxlen + xecfg->interhunkctxlen;
>>> +     long ignorable_context = max_common / 2 - 1;
>>
>> Could you explain how this math works?
>
> I think it doesn't, mostly because I misinterpreted the "interhunkctxlen".
> I will try to think about that and provide a reroll.

OK.  Thanks.

I think the logic would be more like:

 1. Start from xscr, find the first xchp that is !xchp->ignore;
    if there is none, we are done. There is no more to show.

 2. Remember the xchp as the beginning.

 3. Tangle ->next pointer to find the next xch that is !xch->ignore;
    if there is none, we are also done.  xdchanges between the
    beginning you remembered in the step 2. and your current xchp
    are the only things we want to show.

 4. Measure the distance between the end of xchp and the beginning
    of xch.

    - If it is larger than max_common, xdchanges between the
      beginning you remembered in the step 2. and your current xchp
      are the only things we want to show.  The next iteration will
      start by skipping the blank-only changes between xchp and xch.

    - If it is short enough, assign xchp = xch and go back to 3. to
      find more interesting hunks (that is why we remembered the
      real "beginning" in step 2.).
