From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Added support for core.ignorecase when excluding
 gitignore entries
Date: Thu, 16 Jul 2009 05:42:10 -0400
Message-ID: <20090716094210.GC2800@coredump.intra.peff.net>
References: <4A5EB849.1000803@workspacewhiz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Joshua Jensen <jjensen@workspacewhiz.com>
X-From: git-owner@vger.kernel.org Thu Jul 16 11:42:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MRNTs-0001gH-8W
	for gcvg-git-2@gmane.org; Thu, 16 Jul 2009 11:42:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754873AbZGPJmQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jul 2009 05:42:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754825AbZGPJmP
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Jul 2009 05:42:15 -0400
Received: from peff.net ([208.65.91.99]:48343 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754092AbZGPJmP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jul 2009 05:42:15 -0400
Received: (qmail 19549 invoked by uid 107); 16 Jul 2009 09:44:13 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 16 Jul 2009 05:44:13 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 16 Jul 2009 05:42:10 -0400
Content-Disposition: inline
In-Reply-To: <4A5EB849.1000803@workspacewhiz.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123393>

On Wed, Jul 15, 2009 at 11:19:05PM -0600, Joshua Jensen wrote:

> This patch allows core.ignorecase=true to work properly with
> gitignore exclusions.

Makes sense, though I can't help but wonder what would happen with a
filesystem that did more than just case (like the utf8 normalization
that happens on HFS).

Should we actually be converting the filesystem names into a canonical
format as they are read? IIRC, Linus posted some patches a few weeks ago
about "git path" versus "filesystem path", but I didn't actually look
too closely.

That seems like the right way forward to fixing these problems in the
long term, but it may make sense to do something like your patch in the
meantime.

> -                        !strcmp(exclude + 1, pathname + pathlen -
> x->patternlen + 1))
> -                        return to_exclude;
> +                    if (ignore_case) {
> +                        if (x->patternlen - 1 <= pathlen &&
> +                            !strcasecmp(exclude + 1, pathname +
> pathlen - x->patternlen + 1))
> +                            return to_exclude;
> +                    } else {
> +                        if (x->patternlen - 1 <= pathlen &&
> +                            !strcmp(exclude + 1, pathname + pathlen
> - x->patternlen + 1))
> +                            return to_exclude;
> +                    }

If your patch is the right route, it might be nice to collapse the
comparison into its own function. You end up cutting and pasting a lot
of the related conditionals and returns (like above, where 2 lines
become 9), so it might make sense to do something like:

  int filename_cmp(const char *a, const char *b, int ignore_case)
  {
    return ignore_case ? strcasecmp(a, b) : strcmp(a, b);
  }

and then just s/strcmp/filename_cmp/ at the appropriate callsites.

-Peff
