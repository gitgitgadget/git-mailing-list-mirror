From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 00/57] Re-roll of en/merge-recursive from pu
Date: Thu, 11 Aug 2011 22:48:54 -0700
Message-ID: <7vei0rnprt.fsf@alter.siamese.dyndns.org>
References: <1313126429-17368-1-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jim Foucar <jgfouca@sandia.gov>
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 12 07:49:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QrkcA-0007ym-9Z
	for gcvg-git-2@lo.gmane.org; Fri, 12 Aug 2011 07:49:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753402Ab1HLFs6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Aug 2011 01:48:58 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59655 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751359Ab1HLFs5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2011 01:48:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6793C5EA5;
	Fri, 12 Aug 2011 01:48:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=04zaCuT0WReCHUqIGzSi618zAt0=; b=nAL3Z5
	gW/cj41IgBBil/p5vF1IHPdrQScGsJZGBZHwIDq2Wp4hYeU0Gr1ICaVzQDvBuo3i
	AbIOly6lMaPe1RNi8d0jMkvLs5K/7OUybL8V3b6mfLKHILADLSnjjvPYklAbfOMO
	v1CP8ziSN9QMSGEaLGvKo5aFDip1grgDIHDTY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZG6MeNXefidVIilBhJvcRYRkYDZ9vDOW
	XJ/bIzk2CgYhNx9p2TmRzbdFi3u0NeFMISor98ir82rL+SoifPGa1KKukqmm48Ud
	8/iKC08vLDze2jwo6hvc/M4Yo+eyKpxyYTxqQnCaJeYAbP/VIBrqVDwMs19wK/CX
	ZCzaoTTgVaU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5F6A55EA4;
	Fri, 12 Aug 2011 01:48:56 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CEC3E5EA3; Fri, 12 Aug 2011
 01:48:55 -0400 (EDT)
In-Reply-To: <1313126429-17368-1-git-send-email-newren@gmail.com> (Elijah
 Newren's message of "Thu, 11 Aug 2011 23:19:33 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C45424DE-C4A6-11E0-8122-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179220>

Elijah Newren <newren@gmail.com> writes:

> Because it's so hard to rule out regressions with so many changes to a
> complicated portion of the code (though hopefully it is less complicated
> now), and because we've had multiple problems in the past with the
> changes I've been making to merge-recursive, I came up with an idea to
> test this series more thoroughly.  So, I wrote a script to take every
> single merge commit in git.git that had exactly two parents (no octopus
> merges) and redid them both with /usr/bin/git and the version of git
> from this series.  I checked to ensure that the two different versions
> of git:
>   (a) EITHER both failed to merge cleanly OR both merged cleanly
> AND
>   (b) the output of 'git ls-tree -r HEAD' matched between the two
>
> I ran this process with the original version of the series and indeed
> found that my original series mis-merged half a dozen or so merges (out
> of about 5000).

Thanks for doing this; note that the previous "simple one-side renamed the
other just updated in-place are merged incorrectly" was caught by such a
test.

One thing we may need to be careful about is to compare the conflicted
state a failed merge leaves behind.  The latter half of (a) together with
(b) will ensure that you did not introduce silent mismerges.

Avoiding silent mismerges is of course one of the most important criteria,
but we also need to make sure that a conflicted state left in the index
and the working tree files must not be harder to reconcile than what we
have been giving our users---otherwise the change will be seen as a
regression by them.

> *** What is still missing ***
>
> Two things:
>   * Junio had a great suggestion about alternate handling of the index in the
>     case of rename/rename(2to1) and directory/file conflicts (just rename the
>     entry in the index to match how we are renaming in the working copy to
>     some new unique name, in order to allow 'git diff' to provide more useful
>     information to the user).  Just didn't get to it.
>   * Support for running break detection in diffs, in order to fix the testcase
>     corrected by Peff in this series.  Simply didn't get around to it either.

I would say it is sensible to leave these two out. They can be done as a
follow-up series after dust settles.

Thanks.
