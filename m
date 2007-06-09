From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 04/21] Refactor verification of "tagger" line to be more similar to verification of "type" and "tagger" lines
Date: Sat, 09 Jun 2007 11:01:52 -0700
Message-ID: <7vr6olf1m7.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0706072348110.4046@racer.site>
	<7vzm3aig7j.fsf@assigned-by-dhcp.cox.net>
	<200706090210.36270.johan@herland.net>
	<200706090214.11589.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Sat Jun 09 20:02:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hx5GO-0001bE-6N
	for gcvg-git@gmane.org; Sat, 09 Jun 2007 20:02:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757767AbXFISB6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 9 Jun 2007 14:01:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757558AbXFISB6
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Jun 2007 14:01:58 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:48060 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757384AbXFISBy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jun 2007 14:01:54 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070609180153.WGRI12556.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Sat, 9 Jun 2007 14:01:53 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 9W1t1X0021kojtg0000000; Sat, 09 Jun 2007 14:01:53 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49591>

Johan Herland <johan@herland.net> writes:

> Also update selftests to reflect that verification of "tagger" now
> happens _before_ verification of type name, object sha1 and tag name.
>
> Signed-off-by: Johan Herland <johan@herland.net>
> ---
>  mktag.c          |   16 ++++++++--------
>  t/t3800-mktag.sh |    3 +++
>  tag.c            |    6 +++---
>  3 files changed, 14 insertions(+), 11 deletions(-)
>
> diff --git a/mktag.c b/mktag.c
> index 0bc20c8..4dbefab 100644
> --- a/mktag.c
> +++ b/mktag.c
> @@ -62,12 +62,18 @@ static int verify_tag(char *data, unsigned long size)
>  
>  	/* Verify tag-line */
>  	tag_line = strchr(type_line, '\n');
> -	if (!tag_line)
> +	if (!tag_line++)
>  		return error("char" PD_FMT ": could not find next \"\\n\"", type_line - data);
> -	tag_line++;

Code churn "while we are at it" makes reviewing the rest more
cumbersome.  A clean-up like this should be a separate patch.

> diff --git a/tag.c b/tag.c
> index 8d31603..19c66cd 100644
> --- a/tag.c
> +++ b/tag.c
> @@ -73,10 +73,10 @@ static int parse_tag_buffer_internal(struct tag *item, const char *data, const u
>  	if (memcmp(tag_line, "tag ", 4) || tag_line[4] == '\n')
>  		return error("char" PD_FMT ": no \"tag \" found", tag_line - data);
>  
> +	/* Verify the tagger line */
>  	tagger_line = strchr(tag_line, '\n');
> -	if (!tagger_line)
> -		return -1;
> -	tagger_line++;
> +	if (!tagger_line++)
> +		return error("char" PD_FMT ": could not find next \"\\n\"", tag_line - data);
>  
>  	/* Get the actual type */
>  	type_len = tag_line - type_line - strlen("type \n");

Same comments on extra verbosity, as for [2/21].
