From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] name-rev: allow converting the exact object name at the tip of a ref
Date: Mon, 08 Jul 2013 08:12:43 -0700
Message-ID: <7v38rp2ihg.fsf@alter.siamese.dyndns.org>
References: <1373236424-25617-1-git-send-email-gitster@pobox.com>
	<1373236424-25617-3-git-send-email-gitster@pobox.com>
	<CALkWK0kSqaMrD_YuT8OxLo8yLEc0APd2Ca7FapKstqqmcYbC7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 08 17:12:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UwD7T-0005aC-KX
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jul 2013 17:12:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751524Ab3GHPMr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jul 2013 11:12:47 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36992 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751279Ab3GHPMr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jul 2013 11:12:47 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8F1E92D7E6;
	Mon,  8 Jul 2013 15:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YE/Sa8HJ4QZRSm0PYp73yavPpHs=; b=U0Gb0u
	fyAGM4Hf9JwvgSmraKeXewyGItvp3aLGUkraS9yP3cJOP1sCaTe4BrNZnBWAnuGz
	sxVb+Krew7wxxfxJnTYV8H7r1qTOyXKAdsydI3+EipMxuqnEaj24KIFilyKNV1eq
	R5C1Iwvfa4VHVuMl3xSX4p/zcT1wyerCpBcGc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HgMqLv9qQ8dkgRkCSgDT4d9zC5Sh0geK
	r68kqbdGB+SowdZQSUNEf8qPR0IWSePo09yDoVZCNvdtCICDeq8i9ubuHUSB1FXu
	nZ26oHJclAUIs7QWsIZAmZIC1Dev7dGbyrYjucoaiUAMjy747VIZ7NpvYCy5aIqw
	OdmYOZMhcLg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 838E02D7E4;
	Mon,  8 Jul 2013 15:12:46 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0A6DC2D7E3;
	Mon,  8 Jul 2013 15:12:44 +0000 (UTC)
In-Reply-To: <CALkWK0kSqaMrD_YuT8OxLo8yLEc0APd2Ca7FapKstqqmcYbC7A@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Mon, 8 Jul 2013 17:50:16 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D79B9EE6-E7E0-11E2-9FC9-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229862>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

>   Finds symbolic names suitable for human digestion for revisions
>   given in any format parsable by git rev-parse.
>
> It is meant to name _revisions_ (aka. commits):

That is a mistaken documentation, written based on a half-baked
implementation that conflated "the current code only can handle
commits" with "we need to only handle commit and nothing, ever".

We had to fix a similar misguided/short-sighted implementation in
the "git fetch" codepath when adding "git pull/merge $tag" (the code
peeled a tag object too early when writing FETCH_HEAD out, losing
information if what we were given was a tag or a commit).

I do not want to see us making the mistake worse unnecessarily.
When we see a commit object that is pointed by tag v1.8.3, it is the
right thing to do to return v1.8.3^0 as its string representation so
that "git rev-parse v1.8.3^0" give us the same thing back.  name-rev
that is fed a tag object v1.8.3 should give v1.8.3 (not v1.8.3^0)
back, otherwise feeding its output to "git rev-parse" will not give
us the same thing we fed as the input to name-rev.
