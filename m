From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] travis-ci: run previously failed tests first, then slowest to fastest
Date: Sun, 24 Jan 2016 12:03:49 -0800
Message-ID: <xmqqd1sqd9sq.fsf@gitster.mtv.corp.google.com>
References: <1453195469-51696-1-git-send-email-larsxschneider@gmail.com>
	<20160119191234.GA17562@sigill.intra.peff.net>
	<xmqqegdd8997.fsf@gitster.mtv.corp.google.com>
	<20160120002606.GA9359@glandium.org>
	<xmqqfuxt6n00.fsf@gitster.mtv.corp.google.com>
	<DBA834D2-BFC9-4A2F-94D9-A1D0D60377BD@gmail.com>
	<20160122023359.GA686558@vauxhall.crustytoothpaste.net>
	<20160122055255.GA14657@sigill.intra.peff.net>
	<20160122060720.GA15681@sigill.intra.peff.net>
	<20160124143403.GL7100@hank>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Lars Schneider <larsxschneider@gmail.com>,
	Mike Hommey <mh@glandium.org>, git@vger.kernel.org
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 24 21:04:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aNQtG-0003M7-1J
	for gcvg-git-2@plane.gmane.org; Sun, 24 Jan 2016 21:04:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751947AbcAXUD7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jan 2016 15:03:59 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:52017 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751412AbcAXUD5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jan 2016 15:03:57 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 919A83D66C;
	Sun, 24 Jan 2016 15:03:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZWVdqiC33KMpuWPWTpUb1K9lnRY=; b=ZIJuiV
	Q5f2LmaWDVN0jF4lsewfW8ZL/Yw6to0wT3QSn8BHsSmi9PjfvNCP2l67Pi264Skj
	t15WmaqkhRnYz3UUJ4ArLBfZIbHcuukJwXn0deAL5iBaStvsXc49w/m8b5B3sFv0
	7Hv2MW5zEbV6bQAV9Nusm4wuh+E3AX0kq1pRA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SkDQpzyR7yt5jN91Wd2PBDix9pJLUIsa
	D4YybtOUPIeK7d20uYvG6aQEbVYFoy3ScK1Fp7DzfMcbTXaeKFbZ4weG49sy42uh
	9+VXgkV8eIaQkaJVhAo7vf/81VbXLz8nLU2zEek9qTcakB2/nWuN69bBjWdu8cmt
	gFlaY++m25M=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 89A123D66B;
	Sun, 24 Jan 2016 15:03:51 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 066AC3D66A;
	Sun, 24 Jan 2016 15:03:51 -0500 (EST)
In-Reply-To: <20160124143403.GL7100@hank> (Thomas Gummerer's message of "Sun,
	24 Jan 2016 15:34:03 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 965C188E-C2D5-11E5-B052-80A36AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284692>

Thomas Gummerer <t.gummerer@gmail.com> writes:

> My analysis is in the commit message below.
>
> --->8---
> Subject: [PATCH] entry: fix up to date marking
>
> write_entry always marks cache entries up to date when
> state->refresh_cache is set.  This is however not always accurate,
> if core.autocrlf is set in the config, a file with cr and lf line
> endings exists and the file attribute is set to text or crlf in the
> gitattributes.
>
> Most notably this makes t0025 flaky.  When calling deleting the files
> that will be adjusted through the automated crlf handling, and then
> calling `git read-tree --reset -u HEAD`, this leads to a race between
> git read-tree and the filesystem.  The test currently only passes
> most of the time, because the filesystem usually isn't synced between
> the call to unpack_trees() and write_locked_index().
>
> Currently the sequence of 1) remove files with cr and lf as line
> endings, 2) `git read-tree --reset -u HEAD` 3) checking the status of
> the changed files succeeds, because the index and the files are written
> at the same time, so they have the same mtime.  Thus when reading the
> index the next time, the files are recognized as racy, and the actual
> contents on the disk are checked for changes.
>
> If the index and the files have different mtimes however, the entry is
> written to the index as up to date because of the flag set in
> entry.c:write_entry(), and the contents on the filesystem are not
> actually checked again, because the stat data in the index matches.
>
> The failures in t0025 can be consistently reproduced by introducing a
> call to sync() between the call to unpack_trees() and
> write_index_locked().
>
> Instead of blindly marking and entry up to date in write_entry(), check
> if the contents may change on disk first, and strip the CE_UPTODATE flag
> in that case.  Because the flag is not set, the cache entry will go
> through the racy check when writing the index the first time, and
> smudged if appropriate.

Sorry, but I am confused by all of the above.

We write the thing out with write_entry(), possibly applying smudge
filters and eol conversion to the "git" representation to create the
"working tree" representation in this codepath, right?  The resulting
file matches what the user's configuration told us to produce.

Until the working tree file is changed by somebody after the above
happens, we shouldn't have to check the contents of the file to see
if there is a difference.  By definition, that has to match the
contents expected to be there by Git.

The only case I can think of that the above does not hold is when
the smuge/clean and the eol conversion are not a correct round-trip
operation pairs, but that would be a misconfiguration.  Otherwise,
we'd be _always_ comparing the contents without relying on the
cached stat info for any paths whose in-core and working tree
representations are different, not just those that are configured
with misbehaving smudge/clean pair, no?

Puzzled...  In this case, my hunch says that the patch is correct,
your analysis also is and it is only me who is missing some crucial
bits in the analysis and getting confused.

Enlightenment, please?

>
> This fixes the flaky test as well as the underlying problem.
>
> Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> ---
>  entry.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/entry.c b/entry.c
> index 582c400..102fdfa 100644
> --- a/entry.c
> +++ b/entry.c
> @@ -214,6 +214,8 @@ finish:
>  		if (!fstat_done)
>  			lstat(ce->name, &st);
>  		fill_stat_cache_info(ce, &st);
> +		if (would_convert_to_git(ce->name))
> +			ce->ce_flags &= ~CE_UPTODATE;
>  		ce->ce_flags |= CE_UPDATE_IN_BASE;
>  		state->istate->cache_changed |= CE_ENTRY_CHANGED;
>  	}
> --
> 2.7.0.75.g3ee1e0f.dirty
