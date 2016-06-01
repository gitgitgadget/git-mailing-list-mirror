From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/4] Fix prune/gc problem with multiple worktrees
Date: Wed, 01 Jun 2016 09:06:49 -0700
Message-ID: <xmqqshwwzyee.fsf@gitster.mtv.corp.google.com>
References: <574D382A.8030809@kdbg.org>
	<20160601104519.16563-1-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
	Jeff King <peff@peff.net>, mhagger@alum.mit.edu,
	dturner@twopensource.com
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 01 18:06:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b88fa-0004Yn-CR
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jun 2016 18:06:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751385AbcFAQGy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Jun 2016 12:06:54 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60296 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750727AbcFAQGx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Jun 2016 12:06:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 36F8021687;
	Wed,  1 Jun 2016 12:06:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=0jolUae71ETC
	L+Yf/4Ei2zKS37E=; b=xMpD8/4J0m/vjAVvZ2IOVYcpUj10tUuNkPaInccg3S9m
	TXFGL+HQnJXlOEcvYfQUKiMomBxJDc2xq3XzVO8k1rVZVFj980U44MQtFOtQ1V66
	FtuHDaxidjpl9KlQHs7qzEr6A5Y93H0r/E6F8wa5tFyD7rNQDVponjdpCQdF+Lg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=AqF6O0
	D8MhBdm1br+GUbmC1UsVFE2mEYhoqrVLflsloNR7uoZYr19UCRmbWFPNyMMMwF+y
	dsdw6LmrC9lIi8dzGWKUSEhAKBJ2N5pX3C2OScyXeF5SwJOfFd7XB76FV4tsHn1C
	85CyH5ySsqhjZfU0OOmwfGk+HlqxjJKrWMn4A=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2FE4A21686;
	Wed,  1 Jun 2016 12:06:52 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AC9B721685;
	Wed,  1 Jun 2016 12:06:51 -0400 (EDT)
In-Reply-To: <20160601104519.16563-1-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
	Duy"'s message of "Wed, 1 Jun 2016 17:45:15 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: DA3AE416-2812-11E6-A5AA-89D312518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296094>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> This series makes sure that objects referenced by all worktrees are
> marked reachable so that we don't accidentally delete objects that ar=
e
> being used. Previously per-worktree references in index, detached HEA=
D
> or per-worktree reflogs come from current worktree only, not all
> worktrees.

I'll let this topic simmer on the list for now, instead of picking
it up immediately to 'pu', as Michael in $gmane/296068 makes me
wonder if we want to keep piling on the current "worktree ref
iterations are bolted on" or if we want to first clean it up, whose
natural fallout hopefully would eliminate the bug away.

Thanks.

> The series deals with git-prune and git-gc specifically. I left out
> "git rev-list". It shares the same problem because it will only
> consider current worktree's HEAD, index and per-worktree reflogs. The
> problem is I am not sure if we simply just change, say
> --indexed-objects, to cover all indexes, or should we only do that
> with "--all-worktrees --indexed-objects". I guess this is up for
> discussion.
>
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (4):
>   revision.c: move read_cache() out of add_index_objects_to_pending()
>   reachable.c: mark reachable objects in index from all worktrees
>   reachable.c: mark reachable detached HEAD from all worktrees
>   reachable.c: make reachable reflogs for all per-worktree reflogs
>
>  reachable.c      | 47 +++++++++++++++++++++++++++++++++++++++++-----=
-
>  revision.c       | 34 +++++++++++++++++++++++++++-------
>  revision.h       |  7 ++++++-
>  t/t5304-prune.sh | 40 ++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 114 insertions(+), 14 deletions(-)
