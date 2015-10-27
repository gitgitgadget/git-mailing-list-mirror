From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/9] submodule-config: "goto" removal in parse_config()
Date: Tue, 27 Oct 2015 14:39:37 -0700
Message-ID: <xmqq611sng86.fsf@gitster.mtv.corp.google.com>
References: <1445969753-418-1-git-send-email-sbeller@google.com>
	<1445969753-418-2-git-send-email-sbeller@google.com>
	<20151027212645.GF7881@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
	jacob.keller@gmail.com, peff@peff.net,
	johannes.schindelin@gmail.com, Jens.Lehmann@web.de,
	ericsunshine@gmail.com
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 27 22:39:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZrBy5-0007uq-R4
	for gcvg-git-2@plane.gmane.org; Tue, 27 Oct 2015 22:39:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932468AbbJ0Vjm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Oct 2015 17:39:42 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:61370 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932459AbbJ0Vjk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Oct 2015 17:39:40 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C9B1C243FA;
	Tue, 27 Oct 2015 17:39:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xyYzllf9th90T93VAvTVDwlR/PE=; b=gg6Pl4
	Jdj2v4xDGx1sdzTky93CHOZ1HufCaaccZXaxVtjKfyvx3DTl6PaKygj3vm6FtUb5
	TsKaJ61iDsj+KvQw5GipIrF+BwUhDfHyWjpdb3BmjINbTMVq0xUcJxNxbVWQnSaw
	ms1rDRt+YJnXKlFLJNQ+CpMjRZH0ehqokHFzY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=W2L7reoejN3ZvZnxoNPmsx6LpywM7IXL
	mgoTwAaFaZGkKoadVLq8tikkkcrLG4FTLXmvyee88Grri+xKDufw0dghC8Yceilj
	n8bZAC37x1+YNV46f+TJYZ7XMUiKVM28V6nBgr5QdFD+5CJ/WlqQTRdvKBaJXtSa
	P7j14VpxlRU=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BFC8A243F9;
	Tue, 27 Oct 2015 17:39:38 -0400 (EDT)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 3A363243F8;
	Tue, 27 Oct 2015 17:39:38 -0400 (EDT)
In-Reply-To: <20151027212645.GF7881@google.com> (Jonathan Nieder's message of
	"Tue, 27 Oct 2015 14:26:45 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 39330B5E-7CF3-11E5-8C90-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280305>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Not having read the patch yet, the above makes me suspect this is
> going to make the code worse.  A 'goto' for exception handling can
> be a clean way to ensure everything allocated gets released, and
> restructuring to avoid that can end up making the code more error
> prone and harder to read.
>
> In other words, the "goto" removal should be a side effect and not
> the motivation.

Yes, I shared the same general feeling (cf. $gmane/279405).

> More generally, the patch seems to be about changing from a code structure
> of
>
> 	if (condition) {
> 		handle it;
> 		goto done;
> 	}
> 	if (other condition) {
> 		handle it;
> 		goto done;
> 	}
> 	handle misc;
> 	goto done;
>
> to
>
> 	if (condition) {
> 		handle it;
> 	} else if (other condition) {
> 		handle it;
> 	} else {
> 		handle misc;
> 	}
>
> In this example the postimage is concise and simple enough that it's
> probably worth it, but it is not obvious in the general case that this
> is always a good thing to do.

Generally, a large piece of code is _easier_ to read with forward
"goto"s that jump to the shared clean-up code, as they serve as
visual cues that tell the reader "you can stop reading here and
ignore the remainder of this if/else if/... cascade".

> Now that I see the patch is already merged, I don't think it needs
> tweaks.  Just a little concerned about the possibility of people
> judging from the commit message and emulating the pattern in the rest
> of git.

Yes, we shouldn't let people blindly imitate this change.  I merged
it primarily because I wanted the change get out of my hair, as
other changes in flight started conflicting with it.

This kind of change can be good one only in a narrowly defined case
(like this one) but I agree that in general, as you said at the
beginning, it is an easy way to make the resulting code less
maintainable and harder to read.

Thanks.
