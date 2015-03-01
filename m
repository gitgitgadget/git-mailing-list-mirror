From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 4/5] daemon.c: accept extra service arguments
Date: Sat, 28 Feb 2015 19:39:52 -0800
Message-ID: <xmqqioelgzcn.fsf@gitster.dls.corp.google.com>
References: <CAGZ79ka8Zg86qqvWByNiP3F6a9QggO-bNY3ZZ9g+A-MdKYQ7NQ@mail.gmail.com>
	<1425085318-30537-1-git-send-email-sbeller@google.com>
	<1425085318-30537-5-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, pclouds@gmail.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Sun Mar 01 04:40:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YRujf-0004rz-4o
	for gcvg-git-2@plane.gmane.org; Sun, 01 Mar 2015 04:40:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753657AbbCADj4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Feb 2015 22:39:56 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:60200 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753637AbbCADjy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Feb 2015 22:39:54 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A39AD3CA1E;
	Sat, 28 Feb 2015 22:39:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DoZqpUUckxOtjviF+ipklp1w/CM=; b=VFPiuy
	ablTy1lQU77YDXRSDJpueKhlWr4qoZFgisRjTvM8wwEv+ujRo5XVPKhjv0oWqMSe
	ugZ4kziYZG7GAnY76LKR9fYt1ck28J1SSt/my8Zn3nl8CBveJwrbmX89fgmLR3tW
	gYGza/UFP5iAIkn9JoApptJOop07CLyTGLUVE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FrNtd8X5huCidV3uvHJ88kmUVt6+eZ4z
	4/7xoilkpzygmSPKhMjzp14rH5vupEtFUcvSxJhV2o1QRBGYxxyFGMQfSraKZcEo
	wx/3Eg/apCx07OEM6SZMmHt/8uCHN383lkzod59W/zGGB5oF23+up6DS3pKoiFhp
	HW6gT/4Dgco=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9BF553CA1D;
	Sat, 28 Feb 2015 22:39:53 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 26E6C3CA1B;
	Sat, 28 Feb 2015 22:39:53 -0500 (EST)
In-Reply-To: <1425085318-30537-5-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Fri, 27 Feb 2015 17:01:57 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 9F198F98-BFC4-11E4-8AFD-29999F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264547>

Stefan Beller <sbeller@google.com> writes:

> Before 73bb33a (daemon: Strictly parse the "extra arg" part of the
> command - 2009-06-04) a client sending extra arguments could DoS
> git-daemon. 73bb33a fixed it by forbidding extra arguments.
>
> Allow arguments other than "host=" again as a preparation step for
> upload-pack2. "host=" if present must be the first argument
> though. The remaining arguments are concatenated by whitespace.
>
> So far none of supported services support extra arguments. Attempting
> to do will abort the service, just like how it is before. We might
> want to make them silently ignore extra arguments though.

The necessity of this means 3/5, hiding new stuff after
"host=<name>\0", is not a viable strategy to extend the
communication to "git daemon" in a backward compatible way so that
new client can transparently talk with older daemon.

And if you accept that limitation and declare that new client MUST
talk with a new git daemon, then there is not much point in hiding
the extra arguments after "host=<name>\0".  You can just declare
that the new git daemon will accept arguments, including
"host=<name>\0", as a series of "var=<val>\0" in separate packets,
not as a part of the initial "<program> <path>" packet, for example.

One thing 3/5 and 4/5 will give you is to allow old clients to talk
to the new git daemon if the way new programs spawned by git daemon
must use that "hiding" trick, but I am not convinced that it is
necessary to resort to that "hiding" trick in the first place.

Under the same "new client must talk with a new daemon, they cannot
talk with existing daemon" limitation, I think you can arrange
things this way by not touching daemon at all:

 * Keep the daemon protocol as "<program> <path>\0host=<name>\0".

 * New client, as it has to know that it is talking to a host with
   new enough Git, can ask "upload-pack-2" as <program>.

 * Design the protocol that the protocol backend programs such as
   upload-pack-2 (and other updated programs like receive-pack-2,
   trickle-pack, ...) talks in such a way that these "extra"
   parameters sent when client connects are sent as the first
   packet(s).

That way, the new daemon will take "<program> <path>\0host=<name>\0"
and cannot take extra arguments at the end of that packet, but the
new protocol backend programs do not need extra arguments given by
the daemon to them anyway.  Old clients will not ask to be connected
to new upload-pack-2 and friends, but that is to be expected.
