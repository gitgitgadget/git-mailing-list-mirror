From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] transport-helper: report errors properly
Date: Thu, 11 Apr 2013 11:44:09 -0700
Message-ID: <7vfvywj4au.fsf@alter.siamese.dyndns.org>
References: <20130410211311.GA24277@sigill.intra.peff.net>
 <20130410211552.GA3256@sigill.intra.peff.net>
 <CAMP44s02K5ydKLNi0umMkuAicoVTWyCdVfjs0yssCa2oyFShGQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 11 20:44:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQMTp-00086C-0D
	for gcvg-git-2@plane.gmane.org; Thu, 11 Apr 2013 20:44:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765239Ab3DKSoN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Apr 2013 14:44:13 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37125 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1765121Ab3DKSoM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Apr 2013 14:44:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DE55315E06;
	Thu, 11 Apr 2013 18:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=Hjfrr0ymMSxRwatJgyz3xiu+/PM=; b=sIKyJ6g3MIiRp3x0Sq1M
	xKszqdd3D02nAjBLd0O9+WdVYp6Uaa4cwq7mEBRN1RITTam4SPyWcqEuPtCGytFI
	fmoAhHPx5F4lCu0SCO1mgOf1E22W2ClJQZcHgaYj22S8CheY84Lb8wwm4XQXmjWm
	pnqF9i6qxJ00fg2voPq1rOg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=l7y5fMRIBp8pUx+SsVi8jWblsB3LeGRbg2gy3ouP+dzTQo
	u92KpVSE9J4v0zEz/7fTXG6HJjtr7bJ/KEC5XA5ErqJmT8ZKlt0eXf/2N1qOFMCU
	/rk7QvwjJgB67G+vXgSxkOopKe9VfEOKSD6MVjFUCsK5s5LD0R0yQr9IlhPhY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D5A8515E05;
	Thu, 11 Apr 2013 18:44:11 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 59FF715E04; Thu, 11 Apr
 2013 18:44:11 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CCE4F144-A2D7-11E2-A306-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220911>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Wed, Apr 10, 2013 at 4:15 PM, Jeff King <peff@peff.net> wrote:
>> From: Felipe Contreras <felipe.contreras@gmail.com>
>>
>> If a push fails because the remote-helper died (with
>> fast-export), the user does not see any error message. We do

I agree with you that s/does not see/may not see/ would be more
helpful here, so I'll squash it in while queuing.

>> In the long run, it may make more sense to propagate the
>> error back up to push, so that it can present the usual
>> status table and give a nicer message. But this is a much
>> simpler fix that can help immediately.
>
> Yes it might, and it might make sense to rewrite much of this code,
> but that's not relevant.

It is a good reminder for people who later inspect this part of the
code and wonder if it was a conscious design choice not to propagate
the error or just being "simple and sufficient for now", I think.
It would help them by making it clear that it is the latter, no?

> ... I think it might
> be possible enforce remote-helpers to implement the "done" feature,
> and we might want to do that later.

Yes, all these are possible and I think writing it down explicitly
will serve as a reminder for our future selves, I think.

>> +               if test -n "$GIT_REMOTE_TESTGIT_FAILURE"
>> +               then
>> +                       # consume input so fast-export doesn't get SIGPIPE;
>
> I think this is explanation enough.
>
>> +                       # git would also notice that case, but we want
>> +                       # to make sure we are exercising the later
>> +                       # error checks
>
> I don't understand what is being said here. What is "that case"?

In my first reading, it felt to me that it was natural to interpret
that this is "even if we didn't have this loop that avoids killing
fast-export with SIGPIPE, we would notice death of fast-export by
SIGPIPE".
