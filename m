From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git clone silently aborts if stdout gets a broken pipe
Date: Wed, 18 Sep 2013 12:31:23 -0700
Message-ID: <xmqqmwnaudtg.fsf@gitster.dls.corp.google.com>
References: <A612847CFE53224C91B23E3A5B48BAC798CD91DB0B@xmail3.se.axis.com>
	<20130918184551.GC18821@sigill.intra.peff.net>
	<20130918190437.GD18821@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Peter Kjellerstedt <peter.kjellerstedt@axis.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Sep 18 21:31:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VMNTI-0001b1-ON
	for gcvg-git-2@plane.gmane.org; Wed, 18 Sep 2013 21:31:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751979Ab3IRTb2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Sep 2013 15:31:28 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36583 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751880Ab3IRTb1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Sep 2013 15:31:27 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8CBCD42B8A;
	Wed, 18 Sep 2013 19:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TCRIMnKXwxUYSs3mG1Hoq8TetdI=; b=fxMu5T
	DD+ARK7OVJHVRKr7a0/q4zUkNaWAmVWZZOpr5UEWhhk5UvGfD5P0ptBHXIaZrmbh
	P72IdgRp9sRWfRKAgFTsFC7iJsjL+P7cel+kBZpgPRKIVHsn0lIWh9UuoYpv63As
	T/K2tUsm1PqOnvodMFCf2RhCYBbzY1KRo86Zc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=A/dD6b6+Q/aX5eb3MrItB5kut6vv+tnT
	auHoEXC7+VAVZgDIfVlOiO0miJ+WXok5FVWhLQkSlFas3H+gw4uudmNW33XC9WNi
	+GQ7YimoQYM7QGarAIqUE2xNobzKByovMHWJoVaZY4QWxZ6C6Y2xubs5tv+CvRTa
	VyDusbIsdKM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7F8B542B89;
	Wed, 18 Sep 2013 19:31:26 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D551F42B86;
	Wed, 18 Sep 2013 19:31:25 +0000 (UTC)
In-Reply-To: <20130918190437.GD18821@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 18 Sep 2013 15:04:37 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: E887007E-2098-11E3-B228-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234987>

Jeff King <peff@peff.net> writes:

> On Wed, Sep 18, 2013 at 02:45:51PM -0400, Jeff King wrote:
>
>> That being said, the new messages should almost certainly go to stderr.
>> 
>> -- >8 --
>> Subject: [PATCH] clone: write "checking connectivity" to stderr
>> 
>> In commit 0781aa4 (clone: let the user know when
>> check_everything_connected is run, 2013-05-03), we started
>> giving the user a progress report during clone. However,
>> since the actual work happens in a sub-process, we do not
>> use the usual progress code that counts the objects, but
>> rather just print a message ourselves.
>> 
>> This message goes to stdout via printf, which is unlike
>> other progress messages (both the eye candy within clone,
>> and the "checking connectivity" progress in other commands).
>> Let's send it to stderr for consistency.
>
> Hrm, this actually breaks t5701, which expects "clone 2>err" to print
> nothing to stderr.

Hmm, where in t5701?  Ah, you meant t5702 and possibly t5601.

> What should happen here? The message is emulating the usual progress
> messages, which are silent when stderr is redirected. So we could
> actually use isatty() in the usual way to suppress them. On the other
> hand, the point of that suppression is that the regular progress code
> produces long output that is not meant to be seen sequentially (i.e., it
> is overwritten in the terminal with "\r"). But this message does not do
> so. So we can just tweak t5701 to be more careful about what it is
> looking for.

I actually think "it is long and not meant to be seen sequentially"
is a bad classifier; these new messages are also progress report in
that it reports "we are now in this phase".  So if I were to vote, I
would say we should apply the same progress-silencing criteria,
preferrably by not checking isatty() again, but by recording the
decision we have already made when squelching the progress during
the transfer in order to make sure they stay consistent.

> Also, we should arguably give the "Cloning into..." message the same
> treatment. We have printed that to stdout for a very long time, so there
> is a slim chance that somebody actually tries to parse it. But I think
> they are wrong to do so; we already changed it once (in 28ba96a), and
> these days it is internationalized, anyway.

Good thinking.  Please make it so ;-)
