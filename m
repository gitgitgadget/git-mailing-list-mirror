From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] commit: reject invalid UTF-8 codepoints
Date: Sun, 30 Jun 2013 12:29:41 -0700
Message-ID: <7vhagfjt22.fsf@alter.siamese.dyndns.org>
References: <20130629174023.GB226907@vauxhall.crustytoothpaste.net>
	<7v7ghcl50r.fsf@alter.siamese.dyndns.org>
	<20130630022921.GP862789@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Sun Jun 30 21:29:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UtNJu-0006jq-KA
	for gcvg-git-2@plane.gmane.org; Sun, 30 Jun 2013 21:29:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751950Ab3F3T3s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Jun 2013 15:29:48 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59802 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751529Ab3F3T3o (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Jun 2013 15:29:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A6E702CE25;
	Sun, 30 Jun 2013 19:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DtXRLzRVaAcwxDeucfj9wLI9J0Q=; b=dAwkI0
	wzoIPUsLNqxEdiwQAGLzJKEj4HdUQa0W5324p9BcLrdOc6oHgBF2YCjZuZfmaMhv
	sgTOItx3fkJM1Y44gpmFictljarkd4x1dYi4atRcU+U0sIOcN3NxMOOJE80omyWM
	A14pz3bYLMXQcCQrN1RNxsAueZUxOZhL4YbFY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=u4kNJDx22kNXZIuaU+ee7z1pOHfOaqLf
	Wa1ECoMUl2p90CaHOxLJkm9S6O1/hnxwpveiMrYwwnGC7nzm8QKNoW4ZCT/1GIJK
	mrExpOjD13BK5uNK5kvlXrVxh+Ds3kq2ttf4B8NbUEzvAo+L4ZoLklV+YGCPOtCb
	j5J2W4XUgHw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9DE602CE24;
	Sun, 30 Jun 2013 19:29:43 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0B90B2CE20;
	Sun, 30 Jun 2013 19:29:42 +0000 (UTC)
In-Reply-To: <20130630022921.GP862789@vauxhall.crustytoothpaste.net> (brian
	m. carlson's message of "Sun, 30 Jun 2013 02:29:21 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6A264D5A-E1BB-11E2-9AF5-E636B1368C5F-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229284>

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On Sat, Jun 29, 2013 at 07:13:40PM -0700, Junio C Hamano wrote:
>> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>> Does this correspond to the following comment in the same file, and
>> if so, shouldn't this part of your patch?
>
> Yes, yes, it should.
> ...
>> As that comment I quoted at the beginning says, we did not check for
>> invalid encoded values and the primary reason for it is beccause
>> this function did not want to look into the actual values here.  But
>> now you are looking into "codepoint", you can now also check for
>> "overlong" form (e.g. sequence "C0 80" turning into U+0000)?
>
> Correct.  That's what my second patch does.

Ah, I started with that quoted comment when I saw 1/2, thinking that
you may not even have noticed that these two things are our "todo"
list, hence I thought it would be natural to do them both in the
same commit as the logic to do so is in the single place (the
function you patched).  It is not _wrong_ per-se to do this in two
steps, but I do not think it is necessary.  You *could* break this
to even smaller steps to go to the other extreme, first limiting
only upto 4-byte forms, then rejecting a half of the 4-byte form,
then rejecting the range for surrogates, and then rejecting overlong
forms, and the split may be technically logical and "one step at a
time" but that kind of granularity is probably more noisy than it is
valuable.

I think "1/2 is about rejecting a codepoint outside valid ranges and
2/2 is about rejecting a valid codepoint inside the valid range but
expressed in an invalid way" is on the borderline between the two
extremes, but it probably is on the saner side, so let's keep these
two patches separate.

> If you ended up with an encoding of U+D800, then you got it.

I think we are seeing ? U+003F in our mailboxes.

Thanks.
