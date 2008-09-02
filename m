From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] for-each-ref: `:short` format for `refname`
Date: Tue, 02 Sep 2008 16:10:00 -0700
Message-ID: <7v63pei1pz.fsf@gitster.siamese.dyndns.org>
References: <20080902143912.GB28704@spearce.org>
 <1220392637-24978-1-git-send-email-bert.wesarg@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, szeder@ira.uka.de,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Wed Sep 03 01:11:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kaf1u-0001Kt-2X
	for gcvg-git-2@gmane.org; Wed, 03 Sep 2008 01:11:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753522AbYIBXKP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Sep 2008 19:10:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753536AbYIBXKP
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Sep 2008 19:10:15 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:56955 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752300AbYIBXKO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Sep 2008 19:10:14 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 32B545B94C;
	Tue,  2 Sep 2008 19:10:11 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 43BBF5B948; Tue,  2 Sep 2008 19:10:06 -0400 (EDT)
In-Reply-To: <1220392637-24978-1-git-send-email-bert.wesarg@googlemail.com>
 (Bert Wesarg's message of "Tue, 2 Sep 2008 23:57:17 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 4AE03D5A-7944-11DD-9F68-9EE598D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94736>

Bert Wesarg <bert.wesarg@googlemail.com> writes:

> Tries to shorten the refname to a non-ambiguous name.
> I.e. the full and the short refname points to the same object.

The definition of "ambiguity" here is wrong (see below).

> +	/* skip first rule, will always match */
> +	for (i = 0; i < nr_rules - 1; i++) {
> +		const char **p;
> +		int short_name_len;
> +
> +		if (1 != sscanf(ref->refname, scanf_fmts[nr_rules - 1 - i],
> +				short_name))
> +			continue;
> +
> +		short_name_len = strlen(short_name);
> +
> +		/* check if full and short point to the same object

Style?

> +		 * by checking all rules in forward direction
> +		 */

I think this part of the code is wrong, in that it talks about what object
the ref points at.  That is not what ref ambiguity is about.

Given a tag that points at a version 1.0.0 commit, this sequence will
create:

	$ git tag foo v1.0.0^0
        $ git branch foo v1.0.0^0

ambiguous branch and tag whose names are both 'foo', even though they
point at the same thing.  The right API to use would be resolve_ref(), I
think.

Other than that, it is well done.

Although I was initially a bit surprised by the size of the patch to
implement something so (conceptually) simple, the code was easy and
straightforward to follow.

Thanks.
