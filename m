From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] add boolean diff.suppress-blank-empty config option
Date: Mon, 18 Aug 2008 13:20:10 -0700
Message-ID: <7vmyjam5xh.fsf@gitster.siamese.dyndns.org>
References: <87k5eiphro.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>, Paul Eggert <eggert@cs.ucla.edu>
To: Jim Meyering <jim@meyering.net>
X-From: git-owner@vger.kernel.org Mon Aug 18 22:21:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVBED-0005v0-Sc
	for gcvg-git-2@gmane.org; Mon, 18 Aug 2008 22:21:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752807AbYHRUUV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Aug 2008 16:20:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752648AbYHRUUU
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Aug 2008 16:20:20 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:35937 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752500AbYHRUUT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Aug 2008 16:20:19 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 35E8D5EA00;
	Mon, 18 Aug 2008 16:20:17 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 514765E9FE; Mon, 18 Aug 2008 16:20:13 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 1297B3A2-6D63-11DD-B488-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92736>

Jim Meyering <jim@meyering.net> writes:

> GNU diff's --suppress-blank-empty option makes it so that diff does not
> add a space or tab before each empty output line of context.  With this
> option, empty context lines are empty also in "git diff" output.
> Before (and without the option), they'd have a single trailing space.

> diff --git a/xdiff-interface.c b/xdiff-interface.c
> index 61dc5c5..5544e5a 100644
> --- a/xdiff-interface.c
> +++ b/xdiff-interface.c
> @@ -66,6 +66,13 @@ int xdiff_outf(void *priv_, mmbuffer_t *mb, int nbuf)
>  	struct xdiff_emit_state *priv = priv_;
>  	int i;
>
> +	if (priv->suppress_blank_empty
> +	    && mb[0].size == 1
> +	    && mb[0].ptr[0] == ' '
> +	    && mb[1].size == 1
> +	    && mb[1].ptr[0] == '\n')
> +	  mb[0].size = 0;
> +
>  	for (i = 0; i < nbuf; i++) {
>  		if (mb[i].ptr[mb[i].size-1] != '\n') {
>  			/* Incomplete line */

I do not have a fundamental objection to the optional behaviour, but from
technical point of view, I had to wonder if hooking to xdiff_outf() has
funny interactions with codepaths that use patch-id (namely, git-rebase,
git-format-patch, and git-cherry).  Luckily, patch-ids are computed over
non whitespaces, so it turns out to be Ok, but there may be other
unintended side effects that I haven't thought about.

I would have preferred the option to hook into a bit higher layer (namely,
the part that actually writes textual diff to the output stream).
