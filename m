From: Jeff King <peff@peff.net>
Subject: Re: [RFC] branch: list branches by single remote
Date: Wed, 3 Aug 2011 22:06:46 -0600
Message-ID: <20110804040646.GA5104@sigill.intra.peff.net>
References: <4E383132.3040907@elegosoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Michael Schubert <mschub@elegosoft.com>
X-From: git-owner@vger.kernel.org Thu Aug 04 06:06:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QopCx-0003Fb-0b
	for gcvg-git-2@lo.gmane.org; Thu, 04 Aug 2011 06:06:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750863Ab1HDEGt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Aug 2011 00:06:49 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:33221
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750801Ab1HDEGt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2011 00:06:49 -0400
Received: (qmail 14107 invoked by uid 107); 4 Aug 2011 04:07:23 -0000
Received: from S010690840de80b38.ss.shawcable.net (HELO sigill.intra.peff.net) (70.64.172.81)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 04 Aug 2011 00:07:23 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 03 Aug 2011 22:06:46 -0600
Content-Disposition: inline
In-Reply-To: <4E383132.3040907@elegosoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178668>

On Tue, Aug 02, 2011 at 07:17:38PM +0200, Michael Schubert wrote:

> @@ -297,6 +298,9 @@ static int append_ref(const char *refname, const unsigned char *sha1, int flags,
>  	if ((kind & ref_list->kinds) == 0)
>  		return 0;
>  
> +	if (cb->remote && strncmp(cb->remote, refname, strlen(cb->remote)))
> +		return 0;
> +

This isn't right. You are assuming that a remote called "foo" will have
all of its branches in refs/remotes/foo. That's true under the default
configuration, but technically speaking, the remote tracking branches of
"foo" are defined by the right-hand side of foo's fetch refspecs.

So I think you want something more like this:

  int i;
  struct remote *remote = remote_get("foo");

  for (i = 0; i < remote->fetch_refspec_nr; i++) {
          struct refspec *rs = remote->fetch + i;

          /* if it's not a wildcard, then take the rhs verbatim */
          if (!rs->pattern)
                  append_ref(rs->dst);
          else {
                  /* it's a wildcard like refs/remotes/foo/*; glob in
                   * the ref list appropriately. Or we can cheat, noting
                   * that git's only allowed wildcard is "/*" at the
                   * end, and do this: */
                  char *prefix = xstrndup(rs->dst, strlen(rs->dst) - 1);
                  for_each_ref_in(prefix, append_ref, NULL);
          }
  }

instead of the call to "for_each_rawref(append_ref, ...)" that would
normally be used. You could even pretty easily allow selecting branches
from multiple remotes, too, though I don't know if that is actually
useful.

-Peff
