From: Eric Wong <e@80x24.org>
Subject: Re: [PATCH 2/2] am: plug FILE * leak in split_mail_conv()
Date: Thu, 12 May 2016 07:59:39 +0000
Message-ID: <20160512075939.GA31343@dcvr.yhbt.net>
References: <20160511233546.13090-1-gitster@pobox.com>
 <20160511233546.13090-2-gitster@pobox.com>
 <20160512044730.GA5436@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 12 09:59:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0lX6-00027O-AK
	for gcvg-git-2@plane.gmane.org; Thu, 12 May 2016 09:59:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751963AbcELH7k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 May 2016 03:59:40 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:37720 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751379AbcELH7j (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2016 03:59:39 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4840C20D58;
	Thu, 12 May 2016 07:59:39 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20160512044730.GA5436@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294399>

Jeff King <peff@peff.net> wrote:
> On Wed, May 11, 2016 at 04:35:46PM -0700, Junio C Hamano wrote:
> > +++ b/builtin/am.c
> > @@ -761,9 +761,11 @@ static int split_mail_conv(mail_conv_fn fn, struct am_state *state,
> >  		mail = mkpath("%s/%0*d", state->dir, state->prec, i + 1);
> >  
> >  		out = fopen(mail, "w");
> > -		if (!out)
> > +		if (!out) {
> > +			fclose(in);
> >  			return error(_("could not open '%s' for writing: %s"),
> >  					mail, strerror(errno));
> > +		}
> 
> Presumably `fclose` doesn't ever overwrite errno in practice, but I
> guess it could in theory.

I think both patches in this series would benefit from capturing
errno before cleanup.  `fclose` can call `free`, and `free` could
do any manner of things such as calling `madvise` with a flag
not implemented in the running kernel, or failing an optional
trylock without being fatal.

There's lots of non-standard malloc implementations out there :)

So I'm not sure if there's ever a guarantee that a non-error
function call preserves `errno`.
