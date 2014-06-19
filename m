From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] strbuf: add xstrdup_fmt helper
Date: Thu, 19 Jun 2014 09:49:41 -0700
Message-ID: <xmqq38f0j13u.fsf@gitster.dls.corp.google.com>
References: <20140618200000.GA22994@sigill.intra.peff.net>
	<20140618200133.GA23057@sigill.intra.peff.net>
	<xmqq7g4dj1cn.fsf@gitster.dls.corp.google.com>
	<20140619090532.GB1009@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jun 19 18:49:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxfX9-0002K7-Kq
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jun 2014 18:49:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933711AbaFSQtu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2014 12:49:50 -0400
Received: from smtp.pobox.com ([208.72.237.35]:58708 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932213AbaFSQts (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2014 12:49:48 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id AC2001E1EE;
	Thu, 19 Jun 2014 12:49:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=37vvFq5b70AI+cwiNg4jIwy3+j4=; b=fXWb0D
	nUQYmnJouFECyOMAet9GfM+Efd9skLpcm0i6HJ7nij/74vZCnyGUJI0xtwva5LbR
	X0hs8RAnT56Aw0f89uismv5YsJmWtUeH1LG3hL9z1QJYjHzjbTQL4ji3pEjXmtJY
	RIh2Q0w+G0f++Ojz/oZTutdVW+dq4THrfYJWM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aHIVEZVmfcSqagirgoMJAQEjYdZkE1ZC
	o2t88L1uJ8HYSQ/Z+fAplYCedT3LVED+izBFuDK9HqNJwzAdesEpSjb+eDjTwHVi
	ENLUxXogTTp3Ds4AV1OMK4/V+rtHYEVQ0Kp1XDgCNbQiYKC++eQrC+RNL1g7wbfi
	p+5tHGaoqQg=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A0D211E1ED;
	Thu, 19 Jun 2014 12:49:45 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 211841E1E9;
	Thu, 19 Jun 2014 12:49:41 -0400 (EDT)
In-Reply-To: <20140619090532.GB1009@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 19 Jun 2014 05:05:32 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: B532E7FE-F7D1-11E3-8E57-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252165>

Jeff King <peff@peff.net> writes:

> On Wed, Jun 18, 2014 at 03:32:08PM -0700, Junio C Hamano wrote:
>
>> >   str = xstrdup_fmt(fmt, some, args);
>> > ---
>> > I'm open to suggestions on the name. This really is the same thing
>> > conceptually as the GNU asprintf(), but the interface is different (that
>> > function takes a pointer-to-pointer as an out-parameter, and returns the
>> > number of characters return).
>> 
>> Naming it with anything "dup" certainly feels wrong.  The returned
>> string is not a duplicate of anything.
>
> I was somewhat inspired by "mkpathdup" and friends.

That name is from "mkpath gives its result in a static buffer and
forces the callers to xstrdup() if they want to keep the result;
this is a thin wrapper to do so for the caller".  As there is no
str_fmt() that gives its result in a static, so...

> I considered that, but I do find asprintf's interface unnecessarily
> annoying...

Yes, it is annoying.

> Would it be crazy to just call it xprintf? By our current scheme that
> would be "a wrapper for printf", which means it is potentially
> confusing.
>
> Literally any other unused letter would be fine. dprintf for detach? I
> dunno.

If we twist the logic behind the 'mkpathdup' name a little bit,
perhaps we can call it sprintf_dup or something.  That is, "sprintf
wants a fixed preallocated piece of memory to print into, and we
relieve the callers of having to do so", perhaps?

dprintf, mprintf, etc. are also fine by me.
