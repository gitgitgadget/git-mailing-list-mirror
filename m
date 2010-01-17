From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Performance optimization for detection of modified
 submodules
Date: Sun, 17 Jan 2010 12:01:24 -0800
Message-ID: <7vska4xzzf.fsf@alter.siamese.dyndns.org>
References: <4B4BA096.5000909@web.de>
 <7vtyusb6rv.fsf@alter.siamese.dyndns.org> <4B4CA13F.6020505@web.de>
 <7vbpgyqy4a.fsf@alter.siamese.dyndns.org> <4B4E1817.1070202@web.de>
 <7v6375lkpj.fsf@alter.siamese.dyndns.org> <4B4F8EF1.3080709@web.de>
 <7v3a288em2.fsf@alter.siamese.dyndns.org> <4B535E97.1020809@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Heiko Voigt <hvoigt@hvoigt.net>, Lars Hjemli <hjemli@gmail.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Sun Jan 17 21:01:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NWbJi-0001oi-E2
	for gcvg-git-2@lo.gmane.org; Sun, 17 Jan 2010 21:01:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754393Ab0AQUBm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Jan 2010 15:01:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754404Ab0AQUBm
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Jan 2010 15:01:42 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:50406 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754329Ab0AQUBl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jan 2010 15:01:41 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id BF77591EF6;
	Sun, 17 Jan 2010 15:01:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OFHdCa1OU/4KIu0Bid3pE0qC/gg=; b=vKOcsc
	06aVLrq+nI/Xt6U+6vbLIe4HHk2VZw3dTK2M6qtDbrrZOH3qavRzX989zuTmYtSy
	ZZV/56G0ZkjXHPYS7vLTL9xA5eZdmhBiWjrEy8mLaGXy2R4d2h7H5gDgvvZPNqua
	W5wTB6uPLXYtg2f5vRV7Qfp14TG+xQ+AVdJvM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hD8ZfPNDbf5ckBf6jr2fiC3kGcpwvR19
	Pq6+U+9Tveyki3B5q/M1BlE1FiVG3qVP47voIZTsLwrW0wS/swmNKHBj1QrPl+jZ
	+eqhcgVUw9f/4L/6TgwEyorr2gG0HAirl/Ku3JZ3/iETVf5A4MbLoGSsdG2kKcef
	LlFdQ8zZ9Tw=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 59B9291EEC;
	Sun, 17 Jan 2010 15:01:33 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3BE4B91EE5; Sun, 17 Jan
 2010 15:01:26 -0500 (EST)
In-Reply-To: <4B535E97.1020809@web.de> (Jens Lehmann's message of "Sun\, 17
 Jan 2010 20\:01\:43 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 1C46AD2C-03A3-11DF-8E0F-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137316>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> So here is my first attempt of implementing your proposal. The test suite
> runs fine, but a few more eyeballs would really be appreciated as i am not
> very familiar with the code and its corner cases (See diff_change(), is it
> sufficient to only set "two->dirty_submodule", even if the REVERSE_DIFF
> option is set? Apart from that i am not so sure about the four changes to
> tree-diff.c).

The effect of REVERSE_DIFF bit is contained in the output layer.  The
order frontends (e.g. diff-files and diff-lib.c::run_diff_files()) feed
the entries from two hierarchies is not affected.

The current callers of addremove() may always give the work tree side as
the second one, but the API is meant to be usable by any other new callers
and for some of them feeding the work tree side as the first one _might_
be more sensible (we are talking about futureproofing, so by definition we
won't know).  It might even be the case where an unanticipated new caller
might be comparing two trees both living in the work tree (hence you might
require two independent dirty_submodule bits to the call to show which
side is dirty, and such a caller may say "both sides are dirty").

So it would be most future-proof if you add two independent "dirty" bits
to the API if you are changing it: "is the left side of the comparision a
dirty submodule?" and "is the right side ...?".  Especially I don't think
assuming "setting two->dirty is enough for the current implementation" is
the right way going forward.

> I think we could skip the call to is_submodule_modified() in
> run_diff_files() and get_stat_data() when the changed flag is already
> set and only short output (without calling diff_populate_gitlink(), e.g.
> "git status -s" or "git diff-files") is requested.

I am puzzled by your "we could skip"; isn't it what you already have done
in this patch?  More importantly, I think that is the whole point of the
change to diff API this patch brings in.

> What do you think
> about doing that in a seperate patch?

Doing these in this same patch like you did is better, as it demonstrates
how the callers benefit by the addition of these new bits to the API.
