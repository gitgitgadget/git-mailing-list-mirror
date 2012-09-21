From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] receive-pack: send pack-processing stderr over
 sideband
Date: Fri, 21 Sep 2012 10:25:24 -0700
Message-ID: <7vtxur70fv.fsf@alter.siamese.dyndns.org>
References: <20120921053057.GA9768@sigill.intra.peff.net>
 <20120921053455.GB9863@sigill.intra.peff.net>
 <7v7grn8gnv.fsf@alter.siamese.dyndns.org>
 <20120921170539.GA19707@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Sep 21 19:25:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TF6yv-0001Dp-4D
	for gcvg-git-2@plane.gmane.org; Fri, 21 Sep 2012 19:25:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756939Ab2IURZ2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Sep 2012 13:25:28 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58484 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756815Ab2IURZ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Sep 2012 13:25:27 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D4B939872;
	Fri, 21 Sep 2012 13:25:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ubDxIFeNXaf6KGKmbFTF9gVsBok=; b=lp3CsW
	S9uyBzDk23+ryKajn4909LVZz2ZBGVgWYX0X5h4Md9IQ/+zTjLDW7uQbg31kCwC6
	3QDKeUyLrxJFeOuYwJiKpF6WRiQNZkYhKj5uJMnRnZEitmhvWluvd8Kyb0PVBIRn
	K6g/0f7c9HgXJYriM7+DwGER9ieDJIx69S25o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=R9rlIFNGo7MUk5NGOZK9F2Y/kbwRcTjx
	CUytDWXLPDncd0JZp1A/Oc3a9Dcfy/9jYBDSJmZXvziDuDABHYtXdwWCwBpUdMmr
	zcAy7z3Yfjiaj262ia4uPTB5/vkRmFY8RERsijgoquG9Kne2LPOeoTCb47Qk54rL
	ncBFQTlvpMo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C231F9871;
	Fri, 21 Sep 2012 13:25:26 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2A2749870; Fri, 21 Sep 2012
 13:25:26 -0400 (EDT)
In-Reply-To: <20120921170539.GA19707@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 21 Sep 2012 13:05:39 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5503E726-0411-11E2-B44D-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206139>

Jeff King <peff@peff.net> writes:

> On Fri, Sep 21, 2012 at 09:49:40AM -0700, Junio C Hamano wrote:
>
>> >   2. No matter what the cause, we are probably better off
>> >      showing the errors to the client. If the client and the
>> >      server admin are not the same entity, it is probably
>> >      much easier for the client to cut-and-paste the errors
>> >      they see than for the admin to try to dig them out of a
>> >      log and correlate them with a particular session.
>> 
>> I agree with the "probably" above (and also with points 1 and 3),
>> but it at the same time feel a bit iffy.  The server side would lose
>> log entries to check when the operator observes higher error rate
>> and starts suspecting something recently broke, and the lost clue
>> cannot be recovered without contacting the pushers, no?
>
> Yeah, that is true, although that is already the case with ssh pushes.
> Conversely, it also means that servers using the ssh transport have lost
> the option of redirecting the server-side stderr (e.g., with a wrapper
> around git-receive-pack) to a log if they were already doing so.

Yes.

> However, this does make things more consistent with upload-pack, which
> connects the stderr of pack-objects to sideband (which it must to handle
> progress). Furthermore, many of the messages from receive-pack are
> handled by rp_error, which sends to the sideband. So if you were
> monitoring your git purely by trying to capture stderr, you were already
> only getting a fraction of the real data.

The comments were not meant as a rejection notice ;-) Just to see if
some server operators have input on the matter.

I personally do not think tee-ing the error output is worth it; it
would be reasonably simple to arrange, and the server operators who
want it can ask later if that is need.

Thanks.
