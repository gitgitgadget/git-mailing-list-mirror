From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/7] diff_tree(): Skip skip_uninteresting() when all
 remaining paths interesting
Date: Wed, 25 Aug 2010 20:49:11 -0700
Message-ID: <7voccqnidk.fsf@alter.siamese.dyndns.org>
References: <1282704795-29661-1-git-send-email-newren@gmail.com>
 <1282704795-29661-6-git-send-email-newren@gmail.com>
 <7v1v9mp95o.fsf@alter.siamese.dyndns.org>
 <AANLkTi=Z0nZ7dPqZisPkbpGUBvoFbu9UVxkMq0hucGGg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 26 05:49:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OoTSw-0006YT-0q
	for gcvg-git-2@lo.gmane.org; Thu, 26 Aug 2010 05:49:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752686Ab0HZDtU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Aug 2010 23:49:20 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:36087 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751771Ab0HZDtT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Aug 2010 23:49:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1C82ED0C3A;
	Wed, 25 Aug 2010 23:49:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QHDBvgPau0tGugkGaq1sYV+Ye70=; b=KiPDX9
	m5CKz9tKJO5RMU3/ORMbXSFXdCJ5GKjWwBHPqVqlvSAGymWj5lt7RCYyVkUPHKo5
	/xAKLk9zlcOBK4og31sIC3pOuVv5F60kd4lvn7yRle4pCvPADVEMrOjmHeggBvoG
	JFM5u9BlfXCQ2UX4wW8mAdSJzr3SYkdrDhmYE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PmrmJj7T1uVKUJyABZmNvKrO2oafbWLy
	ukf3qxIVLQ0O3cmuxHjisrilRB+MgKD/jeTShUM3I9pSxRdpDZC2BoIQJFfvF6dW
	26TfGY2jBIw6pl3qXflKmnm7qSGEAhEths8Jtfkl6VXARIJXLsHP3myfajMWU0sW
	1pe2PdoR6hE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E66DBD0C39;
	Wed, 25 Aug 2010 23:49:15 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 36702D0C38; Wed, 25 Aug
 2010 23:49:13 -0400 (EDT)
In-Reply-To: <AANLkTi=Z0nZ7dPqZisPkbpGUBvoFbu9UVxkMq0hucGGg@mail.gmail.com>
 (Elijah Newren's message of "Wed\, 25 Aug 2010 17\:57\:06 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E5C1AB56-B0C4-11DF-94BD-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154504>

Elijah Newren <newren@gmail.com> writes:

> ...  I don't think
> supporting this would hurt anyone, as I don't think anyone could
> accidentally use it at this point.

I agree 100%.  There is no harm in doing what the user asks us to do, so
producing list of objects that is path limited is fine [*1*].

After all, you can feed any random set of object names to pack-objects and
use the resulting pack as a way to sneakernet just a random set of objects
without any connectivity guarantee even today.

Also, since it is unlikely anybody would accidentally use the combination,
it wouldn't make much sense to retroactively add a sanity check that
errors out either, as that needs to be lifted later when you two are done.


[Footnote]

*1* As long as it is done correctly, of course.  Watch out for a case like
the same blob that is outside the pathspec (marked as "uninteresting")
appears inside (needs to be sent), i.e.

    mkdir two
    echo frotz >one
    cp one two/three
    git add one two/three
    git commit -m that
    git rev-list --objects two

which _should_ show the blob that records "frotz\n" because it appears at
"two/three" which is in the area, even though you happen to have the same
one at a path outside (i.e. "one").
