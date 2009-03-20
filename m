From: Jeff King <peff@peff.net>
Subject: Re: [RFC] Colorization of log --graph
Date: Fri, 20 Mar 2009 15:58:06 -0400
Message-ID: <20090320195806.GC26934@coredump.intra.peff.net>
References: <20090318100512.GA7932@linux.vnet> <alpine.DEB.1.00.0903181228420.10279@pacific.mpi-cbg.de> <b2e43f8f0903190959if539048r19e972899bd2132d@mail.gmail.com> <alpine.DEB.1.00.0903191831590.6357@intel-tinevez-2-302> <20090320064813.6117@nanako3.lavabit.com> <b2e43f8f0903201213o396de6c0sb52149ed1d889d1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nanako Shiraishi <nanako3@lavabit.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Allan Caffee <allan.caffee@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 20 20:59:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lkksf-0005iO-Qg
	for gcvg-git-2@gmane.org; Fri, 20 Mar 2009 20:59:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755959AbZCTT6U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2009 15:58:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760944AbZCTT6U
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Mar 2009 15:58:20 -0400
Received: from peff.net ([208.65.91.99]:51507 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760254AbZCTT6S (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2009 15:58:18 -0400
Received: (qmail 10678 invoked by uid 107); 20 Mar 2009 19:58:27 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 20 Mar 2009 15:58:27 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 20 Mar 2009 15:58:06 -0400
Content-Disposition: inline
In-Reply-To: <b2e43f8f0903201213o396de6c0sb52149ed1d889d1@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113998>

On Fri, Mar 20, 2009 at 03:13:53PM -0400, Allan Caffee wrote:

> /*
>  * Map names to ANSI escape sequences.  Consider putting this in color.c
>  * and providing color_name_get_ansi_code(enum color_name).
>  */
> const char* git_color_codes[] {
> 	GIT_COLOR_RESET,
> 	GIT_COLOR_BOLD,
> 	GIT_COLOR_RED,
> 	GIT_COLOR_GREEN,
> 	GIT_COLOR_YELLOW,
> 	GIT_COLOR_BLUE,
> 	GIT_COLOR_CYAN,
> 	GIT_COLOR_BG_RED,
> };
> 
> That conveniently offers clients access to both the raw escape codes and
> a clear type for storing/handling colors.

I want to point out one thing: an enum or a list like this is actually a
subset of the useful color codes that git can represent.  Actual
configured colors can have attributes, foreground, and background
colors. So they need to be stored in a character array.

Adding an enum for GIT_COLOR_RED and using it throughout the code can be
helpful for simple cases, but it doesn't give you an easy way of saying
"red background, blue foreground". Maybe that is enough for git internal
usage, since we tend not to use backgrounds or attributes for defaults.
But maybe it makes more sense to do this as:

  const char *ansi_color(enum color fg, enum color bg, enum attribute attr);

and return a pointer to a static array representing the color (and even
cycle through a list the way sha1_to_hex or git_path does). And you
could even use it to simplify and share code with the config color
parsing in color.c.

-Peff
