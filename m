From: Junio C Hamano <gitster@pobox.com>
Subject: Re: diff: --quiet does not imply --exit-code if --diff-filter is
 present
Date: Tue, 31 May 2011 08:46:29 -0700
Message-ID: <7vvcwqkh4a.fsf@alter.siamese.dyndns.org>
References: <87wrh7jgzk.wl@dns1.atmark-techno.com>
 <20110531153356.GB2594@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Yasushi SHOJI <yashi@atmark-techno.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 31 17:46:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QRR9Y-0002OR-DP
	for gcvg-git-2@lo.gmane.org; Tue, 31 May 2011 17:46:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756984Ab1EaPqk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 May 2011 11:46:40 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:33202 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752278Ab1EaPqj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 May 2011 11:46:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 485E9446C;
	Tue, 31 May 2011 11:48:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=X85EJuZeuDKiz6LwNj2AOjRXBaQ=; b=neTA4r
	5GP4rM4TYj5dGh/ElTEb6WuvmKhmGDCJzIYO6BqdISO3SzjXYoPlR9+q3JttdDDt
	hv+kwbfiCwJIyLXJw/h2Qre/gndt/evTQ6WzO6cuh4pM+6d9DtT/5WLAE1zTrdql
	sdn3xhte9xWsC8Cd406O512B0J8y988l05D0M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HvBPTuNA/XCWtknNK1W3EWtm/fIwKulV
	uzJU0x5xIWRLi04jDbi+smd1H0o7cpzql4TrOx4e50ayuVY2MU66adGA87zSQriR
	7MtBk/FTb/eLAvt+i9IPmdKV7HUfnudrDSumcJ65ExK25ygoRC8mAQdqKBaXx1Jd
	G7pB79caLbI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 138584468;
	Tue, 31 May 2011 11:48:45 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id CC84B4456; Tue, 31 May 2011
 11:48:40 -0400 (EDT)
In-Reply-To: <20110531153356.GB2594@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 31 May 2011 11:33:56 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 775858EA-8B9D-11E0-BE2F-D6B6226F3D4C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174807>

Jeff King <peff@peff.net> writes:

> Commit 2cfe8a6 (diff --quiet: disable optimization when
> --diff-filter=X is used, 2011-03-16) fixes this in some
> cases by disabling the optimization when a filter is
> present. However, it only tweaked run_diff_files, missing
> the similar case in diff_tree. Thus the fix worked only for
> diffing the working tree and index, but not between trees.

Thanks; a natural question is if we need the same for diff-index, then.

> diff --git a/tree-diff.c b/tree-diff.c
> index 7a79660..3d08f78 100644
> --- a/tree-diff.c
> +++ b/tree-diff.c
> @@ -143,6 +143,7 @@ int diff_tree(struct tree_desc *t1, struct tree_desc *t2,
>  
>  	for (;;) {
>  		if (DIFF_OPT_TST(opt, QUICK) &&
> +		    !opt->filter &&
>  		    DIFF_OPT_TST(opt, HAS_CHANGES))
>  			break;
>  		if (opt->pathspec.nr) {

We probably want to have a helper in diff.c that does

	int diff_can_quit_early(struct diff_options *opt)
        {
        	return (DIFF_OPT_TST(opt, QUICK) &&
                	!opt->filter &&
                        DIFF_OPT_TST(opt, HAS_CHANGES));
	}

It is possible for us to later add new diffcore transformations that need
a similar "do not stop feeding early, as results may be filtered".
