From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] branch --track: code cleanup and saner handling of local branches
Date: Mon, 09 Jul 2007 14:05:44 -0700
Message-ID: <7v4pkduw2f.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0707062252390.4093@racer.site>
	<7vhcof2rur.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0707081336020.4248@racer.site>
	<7vzm2620wp.fsf@assigned-by-dhcp.cox.net> <46919692.5020708@gnu.org>
	<7vhcoexqeh.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0707091228290.5546@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paolo Bonzini <bonzini@gnu.org>, git@vger.kernel.org,
	Daniel Barkalow <barkalow@iabervon.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jul 09 23:05:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I80Qc-0007B8-9G
	for gcvg-git@gmane.org; Mon, 09 Jul 2007 23:05:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753622AbXGIVFr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Jul 2007 17:05:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754529AbXGIVFr
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jul 2007 17:05:47 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:65150 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752917AbXGIVFq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jul 2007 17:05:46 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070709210546.LFQV1349.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Mon, 9 Jul 2007 17:05:46 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id MZ5k1X00Q1kojtg0000000; Mon, 09 Jul 2007 17:05:45 -0400
In-Reply-To: <Pine.LNX.4.64.0707091228290.5546@racer.site> (Johannes
	Schindelin's message of "Mon, 9 Jul 2007 12:35:05 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52019>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> @@ -349,125 +345,111 @@ static void print_ref_list(int kinds, int detached, int verbose, int abbrev,
>  	free_ref_list(&ref_list);
>  }
>  
> -static char *config_repo;
> -static char *config_remote;
> -static const char *start_ref;
> +static struct {
> +	const char *ref;
> +	int ref_len;
> +	char *remote;
> +	char *merge;
> +	int matches;
> +} tracking;
>  
> -static int get_remote_branch_name(const char *value)
> +static int tracking_config(const char *key, const char *value)
>  {
>  	const char *colon;
> +	int key_len, value_len, match_len;
> +	char *merge = NULL;
>  
> -	colon = strchr(value, ':');
> -	if (!colon)
> +	/* we want: remote.<nick>.fetch = <merge>:<ref> */
> +	if (prefixcmp(key, "remote.") || (key_len = strlen(key)) < 6 ||
> +			strcmp(key + key_len - 6, ".fetch") ||
> +			!(colon = strchr(value, ':')))
>  		return 0;
>  
> -	end = value + strlen(value);
> +	if (*value == '+')
> +		value++;
>  
>  	/*
> -	 * Try an exact match first.  I.e. handle the case where the
> -	 * value is "$anything:refs/foo/bar/baz" and start_ref is exactly
> -	 * "refs/foo/bar/baz". Then the name at the remote is $anything.
> +	 * A remote.<name>.fetch value can have two forms:
> +	 *
> +	 * - exact:
> +	 *
> +	 *	refs/heads/gnu:refs/heads/my-upstream
> +	 *
> +	 * - wildcard:
> +	 *
> +	 *	refs/heads/ *:refs/remotes/gnu/ *
> +	 *
> +	 * try exact match first:
>  	 */

It strikes me a bit odd if Daniel's remote.[ch] infrastructure
does not give you easy access to this kind of information...
