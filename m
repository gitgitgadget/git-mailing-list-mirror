From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] submodule--helper: initial clone learns retry logic
Date: Thu, 09 Jun 2016 12:59:08 -0700
Message-ID: <xmqqtwh2gmlv.fsf@gitster.mtv.corp.google.com>
References: <20160609190637.21177-1-sbeller@google.com>
	<20160609190637.21177-2-sbeller@google.com>
	<xmqqy46egofw.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kbpurbwAB4H5_JPMsaGHmbeZA=EWjMOfQGB6apLhEXVeA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Jun 09 21:59:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bB66n-00072z-0Q
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jun 2016 21:59:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751108AbcFIT7N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jun 2016 15:59:13 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51276 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750751AbcFIT7M (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jun 2016 15:59:12 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E794B22355;
	Thu,  9 Jun 2016 15:59:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Z1ZVhJxfq3V1nf96jFOoENrCpHw=; b=aOCHY2
	OU1K8fKJFanBSta/EWwKVl16tllFX5Ltj3IXXrTGiHDyKOeaJYZAIC7/+Gv7RutK
	v/3nyUsyMgA5fjdpGDl6X4+wb3nUkjb6If+mSWysbcfT2CxbgWohy9AltdQ/IdOw
	BYZqoYI46sjrEbRJ0pG5ZmsODT8r5nH0bLOj8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PYvoru6ZPjft8rt1O3B7MCX5itu7F+Lu
	2VIn4ZnBruZCFbvaVE6cCz50QCSECdHXvVWaAQm1NR9U82GFbLbZ+s3Pga+yo/yw
	WI9I0Z4ZmGt2oI95e1xrnJLums11+LHQc3OgmtVhYTTBaDFDXoE2qLYW0Mpt+jj9
	l78xT5kA5Dg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DF58422354;
	Thu,  9 Jun 2016 15:59:10 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 66CBB22353;
	Thu,  9 Jun 2016 15:59:10 -0400 (EDT)
In-Reply-To: <CAGZ79kbpurbwAB4H5_JPMsaGHmbeZA=EWjMOfQGB6apLhEXVeA@mail.gmail.com>
	(Stefan Beller's message of "Thu, 9 Jun 2016 12:47:40 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A1A7BFFA-2E7C-11E6-8A65-89D312518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296922>

Stefan Beller <sbeller@google.com> writes:

> instead. But that is still unspecified, so we rather go with
>
> static int compare_ce(const void *one, const void *two, void *cb_data)
> {
>     const struct cache_entry *ce_one = one, *ce_two = two;
>     return strcmp(ce_one->name, ce_two->name);
> }

As I said below, I do not think it is worth addressing by making the
code's behaviour on real systems worse.  As long as what you have as
the key into priority queue is a pointer to cache_entry, you cannot
make it better from that point of view.

>> I think we have one or two other instances of such fishy pointer
>> comparison already in the codebase, so it is not a show-stopper, but
>> it would be better if this can be avoided and be replaced with
>> something that I do not have to raise eyebrows at ;-)

If you are using priority queue, it probably would make more sense
to use the "priority" part properly---the paths whose ce happens to
be lower in the address space are not inherently more important and
deserve to be processed sooner.  From "let's retry failed ones after
finishing", I expected that the queue was either fifo (simplest), or
a prio queue whose priority function would give lower priority for
entries with least number of previous attempts (more involved but
probably more fair).

So a proper "fix" probably is either (1) not to use prio queue as
you are not doing anything with priority anyway, or (2) use
something other than ce itself as entries in prio queue, so that the
priority function can be computation that is more meaningful than
"happens to sit in the lower part of the address space".
