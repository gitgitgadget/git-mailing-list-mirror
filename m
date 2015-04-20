From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Why does "git log -G<regex>" works with "regexp-ignore-case" but not with other regexp-related options?
Date: Mon, 20 Apr 2015 10:41:51 -0700
Message-ID: <xmqqbniin1cw.fsf@gitster.dls.corp.google.com>
References: <1090496912.6338.1429264855691.JavaMail.open-xchange@ox1app>
	<55311831.6010004@drmicha.warpmail.net>
	<CAPc5daUULhhV0+kL_htLnA8Z_woFLjxg_pO_cB0KLAMuxJnsMQ@mail.gmail.com>
	<5534BD87.8020709@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Tim Friske <me@tifr.de>, git <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Apr 20 19:42:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YkFhn-0000PJ-Cw
	for gcvg-git-2@plane.gmane.org; Mon, 20 Apr 2015 19:41:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754202AbbDTRly (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2015 13:41:54 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:60124 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753161AbbDTRly (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2015 13:41:54 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 367D4497B6;
	Mon, 20 Apr 2015 13:41:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NxemRLjFlu1lfFd9NZkoIU2GnOI=; b=F4GRR4
	x4DwAnv9ogEwNVN2U2K9Q77wpzn9Zn9oqwTynbUTiqQmNdo/pjMc+kOYYvyqjlPK
	C9sqESI+0UXPaUxIadJH9GxaEsHyv9poBY2GcoyxOhNqvRBs0dIJHfvbMqE/9QqI
	SiczaSHw706d4N1T/iZd5W5ieLv4A+5pkD+qE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bEcGYQktr6bUdVQTfz4q5UAQ+kXpvngH
	mLSp71GLTpIr6cctydz/FE4rgIBKHlYED/kUWcvE+nSIwaGbMz8/2Kin/Km+ACEK
	lPjxvDjuKj40emUDdXOfcp5NSnFZEVAYPZOlRW93MrmDiIZRYQkNu+PS+eJXAuSh
	quIwDTwcN9A=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2DC68497B5;
	Mon, 20 Apr 2015 13:41:53 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A56C8497B2;
	Mon, 20 Apr 2015 13:41:52 -0400 (EDT)
In-Reply-To: <5534BD87.8020709@drmicha.warpmail.net> (Michael J. Gruber's
	message of "Mon, 20 Apr 2015 10:49:11 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 87BBF876-E784-11E4-8276-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267478>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> They [jc: -S and -G] have different semantics, and *therefore*
> they have different defaults, and *therefore* a user may want to
> switch one of them (or --grep or --author or...) to
> --fixed--strings and keep the other to --regexp.

Ahh, OK.  And not just -S and -G, the "fields in headers" may be
something user may want to switch independently?

> One idea would be to make
>
> --regexp -S --fixed-strings -G
>
> work the obvious way (match option affects following grep
> options),...

I understand that your idea is for options to accumulate up to what
consumes them, e.g. -S, -G, --author,..., and then get reset for the
next consumer.  I would think it is very much debatable if that way
of working is "the obvious" one, though.  If I had no prior Git
experience, I would imagine that I would find it more intuitive if

    $ git log --regexp-ignore-case --author=tiM --grep=wip

showed a commit authored by Tim that is labelled with "[WIP]".

It may be tempting to expose that our underlying machinery could use
3 different regexp matching settings for header fields (i.e. author,
committer), log messages and the patch bodies somehow to the end
users, and either interpreting options position-dependently or
having separate options may be possible ways to do so.  That would
give the end users full flexibility the underlying machinery offers.

I am however not yet convinced that additional complexity at the UI
level that would burden the end users is a reasonable price to pay
for such a flexibility.  When was the last time you wanted to grep
for log messages case insensitively for commits authored by Tim but
wanted to hide commits authored by tim when you used the above "log"
command line or similar?
