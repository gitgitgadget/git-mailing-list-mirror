From: Jeff King <peff@peff.net>
Subject: [PATCHv2 0/8] config key-parsing cleanups
Date: Wed, 23 Jan 2013 01:21:32 -0500
Message-ID: <20130123062132.GA2038@sigill.intra.peff.net>
References: <20130114145845.GA16497@sigill.intra.peff.net>
 <20130114150012.GA16828@sigill.intra.peff.net>
 <7v8v7veixc.fsf@alter.siamese.dyndns.org>
 <20130115160422.GC21815@sigill.intra.peff.net>
 <7vehhm4bof.fsf@alter.siamese.dyndns.org>
 <7va9s6qkkz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Joachim Schmitz <jojo@schmitz-digital.de>,
	=?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 23 07:22:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Txtih-0005qf-MT
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jan 2013 07:22:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753059Ab3AWGVi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jan 2013 01:21:38 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:44580 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752969Ab3AWGVh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jan 2013 01:21:37 -0500
Received: (qmail 1193 invoked by uid 107); 23 Jan 2013 06:22:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 23 Jan 2013 01:22:55 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 23 Jan 2013 01:21:32 -0500
Content-Disposition: inline
In-Reply-To: <7va9s6qkkz.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214281>

On Fri, Jan 18, 2013 at 12:53:32PM -0800, Junio C Hamano wrote:

> >> ... did you have any comment on
> >> the "struct config_key" alternative I sent as a follow-up?
> >
> > I did read it but I cannot say I did so very carefully.  My gut
> > reaction was that the "take the variable name and section name,
> > return the subsection name pointer and length, if there is any, and
> > the key" made it readable enough.  The proposed interface to make
> > and lend a copy to the caller does make it more readble, but I do
> > not know if that is worth doing.  Neutral-to-slightly-in-favor, I
> > would say.
> 
> Now I re-read that "struct config_key" thing, I would have to say
> that the idea of giving split and NUL-terminated strings to the
> callers is good, but the "cheat" looks somewhat brittle for all the
> reasons that come from using a static buffer (which you already
> mentioned).  As I do not offhand think of a better alternative, I'd
> say we leave it for another day.

OK. I had the feeling if the config parser provided it to the caller
that more sites could take advantage of it (without adding too many
lines to call the parsing function). But looking again, there aren't
that many sites that would benefit. E.g., git_daemon_config in daemon.c
could use it to avoid using a constant offset. But the current code
there is not hard to read, and saving a few characters there is not
worth the complexity.

So I've re-rolled the original version, taking into account the comments
from you and Jonathan. I also clarified a few of the commit messages,
and modified two more sites to use the new function.

  [1/8]: config: add helper function for parsing key names

Same as before, but now called parse_config_key.

  [2/8]: archive-tar: use parse_config_key when parsing config

Same (rebased for new name, of course).

  [3/8]: convert some config callbacks to parse_config_key

Tweaked confusing "ep" variable name. Fixed missing "!name" check in
userdiff code (which gets removed in the next patch anyway).

  [4/8]: userdiff: drop parse_driver function
  [5/8]: submodule: use parse_config_key when parsing config
  [6/8]: submodule: simplify memory handling in config parsing

Same.

  [7/8]: help: use parse_config_key for man config
  [8/8]: reflog: use parse_config_key in config callback

Two new callsites. I split these out because unlike the ones in 3/8,
they do not benefit from a reduction in lines of code. However, I think
the results are still more readable. You can judge for yourself; drop
them if you disagree. Or feel free to squash them into 3/8 if that makes
more sense.

-Peff
