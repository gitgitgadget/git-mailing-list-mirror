From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] revision.c: propagate tag names from pending array
Date: Thu, 17 Dec 2015 12:28:48 -0800
Message-ID: <xmqqoadobz0f.fsf@gitster.mtv.corp.google.com>
References: <20151217064706.GA3531@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Dec 17 21:29:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a9fAd-0008Ih-C5
	for gcvg-git-2@plane.gmane.org; Thu, 17 Dec 2015 21:29:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932193AbbLQU25 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Dec 2015 15:28:57 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:56325 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932139AbbLQU24 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Dec 2015 15:28:56 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8035E352B5;
	Thu, 17 Dec 2015 15:28:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=e+619Hy1RSpHGFJAczR1RwxYtng=; b=rPXtPK
	GiHu+1mZzHRYFTFl0edDvDKt9mWDxHOjg0Fhx81xm8sVucWuFgrc9L4Jzz3DwYia
	n54glKVMKlp7mPqVy1Oxk7YrYRsaAOLvLL3mCBK55A6kFoaqpRn/XonPa+3dVe5H
	gJp6AG+YURT6oyHpx8XVLu4JogqrTpxRmO2AY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TLCSgJmTywp1XN2/nFVL0mME4V9p0XTt
	pKVt2iKTX1KkaEoDAtfDyShdK3rgjtyIx/55wyVVlb4orbUsc3Wb0vhcyEIk77ST
	ni5ywoYqhMkaA1bWhGgcrD8MxOiXUFanZ5gTZQMBCdpoHeSGKTaH3Q+iMIcBDFXu
	0iLgahH5JnM=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 77A9E352B4;
	Thu, 17 Dec 2015 15:28:50 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id E455C352B2;
	Thu, 17 Dec 2015 15:28:49 -0500 (EST)
In-Reply-To: <20151217064706.GA3531@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 17 Dec 2015 01:47:07 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C80A1152-A4FC-11E5-908F-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282673>

Jeff King <peff@peff.net> writes:

> When we unwrap a tag to find its commit for a traversal, we
> do not propagate the "name" field of the tag in the pending
> array (i.e., the ref name the user gave us in the first
> place) to the commit (instead, we use an empty string). This
> means that "git log --source" will never show the tag-name
> for commits we reach through it.
>
> This was broken in 2073949 (traverse_commit_list: support
> pending blobs/trees with paths, 2014-10-15). That commit
> tried to be careful and avoid propagating the path
> information for a tag (which would be nonsensical) to trees
> and blobs. But it should not have cut off the "name" field,
> which should carry forward to children.
> ...
> This was reported several weeks ago, but I needed to take the time to
> convince myself this wasn't regressing any cases. I'm pretty sure it's
> the right thing to do.
>
> The regression is in v2.2.0, so this is not urgent to make it into v2.7
> before release, but it is definitely maint-worthy.

Makes sense, and I agree.

By the way, a totally unrelated niggle I have with 2073949 is this.

    $ git describe --contains 2073949
    v2.3.1~3^2~4

while as you said, this dates back to at least v2.2.0-rc0

    $ git tag --contains 2073949
    v2.2.0
    v2.2.0-rc0
    ...
    v2.7.0-rc1

That "describe --contains" output comes from "name-rev --tags", and
I need to force it to use v2.2.0-rc0 as the source of naming, i.e.

    $ git name-rev --refs=refs/tags/v2.2.0-rc0 2073949
    2073949 tags/v2.2.0-rc0~13^2~9

to get what I would expect to be more useful.

I know "name-rev --contains" wants to describe a commit based on an
anchor point that is topologically closest, and even though I do not
offhand think of any, I am sure there are valid use cases that want
to see the current behaviour.  But from time to time, I wish it did
its naming taking the topological age of the anchor points into
account.  If a commit is contained in v2.2.0-rc0 and onward, even
though v2.0.0-rc0~13^2~9 describes a longer path from v2.0.0-rc0
than v2.3.1~3^2~4 is from v2.3.1, I often want to see the name based
on the "oldest" tag (if such a thing exists, and for older commits
in this project, it always is the case, I think).
