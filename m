From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/6] Fix some "printf format" warnings.
Date: Sat, 03 Mar 2007 13:53:47 -0800
Message-ID: <7v4pp29eok.fsf@assigned-by-dhcp.cox.net>
References: <45E9BE46.1020801@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Sat Mar 03 22:54:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HNcB0-0003fc-3m
	for gcvg-git@gmane.org; Sat, 03 Mar 2007 22:54:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932526AbXCCVxs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Mar 2007 16:53:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932704AbXCCVxs
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Mar 2007 16:53:48 -0500
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:64830 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932526AbXCCVxs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Mar 2007 16:53:48 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070303215348.NUWM26279.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Sat, 3 Mar 2007 16:53:48 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id WMtn1W00G1kojtg0000000; Sat, 03 Mar 2007 16:53:47 -0500
In-Reply-To: <45E9BE46.1020801@ramsay1.demon.co.uk> (Ramsay Jones's message of
	"Sat, 03 Mar 2007 18:28:22 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41330>

Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:

> Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
> ---
>
> It's interesting to note that all of the warnings are caused by mismatching
> parameter expression involving a call to ntohl().
> [OK, it wasn't that interesting ;-)]
> diff --git a/builtin-ls-files.c b/builtin-ls-files.c
> index ac89eb2..5c990a5 100644
> --- a/builtin-ls-files.c
> +++ b/builtin-ls-files.c
> @@ -193,7 +193,7 @@ static void show_ce_entry(const char *tag, struct cache_entry *ce)
>  		putchar(line_terminator);
>  	}
>  	else {
> -		printf("%s%06o %s %d\t",
> +		printf("%s%06lo %s %d\t",
>  		       tag,
>  		       ntohl(ce->ce_mode),
>  		       abbrev ? find_unique_abbrev(ce->sha1,abbrev)

I think the issue is ntohl() returns uint32_t, and this did not
surface as an issue so far only because that type happens to be
defined as 'unsigned int' on many systems.  Changing %o to %lo
is shifting the breakage to other systems, isn't it?

I think we should do this instead:

	printf("%s%06o %s %d\t", tag, (unsigned) ntohl(ce->ce_mode), ...
