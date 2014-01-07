From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bug report: stash in upstream caused remote fetch to fail
Date: Mon, 06 Jan 2014 19:19:43 -0800
Message-ID: <7vtxdg1nsg.fsf@alter.siamese.dyndns.org>
References: <CAECVvXYD69Xrp85bVJg6XogvctUTwrFDae+3tawFgoCAUGhwGg@mail.gmail.com>
	<20140106152742.GA26221@sigill.intra.peff.net>
	<xmqqbnzpkrvk.fsf@gitster.dls.corp.google.com>
	<20140106193625.GA27062@sigill.intra.peff.net>
	<xmqq61pwj25q.fsf@gitster.dls.corp.google.com>
	<20140106230348.GA7811@sigill.intra.peff.net>
	<xmqq4n5ghf0z.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matt Burke <spraints@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jan 07 04:19:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0NCb-0000Kf-Ck
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jan 2014 04:19:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756650AbaAGDTd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jan 2014 22:19:33 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58124 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752392AbaAGDTc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jan 2014 22:19:32 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 12DB461E63;
	Mon,  6 Jan 2014 22:19:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=s24FxBzwjL+vz43zK6KJRNWHMeg=; b=iO3Eq9
	OeOhbiiv8+vygy9OaJvxImxbEUji+AwKqQ1+nsLpIybftwJjal0G/BQqvhzK5Nb0
	76d49H7rXyPFgmDEjrZmrM7a05jsC8YF/+MfDuB6Nb2jhCytUCeukooJMl/nY5on
	HxR3f91paoHYGf8W3uOrOqVNTshPrE0pC7ddM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=C+dpDyqNza/xWl+0JXfJDOtEQXUhgOiV
	8xM/wigkiKCFGWRkEdlQEifR5OzCWoXCDtf3GEro80MAo1lWakZ/72f8lZVA11Q4
	b/PeOklVKJH0ycn+zzH0s/nhbC3Zb7uH5UwDms8Yoc/wfkHkdSrPvRksaOXCcYrT
	E6B9+ENn/9U=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ED8DA61E60;
	Mon,  6 Jan 2014 22:19:31 -0500 (EST)
Received: from pobox.com (unknown [198.0.213.178])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C6CF561E5E;
	Mon,  6 Jan 2014 22:19:30 -0500 (EST)
In-Reply-To: <xmqq4n5ghf0z.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Mon, 06 Jan 2014 15:22:20 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
X-Pobox-Relay-ID: 85DA74B6-774A-11E3-866A-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240094>

Junio C Hamano <gitster@pobox.com> writes:

>> It's really not clear to me what the check in filter_refs was trying to
>> do. It dates all the way back to 1baaae5 (Make maximal use of the remote
>> refs, 2005-10-28), but there is not much explanation. I haven't dug into
>> the list around that time to see if there's any discussion.
>
> I think the "funny refs" the log message talks about is about
> filtering "we know we can reach these objects via our alternates,
> but these are not refs we actually have".

Actually, I think the above recollection of mine was completely
bogus.  The && is there because we do allow things like "HEAD" (they
are the funny ones) as well as things inside refs/, and the latter
is the only thing we had a check-ref-format to dictate the format
when the code was written.

I do not mind tightening things a bit (e.g. outside refs/, only
allow HEAD and nothing else).  A good first step might be to enforce
allow-onelevel outside refs/ (so that we can allow "HEAD") and for
those inside refs/ check without allow-onelevel but without skipping
the prefix.

It is a separate story if it makes much sense to allow fetching
refs/stash or ignoring when running "git clone".  Operationally, I
think it makes more sense to ignore refs/stash, not because it is a
one-level name, but because what a stash is.
