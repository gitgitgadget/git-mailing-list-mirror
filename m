From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Try harder to find a remote when on a detached HEAD or
 non-tracking branch.
Date: Mon, 18 Jun 2012 15:12:53 -0700
Message-ID: <7vmx402rru.fsf@alter.siamese.dyndns.org>
References: <1340038866-24552-1-git-send-email-marcnarc@xiplink.com>
 <7vaa004j9f.fsf@alter.siamese.dyndns.org> <4FDFA030.7080408@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jens Lehmann <Jens.Lehmann@web.de>
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Tue Jun 19 00:13:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SgkBw-0006la-8S
	for gcvg-git-2@plane.gmane.org; Tue, 19 Jun 2012 00:13:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752146Ab2FRWM4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jun 2012 18:12:56 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60904 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751421Ab2FRWM4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jun 2012 18:12:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AC9CC99A8;
	Mon, 18 Jun 2012 18:12:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9RzAyl56paVHKUOnkhzduOABKYI=; b=KzMubz
	VIj1AjOdKfTNmsTI5nYDoU+oDmAHKKlne8yuuJZyb2/uNDWoF1Mo0M5Wds72riBi
	4z+jrp2JVbzvi9IWy22C7h7TfdvKBVIrpFwRRpUU9KWp1f+P3fbDqWKODNK1O16X
	fHfi4vsyH9VCwQYUsUhueTWb11B4UUyO6YSKo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=d4o2ObTSQPAMVuun54ob/5sonzTeMkvB
	R1vx6ZWckwLsjPrZ6kmlZRKMWNDOE79+indUZKpNYScN58hxQM5n6dm5xxjEqHwt
	aVd+CpwKU4+gstHFYbyv5FS94dB+yTwouKA9v+VhKE6cMXeNjQ7pR7hU+J6WCBOg
	id7/ik2q0d4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A2D0599A7;
	Mon, 18 Jun 2012 18:12:55 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3911799A5; Mon, 18 Jun 2012
 18:12:55 -0400 (EDT)
In-Reply-To: <4FDFA030.7080408@xiplink.com> (Marc Branchaud's message of
 "Mon, 18 Jun 2012 17:40:00 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C103DC7A-B992-11E1-AF9C-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200176>

Marc Branchaud <marcnarc@xiplink.com> writes:

> On 12-06-18 01:33 PM, Junio C Hamano wrote:
>> marcnarc@xiplink.com writes:
>> 
>>> From: Marc Branchaud <marcnarc@xiplink.com>
>>>
>>> get_default_remote() tries to use the checked-out branch's 'remote' config
>>> value to figure out the remote's name.  This fails if there is no currently
>>> checked-out branch (i.e. HEAD is detached) or if the checked-out branch
>>> doesn't track a remote.  In these cases and the function would just fall
>>> back to "origin".
>>>
>>> Instead, let's use the first remote listed in the configuration, and fall
>>> back to "origin" only if we don't find any configured remotes.
>> 
>> I admit that I wouldn't do anything that relies on any remote to be
>> used while on detached head myself, so in that sense I am a biased
>> audience, but guessing (or not guessing and blindly assuming
>> 'origin') feels wrong, and trying even harder to come up with an
>> even wilder guess feels even more wrong.
>
> OK, but what would be right?  AFAIK git doesn't have any real way of
> designating an official default remote.

Correct, and that is why I tend to think "right" is to error out.

> That would be bad for our situation.  As I said, our automated build system
> uses detached HEADs a lot.  Erroring-out in this case would break us.  It's
> really only the near-ubiquity of the name "origin" that has kept things
> working so far.

That reliance of "origin" is what made me think that "not guessing
and blindly assuming" a wrong thing to do.

It is OK that your build usesdetached HEAD, but if that is the case
shoudln't it be the one deciding which specific remote it wants to
take the updated sources from, and telling Git to do so?
