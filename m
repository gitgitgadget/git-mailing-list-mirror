From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] redundant error message
Date: Thu, 05 Dec 2013 12:15:07 -0800
Message-ID: <xmqqfvq73vhw.fsf@gitster.dls.corp.google.com>
References: <CACsJy8BtCi_QSMZXfnscQmRyjvgSV1fG6smAOoCSab_e2YATxQ@mail.gmail.com>
	<20131205191518.GB19039@sigill.intra.peff.net>
	<xmqqsiu73w6n.fsf@gitster.dls.corp.google.com>
	<20131205200306.GA13443@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Dec 05 21:15:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VofKR-00050E-Pm
	for gcvg-git-2@plane.gmane.org; Thu, 05 Dec 2013 21:15:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752632Ab3LEUPP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Dec 2013 15:15:15 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50512 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752508Ab3LEUPO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Dec 2013 15:15:14 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4E03758B11;
	Thu,  5 Dec 2013 15:15:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=J6ZIxhY4GMs66hcMhjv8QnjYI7I=; b=VFcUds
	B1p/AMUuYYlVC0IaAqU0kO7FsatzZdJXH7JFrinc7RgVE00TK2FUPQln7gDa8pds
	ORme8uFnfPirEscGiSXHV5HLjsCD5f7D6NTkji4b+W4u2FAWrp4QiBRiVgvwB2jU
	EDQ6mbSYgOEWDvD+m4OeMVMUyTN6tkc4pzXB8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GbFuonWs7kmsOQjMb+A8tXsbRURKETy+
	vMzk+pp56E6LIX5Ew/0zfLawOROCN8ke+MDFZt3JSS8R3CEdCRu48swSnOoyu7YI
	68viKEgcAewGw2pBQPr2yDT9Mo8vOGgt24I5JRpd9+nGNkOAYVPJmTVwF1YYCF5g
	XEfkZMw89Z4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 373D758B0F;
	Thu,  5 Dec 2013 15:15:13 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 42D4758B0B;
	Thu,  5 Dec 2013 15:15:12 -0500 (EST)
In-Reply-To: <20131205200306.GA13443@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 5 Dec 2013 15:03:06 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: F22982E4-5DE9-11E3-A9B1-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238908>

Jeff King <peff@peff.net> writes:

> On Thu, Dec 05, 2013 at 12:00:16PM -0800, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>> 
>> >   $ >foobar
>> >   $ git rev-parse foobar --
>> >   foobar
>> >   --
>> >   fatal: bad flag '--' used after filename
>> >
>> > That's not right.
>> 
>> Hmph, it looks like it is following the usual "zero-or-more dashed
>> options, zero-or-more revs and then zero-or-one double-dash and then
>> zero-or-more paths" rule to parse the thing.  "foobar" is a file and
>> not a rev, so "--" should not be there, no?
>> 
>> Confused why you think it is not right...
>
> Because once you say "--", then all ambiguity goes away, no?

But it is tricky (not from implementation but from semantics point
of view) to make rev-parse follow that "-- separates revs and paths"
rule literally.  The primary use of rev-parse is to convert revs in
extended SHA-1 expressions into concrete object names, so that
scripts do not have to worry about having to deal with object names
in a format that is not 40-hexdecimal.  "git rev-parse foobar --"
that gives

	foobar
        --

without any error, because 'foobar' cannot be made into an object
name, would be behaving in a way unexpected by the calling script,
no?
