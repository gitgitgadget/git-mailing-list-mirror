From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Review of current github code [Re: [GSoC] Designing a faster
 index format - Progress report week 6]
Date: Thu, 31 May 2012 11:11:34 -0700
Message-ID: <7vhauw6x0p.fsf@alter.siamese.dyndns.org>
References: <20120528214401.GB6449@tgummerer>
 <87pq9k8i4e.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Gummerer <t.gummerer@gmail.com>, <git@vger.kernel.org>,
	<mhagger@alum.mit.edu>, <pclouds@gmail.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu May 31 20:11:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sa9qY-0006H3-0A
	for gcvg-git-2@plane.gmane.org; Thu, 31 May 2012 20:11:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754138Ab2EaSLi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 May 2012 14:11:38 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57361 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751976Ab2EaSLh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 May 2012 14:11:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CD5FC86D1;
	Thu, 31 May 2012 14:11:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7stEdHMPA/vjeFwbJpwAeaIEXuI=; b=UWogZ/
	+adJObb4npmOD8YspDZm7c0cXf8dUPhsKn3WV9IQ2Jyoo50OSBl9pQEtQEAcnOhU
	R2HJn2C1RxHkUzX4kILV1GixmhEa0foRSb0IAJoBvoFun9ix8EeSOUAUKrcNSa9M
	mPMNsxKpFzM17EJpdVfvodctSdG3jobSA+oEY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MyAtLS4qspQMAT6HIPPB6nFHctzgNPa9
	JsQahyDNOcDuUm0yTmyfONkud46j7bIEqHawuskSbbpPP42rEKEx2JSvJ4qxZOW1
	sPlqPD17ysFlRukIFxHtRTGxX13EPDvicUAtVqpOPaQ63c8BO7lrl5hPAhYicBoE
	/zKgCVegTIk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C46DA86D0;
	Thu, 31 May 2012 14:11:36 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 59F5686C4; Thu, 31 May 2012
 14:11:36 -0400 (EDT)
In-Reply-To: <87pq9k8i4e.fsf@thomas.inf.ethz.ch> (Thomas Rast's message of
 "Thu, 31 May 2012 17:50:25 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0F80E56E-AB4C-11E1-9423-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198932>

Thomas Rast <trast@student.ethz.ch> writes:

> Thomas has again been busy hacking, and the reading side is now capable
> of reading a v5 index into the (existing) array-of-cache_entry format.
> It is actually already measurably faster than both v4 and v[23] on the
> Webkit index:
>
>   Test                      this tree      
>   -----------------------------------------
>   0002.1: v[23]: ls-files   0.13(0.11+0.02)
>   0002.4: v4: ls-files      0.11(0.08+0.02)
>   0002.5: v5: ls-files      0.09(0.06+0.02)
>
> I made up a hacky perf script on the spot, it's pasted at the far end of
> this email.  It would most likely still be slower than v4 if we didn't
> switch away from SHA1, though -- we haven't really spent much time
> looking into the speed, except for one particular avoidance of name
> copies that translated into a roughly 30% speedup.

Do you mean by "switch away from SHA-1" that your suspicion is a
large part of the speed-up may be coming from the fact that the
index file as a whole is no longer hashed?

As long as the new format allows us to notice corruption in the file
to a similar degree of confidence by some other means, I personally
do not see it as a regression in safety.

We however eventually would need to hook the logic to check for
index corruption into fsck.  Actually adding such a code to fsck can
and probably should remain outside the GSoC project, but please make
sure you have necessary checksums in the format to allow us to do so
in the future.

Thanks.
