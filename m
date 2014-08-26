From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Check order when reading index
Date: Tue, 26 Aug 2014 10:43:21 -0700
Message-ID: <xmqqy4ubi1ty.fsf@gitster.dls.corp.google.com>
References: <xmqq38cpsmli.fsf@gitster.dls.corp.google.com>
	<1408903047-8302-1-git-send-email-jsorianopastor@gmail.com>
	<xmqqvbpgmqmh.fsf@gitster.dls.corp.google.com>
	<20140825194430.GI30953@peff.net>
	<CAPc5daW-ZckFfhyueNLnPaBeriAmCUVJjFc1cw0O5iRi8F+Kng@mail.gmail.com>
	<CAPuZ2NHafXQthtuq-RnTvpjVfNPaXHEy8SejuhPEnG+MwCK=sg@mail.gmail.com>
	<20140826122008.GC29180@peff.net>
	<xmqqmwarjiq7.fsf@gitster.dls.corp.google.com>
	<CAPuZ2NGTQoKnSfeN2zte5=fqswN5PcfAULdFy9WnGWPtc2Zskg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
To: Jaime Soriano Pastor <jsorianopastor@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 26 19:43:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMKmO-0003dq-0c
	for gcvg-git-2@plane.gmane.org; Tue, 26 Aug 2014 19:43:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752950AbaHZRnc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2014 13:43:32 -0400
Received: from smtp.pobox.com ([208.72.237.35]:62439 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751592AbaHZRnb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2014 13:43:31 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 02F1C324C5;
	Tue, 26 Aug 2014 13:43:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/3Ik1SV2dXFiYJ9uJpCYwAmVNfo=; b=GOmZ2v
	ENhatvr+r9Qc+RR8D0nRQxy6Na5wwmOxTN9/pfNhFemnJQu2LD5C7QaGGRkBLis1
	kNPBYbk53e8l3D60JI733ajWZAJOe9Uo/YL2vinVKBlPIvsxsbHSbiMVeOmbVWaP
	8mqDAbJehx14ezBdK60/mWciQ1vqAceJhv6lo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=axF4CjO4XoDTQuZXVcgYYAEUXFtjFATs
	GB0ItebII8BoKXXL1YcHLFqVen7CGBKqqPkUna4iOj9gkalmcJ/epYDisch9Jrr4
	aOZmShn4gDP0lND4PLte8zkTJHuMMf0YO5Wj9GAtTwnzhyhUYVffaASEkXQOzclV
	gpr9t5/f6pA=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id EDE00324C4;
	Tue, 26 Aug 2014 13:43:30 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id E4C6F324B6;
	Tue, 26 Aug 2014 13:43:22 -0400 (EDT)
In-Reply-To: <CAPuZ2NGTQoKnSfeN2zte5=fqswN5PcfAULdFy9WnGWPtc2Zskg@mail.gmail.com>
	(Jaime Soriano Pastor's message of "Tue, 26 Aug 2014 19:22:30 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 79A16C7C-2D48-11E4-93F3-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255928>

Jaime Soriano Pastor <jsorianopastor@gmail.com> writes:

> On Tue, Aug 26, 2014 at 6:53 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Yes---that is what I meant by the "virtual stuff".  Unlike resolve
>> work by Daniel (around Sep 2005 $gmane/8088) that tried to use
>> multiple ancestors directly in a single merge, recursive limits
>> itself to repeated use of pairwise merges.
>
> Ok, I see now. Then what about checking also in check_ce_order() that
> only stage #1 can be repeated?

We could use multiple stage #3 entries to natively represent an
octopus merge in progress if we wanted to.  I do not think we want
to close the door for doing so, unless there is some compelling
reason.

Does the current codebase choke with such entries in the index file,
like you saw in your index file with both stage #0 and stage #1
entries?
