From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] gitignore: warn about pointless syntax
Date: Mon, 9 Jan 2012 17:33:59 -0500
Message-ID: <20120109223358.GA9902@sigill.intra.peff.net>
References: <1326123647-18352-1-git-send-email-jengelh@medozas.de>
 <1326123647-18352-2-git-send-email-jengelh@medozas.de>
 <20120109162802.GA2374@sigill.intra.peff.net>
 <7vhb04ek6e.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jan Engelhardt <jengelh@medozas.de>, git@vger.kernel.org,
	trast@student.ethz.ch
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 09 23:34:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RkNn7-0000xy-Ry
	for gcvg-git-2@lo.gmane.org; Mon, 09 Jan 2012 23:34:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932309Ab2AIWeE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jan 2012 17:34:04 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:60779
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755880Ab2AIWeD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jan 2012 17:34:03 -0500
Received: (qmail 3153 invoked by uid 107); 9 Jan 2012 22:40:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 09 Jan 2012 17:40:54 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 09 Jan 2012 17:33:59 -0500
Content-Disposition: inline
In-Reply-To: <7vhb04ek6e.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188195>

On Mon, Jan 09, 2012 at 11:43:21AM -0800, Junio C Hamano wrote:

> >> +static inline void check_bogus_wildcard(const char *file, const char *p)
> >> +{
> >> +	if (strstr(p, "**") == NULL)
> >> +		return;
> >> +	warning(_("Pattern \"%s\" from file \"%s\": Double asterisk does not "
> >> +		"have a special meaning and is interpreted just like a single "
> >> +		"asterisk.\n"), file, p);
> >
> > Wouldn't this also match the meaningful "foo\**"?
> 
> Yes.
> 
> But trying to catch that false positive by checking one before "**"
> against a backslash is not a way to do so as it will then turn "foo\\**"
> into a false negative, and you would end up reimplementing fnmatch if you
> really want to avoid false positives nor negatives. At that point, you may
> be better off implementing git_fnmatch() instead that understands the
> double-asterisk that works as some people may expect it to work ;-).

You only have to implement proper backslash decoding, so I think it is
not as hard as reimplementing fnmatch:

  enum { NORMAL, QUOTED, WILDCARD } context = NORMAL;
  for (i = 0; p[i]; i++) {
          if (context == QUOTED)
                  context = NORMAL;
          else if (p[i] == '\\')
                  context = QUOTED;
          else if (p[i] == '*') {
                  if (context == WILDCARD) {
                        warning(...);
                        return;
                  }
                  context = WILDCARD;
          }
          else
                  context = NORMAL;
  }

That being said, if this is such a commonly-requested feature that we
need to be detecting and complaining about its absence, I would be much
more in favor of simply implementing it. Surely fnmatch is not that hard
to write, or we could lift code from glibc or even rsync.

Which perhaps was what you are getting at, but I am happy to say it more
explicitly. :)

-Peff
