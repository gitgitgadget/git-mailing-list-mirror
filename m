From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Make 'diff C^!' show the same diff as 'show C'
Date: Thu, 20 Aug 2009 16:31:25 -0700
Message-ID: <7vocqanjua.fsf@alter.siamese.dyndns.org>
References: <86d1201d8adf53c1f48c0f3526d8e81475b18244.1250806019.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>,
	=?utf-8?Q?Bj=C3=B6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	Abhijit Menon-Sen <ams@toroid.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Aug 21 01:31:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MeH6e-0005h5-DZ
	for gcvg-git-2@lo.gmane.org; Fri, 21 Aug 2009 01:31:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932093AbZHTXbg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Aug 2009 19:31:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754596AbZHTXbf
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Aug 2009 19:31:35 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:40716 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754117AbZHTXbf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Aug 2009 19:31:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 918C512806;
	Thu, 20 Aug 2009 19:31:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:in-reply-to:date:message-id:mime-version
	:content-type; s=sasl; bh=16LoM2kDgmSBQRB+/rDT0U6SB40=; b=PWw9xE
	GWDFz1MVKVQpmea11mJ/cZmlNVzUWFD1fW2PYNu1yVd68MhVMIIslY0gfO35ef21
	DzB1ZVQ87Zq2/YlKC1dafmDO807PUOU3A6qaUrTcSl1M/cMBQ46CQiNJfTXCq9qT
	qesLFHZmXxPBwFPg70YOTU+/Fo+FIfDhQBSyw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:in-reply-to:date:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qTyw5ocEPoRRBbMfyIypMT7dkxGflNt9
	o99kF1i3YEQYW2Kv7zNSD8Bw5h606fVgG32h00IUJ+i7OpErelzdDlvhuLBjXFJg
	yHnzmK1peo+wg10WQAHEHkv9WpUXTifko0FElZN8Nf4PWjDkEJCm1Wei8OcvG60I
	MfKlbads5Bs=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 53C4612803;
	Thu, 20 Aug 2009 19:31:31 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 63788127FF; Thu, 20 Aug
 2009 19:31:26 -0400 (EDT)
In-Reply-To: <86d1201d8adf53c1f48c0f3526d8e81475b18244.1250806019.git.trast@student.ethz.ch> (Thomas Rast's message of "Fri\, 21 Aug 2009 00\:10\:07 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 974A1366-8DE1-11DE-97EB-CA0F1FFB4A78-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126661>

Thomas Rast <trast@student.ethz.ch> writes:

> * If C has no parents, setup_revision() turns C^! into simply C.  This
>   meant that 'git diff C^!' compared the current worktree to C, which
>   is certainly not what the user asked for.
>
> * Otherwise setup_revision puts C itself last, i.e., the rev.pending
>   are ^C^1 ... ^C^N C.  So the first revision is uninteresting and in
>   the case of exactly two parents, the symmetric difference revspec
>   (diff A...B) case fired, and compared C only to C^1 (instead of
>   showing a combined diff).

I actually have a vague recollection that this ugly syntax C^! (and I am
entitled to call it ugly as it was my invention) was advertised as a way
to get "diff C^..C", not the combined diff, iow, this could be deliberate
and people may depend on it.

In that light, I would say the first one (showing the root commit as root)
may be a good change, but the latter one is moderately iffy.

> @@ -292,6 +310,17 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
>  	/* Otherwise, we are doing the usual "git" diff */
>  	rev.diffopt.skip_stat_unmatch = !!diff_auto_refresh_index;
>  
> +	for (i = 1; i < argc; i++) {
> +		if (prefixcmp(argv[i], "--")) {
> +			if (strstr(argv[i], "..."))
> +				mode = DIFF_MODE_SYMMETRIC;
> +			else if (strstr(argv[i], "^!"))
> +				mode = DIFF_MODE_SHOW;
> +		} else if (!strcmp(argv[i], "--")) {
> +			break;
> +		}
> +	}
> +

This is too ugly beyond words.  

We already mark the left side commit "..." with SYMMETRIC_LEFT bit, so you
should be able to detect it from the setup_revisions() result.  If we were
to formerly add some special meaning (other than being a short-hand of
^C^n C) to the ugly C^! syntax, I would suggest marking the result of in a
similar way to allow you to detect it from the result.

But I do mean moderately strong negativeness when I say "if we _were_"
above.

As far as I recall, there were only two reasons C^! was invented for
(actually, one that was invented for, and another that was found to be
useful).

One was so that you can say "The traversal should stop around this commit,
but I want the commit itself to be included in the result".

	$ git log v1.6.3^! v1.6.3.1

This is much less useful than it used to be back when C^! was invented, as
we can ask for --boundary these days.

The other utility later found was "to view diff with its first parent".  I
think it is a useful mode of operation, and we should add a simpler way to
ask for it to "git show", as people often ask to view a merge not in the
combined way, but a simple diff relative to the merged-to commit, to get
an overview of the work done by the side branch.

So if anything, I'm actually for deprecating C^! syntax and removing it
before we hit 1.7.0.
