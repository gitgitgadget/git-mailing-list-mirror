From: Junio C Hamano <gitster@pobox.com>
Subject: Re: problems serving non-bare repos with submodules over http
Date: Wed, 20 Apr 2016 14:27:47 -0700
Message-ID: <xmqqshygt1gs.fsf@gitster.mtv.corp.google.com>
References: <20160420152209.GH23764@onerussian.com>
	<CAGZ79kYS-F1yKpNP7jmhTiZT1R_pucUBBTCbmHKZz6Xd6dy8EA@mail.gmail.com>
	<xmqqh9ewukhw.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kZMOv0r9fRFbP1WV8qFJBm+s=V8=ueFbYvnyFtgV8j9iQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Yaroslav Halchenko <yoh@onerussian.com>,
	Git Gurus hangout <git@vger.kernel.org>,
	Benjamin Poldrack <benjaminpoldrack@gmail.com>,
	Joey Hess <id@joeyh.name>, Jens Lehmann <Jens.Lehmann@web.de>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Apr 20 23:28:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aszfA-0000Iw-HE
	for gcvg-git-2@plane.gmane.org; Wed, 20 Apr 2016 23:27:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751829AbcDTV1v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Apr 2016 17:27:51 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54044 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751371AbcDTV1u (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2016 17:27:50 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 5CA67146E3;
	Wed, 20 Apr 2016 17:27:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+C6V7ioABWMq7i95gHNusYnIQzE=; b=T+c6tY
	k7j3ydFOel/RzuLwB6EA7pY5eg8hyyQ7tCWUnNVFSVydeqt5RsGUJdcCr+fBdi2L
	GaUoUxnm/m0ylVqsNeklK7XVjI53jvvtSDU1dx53ajcbRWXzT/BmoEQpdHCR45rV
	rc+59eTZHsIT8JMUYu37Wnuilg8d73RJPeros=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PQ5YtLIcxyWhJxPYYKfpvK37ejjxpxeY
	58Mz48qFa/Iib1ftQPQZY49iUysgspBXpFruIj8g8wxBDk1lQfh0qV0fpIzpA55x
	LMayRCdZy7sIgEbKV4YukUtEN90sDffMsCc+iAHPY/vmAb3bQgRQ337eJYi0X5Jq
	MU0COiMASKQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 54CE2146E2;
	Wed, 20 Apr 2016 17:27:49 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B1B92146E1;
	Wed, 20 Apr 2016 17:27:48 -0400 (EDT)
In-Reply-To: <CAGZ79kZMOv0r9fRFbP1WV8qFJBm+s=V8=ueFbYvnyFtgV8j9iQ@mail.gmail.com>
	(Stefan Beller's message of "Wed, 20 Apr 2016 14:05:43 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: BAF5F626-073E-11E6-8456-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292084>

Stefan Beller <sbeller@google.com> writes:

>> I may be missing the subtleties, but if you are serving others from
>> a non-bare repository with submodules, I do not think you would want
>> to expose the in-tree version of the submodule in the first place.
>
> Well I would imagine that is the exact point.
> If I was not trying to expose my state, I could ask you to
> obtain your copy from $(git remote get-url origin) just as I did.

That wasn't what I had in mind, but if the cloner cloned from your
repository with a working tree, the cloner would discover submodules
you use from your .gitmodules file, which would record the location
you cloned them from, so something like that may come into the
picture.  What I had in mind was more like this one you mentioned
below:

>     $GIT_DIR_SUPER_PROJECT/modules/$MODULE_NAME
> ...
> Right instead of cloning $WORKTREE/sub/.git you rather want
> $GITDIR/module/sub

> So currently the protocol doesn't allow to even specify the submodules
> directories.

Depends on what you exactly mean by "the protocol", but the
networking protocol is about accessing a single repository.  It is
up to you to decide where to go next after learning what you can
learn from the result, typically by following what appears in
the .gitmodules file.

The only special case is when .gitmodules file records the URL in a
relative form, I would think.  Traditionally (i.e. when it was
considered sane to clone only from bare repositories) I think people
expected a layout like this:

	top.git/
	top.git/refs/{heads,tags,...}/...
        top.git/objects/...
        top.git/sub.git/
	top.git/sub.git/refs/{heads,tags,...}/...
        top.git/sub.git/objects/...

and refer to ./sub.git from .gitmodules recorded in top.git.  It
still would be norm for common distribution sites (i.e. the original
place Yaroslav likely has cloned things from) to be bare, and with
or without $GIT_DIR/modules/, the relative path of submodule seen
by its superproject would (have to) be different between a bare and
a non-bare repository.

I'd imagine that people could agree on a common layout like this
even for a forest of bare repositories:

	top.git/
	top.git/refs/{heads,tags,...}/...
        top.git/objects/...
        top.git/modules/sub.git/
	top.git/modules/sub.git/refs/{heads,tags,...}/...
        top.git/modules/sub.git/objects/...

which would probably make the "relative" relationship between the
supermodule and its submodules the same between bare and non-bare
repositories, but I didn't think it too deeply.
