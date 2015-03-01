From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] index-pack: kill union delta_base to save memory
Date: Sat, 28 Feb 2015 18:37:40 -0800
Message-ID: <xmqqegp9igsr.fsf@gitster.dls.corp.google.com>
References: <1424397488-22169-1-git-send-email-pclouds@gmail.com>
	<1424947928-19396-1-git-send-email-pclouds@gmail.com>
	<1424947928-19396-3-git-send-email-pclouds@gmail.com>
	<xmqqzj7zhx31.fsf@gitster.dls.corp.google.com>
	<CACsJy8A3MxpQRwboVjyv7akvzgf3y23ZsnAaxuHXkm2U=tUk0A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>,
	matthew sporleder <msporleder@gmail.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 01 03:37:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YRtlR-0000Kq-9p
	for gcvg-git-2@plane.gmane.org; Sun, 01 Mar 2015 03:37:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752933AbbCACht (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Feb 2015 21:37:49 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:55642 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752605AbbCAChs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Feb 2015 21:37:48 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E6ED73BF76;
	Sat, 28 Feb 2015 21:37:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DJJhuPsPCxABrqlQGnsWXBlWXmg=; b=tsNr6w
	38gPPF1BJXv+7Oj6owfGqBSkKN1vMoaNLN1OKqfS8yrdOr4I6WTM9DrGvZhTbNb8
	ctrKJph+Q8EW0PT23YuplYqNzcn7OI1qm/mCFD2AGVzNdJ+MJGiEZa6mFKJWCadu
	GpEg7MVNsjIh5kZyBaNjmOewJ846OHaOOhWQE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pwYYW1ax7g+7cji1rto3jXfafM/ahz78
	/OTJCiIQSfXW/KgkxM0dwvWL7g2z0wCv6xM131wfFwsI9DH0d7tsCEdQa/5ZunKL
	etRVu5KcOVGGO7h2XqrUlnIMG7RTAdl1R+aOAlahTZ8wDrSjhY1+XRtXuKA6/PZh
	XJI/jOP/VAE=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DF2833BF75;
	Sat, 28 Feb 2015 21:37:41 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6940F3BF74;
	Sat, 28 Feb 2015 21:37:41 -0500 (EST)
In-Reply-To: <CACsJy8A3MxpQRwboVjyv7akvzgf3y23ZsnAaxuHXkm2U=tUk0A@mail.gmail.com>
	(Duy Nguyen's message of "Sat, 28 Feb 2015 18:44:07 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: EED15178-BFBB-11E4-A1F4-29999F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264544>

Duy Nguyen <pclouds@gmail.com> writes:

>> Probably "Not so ancient versions of Git tries to use ofs-delta
>> encoding whenever possible, so it is expected that objects encoded
>> using ref-delta are minority" may be closer to the truth.  And that
>> observation does justify why using two separate pools (one with
>> 8-byte entries for ofs-delta, the other with 20-byte entries for
>> ref-delta) is a better idean than using one pool with 20-byte
>> entries for both kinds.
>
> Yes. Looks good. Should I send a patch, or you fix the commit
> message locally?

Thinking about the above again, I do not think there is any point
saying "not so ancient versions of Git", as the receiving index-pack
would not even know what implementaiton of Git sits on the other end
of the connection; it may even be a jGit based server, for example.
So something like:

    Because ofs-delta encoding is more efficient space-wise and more
    performant at runtime than ref-delta encoding, Git packers try
    to use ofs-delta whenever possible, and it is expected that
    objects encoded as ref-delta are minority.

perhaps?
