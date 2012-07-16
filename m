From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [GSoC] Designing a faster index format - Progress report week 13
Date: Mon, 16 Jul 2012 13:46:42 -0700
Message-ID: <7vwr23zb65.fsf@alter.siamese.dyndns.org>
References: <20120716203300.GA1849@tgummerer.surfnet.iacbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, pclouds@gmail.com,
	trast@student.ethz.ch
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 16 22:46:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SqsBv-000448-1j
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jul 2012 22:46:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752251Ab2GPUqq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jul 2012 16:46:46 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39795 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751888Ab2GPUqp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jul 2012 16:46:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4CFA180E2;
	Mon, 16 Jul 2012 16:46:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0H1nJiWOYFeIG77WG69X/xXcLxI=; b=rWNPAe
	oNqFUYUqHV5AIHZ9w6daA798sIDPFk3AL/krLaWSyLk+M1/UtWjOCqVA3/PLs5PV
	SdUhb60UWmRvU6ifSnzt1/3aRp9HrWR4q1ttRMDIh+kPNl0NxZz4DL6v3zfcK/7X
	9t80I3iyZwWB/KXxP04ZD+N/L33FiuGwMx7Y4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Sx3W5v0K6tJmclkDfRTbiVmnFFCzLH4J
	4zMvgsBMmkMsGD/MSMbk+Nyf3FGKgnQ80672rZzQIzCHXe8mRGVyKdOAVL4UKeDR
	CuaE+aok3/25pfS2xokxTu+BUiGPFeTByDG8amVIEqTfFx5CUlYQ5o9SMIYcwmjY
	/UzhyhRuZjM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 39BFD80E1;
	Mon, 16 Jul 2012 16:46:44 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8B9AE80E0; Mon, 16 Jul 2012
 16:46:43 -0400 (EDT)
In-Reply-To: <20120716203300.GA1849@tgummerer.surfnet.iacbox> (Thomas
 Gummerer's message of "Mon, 16 Jul 2012 22:33:00 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5A07898A-CF87-11E1-BFB8-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201574>

Thomas Gummerer <t.gummerer@gmail.com> writes:

> == Work done in the previous 12 weeks ==
>
> - Definition of a tentative index file v5 format [1]. This differs
>   from the proposal in making it possible to bisect the directory
>   entries and file entries, to do a binary search. The exact bits
>   for each section were also defined. To further compress the index,
>   along with prefix compression, the stat data is hashed, since
>   it's only used for comparison, but the plain data is never used.

s/comparison/equality comparison/ perhaps?

>   Thanks to Michael Haggerty, Nguyen Thai Ngoc Duy, Thomas Rast
>   and Robin Rosenberg for feedback.

> - Read the index format format and translate it to the current in

s/format format/on-disk file format/ or something?

>   memory format. This doesn't include reading any of the current
>   extensions, which are now part of the main index. The code again
>   is on github. [4] Thanks for reviewing the first steps to Thomas
>   Rast.

> - Started implementing the writer, which extracts the directories from
>   the in-memory format, and writes the header and the directories to
>   disk.
> - I found a few bugs in the algorithm for extracting the directories
>   and decided to completely rewrite it, using a hash table instead of
>   simple lists, since the old one would have to many corner cases to
>   handle.

What does "the algorithm" refer to?  Is it the one described in the
previous bullet point, or is it the code in production?  If latter,
it would help to separate out the task to fix the breakage, as
people with the current or previous versions of Git will be
negatively affected until that bug is fixed.  If former, I am not
sure if this task needs to be described in two bullet points ("I did
X, X had bug so I redid X in a different way" is still a single task
to do X).

> == Work done int the last week ==
>
> - Polished the patch for the ce_namelen field. The thread for the
>   patch can be found at [5].

Thanks for this one; I think it is ready for 'next', but if you are
still not satisfied I do not mind waiting for further perfection.
