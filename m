From: Junio C Hamano <gitster@pobox.com>
Subject: Re: RFC: Resumable clone based on hybrid "smart" and "dumb" HTTP
Date: Thu, 11 Feb 2016 13:32:22 -0800
Message-ID: <xmqq4mdfvspl.fsf@gitster.mtv.corp.google.com>
References: <CAJo=hJtHgE_vye_1sPTDsvJ0X=Cs72HKLgRH8btpW-pMrDdk9g@mail.gmail.com>
	<CAJo=hJuRxoe6tXe65ci-A35c_PWJEP7KEPFu5Ocn147HwVuo3A@mail.gmail.com>
	<20160210214945.GA5853@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Shawn Pearce <spearce@spearce.org>, git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 11 22:32:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aTyqk-0004qB-Bq
	for gcvg-git-2@plane.gmane.org; Thu, 11 Feb 2016 22:32:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751847AbcBKVc0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Feb 2016 16:32:26 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:63251 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751422AbcBKVcZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Feb 2016 16:32:25 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2B07F42E89;
	Thu, 11 Feb 2016 16:32:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=F1M/VnPR8yt98dAYFQTNs0LLdN0=; b=GdYEEv
	Nv8S7IuJu9U4DLPzKliAjyKT8e8IeIqZYiJ9it7Im3XJvDnBuiuf872IThU+r4KF
	Vg3lAiWOa97ktncrwTRLQvYQe9Lzv31bWfqd26YLjoqp8c1ceqIfb64B97uG65V2
	XiEcEenQAcnY3ijNeG6+BMGXgXXD1YFEDLX2I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LnmyFydzaGUozhjY1aszxPaKK7EF8jML
	GzRs89fYAe/SeCpfC1+5oBjEH1p0aKyBQJdDD7SlhcisJieKQ1YaiotSYAYf6vLK
	kFf2UdraV1bPEKS1rkmofAOqs/MSwktYhk4CvLJ8mKH6xoGuRALZEBW9nYGAfjSJ
	QkCJstJF7sE=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1FB3742E86;
	Thu, 11 Feb 2016 16:32:24 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 81E4C42E85;
	Thu, 11 Feb 2016 16:32:23 -0500 (EST)
In-Reply-To: <20160210214945.GA5853@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 10 Feb 2016 16:49:46 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F0413C82-D106-11E5-83EA-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286004>

Jeff King <peff@peff.net> writes:

> ... One
> alternative would be to amend the bundle format so that rather than a
> single file, you get a bundle header whose end says "...and my matching
> packfile is 1234-abcd". And then the client knows that they can fetch
> that separately from the same source.

I would imagine that we would introduce bundle v3 format for this.

It may want to say "my matching packfiles are these" to accomodate a
set of packs split at max-pack-size, but I am perfectly fine to say
you must create a single pack when you use a bundle with separate
header to keep things simpler.

> It's an extra HTTP request, but it makes the code for client _and_
> server way simpler. So the whole thing is basically then:
>
>   0. During gc, server generates pack-1234abcd.pack. It writes matching
>      tips into pack-1234abcd.info, which is essentially a bundle file
>      whose final line says "pack-1234abcd.pack".

OK.

>   1. Client contacts server via any git protocol. Server says
>      "resumable=<url>". Let's says that <url> is
>      https://example.com/repo/clones/1234abcd.bundle.
>
>   2. Client goes to <url>. They see that they are fetching a bundle,
>      and know not to do the usual smart-http or dumb-http protocols.
>      They can fetch the bundle header resumably (though it's tiny, so it
>      doesn't really matter).

Might be in megabytes range, though, with many refs.  It still is
tiny, though ;-).

>   3. After finishing the bundle header, they see they need to grab the
>      packfile. Based on the bundle header's URL and the filename
>      contained within it, they know to get
>      https://example.com/repo/clones/pack-1234abcd.pack". This is
>      resumable, too.

OK.

>   4. Client clones from bundled pack as normal; no root-finding magic
>      required.

I like this part the most.

>   5. Client runs incremental fetch against original repo from step 1.
>
> And you'll notice, too, that all of the bundle-http magic kicks in
> during step 2 because the client sees they're grabbing a bundle. Which
> means that the <url> in step 1 doesn't _have_ to be a bundle. It can be
> "go fetch from kernel.org, then come back to me".

Or it could be a packfile (and the client discovers roots), as you
mentioned in a separate message.  I personally do not think it buys
us much, as long as we do a bundle represented as a header and a
separate pack.
