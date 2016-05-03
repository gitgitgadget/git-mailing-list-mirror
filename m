From: Junio C Hamano <gitster@pobox.com>
Subject: Re: avoid duplicate patches from git log ?
Date: Tue, 03 May 2016 15:12:13 -0700
Message-ID: <xmqqbn4mlrk2.fsf@gitster.mtv.corp.google.com>
References: <712E44CFAD1A41A982AEF1540C1F9F80@PhilipOakley>
	<20160503220039.GB25133@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Philip Oakley <philipoakley@iee.org>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed May 04 00:12:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axiYJ-0007cx-3O
	for gcvg-git-2@plane.gmane.org; Wed, 04 May 2016 00:12:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756593AbcECWMR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 May 2016 18:12:17 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61707 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756527AbcECWMQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2016 18:12:16 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 42BD919CE4;
	Tue,  3 May 2016 18:12:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ESSGtb/MXgDKAiDALXeK4eqQVIs=; b=jYqJfw
	DQQSRLNCHbfW9Y2W2Tv+EL/XnErvh7a0LCw+8OIQ51T7SoJXZjwcETj+aaF1JDa0
	gaxezMfZCGnJKZzqy2XnC9qzsRBq5ERWqRqhljflNeFBorZLZbK0kasiQg3kRhlv
	DgQ+cxZJhepnzQoGVowQ0WRJaR2bXgrLxjBgg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mLtOR6mduh2zGhigQCgSrHdZgoqd6aXu
	za+ovAanSsuqVX80Sif9tQfn1/Cq4BKYOS3/r+OkDhErCcT5jWhVe3lwDbPsQvjm
	OfMMd86bkYu6bWISv49HJ2FcMMSO/A2mITrt9UDOvp1Rpx4DNHVkoaDzUMc5H7y8
	MnY5p4i01Ic=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3AABB19CE3;
	Tue,  3 May 2016 18:12:15 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9BBBB19CE2;
	Tue,  3 May 2016 18:12:14 -0400 (EDT)
In-Reply-To: <20160503220039.GB25133@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 3 May 2016 18:00:39 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1755E132-117C-11E6-B707-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293466>

Jeff King <peff@peff.net> writes:

> On Tue, May 03, 2016 at 09:11:55PM +0100, Philip Oakley wrote:
>
>> However, as the G4W project (https://github.com/git-for-windows/git/)
>> follows the main git repo and its releases, it needs to rebase it's fixup
>> patches, while retaining their original series, so has repeated copies of
>> those fix patches on the second parent path (a technique Dscho called
>> rebasing merges).
>> 
>> for example:
>> > bf1a7ff (MinGW: disable CRT command line globbing, 2011-01-07)
>> > a05e9a8 (MinGW: disable CRT command line globbing, 2011-01-07)
>> > 45cfa35 (MinGW: disable CRT command line globbing, 2011-01-07)
>> > 1d35390 (MinGW: disable CRT command line globbing, 2011-01-07)
>> > 022e029 (MinGW: disable CRT command line globbing, 2011-01-07)
>> 
>> 
>> How can I filter out all the duplicate patches which are identical other
>> than the commit date?
>> 
>> The --left --right and --cherry don't appear to do what I'd expect/hope. Any
>> suggestions?
>
> I don't think there's a good way right now. The option that suppresses
> commits is --cherry-pick, but it wants there to be a "left" and "right"
> from a symmetric difference, and to cull duplicates from the various
> sides.
>
> I think you really just want to keep a running list of all of the
> commits you've seen and cull any duplicates. I guess you'd want this as
> part of the history simplification step, so that whole uninteresting
> side-branches are culled.
>
> The obvious choice for matching two commits is patch-id, though it can
> be expensive to generate. There have been patches playing around with
> caching in the past, but nothing merged. For your purposes, I suspect
> matching an "(author, authordate, subject)" tuple would be sufficient
> and fast.

What would be really interesting is what should happen when the side
"rebase merge" branch that is supposed to be irrelevant for the
purpose of explaining the overall history does not become empty
after such filtering operation.  The merge commit itself may claim
that both branches are equivalent, but in reality it may turn out
that the merge failed to reflect the effect of some other changes in
the history of the side branch in the result--which would be a
ticking time-bomb for future mismerges waiting to happen.
