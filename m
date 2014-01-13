From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC v2] blame: new option --prefer-first to better handle merged cherry-picks
Date: Mon, 13 Jan 2014 14:26:26 -0800
Message-ID: <xmqqfvor5xil.fsf@gitster.dls.corp.google.com>
References: <20140113063008.GA3072@client.brlink.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Bernhard R. Link" <brlink@debian.org>
X-From: git-owner@vger.kernel.org Mon Jan 13 23:26:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W2pyB-0002OZ-GG
	for gcvg-git-2@plane.gmane.org; Mon, 13 Jan 2014 23:26:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751623AbaAMW0c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jan 2014 17:26:32 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:32804 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751388AbaAMW0a (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jan 2014 17:26:30 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DB7EA619D8;
	Mon, 13 Jan 2014 17:26:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AntxE1OqvKViejeXYmen642OLrU=; b=uEFVVL
	EkWiDKDrjIilDeHKI8aY1sD0HFfzJURyARKn6KeEQd8y3n5U5M/KK9/1P0e2pVXn
	Ne79gMr7FvICNAVDfnwHVx/v05CXTwZXa1/QBPQsvXvIbqX+qV88geNlzz4RP5NQ
	bp7yEEKL8dI44oJsTg9eiZTaKJg5f7H9QyR4o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=a64PeTfo9Bz8bw+lZWAInXxhzxGBPNQx
	g/EhziMeQAp7/FND7r0mJ4wJfTWFi5yMZmMsXbknnSIlCibXpcPYf3hjgaXDO4wt
	o5o9bX8W/cktyM0HN9jojuuVokEfz3ej12fPb8BADFQCUqGPXe6BWIDBfXBFPK1C
	RVos+G4rDvs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C7BBD619D5;
	Mon, 13 Jan 2014 17:26:29 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EA651619D4;
	Mon, 13 Jan 2014 17:26:27 -0500 (EST)
In-Reply-To: <20140113063008.GA3072@client.brlink.eu> (Bernhard R. Link's
	message of "Mon, 13 Jan 2014 07:30:25 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: BE8C4BCA-7CA1-11E3-9860-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240376>

"Bernhard R. Link" <brlink@debian.org> writes:

> Allows to disable the git blame optimization of assuming that if there is a
> parent of a merge commit that has the exactly same file content, then
> only this parent is to be looked at.
>
> This optimization, while being faster in the usual case, means that in
> the case of cherry-picks the blamed commit depends on which other commits
> touched a file.
>
> If for example one commit A modified both files b and c. And there are
> commits B and C, B only modifies file b and C only modifies file c
> (so that no conflicts happen), and assume A is cherry-picked as A'
> and the two branches then merged:
>
> --o-----B---A
>    \         \
>     ---C---A'--M---
>
> Then without this new option git blame blames the A|A' changes of
> file b to A while blaming the changes of c to A'.
> With the new option --prefer-first it blames both changes to the
> same commit and to the one more on the "left" side of the graph.
>
> Signed-off-by: Bernhard R. Link <brlink@debian.org>
> ---
>  Documentation/blame-options.txt | 6 ++++++
>  builtin/blame.c                 | 7 +++++--
>  2 files changed, 11 insertions(+), 2 deletions(-)
>
>  Differences to first round: rename option and describe the effect
>  instead of the implementation in documentation.

I read the updated documentation three times but it still does not
answer any of my questions I had in $gmane/239888, the most
important part of which was:

    Yeah, the cherry-picked one will introduce the same change as
    the one that was cherry-picked, so if you look at the end result
    and ask "where did _this_ line come from?", there are two
    equally plausible candidates, as "blame" output can give only
    one answer to each line.  I still do not see why the one that is
    picked with the new option is better.  At best, it looks to me
    that it is saying "running with this option may (or may not)
    give a different answer, so run the command with and without it
    and see which one you like", which does not sound too useful to
    the end users.

To put it another way, why/when would an end user choose to use this
option?  If the result of using this option is always better than
without, why/when would an end user choose not to use this option?

> diff --git a/Documentation/blame-options.txt b/Documentation/blame-options.txt
> index 0cebc4f..b2e7fb8 100644
> --- a/Documentation/blame-options.txt
> +++ b/Documentation/blame-options.txt
> @@ -48,6 +48,12 @@ include::line-range-format.txt[]
>  	Show the result incrementally in a format designed for
>  	machine consumption.
>  
> +--prefer-first::
> +	If a line was introduced by two commits (for example via
> +	a merged cherry-pick), prefer the commit that was
> +	first merged in the history of always following the
> +	first parent.
> +
>  --encoding=<encoding>::
>  	Specifies the encoding used to output author names
>  	and commit summaries. Setting it to `none` makes blame
