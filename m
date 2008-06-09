From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Introduce get_octopus_merge_bases() in commit.c
Date: Mon, 09 Jun 2008 16:06:12 -0700
Message-ID: <7v8wxefbtn.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0806091458190.1783@racer>
 <1213051426-11530-1-git-send-email-vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Tue Jun 10 01:07:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5qSQ-0005Hc-00
	for gcvg-git-2@gmane.org; Tue, 10 Jun 2008 01:07:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752214AbYFIXG3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2008 19:06:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752672AbYFIXG3
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jun 2008 19:06:29 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:42193 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751523AbYFIXG2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2008 19:06:28 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 00FD35482;
	Mon,  9 Jun 2008 19:06:26 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 21A89547F; Mon,  9 Jun 2008 19:06:19 -0400 (EDT)
In-Reply-To: <1213051426-11530-1-git-send-email-vmiklos@frugalware.org>
 (Miklos Vajna's message of "Tue, 10 Jun 2008 00:43:46 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: AF888118-3678-11DD-8913-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84448>

Miklos Vajna <vmiklos@frugalware.org> writes:

> +struct commit_list *get_octopus_merge_bases(struct commit_list *in, int cleanup)
> +{
> +	struct commit_list *ret, *i;
> +
> +	ret = merge_bases_many(in->item, in->next);
> +	if (cleanup)
> +		for(i = in; i; i = i->next)
> +			clear_commit_marks(i->item, all_flags);
> +	return ret;
> +}

I suspect either me or you are confused, but how is this exactly used?

The code for merge_bases_many(), at least the one I showed you a few days
ago, is not a replacement for "show-branch --merge-base", and I do not
think you would want to use it as such in the rewrite of git-merge, if you
are trying to replace this part of git-merge.sh:

        case "$#" in
        1)
                common=$(git merge-base --all $head "$@")
                ;;
        *)
                common=$(git show-branch --merge-base $head "$@")
                ;;
        esac

The purpose of merge-base-many code was to improve this line in the
git-merge-octopus.sh:

	common=$(git merge-base --all $MRC $SHA1) ||
		die "Unable to find common commit with $SHA1"

Instead of keeping a single MRC, we can compute the merge-base-many
between the SHA1 (i.e. the one we are looking at right now -- it is fed as
"one") and all the previous SHA1's we have already looked at (they become
"two's"), like this:

	common($git merge-base-many $SHA1 $SHA1_SO_FAR)

and you would have at the end of the loop:

	SHA1_SO_FAR="$SHA1_SO_FAR$SHA1 "

or something.
