From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC v2 0/2] add regex match flags to git describe
Date: Mon, 28 Dec 2015 12:30:07 -0800
Message-ID: <xmqqy4cejoz4.fsf@gitster.mtv.corp.google.com>
References: <cover.1451298323.git.mostynb@opera.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	"brian m . carlson" <sandals@crustytoothpaste.net>
To: Mostyn Bramley-Moore <mostynb@opera.com>
X-From: git-owner@vger.kernel.org Mon Dec 28 21:30:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aDeQv-000469-3u
	for gcvg-git-2@plane.gmane.org; Mon, 28 Dec 2015 21:30:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752609AbbL1UaR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Dec 2015 15:30:17 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:50534 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752437AbbL1UaP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Dec 2015 15:30:15 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CC63A38765;
	Mon, 28 Dec 2015 15:30:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BkuK6dtqLucPznAPmeazWXYrrEg=; b=chmB5v
	Av8oOcr0ka28Q42yGCa/Dlq8Tn89fRxPR++lURtyhVwnFG1NvpRsOnxeu68olofH
	s0ltetvPbcQAwMF7rYI35HM4/zbJGK3+g54ZMMJMxQbmVlI+5J2gfcM6ss45Hx4D
	AMGtfJJmXntiAG2f7g/FDCQvjkoprbk8W716I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=axo1QvtuFk8da1sRhInFMLxPqEJhkz9c
	x0VXByO8WFQr8HGqRB5EEEEfjepLc4Vb5VjDFrAqpijltdg1DjBgbN+OY1M8dOfV
	T3FlZgXAtJTiQ/O9Og0CoK5pUv9Tct23mJGRHx6xll7w2J23qbT8fTXzOGO2R78f
	g/mNl9D71FQ=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C4F0E38764;
	Mon, 28 Dec 2015 15:30:09 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 4716D38761;
	Mon, 28 Dec 2015 15:30:09 -0500 (EST)
In-Reply-To: <cover.1451298323.git.mostynb@opera.com> (Mostyn Bramley-Moore's
	message of "Mon, 28 Dec 2015 11:30:22 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C9E25BD0-ADA1-11E5-BA0D-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283048>

Mostyn Bramley-Moore <mostynb@opera.com> writes:

> git describe currently only supports glob matching with the --matches flag.
> It would be useful to support regular expressions.
>
> For consistency, this uses the same regex flags as those used by git-grep.
>
> Some old discussion of this as a candidate feature is here, though nobody put
> together a patch as far as I can see:
> http://comments.gmane.org/gmane.comp.version-control.git/173873

Thanks.

I do not think it is wrong per-se to add an option to use regular
expressions instead of globs, but if we are to do so, the endgame we
aim for MUST be that we do so consistently to all the other commands
that iterate over refs and limit their output to the ones that match
given pattern (or a set of patterns), not just 'describe'.

Even if we are not adding such an option to these other commands
right now (yet), we at least need to know what these commands are
(e.g. "git tag -l" and "git for-each-ref" immediately come to mind,
but there may be others), and make sure that the option names you
choose here can be used sensibly in their context.  I think "tag"
and "for-each-ref" do no pattern matching against anything other
than the refnames, so it would be clear what a new --perl-regexp
option does in their contexts.

Unlike "grep" whose sole point is to perform pattern matching, the
filtering of refs these commands do is merely a very small tweak in
the overall picture (e.g. "git tag --contains $commit -l $pattern"
does filter by matching $pattern against the refname, but that is a
small detail compared to the filtering done by the reachability with
the $commit), so I am not sure if short -E/-G/-F/-P should be given
to these commands like "grep" does, though.  These commands may have
better uses for these shorter option names.
