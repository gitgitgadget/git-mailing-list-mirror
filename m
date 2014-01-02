From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] blame: new option to better handle merged cherry-picks
Date: Thu, 02 Jan 2014 13:48:38 -0800
Message-ID: <xmqq4n5moy15.fsf@gitster.dls.corp.google.com>
References: <20140102175529.GA4669@client.brlink.eu>
	<xmqqlhyyp1oo.fsf@gitster.dls.corp.google.com>
	<20140102211507.GA6323@client.brlink.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Bernhard R. Link" <brl+git@mail.brlink.eu>
X-From: git-owner@vger.kernel.org Thu Jan 02 22:49:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vyq8S-0004w1-GM
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jan 2014 22:49:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750945AbaABVso (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jan 2014 16:48:44 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43680 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750740AbaABVsn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jan 2014 16:48:43 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BF5A55E878;
	Thu,  2 Jan 2014 16:48:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SGi1uSUgCDtuUuDrT/yN1sdzUPw=; b=w2IQJe
	9nToE4g4CSIVUYG3j/1X2ze65hngA5gSaCy/0Qj2qZEtCVKmUbAwBqww/jO2PVaM
	SrsXvGuRumRe9rEx/atmZOOQK4euTARx/F419xiGddmGbf6ZLG6k+mleVYp5MH0A
	A/Q8GN7gjTRAVmKzk9WcXipU1Ec4Clr2kUxWk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mclRI3FpOTB2D3EzrHHr6rXG5Kpt3FgP
	0DFQQAkTHgIaFH+aVEA4oMMVgRtukytvXjWD96ulverOu1UtrXl9mJRjgbPts0TA
	70fBFAiCGANBzGOPeCtv2mGBitFr0+gAINg61x0UCSwNqO6t3hINpmGMwk34donB
	YNgp2R7IcxE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 909555E877;
	Thu,  2 Jan 2014 16:48:42 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C69095E872;
	Thu,  2 Jan 2014 16:48:41 -0500 (EST)
In-Reply-To: <20140102211507.GA6323@client.brlink.eu> (Bernhard R. Link's
	message of "Thu, 2 Jan 2014 22:15:07 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: A546749A-73F7-11E3-901E-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239888>

"Bernhard R. Link" <brl+git@mail.brlink.eu> writes:

> When giving git-blame the new option introduced with my patch, only
> the order of parents determines which commit is blamed. Without
> the option (i.e. the currently only possible behaviour) which commit
> is blamed depends what else touches other parts of the file.

I am trying to figure out why that difference matters, in other
words, when using the new option is actually useful.  You give the
command a scenario that can be solved in two equally valid ways
(blaming to either A or A' is equally valid), and sometimes the
command gives the identical result with or without the new option,
and some other times the user gets a different but an equally valid
result (but after traversing more history spending more cycles).  I
am not sure what problem the new option solves.  I am trying to come
up with an easy-to-understand explanation to the end users: "If you
want to see blame's result with the property X, use this option---it
may have to spend extra cycles, but the property X is so desirable
that it may be worth it".  And I am having a hard time understanding
what that X is.

> But in the example with one commit B touching also b and one commit C
> touching also c, there is (without the new option) always one part
> of the cherry-picked commit is blamed on the original and one on the
> cherry-picked, no matter how you order the parents.

Yeah, the cherry-picked one will introduce the same change as the
one that was cherry-picked, so if you look at the end result and ask
"where did _this_ line come from?", there are two equally plausible
candidates, as "blame" output can give only one answer to each line.
I still do not see why the one that is picked with the new option is
better.  At best, it looks to me that it is saying "running with
this option may (or may not) give a different answer, so run the
command with and without it and see which one you like", which does
not sound too useful to the end users.  That is where my confusion
comes from.

> (While by having your mainline always the most leftward parent, with
> the the new option you always get those commit blamed that is the
> "first one this was introduced to mainline".)

Yes, I vaguely recall we talked about adding --first-parent option
to the command in the past.  I do not remember what came out of that
discussion.
