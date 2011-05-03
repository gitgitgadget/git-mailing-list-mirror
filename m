From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] Add default merge options for all branches
Date: Tue, 03 May 2011 15:03:16 -0700
Message-ID: <7vwri7h26z.fsf@alter.siamese.dyndns.org>
References: <20110503090351.GA27862@elie> <4DC0608F.9040208@dailyvoid.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	vmiklos@frugalware.org
To: Michael Grubb <devel@dailyvoid.com>
X-From: git-owner@vger.kernel.org Wed May 04 00:03:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHNgz-0006jS-TE
	for gcvg-git-2@lo.gmane.org; Wed, 04 May 2011 00:03:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752689Ab1ECWDh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 May 2011 18:03:37 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:56640 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750936Ab1ECWDg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2011 18:03:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 140CB576C;
	Tue,  3 May 2011 18:05:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Ciw5BoUAIBf2+cfL83pd90HDRgQ=; b=RDPQ9J
	ErkAUrP8SPqwBNFHxW+ssPTzx1AsiXJtuGxBMG6BTtEv0kAnSWwIkDuQ30uDgjT0
	c+UlMtj4zLx1XOn+weMk9bglTS8PEhmnDyNo2DojG+Pgk2BIw0XLBYdbbPYg7WOh
	/2Vz2TwSTU/GudzLXaixDLfgCPc+1umYZqrf8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BCz97bC77ATItMn0jNCK8jngMXq3Olm9
	5554hEGEY8n9Hsy0RpIFYEBjkadqtuc8zLwtkXyaSfy0PY1S95niaV44YWxbYmOb
	F78KOZQ+QbjDlURFiYf51WRUfxvOo7mAc8aBogG6bL+uLZwv45YWB2kQqbG1USr0
	fsfzEB/snQI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C4295576A;
	Tue,  3 May 2011 18:05:30 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 7D9865769; Tue,  3 May 2011
 18:05:20 -0400 (EDT)
In-Reply-To: <4DC0608F.9040208@dailyvoid.com> (Michael Grubb's message of
 "Tue, 03 May 2011 15:07:43 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 75DE1B9E-75D1-11E0-8973-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172698>

Michael Grubb <devel@dailyvoid.com> writes:

/*
 * Our Multi-line comments begin with a line with
 * slash asterisk then newline.
 */

> +/* This is for branch.<foo>. blocks
> + * the vote member holds a value between
> + * 0.0 and 1.0 which measures how closely
> + * a branch name matches the key member.
> + * where branch.*.mergeoptions would be 0.1 and
> + * branch.<name>.mergeoptions would be 1.0
> + * Also it is called vote because I couldn't come
> + * up with a better name.
> + */

How about simply dropping that "vote" thing?  I do not want to see
unnecessary float creeping into our codebase.

The k and v parameters are volatile from the point of view of this
function.  You need to xstrdup() them to keep a copy.

There is no need to store "branch." part in cb->key, as it is common
across the variables.

The logic would probably look like this:

	if (prefixcmp(k, "branch."))
		return;
	k += 7; /* past "branch." part */
	eon = strrchr(k, '.'); /* end-of-name 8/
        if (!eon || strcmp(eon, ".mergeoptions"))
        	return;

	/* k thru eon is the name or wildcard */
	spec = xmemdupz(k, eon - k);
        /*
         * NEEDSWORK: for now we say "*" matches; we would need
         * to turn the following into something like:
         *	if (has_wildcard(spec) 
	 *		? !glob_matches(spec, branch)
	 *		: strcmp(spec, branch)) {
         *		free(spec);
         *		return;
         *	}
         */
	if (strcmp(spec, "*") && strcmp(spec, branch)) {
        	free(spec);
                return;
	}

        if (!merge_options->option ||
             cmp_specificity(merge_options->spec, spec) < 0) {
		/* use this one */
                free(merge_options->spec);
                free(merge_options->option);
                merge_options->option = xstrdup(v);
                merge_options->spec = spec;
		return;
	}
        free(spec);

And then cmp_specificity() would say something like:

	static int cmp_specificity(const char *a, const char *b)
        {
        	switch ((!strcmp(a, "*") ? 2 : 0) |
                	(!strcmp(b, "*") ? 1 : 0)) {
		case 3:
                        /*
                         * NEEDSWORK: when we start truly globbing,
                         * we need to decide "foo/*" is more specific than
                         * "*" and the like. But for now we do not have to
                         * worry about that case.
                         */
		case 0:
                        return -1; /* later one wins if they are the same */
		case 1:
			return 1;
		case 2:
			return -1;
		}
	}

meaning, the ones with wildcard are weaker than the ones without.
