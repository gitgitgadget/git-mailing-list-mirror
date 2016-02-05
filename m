From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v1] config: add '--sources' option to print the source of
 a config value
Date: Fri, 5 Feb 2016 08:58:55 -0500
Message-ID: <20160205135855.GA19154@sigill.intra.peff.net>
References: <1454661750-85703-1-git-send-email-larsxschneider@gmail.com>
 <20160205112001.GA13397@sigill.intra.peff.net>
 <56B48803.9080909@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: larsxschneider@gmail.com, git@vger.kernel.org
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 05 14:59:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRgud-0006Xb-A2
	for gcvg-git-2@plane.gmane.org; Fri, 05 Feb 2016 14:59:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753344AbcBEN67 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2016 08:58:59 -0500
Received: from cloud.peff.net ([50.56.180.127]:38129 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753179AbcBEN66 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2016 08:58:58 -0500
Received: (qmail 13211 invoked by uid 102); 5 Feb 2016 13:58:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 05 Feb 2016 08:58:57 -0500
Received: (qmail 14312 invoked by uid 107); 5 Feb 2016 13:58:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 05 Feb 2016 08:58:58 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 05 Feb 2016 08:58:55 -0500
Content-Disposition: inline
In-Reply-To: <56B48803.9080909@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285579>

On Fri, Feb 05, 2016 at 12:31:15PM +0100, Sebastian Schuberth wrote:

> >I'm not sure returning here is the best idea. We won't have a config
> >filename if we are reading from "-c", but if we return early from this
> >function, it parses differently than every other line. E.g., with your
> >patch, if I do:
> >
> >   git config -c foo.bar=true config --sources --list
> >
> >I'll get:
> >
> >   /home/peff/.gitconfig <tab> user.name=Jeff King
> >   /home/peff/.gitconfig <tab> user.email=peff@peff.net
> >   ...etc...
> >   foo.bar=true
> >
> >If somebody is parsing this as a tab-delimited list, then instead of the
> >source field for that line being empty, it is missing (and it looks like
> >"foo.bar=true" is the source file). I think it would be more friendly to
> >consumers of the output to have a blank (i.e., set "fn" to the empty
> >string and continue in the function).
> 
> Or to come up with a special string to denote config values specified on the
> command line. Maybe somehting like
> 
>     <command line> <tab> foo.bar=true
> 
> I acknowledge that "<command line>" would be a valid filename on some
> filesystems, but I think the risk is rather low that someone would actually
> be using that name for a Git config file.

Yeah, I agree it's unlikely. And the output is already ambiguous, as the
first field could be a blob (though I guess the caller knows if they
passed "--blob" or not). If we really wanted an unambiguous output, we
could have something like "file:...", "blob:...", etc. But that's a bit
less readable for humans, and I don't think solves any real-world
problems.

So I think it would be OK to use "<command line>" here, as long as the
token is documented.

Are there any other reasons why current_config_filename() would return
NULL, besides command-line config? I don't think so. It looks like we
can read config from stdin, but we use the token "<stdin>" there for the
name field (another ambiguity!).

-Peff
