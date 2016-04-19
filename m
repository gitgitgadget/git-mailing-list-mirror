From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC 4/6] transport: add refspec list parameters to functions
Date: Tue, 19 Apr 2016 13:55:11 -0700
Message-ID: <xmqqlh49z5cg.fsf@gitster.mtv.corp.google.com>
References: <1460747949-3514-1-git-send-email-dturner@twopensource.com>
	<1460747949-3514-5-git-send-email-dturner@twopensource.com>
	<xmqqa8kq69i5.fsf@gitster.mtv.corp.google.com>
	<20160419071403.GA22577@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: David Turner <dturner@twopensource.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Apr 19 22:55:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ascg9-0000F4-0E
	for gcvg-git-2@plane.gmane.org; Tue, 19 Apr 2016 22:55:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932834AbcDSUzV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Apr 2016 16:55:21 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60319 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754482AbcDSUzU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2016 16:55:20 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7F34714EB2;
	Tue, 19 Apr 2016 16:55:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Y7uf1MPh+BvtHVgRurqgeq+BPjU=; b=A5b6Yg
	w3/QSlnoQxvUYg9H18G4zuJu9A/S5JSbOyjqC+MhoPsHZF8/Q00w8PPIpfh1aY8n
	Lx0/0u1AWnr7lbgzNSEI0e4ayxlQUah8btXK4HNOmWfU4Mtz3C+ZKj1TRzow2075
	zp4i//aaApHe/3kSmstKkvXOSmTr9wsTO1PBs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VT/IRb/7ET4TpCBIHBmCQiZRuoUbJupu
	/VpqoDp5NC9BoF9WT6IpJNcZpIRk3AugszB1DHDVhScyrmaL/2VIkzV0hFnBmW68
	MiD1hpZ3BKmG6PY9XdQQr/Y3ptyh+cMK9JIXFuAR2hslx7sXxKLvoje7iiONuYx2
	MLstZh6H74w=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7694A14EB1;
	Tue, 19 Apr 2016 16:55:13 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DE79E14EB0;
	Tue, 19 Apr 2016 16:55:12 -0400 (EDT)
In-Reply-To: <20160419071403.GA22577@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 19 Apr 2016 03:14:03 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 02CA0AE2-0671-11E6-8CC3-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291925>

Jeff King <peff@peff.net> writes:

>> What the code tries to do I am more than halfway happy.  It is
>> unfortunate that we cannot do this natively without upgrading the
>> protocol in a fundamental way, but this is a nice way to work it
>> around only for Git-over-HTTP transport without having to break the
>> protocol.
>
> I dunno, I am a bit negative on bringing new features to Git-over-HTTP
> (which is already less efficient than the other protocols!) without any
> plan for supporting them in the other protocols.
>
> I thought Stefan's v2 protocol work looked quite good, but it seems to
> have stalled. The hardest part of that topic is figuring out the upgrade
> path. But for git-over-http, we can solve that in the same way that
> David is passing in the extra refspecs.

Yeah, I had the same feeling.

> So I'd rather see something like:
>
>   1. Support for v2 "capabilities only" initial negotiation, followed
>      by ref advertisement.
>
>   2. Support for refspec-limiting capability.
>
>   3. HTTP-only option from client to trigger v2 on the server.

I like that; reducing the initial scope of v2 so that we can do this
new feature as its first use case would be a good way to move things
forward.

> That's still HTTP-specific, but it has a clear path for converging with
> the ssh and git protocols eventually, rather than having to support
> magic out-of-band capabilities forever.
>
> It does require an extra round of HTTP request/response, though.

Yes.  And as we discussed before, we can do "upload-pack" that
advertises "by the way, upload-pack-v2 is available next to me" and
a separate "upload-pack-v2" that talks v2 (i.e. its initial message
is limited to capabilities and nothing else) would probably be a
sufficient migration path for native protocol.

        
