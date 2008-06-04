From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] http clone does not checkout working tree
Date: Wed, 04 Jun 2008 12:02:26 -0700
Message-ID: <7vwsl5vxa5.fsf@gitster.siamese.dyndns.org>
References: <20080604183858.GA7095@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jun 04 21:03:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3yGe-0002j0-6P
	for gcvg-git-2@gmane.org; Wed, 04 Jun 2008 21:03:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756406AbYFDTCg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jun 2008 15:02:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759534AbYFDTCg
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jun 2008 15:02:36 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:37912 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754172AbYFDTCf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jun 2008 15:02:35 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 452A73C95;
	Wed,  4 Jun 2008 15:02:34 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 3DF173C91; Wed,  4 Jun 2008 15:02:29 -0400 (EDT)
In-Reply-To: <20080604183858.GA7095@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 4 Jun 2008 14:38:58 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: CA48116C-3268-11DD-A695-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83809>

Jeff King <peff@peff.net> writes:

> The following patch fixes it for me, but I really have no idea if there
> isn't something more subtle at work. Sending to Linus, since "git blame"
> points the surrounding code to you, and to Daniel, since the new clone
> and the commit walker are your areas.
>
> ---
> diff --git a/walker.c b/walker.c
> index 31de6c1..0e68ee6 100644
> --- a/walker.c
> +++ b/walker.c
> @@ -59,6 +59,7 @@ static int process_tree(struct walker *walker, struct tree *tree)
>  	free(tree->buffer);
>  	tree->buffer = NULL;
>  	tree->size = 0;
> +	tree->object.parsed = 0;
>  	return 0;
>  }
>  

The patch looks good to me.

And blaming Linus for this is slightly unfair, as the context the original
"process_tree()" taken out of was that tree object was used once and then
never used after this codepath is done with it, even though he _could_
have a perfect foresight to anticipate that someday somebody might want to
call the routine from elsewhere without understanding the implications.
