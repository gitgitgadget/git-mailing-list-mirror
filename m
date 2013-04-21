From: Jeff King <peff@peff.net>
Subject: Re: [BUG] Filenames with single colon being treated as remote
 repository
Date: Sun, 21 Apr 2013 08:45:11 -0400
Message-ID: <20130421124511.GA1933@sigill.intra.peff.net>
References: <20130421045329.GB30538@WST420>
 <20130421060538.GB10429@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: William Giokas <1007380@gmail.com>, git@vger.kernel.org,
	fsckdaemon@gmail.com, Daniel Barkalow <barkalow@iabervon.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 21 14:45:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTte0-0000uQ-1x
	for gcvg-git-2@plane.gmane.org; Sun, 21 Apr 2013 14:45:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753389Ab3DUMpQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Apr 2013 08:45:16 -0400
Received: from cloud.peff.net ([50.56.180.127]:45525 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751012Ab3DUMpO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Apr 2013 08:45:14 -0400
Received: (qmail 2498 invoked by uid 102); 21 Apr 2013 12:45:20 -0000
Received: from 99-108-225-125.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.225.125)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 21 Apr 2013 07:45:20 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 21 Apr 2013 08:45:11 -0400
Content-Disposition: inline
In-Reply-To: <20130421060538.GB10429@elie.Belkin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221945>

On Sat, Apr 20, 2013 at 11:05:39PM -0700, Jonathan Nieder wrote:

> >     Cloning into 'new-baz'...
> >     ssh: Could not resolve hostname /tmp/foo: Success
> >     fatal: Could not read from remote repository.
> 
> Here's a toy patch.  I haven't thought carefully about whether it's a
> good idea, but maybe it can be useful for thinking about that.
> 
> Still needs documentation and tests.
> 
> My main worry is that the proposed rule for when an argument is
> treated as a local path is hard to explain.  There's some precedent in
> handling of bundles, though.  What do you think?

I think the rule could be something like:

  1. If it looks like a URL ("^scheme://"), it is.

  2. Otherwise, if it is a path in the filesystem, it is.

  3. Otherwise, if it has a colon, it's host:path

  4. Otherwise, barf.

where the interesting bit is the ordering of 2 and 3.  It seems like
"git clone" follows the order above with get_repo_path. But we do not
seem to follow it in git_connect, where we prefer 3 over 2.

> @@ -942,6 +943,7 @@ struct transport *transport_get(struct remote *remote, const char *url)
>  		ret->disconnect = close_bundle;
>  		ret->smart_options = NULL;
>  	} else if (!is_url(url)
> +		|| (is_local(url) && !stat(url, &st))
>  		|| !prefixcmp(url, "file://")
>  		|| !prefixcmp(url, "git://")
>  		|| !prefixcmp(url, "ssh://")

I don't think that is enough. Something like /path/to/foo:bar would
trigger !is_url already, but then git_connect fails.

Try:

  $ git init --bare foo:bar
  $ git clone foo:bar
  ssh: Could not resolve hostname /home/peff/foo: Name or service not known
  fatal: Could not read from remote repository.
  ...

Clone recognizes it as a path and turns it into an absolute path. It
then feeds it to the transport code, which triggers !is_url and knows to
use the git transport. But then git_connect prefers ssh over the
filesystem.

If you do a straight fetch, though, the transport code might see the
relative path (if you use one):

  $ git init
  $ git init --bare sub:repo
  $ git fetch sub:repo
  ssh: Could not resolve hostname sub: Name or service not known

but that still triggers the is_url above (which demands the "://").

I am not sure whether your patch covers any cases I am missing, but I
think you would need an analogous change to git_connect for these common
cases.

-Peff
