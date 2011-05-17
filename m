From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC] config: Give error message when not changing a
 multivar
Date: Tue, 17 May 2011 08:38:40 -0400
Message-ID: <20110517123840.GB13176@sigill.intra.peff.net>
References: <42ab57ae5a2cb7d6860e43e7c3061f9c38cf1b99.1305632091.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue May 17 14:38:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QMJY1-0000lJ-7y
	for gcvg-git-2@lo.gmane.org; Tue, 17 May 2011 14:38:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754458Ab1EQMin (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 May 2011 08:38:43 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:43543
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754228Ab1EQMim (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 May 2011 08:38:42 -0400
Received: (qmail 25916 invoked by uid 107); 17 May 2011 12:40:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 17 May 2011 08:40:43 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 17 May 2011 08:38:40 -0400
Content-Disposition: inline
In-Reply-To: <42ab57ae5a2cb7d6860e43e7c3061f9c38cf1b99.1305632091.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173797>

On Tue, May 17, 2011 at 01:34:58PM +0200, Michael J Gruber wrote:

> Instead, make it
> 
> warning: remote.repoor.push has multiple values
> error: Use a regexp, --add or --set-all to change remote.repoor.push.
> 
> to be clear and helpful.
> 
> Note: The "warning" is raised through other code paths also so that it
> needs to remain a warning for these (which do not raise the error). Only
> the caller can determine how to go on from that.

Makes sense, and I think trying to change the "warning" text is not
worth the effort.

>  	else if (actions == ACTION_SET) {
> +		int ret;
>  		check_argc(argc, 2, 2);
>  		value = normalize_value(argv[0], argv[1]);
> -		return git_config_set(argv[0], value);
> +		ret = git_config_set(argv[0], value);
> +		if (ret == 5)
> +			error("Use a regexp, --add or --set-all to change %s.", argv[0]);
> +		return ret;
>  	}

What the heck is this 5? In fact, what in the world is going on with the
return values from git_config_set_multivar? It looks like we can return
3, 4, 5, or 6 to return various errors, but they're not documented
anywhere. Or we can return 2, propagated from parse_key. Or we can
return -1 (negative!) if the lock doesn't work.

I think the last one is a straight-out error. For the other ones, we
should probably document them in git-config(1). And it would be nice to
at least have some symbolic constants in the code.

None of these problems is introduced by your patch, of course. But it
might be nice to at least do the symbolic constants while we're looking
at this so that your patch can use them.

-Peff
