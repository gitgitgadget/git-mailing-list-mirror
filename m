From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Support output ISO 8601 format dates
Date: Fri, 13 Jul 2007 15:11:28 -0700
Message-ID: <7vy7hklzsf.fsf@assigned-by-dhcp.cox.net>
References: <20070713202258.14107.18196.stgit@lathund.dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Sat Jul 14 00:11:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I9TML-0003Sa-F5
	for gcvg-git@gmane.org; Sat, 14 Jul 2007 00:11:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758996AbXGMWLa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Jul 2007 18:11:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758502AbXGMWLa
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jul 2007 18:11:30 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:40391 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757281AbXGMWL3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jul 2007 18:11:29 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070713221129.SAYF1428.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Fri, 13 Jul 2007 18:11:29 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id PABU1X00p1kojtg0000000; Fri, 13 Jul 2007 18:11:29 -0400
In-Reply-To: <20070713202258.14107.18196.stgit@lathund.dewire.com> (Robin
	Rosenberg's message of "Fri, 13 Jul 2007 22:22:58 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52417>

Documentation/pretty-formats.txt does not talk about this
addition.

Almost everything else looks fine with your patch, except that
neither "git show --date=iso" nor "git log --date=iso8601" works
with this change, but that is only half your fault.

When we added DATE_SHORT support we could have added the option
parser to revision.c so that you could mimick it more easily.
That half is my fault.

The patch, especially this hunk:

> diff --git a/commit.c b/commit.c
> index 5632e32..68df3b4 100644
> --- a/commit.c
> +++ b/commit.c
> @@ -773,6 +773,7 @@ static void fill_person(struct interp *table, const char *msg, int len)
>  	interp_set_entry(table, 2, show_date(date, tz, 0));
>  	interp_set_entry(table, 3, show_rfc2822_date(date, tz));
>  	interp_set_entry(table, 4, show_date(date, tz, 1));
> +	interp_set_entry(table, 6, show_date(date, tz, DATE_ISO8601));
>  }
>  
>  static long format_commit_message(const struct commit *commit,

makes me wonder if we would want to refactor and reimplement
show_rfc2822_date() in terms of show_date(), by introducing
DATE_RFC2822 in the date format enum, which will allow us to say
"git show --date=rfc2822".

Hmm?
