From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Fwd: git status options feature suggestion
Date: Sun, 12 Oct 2008 02:58:20 -0700
Message-ID: <7vwsgef83n.fsf@gitster.siamese.dyndns.org>
References: <81bfc67a0810082234p55e2fb9jb2a10f837eea7de0@mail.gmail.com>
 <20081009061136.GA24288@coredump.intra.peff.net>
 <81bfc67a0810082327p421ca4e9v84f4b33023bc6fe6@mail.gmail.com>
 <81bfc67a0810082327q71b9d6apf2787eb8519031bb@mail.gmail.com>
 <alpine.DEB.1.00.0810091101230.22125@pacific.mpi-cbg.de.mpi-cbg.de>
 <48EE1F58.2060707@drmicha.warpmail.net>
 <20081012044900.GA27845@coredump.intra.peff.net>
 <20081012082607.GA17852@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Caleb Cushing <xenoterracide@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Oct 12 11:59:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Koxjs-0006g0-75
	for gcvg-git-2@gmane.org; Sun, 12 Oct 2008 11:59:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751533AbYJLJ6f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Oct 2008 05:58:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751456AbYJLJ6e
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Oct 2008 05:58:34 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:49271 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751437AbYJLJ6e (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Oct 2008 05:58:34 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id E33BE88A05;
	Sun, 12 Oct 2008 05:58:32 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id A29A988957; Sun, 12 Oct 2008 05:58:23 -0400 (EDT)
In-Reply-To: <20081012082607.GA17852@sigill.intra.peff.net> (Jeff King's
 message of "Sun, 12 Oct 2008 04:26:08 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 5437C426-9844-11DD-9DA5-4F5276724C3F-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98009>

Jeff King <peff@peff.net> writes:

> BTW, in case anybody is interested, here is the patch. Like I said, I
> think we are better off with an alternative to "status", but maybe this
> is useful to somebody anyway.
>
> ---
> diff --git a/builtin-commit.c b/builtin-commit.c
> index b01ad9f..8951364 100644
> --- a/builtin-commit.c
> +++ b/builtin-commit.c
> @@ -217,7 +217,8 @@ static void create_base_index(void)
>  		exit(128); /* We've already reported the error, finish dying */
>  }
>  
> -static char *prepare_index(int argc, const char **argv, const char *prefix)
> +static char *prepare_index(int argc, const char **argv, const char *prefix,
> +		int status_only)
>  {
>  	int fd;
>  	struct string_list partial;
> @@ -270,7 +271,13 @@ static char *prepare_index(int argc, const char **argv, const char *prefix)
>  	 * We still need to refresh the index here.
>  	 */
>  	if (!pathspec || !*pathspec) {
> -		fd = hold_locked_index(&index_lock, 1);
> +		fd = hold_locked_index(&index_lock, 0);
> +		if (fd < 0) {
> +			if (!status_only)
> +				die("unable to lock index: %s",
> +						strerror(errno));
> +			return get_index_file();
> +		}
>  		refresh_cache(REFRESH_QUIET);

You would probably want to refresh_cache() here even if you are not going
to write the resulting index out, so that you won't show the stat-only
differences to the end user.  Other than that, I think this is a good
change.
