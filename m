From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG?] fetch into shallow sends a large number of objects
Date: Mon, 07 Mar 2016 15:47:53 -0800
Message-ID: <xmqqio0xn93q.fsf@gitster.mtv.corp.google.com>
References: <20160307221539.GA24034@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 08 00:48:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ad4t6-0004Aw-Kr
	for gcvg-git-2@plane.gmane.org; Tue, 08 Mar 2016 00:48:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932841AbcCGXs2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Mar 2016 18:48:28 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:50079 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933680AbcCGXr5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Mar 2016 18:47:57 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A40BD4B8B5;
	Mon,  7 Mar 2016 18:47:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SpVo2c1696GumtSryKKfZR3fQv0=; b=hcZVKw
	Vsl8JQErwi7Xilimfa9NuTclOUoAF0Il/gF0/Su0Pp4t7YrMa3YK2qEgw9rwVwPu
	cLg2kFUaed1tYDKGebPeFmfo1N098EVDEwW8+N6Wso0oxeJY+3+ilbvpFw7taCHS
	hDy+q2lV7WX277Pyc44R3berQALypnMrIJo80=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XYkfYZUBFBfFSJehs7kN5VrcgwlCGnZw
	sICVPJD7fFgIddWxnatosQMJIN/Tb3KF9vfaiDtqKPlFZPdY2iKLP9qneqUewYXt
	hmGRlvRdzmtSphOxWH3Osd/bGggeygu9vHqitYEYaVuJGtbPc/HAQyMsXnqRwaVv
	k1xrJKXsBmc=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9B9C84B8B4;
	Mon,  7 Mar 2016 18:47:55 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 180654B8B3;
	Mon,  7 Mar 2016 18:47:55 -0500 (EST)
In-Reply-To: <20160307221539.GA24034@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 7 Mar 2016 17:15:40 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 035EED5C-E4BF-11E5-B655-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288409>

Jeff King <peff@peff.net> writes:

> I don't know how the client invoked git, but we can guess what happened
> and simulate with:
>
>   git tag shallow ecd7ea6033fe8a05d5c21f3a54355fded6942659
>   git tag old 067f265bb512c95b22b83ccd121b9facbddcf6b1
>   git tag new d7a6d9295d718c6015be496880f1a293bdd89185
>
>   git clone --no-local --bare --branch=shallow --depth=1 . clone.git
>   cd clone.git
>   git fetch origin old:refs/tags/old
>   git fetch origin new:refs/tags/new
>
> Of the two follow-up fetches in the clone, the first is reasonably fast
> (it just grabs a few new commits on top of the shallow base), but the
> second is expensive (it grabs the merge which pulls in the whole
> history). If we add "--depth=1" to each of those fetches, everything
> remains fast.
>
> Is this user error to call "git fetch" without "--depth" in the
> subsequent cases? Or should git remember that we are in a shallow repo,
> and presume that the user by default wants to keep things shallow?

Hmph, you shouldn't, and I somehow thought that you do not, have to
explicitly say things like "--deepen" to break the original
shallowness, but your example illustrates that the logic to do so is
not well thought out.  A new side branch will prevent you from
hitting an already-known shallow cut-off and traverse down to the
root.

Giving a random "depth" in subsequent fetch would however not work
very well, I suspect, as that is very prone to make the part of the
history the user originally obtained, and presumably used to build
her own history, into an island that is unconnected to the updated
tip of the history.  

I also do not offhand think of a good way to use the topology or
timestamp to figure out the best "depth" to truncate the side branch
at.  The server side may be able to figure out that things before 'F'
in your picture is not relevant for a client that has the shallow
cut-off at 067f265, but the side branch can be forked arbitrarily
long in the past, or it may not even share the ancient part of the
history and has its own root commit.
