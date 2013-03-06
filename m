From: Junio C Hamano <gitster@pobox.com>
Subject: Re: feature suggestion: optimize common parts for checkout
 --conflict=diff3
Date: Wed, 06 Mar 2013 13:09:41 -0800
Message-ID: <7vr4jsp756.fsf@alter.siamese.dyndns.org>
References: <20130306150548.GC15375@pengutronix.de>
 <CALWbr2xDYuCN4nd-UNxkAY8-EguYjHBYgfu1fLtOGhYZyRQg_A@mail.gmail.com>
 <20130306200347.GA20312@sigill.intra.peff.net>
 <7vvc94p8hb.fsf@alter.siamese.dyndns.org>
 <20130306205400.GA29604@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Antoine Pelisse <apelisse@gmail.com>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>, git <git@vger.kernel.org>,
	kernel@pengutronix.de
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 06 22:10:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UDLbG-0005dB-QC
	for gcvg-git-2@plane.gmane.org; Wed, 06 Mar 2013 22:10:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755289Ab3CFVJp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Mar 2013 16:09:45 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48001 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753509Ab3CFVJo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Mar 2013 16:09:44 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EE76EA282;
	Wed,  6 Mar 2013 16:09:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+wNJdNXc7YwHIX7NhJ2Sk8gzGVk=; b=w54+1p
	hPqVLac1GZz8LVxZRlE0so5mWX09PzuDQ/w2OM5R5MBAGqbvzjzHK9/FVXZHbVYG
	1yt67VZ9vhlJkvXP++D+i3Hqzv53HOB6P4wqsWFdgh1zx2hQh+D6DJlp78jIQPGm
	o95Q9uRJGVnhdNbevbvu+y/HL7m1l+mfLBSJE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lRMgknQ1FZ04BHp7v7Csa1RZJD3vjX5C
	DZhQ4W7R/wYYNlisLczocBXk8/LDEyuwA2EY8hOmCrlVneC+M7WiLKYEQpPk4IL3
	hVyI4GDFzS5wrw38tphJYIo0+6xJvi8ynAr3y7WJOi6Cs9efFxq97/gmK8MH/H3m
	wkajJEabpxk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DE45FA281;
	Wed,  6 Mar 2013 16:09:43 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 40C47A27A; Wed,  6 Mar 2013
 16:09:43 -0500 (EST)
In-Reply-To: <20130306205400.GA29604@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 6 Mar 2013 15:54:00 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2AA3E56C-86A2-11E2-8AA5-26A52E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217546>

Jeff King <peff@peff.net> writes:

> But it would apply to the content that is outside
> of the hunk marker; we have changed the concept of what is in the base
> and what is in the conflict by shrinking the conflict to its smallest
> size.

Hmm, unless you mean by "base" something entirely different from
"what was in the common ancestor version", I do not think I can
agree.  The point of diff3 mode is to show how it looked line in the
common ancestor and what the conflicting sides want to change that
common version into; letting the user view three versions to help
him decide what to do by only looking at the part inside conflict
markers.

We show "both sides added, either identically or differently" as
noteworthy events, but the patched code pushes "both sides added
identically" case outside the conflicting hunk, as if what was added
relative to the common ancestor version (in Uwe's case, is it 1-14
that is common, or just 10-14?) is not worth looking at when
considering what the right resolution is.  If it is not worth
looking at what was in the original for the conflicting part, why
would we be even using diff3 mode in the first place?
