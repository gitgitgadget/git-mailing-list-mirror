From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] fetch --prune: Repair branchname DF conflicts
Date: Wed, 18 Dec 2013 22:28:22 -0800
Message-ID: <7vzjnxjqwp.fsf@alter.siamese.dyndns.org>
References: <1387401776-30994-1-git-send-email-jackerran@gmail.com>
	<1387401776-30994-3-git-send-email-jackerran@gmail.com>
	<xmqq4n65hlko.fsf@gitster.dls.corp.google.com>
	<20131219014859.GA32240@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Tom Miller <jackerran@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 19 07:28:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VtX5x-0001ge-Ei
	for gcvg-git-2@plane.gmane.org; Thu, 19 Dec 2013 07:28:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751218Ab3LSG2W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Dec 2013 01:28:22 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51489 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751158Ab3LSG2W (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Dec 2013 01:28:22 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 434045526A;
	Thu, 19 Dec 2013 01:28:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+7E41cyQYESnMX9IytVV0ssZb6A=; b=OMK7/w
	JlmeanltGCe3/y5KiI3nWXdRr5oBuFK8j6nKQRJieRTijGld/EmhEXjyH5TIxIJL
	o053ZbtSFpw6cJEjVM+tXkUJULP/sE4JcGywX+R+XMLDQgs5oOzAEZa7HacqlsOo
	YLY1yNe6NmPDdD4/bLvfK7HW1WcFhfp3g4wEk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lBPJQUIvhBRbz0VI3JeK6TNEJOWdi8LD
	9lUQNoWizddZG3xtvJQDOsifWP1zEECb5ebxZbfiNd8C91pWBEMwm5ht3JOykUZW
	sQfbxzfGZmIb0MQ/cS0N/WNLWMYSaLPRY2h13BwK+COyJx8dWpmna2j2S4+rfMWG
	nbwzaiZcyZA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2B10B55269;
	Thu, 19 Dec 2013 01:28:21 -0500 (EST)
Received: from pobox.com (unknown [198.0.213.178])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3C4A055268;
	Thu, 19 Dec 2013 01:28:20 -0500 (EST)
In-Reply-To: <20131219014859.GA32240@gmail.com> (Tom Miller's message of "Wed,
	18 Dec 2013 19:48:59 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
X-Pobox-Relay-ID: C0DF9BFA-6876-11E3-A264-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239515>

Tom Miller <jackerran@gmail.com> writes:

> The commit below should be the same patch he tested. The test was added
> by him, and I made it part of this commit. Did I do this wrong?

No, no, no.  All my questions were true questions, not complaints
veiled as rhetorical questions.  Thanks for many pointers for
clarification.

>>>> ---
>>>  builtin/fetch.c  | 10 +++++-----
>>>  t/t5510-fetch.sh | 14 ++++++++++++++
>>>  2 files changed, 19 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/builtin/fetch.c b/builtin/fetch.c
>>> index e50b697..845c687 100644
>>> --- a/builtin/fetch.c
>>> +++ b/builtin/fetch.c
>>> @@ -868,11 +868,6 @@ static int do_fetch(struct transport *transport,
>>>
>>>       if (tags == TAGS_DEFAULT && autotags)
>>>               transport_set_option(transport, TRANS_OPT_FOLLOWTAGS, "1");
>>> -     if (fetch_refs(transport, ref_map)) {
>>> -             free_refs(ref_map);
>>> -             retcode = 1;
>>> -             goto cleanup;
>>> -     }
>>>       if (prune) {
>>>               /*
>>>                * We only prune based on refspecs specified
>>> @@ -888,6 +883,11 @@ static int do_fetch(struct transport *transport,
>>>                                  transport->url);
>>>               }
>>>       }
>>> +     if (fetch_refs(transport, ref_map)) {
>>> +             free_refs(ref_map);
>>> +             retcode = 1;
>>> +             goto cleanup;
>>> +     }
>>>       free_refs(ref_map);
>>>
>>>       /* if neither --no-tags nor --tags was specified, do automated tag
>>> diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
>>> index 5d4581d..a981125 100755
>>> --- a/t/t5510-fetch.sh
>>> +++ b/t/t5510-fetch.sh
>>> @@ -614,4 +614,18 @@ test_expect_success 'all boundary commits are excluded' '
>>>       test_bundle_object_count .git/objects/pack/pack-${pack##pack    }.pack 3
>>>  '
>>>
>>> +test_expect_success 'branchname D/F conflict resolved by --prune' '
>>> +     git branch dir/file &&
>>> +     git clone . prune-df-conflict &&
>>> +     git branch -D dir/file &&
>>> +     git branch dir &&
>>> +     (
>>> +             cd prune-df-conflict &&
>>> +             git fetch --prune &&
>>> +             git rev-parse origin/dir >../actual
>>> +     ) &&
>>> +     git rev-parse dir >expect &&
>>> +     test_cmp expect actual
>>> +'
>>> +
>>>  test_done
