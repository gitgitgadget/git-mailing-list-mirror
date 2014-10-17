From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-bundle rev handling and de-duping
Date: Fri, 17 Oct 2014 15:41:22 -0700
Message-ID: <xmqq1tq6s4j1.fsf@gitster.dls.corp.google.com>
References: <20141015223244.GA25368@peff.net>
	<20141015223419.GC25630@peff.net>
	<xmqqr3y7ud5h.fsf@gitster.dls.corp.google.com>
	<20141017003356.GC7848@peff.net>
	<ECD50FDF3714423E99E6CC6B4DE04FBF@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "Jeff King" <peff@peff.net>, "Git List" <git@vger.kernel.org>,
	"Michael Haggerty" <mhagger@alum.mit.edu>
To: "Philip Oakley" <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Sat Oct 18 00:41:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XfGDS-0007me-7T
	for gcvg-git-2@plane.gmane.org; Sat, 18 Oct 2014 00:41:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751302AbaJQWlc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Oct 2014 18:41:32 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:59235 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751158AbaJQWlb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Oct 2014 18:41:31 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B614516AE4;
	Fri, 17 Oct 2014 18:41:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+xvBlhmmmRgezRRMy06ze1UDNcY=; b=LAO108
	2FShFvXJYEDmbUIFcz3+S2dVLOKvTi2DeIE/2vheWNf/NbE78RWazcYI3CQ7AhyS
	XBGLHlXupn2nY0JilejQJIcGIAen9E/QNlCUtrt+QSxaP6gZlglVPPnGELv0Jhel
	dXsS60+Mk7mZ+V2YKntCvdpZ9KW8JaxhxHiyc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yTRLOJuLwhFDYCTWpCcJwmvnKW+9x/1m
	ib7AGsp+kek4bIHoW6UAiJ6+utkMlb/OfDRl8S5w0P3cd6hwSYn+15VEYCiBC93M
	geoSfmvkYClBueo9TSrvdbyCDc9S5dSS+PC1wGpQrG4SW6Zg3sNBIt6bTJFkmFhm
	X6c+CeSZFi8=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id AB89816AE3;
	Fri, 17 Oct 2014 18:41:24 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2C25316AE2;
	Fri, 17 Oct 2014 18:41:24 -0400 (EDT)
In-Reply-To: <ECD50FDF3714423E99E6CC6B4DE04FBF@PhilipOakley> (Philip Oakley's
	message of "Fri, 17 Oct 2014 22:03:14 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B929C43C-564E-11E4-982C-855A93717476-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Philip Oakley" <philipoakley@iee.org> writes:

>>  # two branches point at the same object
>>  git branch foo master
>>
>>  # the other side already has master. Let's send them foo.
>>  # this will fail because the bundle is empty. That's mildly
>>  # annoying because we really want to tell them "hey, update
>>  # your foo branch". But at least we get an error.
>>  git bundle create tmp.bundle foo ^master
>
> Isn't this kindof what happens as an issue when we want the right HEAD
> to be included explicitly in a bundle. Though


What we are discussing here is "we tell from the command line where
the histories end, but do we correctly record all these end points
as fetchable refs in the resulting bundle?"

It does not have anything to do with "bundle that does not record
its HEAD cannot be cloned", which happens when you do not mention
HEAD when creating the bundle in the first place, which is a totally
different thing.

> http://thread.gmane.org/gmane.comp.version-control.git/234053 suggests
> its more complicated than that.

The main topic of discussion does not have much to what bundle
records and what a reader of a bundle guesses.  It is about what
goes on the wire and mention of bundle was just a tangent brought up
by those who do not know what was being discussed, I think.

I think the right fix to the "git bundle" issue is to make it easier
on the "git bundle create" side to have the resulting bundle record
its HEAD, even when the user did not mention HEAD on the command
line.  For example, when there is only one end point, e.g. "git
bundle create x next", record refs/heads/next _and_ HEAD pointing at
the same commit, because there is no other seneible choice.  

"git bundle create y master next" may record master, next and HEAD
while HEAD is likely pointing at the same commit as master (because
'master' is special).  Or we could give a warning and even go
interactive to ask which ref to record as HEAD.

But the above three paragraphs are tangent so I'd stop here.
