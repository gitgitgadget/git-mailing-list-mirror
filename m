From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/6] fetch-pack: fix deepen shallow over smart http with no-done cap
Date: Mon, 10 Feb 2014 10:18:52 -0800
Message-ID: <xmqq1tzau8z7.fsf@gitster.dls.corp.google.com>
References: <1391699439-22781-1-git-send-email-pclouds@gmail.com>
	<1391699439-22781-7-git-send-email-pclouds@gmail.com>
	<xmqqppmyvm3f.fsf@gitster.dls.corp.google.com>
	<20140207233906.GA5791@lanh>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 10 19:19:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WCvRg-0001Sr-N8
	for gcvg-git-2@plane.gmane.org; Mon, 10 Feb 2014 19:19:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752960AbaBJSTA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Feb 2014 13:19:00 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65051 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752238AbaBJSS6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Feb 2014 13:18:58 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3156E69CA5;
	Mon, 10 Feb 2014 13:18:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TuT1c5rlc5OTt+gMEcLNQG67ptU=; b=muykN4
	/+sOa95o0JM8FjbDVkcRFcNMY8Cp7TOtmNSE9q2lSwTnzpj4TNeIF3HZ61tRzAV4
	ILhDIIEZrwkWfm93FxWvJxXbz30ns6cmbeaH5rqWj6zOfJYbTq2BtM8UKw5cb/rz
	8TrfO8WhUgaBVOm/4+qBe9IxzwxPRpGQdNXqA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lIm7MFVaeXtr2dbPW08N6GOP2qEfE11Y
	eudYT30yGART8F5xioalzREo7HBGqoLmrDZAqGANGRPy1cBFCiEUsXWmlSMsFynA
	yzDJrAr576o9lBnBR9U+ZQnta+RspHCVju16J6KCeOcdQ9SqtBSkDbQ6Bejm/gTw
	uIpDRvS4BTI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 02D2D69CA2;
	Mon, 10 Feb 2014 13:18:58 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8B88C69C9A;
	Mon, 10 Feb 2014 13:18:55 -0500 (EST)
In-Reply-To: <20140207233906.GA5791@lanh> (Duy Nguyen's message of "Sat, 8 Feb
	2014 06:39:06 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: CD66B8D0-927F-11E3-B7E5-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241918>

Duy Nguyen <pclouds@gmail.com> writes:

> On Fri, Feb 07, 2014 at 10:01:08AM -0800, Junio C Hamano wrote:
>> Here is the difference between the posted series and what I queued
>> after applying the changes suggested during the review.
>> 
>> Thanks.
>
> I was going to send a reroll after the received comments. Could you
> put this on top of 6/6, just to make sure future changes in t5537
> (maybe more or less commits created..) does not change the test
> behavior?
>
> It fixes the test name too. I originally thought, ok let's create
> commits in one test and do fetch in another. But it ended up in the
> same test and I forgot to update test name.

Surely, and thanks for being careful.  Will squash it in.


> -- 8< --
> diff --git a/t/t5537-fetch-shallow.sh b/t/t5537-fetch-shallow.sh
> index 1413caf..b300383 100755
> --- a/t/t5537-fetch-shallow.sh
> +++ b/t/t5537-fetch-shallow.sh
> @@ -203,7 +203,7 @@ EOF
>  # This test is tricky. We need large enough "have"s that fetch-pack
>  # will put pkt-flush in between. Then we need a "have" the server
>  # does not have, it'll send "ACK %s ready"
> -test_expect_success 'add more commits' '
> +test_expect_success 'no shallow lines after receiving ACK ready' '
>  	(
>  		cd shallow &&
>  		for i in $(test_seq 10)
> @@ -224,7 +224,9 @@ test_expect_success 'add more commits' '
>  		cd clone &&
>  		git checkout --orphan newnew &&
>  		test_commit new-too &&
> -		git fetch --depth=2
> +		GIT_TRACE_PACKET="$TRASH_DIRECTORY/trace" git fetch --depth=2 &&
> +		grep "fetch-pack< ACK .* ready" ../trace &&
> +		! grep "fetch-pack> done" ../trace
>  	)
>  '
>  
> -- 8< -- 
