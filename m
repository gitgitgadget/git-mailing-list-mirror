From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC 3/3] reset: Change the default behavior to use "--merge" during a merge
Date: Wed, 26 Feb 2014 12:53:37 -0800
Message-ID: <xmqqfvn538a6.fsf@gitster.dls.corp.google.com>
References: <1393437985-31401-1-git-send-email-andrew.kw.w@gmail.com>
	<1393437985-31401-4-git-send-email-andrew.kw.w@gmail.com>
	<vpq8usxenul.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andrew Wong <andrew.kw.w@gmail.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Feb 26 21:53:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WIlU9-0000vC-Uv
	for gcvg-git-2@plane.gmane.org; Wed, 26 Feb 2014 21:53:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753535AbaBZUxl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Feb 2014 15:53:41 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60927 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753482AbaBZUxk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Feb 2014 15:53:40 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 96D086E3C2;
	Wed, 26 Feb 2014 15:53:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6QMzcDMR7SRZAi0N/8NlGRWz3R0=; b=iNTwvY
	wSqZfxgMDB4uD2GoirtwI6DiUiKQVGCWBpsWvhURTVORZ/2esh1r5g5NZzhPWhW5
	WXkVe0gqecIqIIETyFfDq2YaUktGF2iFUBiifiusFm4yqOPOdrxu7KXbubUV1xdS
	ae2C876tbqSs2YGkUQuBiEoE8j6Ri+pyp+udY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AUcG/SqCnf189dzLh5l0h/uSgg7L6l86
	QUctLlS3lSI86MnvlutfUOE562jbLszV3ZKQ+J+f69/C6sEVgn19NMGtSSDU7LEi
	sxvqJGsxJbcrHo+uQfEWCvU2sevyzZ4dmM8hbyb3/ozo7XEdMJc0VzXYVdJXOi0e
	xINPZwSPFMY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 80EBC6E3C1;
	Wed, 26 Feb 2014 15:53:39 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DB0666E3C0;
	Wed, 26 Feb 2014 15:53:38 -0500 (EST)
In-Reply-To: <vpq8usxenul.fsf@anie.imag.fr> (Matthieu Moy's message of "Wed,
	26 Feb 2014 19:21:54 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 114DC28C-9F28-11E3-96D8-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242766>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Andrew Wong <andrew.kw.w@gmail.com> writes:
>
>> If the user wants to do "git reset" during a merge, the user most likely
>> wants to do a "git reset --merge". This is especially true during a
>> merge conflict and the user had local changes, because "git reset" would
>> leave the merged changes mixed in with the local changes. This makes
>> "git reset" a little more user-friendly during a merge.
>
> But this breaks backward compatibility.
>
> I sometimes run "git reset" during a merge to only reset the index and
> then examine the changes introduced by the merge.

Hmmmm, wouldn't it a better way to do this to run "git diff HEAD"
without any resetting of the index, though?  Having said that...

> With your changes,
> someone doing so would abort the merge and discard the merge resolution.
>
> I very rarely do this, but even rarely, I wouldn't like Git to start
> droping data silently for me ;-).

...this indeed may be a concern that deserves a bit more thought.

> I'm not really convinced that this is such a good change, and if we go
> this way, there should be a transition to let users stop using
> argumentless "git reset" to reset the index during a merge.

If the only reason somebody might want to "reset --mixed" is to make
the next "git diff" behave as if it were "git diff HEAD", I would be
willing to say that we should:

 - start warning against "reset" (no mode specifier) and "reset --mixed"
   when the index is unmerged *and* MERGE_HEAD exists; and then

 - after a few releases start erroring out when such a "reset" is
   given; and then

 - use this patch to intelligently choose the default mode.

Another downside of "reset --mixed" during a conflicted merge (or
other mergy operations, e.g. "am -3") is that new files are left in
the working tree, making the next attempt to redo the mergy
operation immediately fail until you remove them, so in practice,
the only mode I'd use with a conflicted index (be it from a
conflicted merge or any other mergy operation) is "reset --hard".

So forbidding "reset --mixed" when the index is unmerged (even when
there is no MERGE_HEAD) may be a good idea in the long run.
