From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG-ish] diff compaction heuristic false positive
Date: Fri, 10 Jun 2016 08:56:41 -0700
Message-ID: <xmqqvb1hf35y.fsf@gitster.mtv.corp.google.com>
References: <20160610075043.GA13411@sigill.intra.peff.net>
	<20160610083102.GA14192@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>,
	Jacob Keller <jacob.keller@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jun 10 17:56:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bBOni-0004pn-2B
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jun 2016 17:56:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933177AbcFJP4p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jun 2016 11:56:45 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52883 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932214AbcFJP4p (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jun 2016 11:56:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id BE40822060;
	Fri, 10 Jun 2016 11:56:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9++1KmM8p3mTP9OH80TULLtbbz4=; b=ePgBaY
	etSEaiVTttNKbel04Z5xy0GOpGW5FS+/PLwsRKhcoiARsSse+6TZJBZVA0OE+BYJ
	R8dl+hQXRNDABdMg2mObnZEVOUcQzcIa02eDSw1YzOzjh9d5g/toeagqDTKjX09C
	+Kx/mCQLX5m5Lj/fRDDNaSg01EjldfC4eKBis=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=e7k3Q9iJS3dkM/SCa4kCg95E86nMXvm6
	vTOoF6xjmE3qIhaHYRZbJzDndz1hqoWcYx+7EGbZIBwXfj9pMS5TV3q88KMJgwhu
	a2yWIjeQpIGhCc+HSSu0HHMNMQjuQzRFCCnnRdLIs88Npgc8GYQSW5X9LVNpjywz
	TBqMq0YSmDs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id B5FD52205F;
	Fri, 10 Jun 2016 11:56:43 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3E0232205E;
	Fri, 10 Jun 2016 11:56:43 -0400 (EDT)
In-Reply-To: <20160610083102.GA14192@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 10 Jun 2016 04:31:02 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: ED480274-2F23-11E6-92B8-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297009>

Jeff King <peff@peff.net> writes:

> On Fri, Jun 10, 2016 at 03:50:43AM -0400, Jeff King wrote:
>
>> I found a false positive with the new compaction heuristic in v2.9:
>> [...]
>
> And by the way, this is less "hey neat, I found a case" and more "wow,
> this is a lot worse than I thought".
>
> I diffed the old and new output for the top 10,000 commits in this
> particular ruby code base. There were 45 commits with changed diffs.
> Spot-checking them manually, a little over 1/3 of them featured this bad
> pattern. The others looked like strict improvements.
>
> That's a lot worse than the outcomes we saw on other code bases earlier.
> 1/3 bad is still a net improvement, so I dunno. Is this worth worrying
> about? Should we bring back the documentation for the knob to disable
> it? Should we consider making it tunable via gitattributes?
>
> I don't think that last one really helps; the good cases _and_ the bad
> ones are both in ruby code (though certainly the C code we looked at
> earlier was all good).
>
> It may also be possible to make it Just Work by using extra information
> like indentation. I haven't thought hard enough about that to say.
>
> -Peff

I recall saying "we'd end up being better in some and worse in
others" at the very beginning.  How about toggling the default back
for the upcoming release, keeping the experimentation knob in the
code, and try different heuristics like the "indentation" during the
next cycle?
