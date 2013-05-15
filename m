From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Lines missing from git diff-tree -p -c output?
Date: Wed, 15 May 2013 10:48:21 -0700
Message-ID: <7v4ne4cexm.fsf@alter.siamese.dyndns.org>
References: <20130515143508.GO25742@login.drsnuggles.stderr.nl>
	<7vhai4cgco.fsf@alter.siamese.dyndns.org>
	<20130515173312.GR25742@login.drsnuggles.stderr.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthijs Kooijman <matthijs@stdin.nl>
X-From: git-owner@vger.kernel.org Wed May 15 19:48:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcfoT-000673-Os
	for gcvg-git-2@plane.gmane.org; Wed, 15 May 2013 19:48:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759803Ab3EORsZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 May 2013 13:48:25 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44204 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759723Ab3EORsY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 May 2013 13:48:24 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 98C581FC88;
	Wed, 15 May 2013 17:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DR3pW+PEMpfHBT7qybtsbAj8bL0=; b=IG3uUD
	OzqwvZmvEPrhZaIKCR2jl2TTTRS4I9tfDeZlSDWb8JF6nQ7fJtmkKTuzsY+yQEc7
	bKpH9BWmCmtJbpGpl9612lsVyAGhQ53BlQLfOPu/yGnybs/BuSZeyuXceKFXKxJR
	oUJcWpyyx65L6o1/vH9jkB3/3qpJOOn5nk86c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=v/ByPR/TSys/SnBdiFZTLbi2dW4a+Qtp
	WxIuwtLapnGG4bKxjGT0mbcMt6Su1rVJ5WBmU9UT0NnrI78oIdid6gvVPY1lMB/m
	eANcOwW79Nt+X3UyxeeRTPXR1ECnqXYBBRfCG1MHjEefruTqkbD6s14yFbbYBSzL
	gteTxXbhecM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8C7CC1FC87;
	Wed, 15 May 2013 17:48:23 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DEEA81FC85;
	Wed, 15 May 2013 17:48:22 +0000 (UTC)
In-Reply-To: <20130515173312.GR25742@login.drsnuggles.stderr.nl> (Matthijs
	Kooijman's message of "Wed, 15 May 2013 19:33:12 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A31AF56E-BD87-11E2-ADEE-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224431>

Matthijs Kooijman <matthijs@stdin.nl> writes:

> Hi Junio,
>
>> I think the coalescing of two adjacent hunks into one is painting
>> leading lines "interesting to show context but not worth showing
>> deletion before it" incorrectly.
> Yup, that seems to be the case.
>
>> Does this patch fix the issue?
>
> Yes, it fixes the issue. However, I think that this patch actually hides
> the real problem (in a way that will always work with the current code,
> though).

Could you explain why you think it hides the real problem, and what
kind of future enhancement may break it?

This is *not* my usual rhetorical question "Please explain yourself,
because I think you are wrong", but is "I do not understand the
reasoning behind your statement, and I (and the reasoning behind my
patch) must be missing something important, so please enlighten me
by pointing out where I am wrong, so that I won't stick to my flawed
patch".

The painting with no_pre_delete is applied when we extend the common
context back to lines we _know_ otherwise not worth showing (because
there is no difference) only because we want to show them as the
context lines and we do not need to show deletions that come before
these common context.  By forcing (k == j + context) case, that is,
there are exactly "context" number of lines between the end of the
current hunk and the next hunk, which the old code would have showed
"context" lines at the beginning of the next hunk, to go back to the
"again" label, we are coalescing the two hunks that _should_ have
been shown together anyway, without painting the context lines
incorrectly with "before this line, do not show deletion" mark.

> I had come up with a different fix myself (similar to the one I sent to
> the list as a followup, but that one still had a bug), which I think
> might be better. In any case, it includes a testcase for this bug which
> seems good to include.
>
> I'll send my patch as a followup in a minute, feel free to use it
> entirely or only partially.
>
> Gr.
>
> Matthijs
