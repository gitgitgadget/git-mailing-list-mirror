From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/17] Remove assumptions about refname lifetimes
Date: Tue, 21 May 2013 11:39:14 -0700
Message-ID: <7v7gisnpnx.fsf@alter.siamese.dyndns.org>
References: <1368995232-11042-1-git-send-email-mhagger@alum.mit.edu>
	<CALKQrgfpAqWESDrjE5po+XPvK+xft=PVwDXr3E7BU28jdDRcZA@mail.gmail.com>
	<7vfvxhwqt1.fsf@alter.siamese.dyndns.org>
	<CALKQrgd3=5Rb5wbDGTV7PQfcingimYf08yEHcbfSCkjGDUU_Ng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Tue May 21 20:39:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UerT0-0006py-FN
	for gcvg-git-2@plane.gmane.org; Tue, 21 May 2013 20:39:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752265Ab3EUSjS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 May 2013 14:39:18 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45640 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751764Ab3EUSjR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 May 2013 14:39:17 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5F78D2034B;
	Tue, 21 May 2013 18:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WFy+E5gwVm3Sz6ubBtzRFBe/mdo=; b=Vn7apx
	4bNnykr43ZhaZCxa41Mp15JWXaRwl6Ho25B+QQWd9G3ab1QN4iLltVjvfCl+HKsz
	rJKq/OflHYnRI/c8j7o6dJIcDBSJxBBau2h+OyTWZWydRDRVdygfjHgO4swMGPFS
	MRuMuQvxBhHIcaTkXTkbB5/eWRSVqewd/OEAk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DizTNsDbzoJnE8dvBdAsLVDl11exKLRf
	groM0xy4w/JA3XlQJZCeSz8jgk3SzOJ8smReszW3IeJ4id0LtQOqc3wuIvAkBl3m
	Hv1oRkw9YxYSL6Z2+yQaLY5mCowBto7cB+uUb0uBAkrOtqb0RHwyzqu0vL00vOsH
	BA8pflGmp3M=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 56B7820349;
	Tue, 21 May 2013 18:39:16 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id ABD7120347;
	Tue, 21 May 2013 18:39:15 +0000 (UTC)
In-Reply-To: <CALKQrgd3=5Rb5wbDGTV7PQfcingimYf08yEHcbfSCkjGDUU_Ng@mail.gmail.com>
	(Johan Herland's message of "Mon, 20 May 2013 19:03:52 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BD303168-C245-11E2-93D2-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225064>

Johan Herland <johan@herland.net> writes:

> On Mon, May 20, 2013 at 6:37 PM, Junio C Hamano <gitster@pobox.com> wrote:
> ...
>> That "backing out" can be made more intelligently than just dying
>> with "compare and swap failed--please retry" message, e.g. you at
>> that point notice what you started with, what the other party did
>> while you were working on (i.e. updating refs/tags/), and three-way
>> merge the refs tree, and in cases where "all refs recorded as loose
>> refs" scheme wouldn't have resulted in problematic conflict, such a
>> three-way merge would resolve trivially (you updated refs/heads/ and
>> the update by the other process to refs/tags/ would not conflict
>> with what you did).  But the same three-way merge scheme can be
>> employed with the current flat single packed-refs scheme, can't it?
>
> Yes. (albeit without reusing the machinery we already have for doing
> three-way merges)

I do not think that is relevant, as you do *not* want to reuse the
usual three-way xdiff merge machinery that leaves "<=>" markers for
this usage anyway.

But that is not the primary reason why I am beating this dead horse;
it is the following.

Your version of packed-refs file, and his version of packed-refs
file, and the original you started with, are all sorted in a known
order.  You just look at lines from all and merge them line by line.

I think that logic should become a new blob-level merge driver that
can be reused for normal in-working-tree objects that are sorted.
For that kind of "sorted wordlist" file, conflicts that may
artificially arise only because two sides updated adjacent lines in
the list and you used the normal xdiff merge machinery is unwanted,
and users would benefit by having such a specialized merge driver
outside the context of merging two proposed list of refs.
