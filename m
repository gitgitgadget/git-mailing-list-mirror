From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] RFC/Add documentation for version protocol 2
Date: Wed, 22 Apr 2015 12:19:35 -0700
Message-ID: <xmqqd22wdl88.fsf@gitster.dls.corp.google.com>
References: <1429658342-5295-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, mfick@codeaurora.org, pclouds@gmail.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Apr 22 21:20:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yl0Be-0003uL-3I
	for gcvg-git-2@plane.gmane.org; Wed, 22 Apr 2015 21:19:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965557AbbDVTTq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2015 15:19:46 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:60611 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932382AbbDVTTh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Apr 2015 15:19:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6D2104B020;
	Wed, 22 Apr 2015 15:19:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=m3E8/omjzyJHVtdnv9TJeTWEwpg=; b=Uz1LAo
	6RoG0bgvGOWIn87BrRWci0L3n10fWdTUB43bU6bBhq//oTPV4VJ66eBNWzLFtkdL
	iLTif22XJB8t4AJY0I1e5OfFno4vl96ifSpX6XRaQTOjzPThJQAVxj5Oq1Wc3JQf
	EgpO/uD6rR2ksfBSVYO86qKMcSXoW/wTDD8i4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WPGO4GE3X9PkfmHvgKxH5/e7ZQIJoYoo
	1akTk5GXFH0xHKbi3f0ZZvELRd2Pemor0J2+60T2Jm2FrkY1NK6h3iOVt2GHzczW
	JF2G1LC/jGRF/WCicr1HfxD5fRuZQaO8ycoxaegL/kAZd52mG7i4w63TfULjH9TK
	GHVTFws1vg8=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 653A84B01F;
	Wed, 22 Apr 2015 15:19:37 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DD14D4B01E;
	Wed, 22 Apr 2015 15:19:36 -0400 (EDT)
In-Reply-To: <1429658342-5295-1-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Tue, 21 Apr 2015 16:19:02 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 83EA2B54-E924-11E4-9517-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267615>

Stefan Beller <sbeller@google.com> writes:

> This adds the design document for protocol version 2.
> It's better to rewrite the design document instead of trying to
> squash it into the existing pack-protocol.txt and then differentiating
> between version 1 and 2 all the time.

Just a handful of random thoughts, without expressing agreement or
objection at this point.

> diff --git a/Documentation/technical/pack-protocol-2.txt

I wonder, if we are really revamping, if we want this to be limited
to "pack" protocol (see more below).

> +General structure
> +=================
> +
> +There are four phases involved in the protocol, which are described below:
> +
> +1) capability negotiation
> +2) goal annoncement
> +3) reference advertisement
> +4) pack transfer
> +
> +
> +1) Capability negotiation
> +-------------------------
> +
> +In this phase both client and server send their capabilities to the other side
> +using the following protocol:
> +
> +---
> +list-of-capabilities = *capability flush-pkt
> +capability           =  PKT-LINE(1*(LC_ALPHA / DIGIT / "-" / "_"))
> +----
> +
> +The capabilities itself are described in protocol-capabilities.txt
> +Sending the capabilities to the other side MAY happen concurrently or
> +one after another. There is no order who sends first.

Doesn't that set us up for an easy deadlock (i.e. both sides fill
their outgoing pipe because they are not listening)?

> +2) Goal annoncement
> +-------------------
> +
> +The goal of this phase is for the client to tell the server what
> +outcome it expects from this communication, such as pushing or
> +pulling data from the server.
> +
> +---
> +list-of-goals    = *goal
> +goal             = PKT-LINE(action-line)
> +action-line      = action *(SP action-parameter)
> +action           = "noop" / "ls-remote" / "fetch" / "push" / "fetch-shallow"

This is interesting, in that it implies that you can connect to a
service and after learning what is running on the other hand then
decide you would be fetching or pushing.  Which is *never* be
possible with v1 where you first connect to a specific service that
knows how to handle "fetch".

If we are going in this "in-protocol message switches the service"
route, we should also support "archive" as one of the actions, no?
Yes, I know you named the document "pack-protocol" and "archive"
does not give you packs, but "ls-remote" does not transfer pack data,
either.

And when we add "archive" (and later "refer to bundle on CDN" to
help initial clone), it would become clear that steps #3 and #4 are
optional components that are shared by majority of the protocol
users (i.e. fetch, push, ls-remote uses #3, fetch, push uses #4.),
and other services that also use the protocol need their own
equivalents for steps #3 and #4.

Of course, we do not have to do it this way and stick to "one 'goal'
per service is pre-arranged before the protocol exchange happens,
either via git-daemon or ssh shell command line interactiosn" way of
doing things we have always done in v1 protocol.

I have to wonder what role, if any, should "git daemon" (and its
equivalent, "the shell command line", if the transport is over ssh)
play in this new world order.

Note again that I am not objecting. I am trying to fathom the
ramifications of what you wrote here.

> +3) Ref advertisement
> +--------------------
> +3) and 4) are highly dependant on the mode for fetch and push. As currently
> +only mode "version1" is supported, the these phases follow the ref advertisement
> +in pack protocol version 1 without capabilities on the first line of the refs.
