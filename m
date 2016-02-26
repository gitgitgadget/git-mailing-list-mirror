From: Jeff King <peff@peff.net>
Subject: Re: Fwd: git clone does not respect command line options
Date: Fri, 26 Feb 2016 03:45:15 -0500
Message-ID: <20160226084514.GA28898@sigill.intra.peff.net>
References: <CAMDzUtzoiJWzckTX818HJV=su0eEP35gsNDJ=+k_me08EDvxRg@mail.gmail.com>
 <CAMDzUtxQPMty0Nncr7Yj3up6Zb6F-E0QudOMOZO_jG-Goq0YBg@mail.gmail.com>
 <20160226073444.GA26340@sigill.intra.peff.net>
 <CAMDzUty5oWjS=4kvvYL7XNCY=xHm3N=+kaeT_zTtpkaMakMrmA@mail.gmail.com>
 <20160226075948.GA26994@sigill.intra.peff.net>
 <CA+P7+xpuiUQgWYRgVrwKkv27KiJGQ0COrR93cFzQzn2uVA6ypQ@mail.gmail.com>
 <20160226082437.GB26994@sigill.intra.peff.net>
 <CACsJy8BK=2aKg68msH9vawHrXr=PsQYgs6sGXy0koy459MYfSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jacob Keller <jacob.keller@gmail.com>,
	Guilherme <guibufolo@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 26 09:45:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZE1d-0003SX-0E
	for gcvg-git-2@plane.gmane.org; Fri, 26 Feb 2016 09:45:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753794AbcBZIpU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Feb 2016 03:45:20 -0500
Received: from cloud.peff.net ([50.56.180.127]:49911 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753767AbcBZIpS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Feb 2016 03:45:18 -0500
Received: (qmail 29620 invoked by uid 102); 26 Feb 2016 08:45:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 26 Feb 2016 03:45:17 -0500
Received: (qmail 479 invoked by uid 107); 26 Feb 2016 08:45:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 26 Feb 2016 03:45:26 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 26 Feb 2016 03:45:15 -0500
Content-Disposition: inline
In-Reply-To: <CACsJy8BK=2aKg68msH9vawHrXr=PsQYgs6sGXy0koy459MYfSA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287556>

On Fri, Feb 26, 2016 at 03:34:53PM +0700, Duy Nguyen wrote:

> On Fri, Feb 26, 2016 at 3:24 PM, Jeff King <peff@peff.net> wrote:
> > As an alternative, it would be nice to have some config syntax for
> > "clear the list". Maybe something like an empty string, which I think
> > has no meaning for the current multi-valued variables (at least not for
> > credential helpers or refspecs). That would allow something like:
> >
> >   git -c credential.helper= clone ...
> >
> > to do what you'd expect.
> 
> I've been thinking of -= instead. It's unambiguous. And you can use
> wildcards on both sides. "credential.helper -= *" means delete that
> key, "credential.* -= *" deletes all credential.* keys.
> credential.helper -= abc only deletes it if the previous value is abc.

But there you're inventing new syntax, so you'd need to invent new
syntax inside the config file, too. And you'd need to somehow
communicate to the consumers of the config values that the value is
"unset". So for config callbacks inside of git, they need to take more
than just the key/value pair (or we'd have to read all of the config and
pre-process it). Ditto for git-config. How do we show in the output of
--get-all that the list was reset? Or again, we could pre-process
completely in git-config (which would probably mean using a new option,
--get-list or something, instead of --get-all).

By contrast, I think my suggestion can be implemented as:

diff --git a/credential.c b/credential.c
index 7d6501d..aa99666 100644
--- a/credential.c
+++ b/credential.c
@@ -63,9 +63,12 @@ static int credential_config_callback(const char *var, const char *value,
 		key = dot + 1;
 	}
 
-	if (!strcmp(key, "helper"))
-		string_list_append(&c->helpers, value);
-	else if (!strcmp(key, "username")) {
+	if (!strcmp(key, "helper")) {
+		if (*value)
+			string_list_append(&c->helpers, value);
+		else
+			string_list_clear(&c->helpers, 0);
+	} else if (!strcmp(key, "username")) {
 		if (!c->username)
 			c->username = xstrdup(value);
 	}

The big downside is that each consumer of the value needs to learn this
trick. But as I said, I think there aren't very many.

Don't get me wrong; I think your suggestion is a little cleaner. If we
were designing the config system from scratch, I'd probably favor a
single query-able tree rather than the callback system, and do things
like list-processing centrally. But given the history, I'm not sure if
it's worth it now.

-Peff
