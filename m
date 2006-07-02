From: Junio C Hamano <junkio@cox.net>
Subject: Re: [POSSIBLE REGRESSION] Spurious revs after patch "revision.c: --full-history fix"
Date: Sun, 02 Jul 2006 10:48:16 -0700
Message-ID: <7v64if6gpr.fsf@assigned-by-dhcp.cox.net>
References: <e5bfff550607020519k6007f41bne34d10c0e919f3c8@mail.gmail.com>
	<Pine.LNX.4.64.0607021012180.12404@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 02 19:48:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fx63S-0003qw-6R
	for gcvg-git@gmane.org; Sun, 02 Jul 2006 19:48:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751273AbWGBRsS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Jul 2006 13:48:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751363AbWGBRsS
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Jul 2006 13:48:18 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:7302 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1751273AbWGBRsR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Jul 2006 13:48:17 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060702174817.KMXO6385.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 2 Jul 2006 13:48:17 -0400
To: Linus Torvalds <torvalds@osdl.org>,
	"Marco Costalba" <mcostalba@gmail.com>
In-Reply-To: <Pine.LNX.4.64.0607021012180.12404@g5.osdl.org> (Linus Torvalds's
	message of "Sun, 2 Jul 2006 10:14:35 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23110>

Linus Torvalds <torvalds@osdl.org> writes:

> Gaah. Does this trivial patch fix it for you?
>
> It had the wrong test for whether a commit was a merge.

Gaah indeed -- I did not notice the logic error when I picked it
up either, sorry.

> diff --git a/revision.c b/revision.c
> index 1cf6276..880fb7b 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -997,7 +997,7 @@ struct commit *get_revision(struct rev_i
>  				if (!revs->parents)
>  					continue;
>  				/* non-merge - always ignore it */
> -				if (commit->parents && !commit->parents->next)
> +				if (!commit->parents || !commit->parents->next)
>  					continue;
>  			}
>  			if (revs->parents)

For a casual reader who is curious, the reason it matters to
treat the "root" commit sanely in this example is because with
the --remove-empty option the commits that add the specified
paths are already made into "fake" root commits when the above
function sees them (done in try_to_simplify_commit()).

Thanks, Linus and Marco.
