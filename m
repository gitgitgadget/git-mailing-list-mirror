From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] add '%d' pretty format specifier to show decoration
Date: Wed, 3 Sep 2008 15:12:17 -0400
Message-ID: <20080903191217.GA31195@coredump.intra.peff.net>
References: <alpine.LNX.1.10.0809032036270.32295@pollux>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Michael Dressel <MichaelTiloDressel@t-online.de>
X-From: git-owner@vger.kernel.org Wed Sep 03 21:13:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KaxnE-0005Xi-Jj
	for gcvg-git-2@gmane.org; Wed, 03 Sep 2008 21:13:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754411AbYICTMU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Sep 2008 15:12:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753580AbYICTMU
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Sep 2008 15:12:20 -0400
Received: from peff.net ([208.65.91.99]:2393 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752191AbYICTMU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Sep 2008 15:12:20 -0400
Received: (qmail 30664 invoked by uid 111); 3 Sep 2008 19:12:18 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 03 Sep 2008 15:12:18 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 03 Sep 2008 15:12:17 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LNX.1.10.0809032036270.32295@pollux>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94838>

On Wed, Sep 03, 2008 at 08:40:08PM +0200, Michael Dressel wrote:

> This is a variation of the patch provided by  Jeff King <peff@peff.net>:
> allow '%d' pretty format specifier to show decoration

Thank you for picking this up. I had been meaning to look at it further
but hadn't gotten around to it yet.

> would calculate decorations, but not show them. You can now
> do:
>
>   git log --pretty=format:'%H (%d) %s'

I think Junio requested the enclosing parentheses be included. I am not
sure I agree, but we are already mandating the comma separator.
Personally, I think the right solution is more like

  %(decorate:delim=, )

but that is a much bigger change (and part of what was holding me up on
just improving this patch). I think adding %d in the meantime (with or
without the surrounding parentheses) is reasonable.

> The difference is that you don't need --decorate when %d has been given
> because this would be "doppeltgemoppelt" (redundant).

This is good, but I don't like the implementation:

> +static int deco_in_format(int argc, const char **argv)
> +{
> +	int i;
> +	int deco=0;
> +	for (i=0;i<argc;i++)
> +	{
> +		if ((strstr(argv[i], "pretty=format:") ||
> +					strstr(argv[i], "pretty=tformat:")) &&
> +				strstr(argv[i], "%d"))
> +		{
> +			deco=1;
> +			break;
> +		}
> +
> +	}
> +	return deco;
> +}

There are two bad things about this:

  1. It looks through argv. Partly this is a bit ugly, and we should
     just hook into the part where we have already parsed --pretty=.
     Which in this case really means looking at user_format after
     calling setup_revisions (which is sadly a static global; it really
     should be cleaned up as a member of struct rev_list). But worse
     here is that you don't even look through argv correctly. You really
     want prefixcmp(argv[i], "--pretty=format:"), since otherwise this
     would trigger on something like:

         git log ':/implement %d in pretty:format'

     which is unlikely, perhaps, but I don't think it's that hard to do
     it right in this case.

  2. It just looks for '%d' rather than using the same parser as the
     rest of the code. I _think_ this is actually correct now, because
     we don't even allow simple quoting like '%%d'. But it would be much
     cleaner, I think, to have a library call next to
     format_commit_message() that fills in a struct of "used" items.

So something like:

  static void cmd_log_init(...)
  {
          struct user_format_need ufneed;
  ...
          for (i = 1; i < argc; i++) {
            ...
                  if (!stcmp(arg, "--decorate"))
                          decorate = 1;
            ...
          }

          user_format_needs(&ufneed);
          if (decorate || ufneed.decorate)
            for_each_ref(add_ref_decoration, NULL);

  }

Make sense?

-Peff
