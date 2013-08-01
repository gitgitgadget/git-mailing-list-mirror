From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v6 6/6] config: "git config --get-urlmatch" parses
 section.<url>.key
Date: Thu, 1 Aug 2013 10:30:11 -0700
Message-ID: <20130801173010.GB16562@sigill.intra.peff.net>
References: <1375298768-7740-1-git-send-email-gitster@pobox.com>
 <1375298768-7740-7-git-send-email-gitster@pobox.com>
 <20130731224511.GA25882@sigill.intra.peff.net>
 <62E17EDB-B24D-4F37-95F8-E2E26118E5E9@gmail.com>
 <20130731234448.GA8764@sigill.intra.peff.net>
 <7vob9hs4qu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Kyle J. McKay" <mackyle@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 01 19:30:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V4whl-0000fy-Bt
	for gcvg-git-2@plane.gmane.org; Thu, 01 Aug 2013 19:30:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753261Ab3HARaR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Aug 2013 13:30:17 -0400
Received: from cloud.peff.net ([50.56.180.127]:58442 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752050Ab3HARaO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Aug 2013 13:30:14 -0400
Received: (qmail 18327 invoked by uid 102); 1 Aug 2013 17:30:14 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (12.144.179.211)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 01 Aug 2013 12:30:14 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 01 Aug 2013 10:30:11 -0700
Content-Disposition: inline
In-Reply-To: <7vob9hs4qu.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231493>

On Thu, Aug 01, 2013 at 10:25:13AM -0700, Junio C Hamano wrote:

> > diff --git a/builtin/config.c b/builtin/config.c
> > index c35c5be..9328a90 100644
> > --- a/builtin/config.c
> > +++ b/builtin/config.c
> > @@ -589,7 +589,9 @@ int cmd_config(int argc, const char **argv, const char *prefix)
> >  	}
> >  	else if (actions == ACTION_GET_URLMATCH) {
> >  		check_argc(argc, 2, 2);
> > -		return get_urlmatch(argv[0], argv[1]);
> > +		if (git_config_parse_key(argv[0], &key, NULL))
> > +			return CONFIG_INVALID_KEY;
> > +		return get_urlmatch(key, argv[1]);
> >  	}
> >  	else if (actions == ACTION_UNSET) {
> >  		check_argc(argc, 1, 2);
> 
> If we drop the "list every key in section.*" mode, the above should
> be sufficient, I think.

Ah, right, forgot about that again.

> I do not know how useful it would be to be for a scripted Porcelain
> to be able to ask
> 
>     $ git config --get-urlmatch http https://weak.example.com/path/to/git.git
> 
> and get all the "http.*" variables that will apply to the given URL.

I do not think it is all that useful, but I don't think it hurts too
much to have it (and it would be a hard operation to do otherwise). The
implementation you posted that downcases as we memdup the key makes
sense to me.

The key thing is that it is done only by git-config, as we would not
want to pay the allocation cost for every config key we look at during a
git_config() run, but I think your implementation is fine in that
respect.

-Peff
