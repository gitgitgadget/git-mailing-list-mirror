From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 2/4] config: drop file pointer validity check in
 get_next_char()
Date: Tue, 12 Mar 2013 15:18:09 -0400
Message-ID: <20130312191809.GD17099@sigill.intra.peff.net>
References: <20130310165642.GA1136@sandbox-ub.fritz.box>
 <20130310165857.GC1136@sandbox-ub.fritz.box>
 <20130312110003.GD11340@sigill.intra.peff.net>
 <20130312160056.GB4472@sandbox-ub.fritz.box>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jens Lehmann <jens.lehmann@web.de>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Tue Mar 12 20:18:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFUid-0007VY-Aj
	for gcvg-git-2@plane.gmane.org; Tue, 12 Mar 2013 20:18:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755566Ab3CLTSN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Mar 2013 15:18:13 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:50011 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755274Ab3CLTSM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Mar 2013 15:18:12 -0400
Received: (qmail 29293 invoked by uid 107); 12 Mar 2013 19:19:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 12 Mar 2013 15:19:52 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 12 Mar 2013 15:18:09 -0400
Content-Disposition: inline
In-Reply-To: <20130312160056.GB4472@sandbox-ub.fritz.box>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217982>

On Tue, Mar 12, 2013 at 05:00:56PM +0100, Heiko Voigt wrote:

> > That is, every path to get_next_char happens while we are in
> > git_config_from_file, and that function guarantees that cf = &top, and
> > that top.f != NULL.  We do not have to even do any analysis of the
> > conditions for each call, because we never change "cf" nor "top.f"
> > except when we set them in git_config_from_file.
> 
> Ok if you say so I will do that :-). I was thinking about adding a patch
> that would remove cf as a global variable and explicitely pass it down
> to get_next_char. That makes it more obvious that it actually is != NULL.
> Looking at your callgraph I do not think its that much work. What do you
> think?

Yeah, I think that makes it more obvious what is going on, but you will
run into trouble if you ever want that information to cross the "void *"
boundary of a config callback, as adding a new parameter there is hard.

The only place we do that now is for git_config_include, and I think you
could get by with stuffing it into the config_include_data struct (which
is already there to deal with this problem).

It would also make something like this patch hard or impossible:

  http://article.gmane.org/gmane.comp.version-control.git/190267

as it wants to access "cf" from arbitrary callbacks. That is not a patch
that is actively under consideration, but I had considered polishing it
up at some point.

> BTW, how did you generate this callgraph? Do you have a nice tool for that?

I just did it manually in vi, working backwards from every instance of
get_next_char, as it is not that big a graph. I suspect something like
cscope could make it easier, but I don't know of any tool that will
build the graph automatically (it would not be that hard from the data
cscope has, though, so I wouldn't be surprised if such a tool exists).

-Peff
