From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] remove unnecessary test and dead diagnostic
Date: Thu, 26 May 2011 10:11:30 -0400
Message-ID: <20110526141130.GB18520@sigill.intra.peff.net>
References: <87tych5zrh.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git list <git@vger.kernel.org>
To: Jim Meyering <jim@meyering.net>
X-From: git-owner@vger.kernel.org Thu May 26 16:11:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPbHo-00032J-EI
	for gcvg-git-2@lo.gmane.org; Thu, 26 May 2011 16:11:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757946Ab1EZOLe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2011 10:11:34 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:36566
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757932Ab1EZOLd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2011 10:11:33 -0400
Received: (qmail 11704 invoked by uid 107); 26 May 2011 14:11:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 26 May 2011 10:11:33 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 26 May 2011 10:11:30 -0400
Content-Disposition: inline
In-Reply-To: <87tych5zrh.fsf@rho.meyering.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174513>

On Thu, May 26, 2011 at 03:59:14PM +0200, Jim Meyering wrote:

> * sha1_file.c (index_stream): Don't check for size_t < 0.
> read_in_full does not return an indication of failure.

Are you sure about that?

  $ sed -n '/read_in_full/,/^}/p' wrapper.c
  ssize_t read_in_full(int fd, void *buf, size_t count)
  {
          char *p = buf;
          ssize_t total = 0;

          while (count > 0) {
                  ssize_t loaded = xread(fd, p, count);
                  if (loaded <= 0)
                          return total ? total : loaded;
                  count -= loaded;
                  p += loaded;
                  total += loaded;
          }

          return total;
  }

It looks like if we get -1 on the _first_ read, we will then return -1.
Subsequent errors are then ignored, and we return the (possibly
truncated) result.

Which, to be honest, seems kind of insane to me. I'd think:

  while (count > 0) {
          ssize_t loaded = xread(fd, p, count);
          if (loaded < 0)
                  return loaded;
          if (loaded == 0)
                  return total;
          ...
  }

would be much more sensible semantics.

-Peff
