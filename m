From: Jeff King <peff@peff.net>
Subject: Re: bug report: build issue with git 2.2.2 using uclibc toolchain
Date: Fri, 30 Jan 2015 11:33:32 -0500
Message-ID: <20150130163331.GA5239@peff.net>
References: <54CBA968.2040807@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Lance Fredrickson <lancethepants@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 30 17:33:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YHEVn-0003So-3g
	for gcvg-git-2@plane.gmane.org; Fri, 30 Jan 2015 17:33:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932909AbbA3Qdf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jan 2015 11:33:35 -0500
Received: from cloud.peff.net ([50.56.180.127]:43344 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752910AbbA3Qde (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jan 2015 11:33:34 -0500
Received: (qmail 26216 invoked by uid 102); 30 Jan 2015 16:33:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 30 Jan 2015 10:33:34 -0600
Received: (qmail 25385 invoked by uid 107); 30 Jan 2015 16:34:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 30 Jan 2015 11:34:03 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 30 Jan 2015 11:33:32 -0500
Content-Disposition: inline
In-Reply-To: <54CBA968.2040807@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263183>

On Fri, Jan 30, 2015 at 08:55:20AM -0700, Lance Fredrickson wrote:

> I've been keeping up-to-date versions of git built for an embedded mipsel
> architecture device running on uclibc.
> 2.2.1 and previous versions build fine, but 2.2.2 stops with an error.
> 
> The toolchain is an OpenWRT variant (entware) using gcc 4.6.4 and uclibc
> 0.9.32, available at the following.
> http://entware.wl500g.info/sources/
> 
> Here is the output of the build error.
> 
> CC builtin/grep.o
> builtin/get-tar-commit-id.c: In function 'cmd_get_tar_commit_id':
> builtin/get-tar-commit-id.c:31:12: error: dereferencing pointer to
> incomplete type

That seems odd. The line in question is:

  if (header->typeflag[0] != 'g')

the "header" variable is defined above as:

  struct ustar_header *header = (struct ustar_header *)buffer;

and "struct ustar_header" is defined in "tar.h", which is included
above.

uclibc ships its own tar.h. Ours should take precedence (because we use
""), but perhaps there is something funny going on in the build
settings. I can't find any interesting changes in v2.2.1..v2.2.2,
though.

Can you double-check that v2.2.1 still builds, and if so try to use "git
bisect start v2.2.2 v2.2.1" to find the responsible commit?

-Peff
