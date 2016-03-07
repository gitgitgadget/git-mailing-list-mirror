From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Resumable clone
Date: Sun, 06 Mar 2016 19:55:23 -0800
Message-ID: <xmqq37s3rlg4.fsf@gitster.mtv.corp.google.com>
References: <CANtyZjSJf5_xbsBC5tUaazFT3uiEgJnx2_kHLwYwKcn50Jy_qg@mail.gmail.com>
	<CACsJy8CESL6vH22mGSLRE1OKTEbGz2Vqmsv5bY3mn_E+03wADw@mail.gmail.com>
	<xmqqoaasvkrt.fsf@gitster.mtv.corp.google.com>
	<alpine.DEB.2.20.1603060831570.3152@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Duy Nguyen <pclouds@gmail.com>,
	Kevin Wern <kevin.m.wern@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Mar 07 04:55:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1acmGa-0006lh-VU
	for gcvg-git-2@plane.gmane.org; Mon, 07 Mar 2016 04:55:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752039AbcCGDz2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Mar 2016 22:55:28 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:64369 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751938AbcCGDz0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Mar 2016 22:55:26 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0FE3D4BF99;
	Sun,  6 Mar 2016 22:55:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=LC4KIKcNG7od57Dj0dpAXb0Xzus=; b=Zv1vtGJavoBZEAyD671U
	PfqAKvsR3Sj/uPN/3+0nu5D+I0VU4QpcfRmZEjfvuyOczZBjDBxRcw561dvwvFps
	J6u38kJV9B+UE2lIWR0NqKEda+NjUJ/WSlCl/IcXsfQr75Fyfge/77vj83uTydl9
	qlVKsOcwA7EsxTEzIdZkQec=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=LGaAX7CV9dF2/0tteremsMg+AT09fuHHbl4uhF3SdLzH/+
	5z1XqK9SIFFbIpb6Xjt8bJkSYtsxPofI7uJdzzWNFXs9wGyD6/EB1jCwa7M1lete
	MiQMbgv9/flquhL7bpnQa4U3nUbEp8/MxmogQgjJk6vKKqpso00xYKMVuFEhw=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id F32AE4BF98;
	Sun,  6 Mar 2016 22:55:24 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 71ECC4BF95;
	Sun,  6 Mar 2016 22:55:24 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6BDF53C8-E418-11E5-B5CF-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288380>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> First of all: my main gripe with the discussed approach is that it uses
> bundles. I know, I introduced bundles, but they just seem too klunky and
> too static for the resumable clone feature.

We should make the mechanism extensible so that we can later support
multiple "alternate resource" formats, and "bundle" could be one of
the options, my current thinking is that the initial version should
use just a bare packfile to bootstramp, not a bundle.

The format being "static" is both a feature and a practical
compromise.  It is a feature to allow clone traffic, which is a
significant portion of the whole traffic to hosting sites, diverted
off of the core server network for a busy hosting site, saving both
networking and CPU cost.  And that benefit will be felt even if the
client has a good enough connection to the server that it does not
have to worry about resuming.  It is a practical compromise that the
mechanism will not be extensible for helping incremental fetch but I
heard that the server side statistics tells us that there aren't
many "duplicate incremental fetch" requests (i.e. many clients
having the same set of "have"s so that the server side can prepare,
serve, and cache the same incremental pack, which can be served on a
resumable transport, to help resuming clients by supporting
partial/range requests), I do not think it is practical to try to
use the same mechanism to help incremental and clone traffic.  One
size would not fit both here.

I think a better approach to help incremental fetches is along the
line of what was discussed in the discussion with Al Viro and others
the other day.  You'd need various building blocks implemented anew,
including:

 - A protocol extension to allow the client to tell the server a
   list of "not necessarily connected" objects that it has, so that
   the server side can exclude them from the set of objects the
   traditional "have"-"ack" exchange would determine to be sent when
   building a pack.

   - A design of deciding what "list of objects" is worth sending to
     the server side.  The total number of objects in the receiving
     end is an obvious upper bound, and it might be sufficient to
     send the whole thing as-is, but there may be more efficient way
     to determine this set [*1*]

 - A way to salvage objects from a truncated pack, as there is no
   such tool in core-git.


[Footnote]

*1* Once the traditional "have"-"ack" determines the set of objects
    the sender thinks the receiver may not have, we need to figure
    out the ones that happen to exist on the receiver end already,
    either because they were salvaged from a truncated pack data it
    received earlier, or perhaps because they already existed by
    fetching from a side branch (e.g. two repositories derived from
    the same upstream, updating from Linus's kernel tree by somebody
    who regularly interacts with linux-next tree), and exclude them
    from the set of objects sent from the sender.

    I've long felt that Eppstein's invertible bloom filter might be
    a good way to determine efficiently, among the set of objects
    the sending and the receiving ends have, which ones are common,
    but I didn't look into this deeply myself.
