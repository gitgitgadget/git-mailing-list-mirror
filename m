From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] Allow git-apply to ignore the hunk headers (AKA
 recountdiff)
Date: Tue, 24 Jun 2008 16:35:33 -0700
Message-ID: <7vfxr29zju.fsf@gitster.siamese.dyndns.org>
References: <20080624050901.GA19224@sigill.intra.peff.net>
 <200806242108.16379.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Jun 25 01:37:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBI46-00036P-N8
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 01:36:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753371AbYFXXft (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 19:35:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752796AbYFXXft
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 19:35:49 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:49010 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752603AbYFXXfs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 19:35:48 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id BA33998BA;
	Tue, 24 Jun 2008 19:35:46 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id C203298B9; Tue, 24 Jun 2008 19:35:40 -0400 (EDT)
In-Reply-To: <200806242108.16379.trast@student.ethz.ch> (Thomas Rast's
 message of "Tue, 24 Jun 2008 20:08:15 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 45393800-4246-11DD-A955-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86184>

Thomas Rast <trast@student.ethz.ch> writes:

> diff --git a/builtin-apply.c b/builtin-apply.c
> index c497889..34c220f 100644
> --- a/builtin-apply.c
> +++ b/builtin-apply.c
> @@ -153,6 +153,7 @@ struct patch {
>  	unsigned int is_binary:1;
>  	unsigned int is_copy:1;
>  	unsigned int is_rename:1;
> +	unsigned int recount:1;
>  	struct fragment *fragments;
>  	char *result;
>  	size_t resultsize;

Why doesn't anybody find this quite wrong?

What is a "struct patch"?  It describes a change to a single file
(i.e. information contained from one "diff --git" til next "diff --git"),
groups the hunks (called "fragments") together and holds the postimage
after applying these hunks.  Is this new "recount" field a per file
attribute?

> +	fragment->oldpos = 2;
> +	fragment->oldlines = fragment->newlines = 0;

Why is this discarding the position information?  

It is none of this function's business.  The ONLY THING this function
should do is to discard fragment->oldlines and fragment->newlines, count
the contents and update these two fields, and nothing else.  Touching
oldpos, leading and other things is an absolute no-no.

> @@ -1013,6 +1058,9 @@ static int parse_fragment(char *line, unsigned long size,
>  	offset = parse_fragment_header(line, len, fragment);
>  	if (offset < 0)
>  		return -1;
> +	if (offset > 0 && patch->recount &&
> +			recount_diff(line + offset, size - offset, fragment))
> +		return -1;

And recount should not cause parse_fragment() to fail out either.  If you
miscounted, the codepath that follows this part knows how to handle broken
patch correctly anyway.

I think I've already mentioned the above two points when this was
originally posted.

Somewhat disgusted...
