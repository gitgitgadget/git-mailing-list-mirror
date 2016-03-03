From: Jeff King <peff@peff.net>
Subject: Re: "./t0001-init.sh --valgrind" is broken
Date: Thu, 3 Mar 2016 13:05:01 -0500
Message-ID: <20160303180501.GA23116@sigill.intra.peff.net>
References: <CAP8UFD0-FxoPe5-35NAKSkegFBoRPy1+BOsqN-y+QJUoXAqR3g@mail.gmail.com>
 <CACsJy8AL_RGEb2z44-yoL+3yF7n1+FMLqZkmWwUDFJnEPYS_nw@mail.gmail.com>
 <56D7DFD5.8010108@kdbg.org>
 <CACsJy8CVfJdCmwWo50wHsc6DP6ft71d5bfBaFSJpv9XcNRwdSQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <j6t@kdbg.org>,
	Christian Couder <christian.couder@gmail.com>,
	git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 03 19:05:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1abXcf-0007zj-QD
	for gcvg-git-2@plane.gmane.org; Thu, 03 Mar 2016 19:05:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756877AbcCCSFI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Mar 2016 13:05:08 -0500
Received: from cloud.peff.net ([50.56.180.127]:54278 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754693AbcCCSFH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Mar 2016 13:05:07 -0500
Received: (qmail 7648 invoked by uid 102); 3 Mar 2016 18:05:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 03 Mar 2016 13:05:05 -0500
Received: (qmail 8155 invoked by uid 107); 3 Mar 2016 18:05:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 03 Mar 2016 13:05:17 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 03 Mar 2016 13:05:01 -0500
Content-Disposition: inline
In-Reply-To: <CACsJy8CVfJdCmwWo50wHsc6DP6ft71d5bfBaFSJpv9XcNRwdSQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288197>

On Thu, Mar 03, 2016 at 07:09:12PM +0700, Duy Nguyen wrote:

> +the-other-Johannes who added valgrind support.
> 
> On Thu, Mar 3, 2016 at 1:55 PM, Johannes Sixt <j6t@kdbg.org> wrote:
> > ---- 8< ----
> > Subject: [PATCH] t0001: fix GIT_* environment variable check under --valgrind
> >
> > When a test case is run without --valgrind, the wrap-for-bin.sh
> > helper script inserts the environment variable GIT_TEXTDOMAINDIR, but
> > when run with --valgrind, the variable is missing. A recently
> > introduced test case expects the presence of the variable, though, and
> > fails under --valgrind.
> 
> Yep.
> 
> It's interesting though that valgrind sets up some variables without
> going through bin-wrappers. That's understandable because valgrind
> support is added (in 4e1be63) 10 months before bin-wrappers (in
> ea92519).  But it's probably better that we inject valgrind command
> from inside bin-wrappers script, the same way we inject gdb, I think.

I had the same thought and even started on a patch, but it doesn't quite
work. The bin-wrappers are all about intercepting what goes into the
user's $PATH, and pointing our libexec dir at the main build.

So we have "git" and "git-upload-pack" in bin-wrappers, but not
"git-log". Whereas the valgrind code wants to intercept _all_ of the
test script's invocations of git, including ones spawned by scripts,
other git commands, etc. So conceptually, it wants to intercept
$GIT_EXEC_PATH.

-Peff
