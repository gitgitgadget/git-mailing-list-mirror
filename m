From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 2/2] stash: drop dirty worktree check on apply
Date: Tue, 05 Apr 2011 14:59:36 -0700
Message-ID: <7vvcysl5pz.fsf@alter.siamese.dyndns.org>
References: <20110405212025.GA3579@sigill.intra.peff.net>
 <20110405212314.GA3613@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Nanako Shiraishi <nanako3@lavabit.com>,
	Brian Lopez <brian@github.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Apr 05 23:59:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7EI0-00029y-ON
	for gcvg-git-2@lo.gmane.org; Tue, 05 Apr 2011 23:59:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751479Ab1DEV7v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Apr 2011 17:59:51 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:44561 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750940Ab1DEV7v (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Apr 2011 17:59:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id AE7CC4E96;
	Tue,  5 Apr 2011 18:01:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=h/vO/D3X3UJ2O4LxmCg1LgixIko=; b=kMzJd2
	+Hw8N9zthIJ2pwDJ+UD9QUliwe5zrR28W0obdxF/rrgGUedaMY18SCcfwdRfRM8C
	LXr2lO3DOIkGqN//b4jhKEjCywTdgF/9fKFN/6iy0eSBxUrDexhJ9SEF5p8HG4Vr
	DLmkI7IX4SEovZvM8m0RZEChI2Y2Z0WNE446s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZEIvGtajcFlT1lh6o7hfbKPRh5zSKR12
	nmlBDi9hIl/z9YbkzaAwpgrG6Ylw6m84Rm0+7visb2GX8n0d3kPFhXK8bT4l7wev
	ybgY37czYchCB7FHkd1SqBc+XosCKacp5Z9Pj6O8bF7re1dlImgdzFEQ/8ZSpy72
	gReXMJwFI+M=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4FC674E8F;
	Tue,  5 Apr 2011 18:01:37 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 6FF1B4E8A; Tue,  5 Apr 2011
 18:01:31 -0400 (EDT)
In-Reply-To: <20110405212314.GA3613@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 5 Apr 2011 17:23:15 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 471B38C6-5FD0-11E0-AB3F-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170924>

Jeff King <peff@peff.net> writes:

> However, this check has two problems:
>
>   1. It is overly restrictive. If my stash changes only file
>      "foo", but "bar" is dirty in the working tree, it will
>      prevent us from applying the stash.
>
>   2. It is redundant. We don't touch the working tree at all
>      until we actually call merge-recursive. But it has its
>      own (much more accurate) checks to avoid losing working
>      tree data, and will abort the merge with a nicer
>      message telling us which paths were problems.

I _think_ the reason we originally insisted on clean working tree was that
while merge-resolve has always had an acurate check, merge-recursive's
check was not very good, especially when renames are involved.  So
probably this part of your comment ...

> I'm not sure if the check was perhaps even required when git-stash was
> written, and has simply since become useless as merge-recursive became
> more careful.

... may need to be used to rewrite bullet 2. above.

This is a tangent, but I notice that the additional bolted-on codepath for
the --index option has this:

    git diff-tree --binary $s^2^..$s^2 | git apply --cached

It might want to do -B -M to match what "git merge-recursive" does.
