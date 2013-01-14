From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] archive-tar: fix sanity check in config parsing
Date: Mon, 14 Jan 2013 06:58:45 -0800
Message-ID: <20130114145845.GA16497@sigill.intra.peff.net>
References: <50F2F1E9.1040700@lsrfire.ath.cx>
 <20130113200044.GA3979@sigill.intra.peff.net>
 <kd0evl$ac0$1@ger.gmane.org>
 <20130114124424.GA14129@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Joachim Schmitz <jojo@schmitz-digital.de>
X-From: git-owner@vger.kernel.org Mon Jan 14 15:59:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TulVG-0002FW-QV
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jan 2013 15:59:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756603Ab3ANO6v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2013 09:58:51 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:32883 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756109Ab3ANO6u (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jan 2013 09:58:50 -0500
Received: (qmail 19786 invoked by uid 107); 14 Jan 2013 15:00:06 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (12.144.179.211)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 14 Jan 2013 10:00:06 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 14 Jan 2013 06:58:45 -0800
Content-Disposition: inline
In-Reply-To: <20130114124424.GA14129@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213490>

On Mon, Jan 14, 2013 at 04:44:24AM -0800, Jeff King wrote:

> > Wouldn't it then be better ti use strlen("tar") rather than a 3? Or
> > at least a comment?
> [...]
> We could also potentially encapsulate it in a function. I think the diff
> code has a very similar block.

Here's a series that does that, with a few other cleanups on top. The
diffstat actually ends up a few lines longer, but that is mostly because
of comments and function declarations. More importantly, though, the
call-sites are much easier to read.

Having written this series, though, I can't help but wonder if the world
would be a better place if config_fn_t looked more like:

  typedef int (*config_fn_t)(const char *full_var,
                             const char *section,
                             const char *subsection,
                             const char *key,
                             const char *value,
                             void *data);

It's just as easy for the config parser to do this ahead of time, and by
handing off real C-strings (instead of ending up with a ptr/len pair for
the subsection), it makes the lives of the callbacks much easier (e.g.,
the final patch below contorts a bit to use string_list with the
subsection).

I can look into that, but here is the less invasive cleanup:

  [1/6]: config: add helper function for parsing key names
  [2/6]: archive-tar: use match_config_key when parsing config
  [3/6]: convert some config callbacks to match_config_key
  [4/6]: userdiff: drop parse_driver function
  [5/6]: submodule: use match_config_key when parsing config
  [6/6]: submodule: simplify memory handling in config parsing

-Peff
