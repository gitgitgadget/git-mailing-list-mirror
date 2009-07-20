From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Added support for core.ignorecase when excluding
 gitignore entries
Date: Mon, 20 Jul 2009 11:37:37 -0400
Message-ID: <20090720153737.GF5347@coredump.intra.peff.net>
References: <4A5EB849.1000803@workspacewhiz.com>
 <20090716094210.GC2800@coredump.intra.peff.net>
 <4A5F27EE.3070101@workspacewhiz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Joshua Jensen <jjensen@workspacewhiz.com>
X-From: git-owner@vger.kernel.org Mon Jul 20 17:37:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MSuvs-00070Z-Nu
	for gcvg-git-2@gmane.org; Mon, 20 Jul 2009 17:37:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751622AbZGTPhe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jul 2009 11:37:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751257AbZGTPhd
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Jul 2009 11:37:33 -0400
Received: from peff.net ([208.65.91.99]:46968 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751119AbZGTPhc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jul 2009 11:37:32 -0400
Received: (qmail 26825 invoked by uid 107); 20 Jul 2009 15:39:34 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 20 Jul 2009 11:39:34 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 20 Jul 2009 11:37:37 -0400
Content-Disposition: inline
In-Reply-To: <4A5F27EE.3070101@workspacewhiz.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123616>

On Thu, Jul 16, 2009 at 07:15:26AM -0600, Joshua Jensen wrote:

> >Should we actually be converting the filesystem names into a canonical
> >format as they are read? IIRC, Linus posted some patches a few weeks ago
> >about "git path" versus "filesystem path", but I didn't actually look
> >too closely.
> I'm game for whatever.  Git actually has a lot of places where it
> doesn't pay attention to core.ignorecase, and having a standard and
> correct method of comparing filenames would make it easier to handle
> core.ignorecase=true in a more global fashion.

Like I said, I'm not sure what the status of that is, so probably
something simple like your patch makes sense in the interim (unless we
hear from somebody more clueful).

> >If your patch is the right route, it might be nice to collapse the
> >comparison into its own function. You end up cutting and pasting a lot
> >of the related conditionals and returns (like above, where 2 lines
> >become 9), so it might make sense to do something like:
> >
> >  int filename_cmp(const char *a, const char *b, int ignore_case)
> >  {
> >    return ignore_case ? strcasecmp(a, b) : strcmp(a, b);
> >  }
> >
> >and then just s/strcmp/filename_cmp/ at the appropriate callsites.
> I started off with this method, but it required two functions, one
> with the strcmp() and one for strncmp().  In fact, in other places in
> the code, Git uses memcmp() for comparison.  Is that, then, three
> filename comparison functions, dependent upon intent?  At that point,
> it felt like my change wasn't as self contained anymore, so I then
> wrote what I posted to the list to get feedback.

IMHO, you are better off even with three wrapper functions, just because
they are all very straightforward. Whereas with your patch, I felt like
the innards of complex functions got harder to read because of big
duplicate conditionals. But that's just my two cents.

-Peff
