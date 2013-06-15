From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rebase -i: fixup fixup! fixup!
Date: Sat, 15 Jun 2013 03:07:22 -0700
Message-ID: <7vk3lvlmat.fsf@alter.siamese.dyndns.org>
References: <20130611180530.GA18488@oinkpad.pimlott.net>
	<87obbc8otc.fsf@hexa.v.cablecom.net> <1371237209-sup-639@pimlott.net>
	<1371278908-sup-1930@pimlott.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@inf.ethz.ch>, git <git@vger.kernel.org>
To: Andrew Pimlott <andrew@pimlott.net>
X-From: git-owner@vger.kernel.org Sat Jun 15 12:07:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnnOM-00013Y-L5
	for gcvg-git-2@plane.gmane.org; Sat, 15 Jun 2013 12:07:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753899Ab3FOKH1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Jun 2013 06:07:27 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51863 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753842Ab3FOKH0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Jun 2013 06:07:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1FDBC2369C;
	Sat, 15 Jun 2013 10:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pc1ol/paSo4HT+2mE8Xq+8yd9jI=; b=XUpXWB
	MbalTuGUhZ22aA8m85cCb25HeCRqHeq5CWQ4FG4rf/WaeTR+pqXFKPTvsu6gnehV
	xA4wtUaoPYmFoJp+yYQgLpIMHUDmrvORJ0KJdHOT5JjaX4iKWSflkHZ16d4TEao/
	wgnVZh5Vdfd8o28GrILvtJcQrleUn7gtb2Gsw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jfpQFSaSlBlF5opxb8dmMt54YNsV5mT2
	LOk2cA2Kzu5QdX7/bZaPJ7cj7aR2+FuaOc4QlHgH2/WWlDgxdrEaUYLWBBLjsMRK
	hE9+gk++uRidnIyLD6HxDkLIG0+hUIYowrN9WQf7UYUInXuz6YRSc1cbMxUx/zZT
	a4XalkpKi+0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 137DA2369B;
	Sat, 15 Jun 2013 10:07:25 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4303B2369A;
	Sat, 15 Jun 2013 10:07:24 +0000 (UTC)
In-Reply-To: <1371278908-sup-1930@pimlott.net> (Andrew Pimlott's message of
	"Fri, 14 Jun 2013 23:50:21 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6013F890-D5A3-11E2-870D-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227940>

Andrew Pimlott <andrew@pimlott.net> writes:

> Excerpts from Andrew Pimlott's message of Fri Jun 14 12:31:57 -0700 2013:
>> It happened to work and I added a test.  But then it occurred to me that
>> it might have been better to fix commit --fixup/--squash to strip the
>> fixup! or squash! from the referenced commit in the first place.
>> Anyhow, below is my patch for --autosquash, but unles someone has an
>> objection to doing it in commit, I'll work on that.

Is it always true that you would squash and fixup in the same order
as these follow-up commits happened?

That is, if you did this (time flows from top to bottom):

	1 A
        2 B
        3 fixup A
        4 squash B
        5 fixup fixup A
        6 fixup A

I am wondering if applying 6 on top of 5 is always what you want, or
you would want to apply it to 3 instead.  Otherwise you would have
written

	6 fixup fixup fixup A

instead.

The two reordering possibilities are:

        1 A                        1 A             
        3 fixup A                  3 fixup A       
        5 fixup fixup A            6 fixup A       
        6 fixup A                  5 fixup fixup A
        2 B                        2 B             
        4 squash B                 4 squash B      

If you strip out the prefix when you make commits, you may lose the
information if you want to use in order to express these different
orders.  I am not sure if it matters in practice, but I am not yet
convinced it is a good idea.

By the way, the message I am responding to is not something we can
apply. I am assuming these paches are for discussion-only; before
sending the final one, please check Documentation/SubmittingPatches.

Thanks.
