From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH v3] Advertise the ability to abort a commit
Date: Thu, 31 Jul 2008 12:55:39 +0200
Message-ID: <20080731105539.GM32184@machine.or.cz>
References: <20080730051059.GA4497@sigill.intra.peff.net> <1217440391-13259-1-git-send-email-mail@cup.kalibalik.dk> <20080731055024.GA17652@sigill.intra.peff.net> <7vwsj23896.fsf@gitster.siamese.dyndns.org> <20080731073609.GA8049@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Anders Melchiorsen <mail@cup.kalibalik.dk>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jul 31 12:56:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOVpw-0005nE-7P
	for gcvg-git-2@gmane.org; Thu, 31 Jul 2008 12:56:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751616AbYGaKzo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2008 06:55:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751567AbYGaKzn
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jul 2008 06:55:43 -0400
Received: from w241.dkm.cz ([62.24.88.241]:50714 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751475AbYGaKzn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2008 06:55:43 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 9C890393A2E5; Thu, 31 Jul 2008 12:55:39 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080731073609.GA8049@sigill.intra.peff.net>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90923>

On Thu, Jul 31, 2008 at 03:36:09AM -0400, Jeff King wrote:
>  builtin-commit.c  |   19 ++++++++++++-------
>  t/t7502-commit.sh |   11 +++++------
>  2 files changed, 17 insertions(+), 13 deletions(-)
> 
> diff --git a/builtin-commit.c b/builtin-commit.c
> index f7c053a..b783e6e 100644
> --- a/builtin-commit.c
> +++ b/builtin-commit.c
> @@ -554,14 +554,18 @@ static int prepare_to_commit(const char *index_file, const char *prefix)
>  
>  		fprintf(fp,
>  			"\n"
> -			"# Please enter the commit message for your changes.\n"
> -			"# To abort the commit, use an empty commit message.\n"
> -			"# (Comment lines starting with '#' will ");
> +			"# Please enter the commit message for your changes.");
>  		if (cleanup_mode == CLEANUP_ALL)
> -			fprintf(fp, "not be included)\n");
> +			fprintf(fp,
> +				" Lines starting\n"
> +				"# with '#' will be ignored, and an empty"
> +				" message aborts the commit.\n");
>  		else /* CLEANUP_SPACE, that is. */
> -			fprintf(fp, "be kept.\n"
> -				"# You can remove them yourself if you want to)\n");
> +			fprintf(fp,
> +				" Lines starting\n"
> +				"# with '#' will be kept; you may remove them"
> +				" yourself if you want to.\n"
> +				"# An empty message aborts the commit.\n");
>  		if (only_include_assumed)
>  			fprintf(fp, "# %s\n", only_include_assumed);
>  

This is rather funny-looking; you print _one_ fragment of the common
string by a common fprintf, but then repeat _second_ fragment of the
still-common string in a per-case fprintf. Can't we at least split this
on the line boundary, if not do something loosely like this?

		fprintf(fp,
			"\n"
			"# Please enter the commit message for your "
			"changes. Lines starting\n"
			"# with a '#' will be %s "
			"and an empty message aborts the commit\n",
			cleanup_mode == CLEANUP_ALL ? "ignored,"
			/* CLEANUP_SPACE */ : "kept (you may remove them "
				"yourself if you want to)\n#");


-- 
				Petr "Pasky" Baudis
As in certain cults it is possible to kill a process if you know
its true name.  -- Ken Thompson and Dennis M. Ritchie
