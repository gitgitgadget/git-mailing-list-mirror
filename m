From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] builtin/blame.c: large-scale rewrite
Date: Mon, 27 Jan 2014 12:51:33 -0800
Message-ID: <xmqqtxcpno6i.fsf@gitster.dls.corp.google.com>
References: <877g9ocjsk.fsf@fencepost.gnu.org>
	<1390674221-25767-1-git-send-email-dak@gnu.org>
	<1390674221-25767-4-git-send-email-dak@gnu.org>
	<xmqq8uu1pdqq.fsf@gitster.dls.corp.google.com>
	<87a9eh8b0d.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Mon Jan 27 21:51:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W7t9k-0006s3-Nc
	for gcvg-git-2@plane.gmane.org; Mon, 27 Jan 2014 21:51:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754045AbaA0Uvk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Jan 2014 15:51:40 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63142 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753657AbaA0Uvj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jan 2014 15:51:39 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B1D1B67672;
	Mon, 27 Jan 2014 15:51:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=023RT7bIpBZm27R6nCAh69JRTrs=; b=Rp0zwc
	8ZSPM0tkUU9NZZGehvr/RAOUvR+LZqe4tjLNcAvfReE/hM+etvJ3abA9o4Biof20
	leMkJHDjV+6Qy+ZMzLE00unNCgfddDhOvVTXnQbBhvBWLQ+XrZ+X05fT6yw9ojKW
	qDE8dzyzSMPXmfFfQLUsQ3uVw4ZklsJdSxUi0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yTyIo8I32ujSGPmN0CmEhbGeceftgPUt
	i7dUv1P0nq1PMVkAsloqMwoHzD5kMYYHASX27gE4y47zV/hbhoAkm1Hz8Db4BZSA
	7Coy+VT2VZm3FGHpHo7BAyvXjsAICfUF6YOh8c9mTssbGQHTeVnWvohx7kOaY+k+
	cS5ROJ7RaV8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9E74367671;
	Mon, 27 Jan 2014 15:51:38 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AA3996766E;
	Mon, 27 Jan 2014 15:51:37 -0500 (EST)
In-Reply-To: <87a9eh8b0d.fsf@fencepost.gnu.org> (David Kastrup's message of
	"Mon, 27 Jan 2014 20:45:06 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: D0AB5BAE-8794-11E3-95DD-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241156>

David Kastrup <dak@gnu.org> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> David Kastrup <dak@gnu.org> writes:
>>
>>> The previous implementation uses a sorted linear list of struct
>>> blame_entry in a struct scoreboard for organizing all partial or
>>> completed work.  Every task that is done requires going through the
>>> whole list where most entries are not relevant to the task at hand.
>>>
>>> This commit reorganizes the data structures in order to have each
>>> remaining subtask work with its own sorted linear list it can work off
>>> front to back.  Subtasks are organized into "struct origin" chains
>>> hanging off particular commits.  Commits are organized into a priority
>>> queue, processing them in commit date order in order to keep most of
>>> the work affecting a particular blob collated even in the presence of
>>> an extensive merge history.  In that manner, linear searches can be
>>> basically avoided anywhere.  They still are done for identifying one
>>> of multiple analyzed files in a given commit, but the degenerate case
>>> of a single large file being assembled from a multitude of smaller
>>> files in the past is not likely to occur often enough to warrant
>>> special treatment.
>>> ---
>>
>> Sign-off?
>
> Not while this is not fit for merging because of #if 0 etc and missing
> functionality.  This is just for review.

That is not what Signing off a patch means, though ;-)

>> Actually, I'd like to take my previous suggestion to add this as
>> blame2 (to replace blame in the future) back.  That was based on my
>> fear/hope to see an implementation based on a completely different
>> approach, but the basic premise of having one blame_entry record per
>> the lines of the final image in the scoreboard, using diff between
>> parents to the child to find common lines for passing the blame up,
>> etc. have not changed at all and the change is all about organizing
>> the pieces of data in a *much* *better* way to avoid needlessly
>> finding what we already have computed.
>
> Yes.  Basically, the call graph outside of blame.c itself should be
> pretty much the same.
> ...
> Ok.  I'm also certain to have a few "space between function name and
> arguments" left and will grep for those before submitting the next
> version.
>
> Next version will at least include -M option, possibly leaving -C for
> later.

OK.  As we do not want to break the build in the middle of the
series, but we still want to keep the individual steps reviewable
incrementally, I would think the best structure would be have the
series that consists of multiple steps "the basic infrastructure is
there, but no rename following, and neither -M or -C works", "now
renames are followed", "now -M works", etc., with tests that are not
yet working (in the beginning, most of "git blame" test may no
longer work until the series is finished) marked with

    s/test_expect_success/test_expect_failure/

and turn expect_failure into expect_success as the series advances.
That way, we may get a better picture of what each step achieves.  I
dunno.
