From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Migrating away from SHA-1?
Date: Tue, 12 Apr 2016 18:03:02 -0700
Message-ID: <xmqqlh4imibd.fsf@gitster.mtv.corp.google.com>
References: <570D78CC.9030807@zytor.com>
	<20160412234251.GB2210@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 13 03:03:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aq9DQ-0004sB-Gn
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 03:03:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757851AbcDMBDH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Apr 2016 21:03:07 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:58768 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756426AbcDMBDG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Apr 2016 21:03:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D0CC855E30;
	Tue, 12 Apr 2016 21:03:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EXccqC1R26khwkLX5GcJ6bF0New=; b=ZiZuQg
	PQs4VRKjmBuk6Y5/1IoscSsgcXFH4u0/tYdFevwP+g/aBvtmKmSrQVJDSzqQCaJH
	w4utWZcvYBekwxYwAMTpNBDLjpSnm30WLAMneLi56T1G/FiwFVY4Ri5SGI9I18z8
	pQqsgpz2QPXojEg8V3NBJEaih9vyDfdVAFWH0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dYRO436p7uq7bKLlkatjgkThWbhFhEyg
	tAxdZUV4VBpE7105nGT8oWS2yxeBhND8jrsOPTirPnXZsH6xIe4ny1ihUq2MIi9O
	te9tAdyKc+MoXzQ/y5Ud12k9idQ9OSLBC3xUcNZAFUqKpMxb+QO4LqCqSknhhDm+
	Ldeo8D/1Qo8=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C852055E2E;
	Tue, 12 Apr 2016 21:03:03 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 4C1FA55E2B;
	Tue, 12 Apr 2016 21:03:03 -0400 (EDT)
In-Reply-To: <20160412234251.GB2210@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 12 Apr 2016 19:42:52 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 7958D39A-0113-11E6-A021-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291354>

Jeff King <peff@peff.net> writes:

> So a slightly nicer thing is to parameterize the algorithm for every
> object name reference. So commits look like:
>
>   tree sha256:1234abcd...
>   parent sha256:1234abcd...
>
> and so on. Of course trees don't have any space for this; they have a
> fixed-length for the hash part of each record, which is basically:
>
>   <mode> <name> NUL <20-byte-sha1>
>
> So we'd probably need a "treev2" object type that gives room for an
> algorithm byte (or we'd have to try to shove it into the mode, but since
> old versions won't know the new algorithm anyway, I don't think it
> solves that much...). Or you can just define for the whole tree object
> (either implicit in its type, or in a header) that it always uses
> algorithm X.

This will hurt the performance a lot during the transition period as
it no longer will be possible to rely on "most of the time a fine
grained commit changes only a small part of the tree, and we can
cheaply avoid descending into trees that haven't changed because we
can tell that the corresponding tree objects in the pre- and post-
trees have the same object name" optimization.  But we cannot avoid
it.

> Transitioning to that would be something like:
>
>   0. Overhaul all of the git code to handle arbitrary-sized object ids.
>
>   1. Decide on the new algorithm and implement it in git.
>
>   2. Recognize parameterized object ids in commits and tags (designing
>      format, implementing the reading side).
>
>   3. Recognize parameterized object ids somehow in trees (designing
>      format, implementing the reading side).
>
>   4. Teach the object database to index objects by the new algorithm (or
>      possibly both algorithms).
>
>   5. Add a protocol extension so that both sides can decide which
>      algorithm is being used when they talk about oids.
>
>   6. Add a config option to write references in objects using the new
>      algorithm.
>
>   7. After a while, flip the config option on. Hopefully the readers
>      from steps 1-5 have percolated to the masses by then, and it's not
>      a horrible flag day.
>
> We're basically on step 0 right now. I'm sure I'm missing some
> subtleties in there, too.

One subtlety is that 7. "not a flag day" may not be a good thing.

There has to be a section of a history that spans the transition,
set of commits and trees that have pointers to both kinds of object
names.  The narrower such a section of the history, the more
pleasant to use the result of the transition would be.

Different projects that can have their own flag days at their own
pace is a good thing, so the above observation does not invalidate
your transition plan, though.
