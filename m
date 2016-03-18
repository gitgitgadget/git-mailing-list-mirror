From: Jeff King <peff@peff.net>
Subject: Re: [RFC] Code reorgnization
Date: Fri, 18 Mar 2016 01:24:47 -0400
Message-ID: <20160318052447.GD22327@sigill.intra.peff.net>
References: <20160317111136.GA21745@lanh>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 18 06:24:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agmu6-0005Hg-Fs
	for gcvg-git-2@plane.gmane.org; Fri, 18 Mar 2016 06:24:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751460AbcCRFYv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Mar 2016 01:24:51 -0400
Received: from cloud.peff.net ([50.56.180.127]:33886 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750895AbcCRFYu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Mar 2016 01:24:50 -0400
Received: (qmail 15041 invoked by uid 102); 18 Mar 2016 05:24:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 18 Mar 2016 01:24:50 -0400
Received: (qmail 8676 invoked by uid 107); 18 Mar 2016 05:25:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 18 Mar 2016 01:25:08 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 18 Mar 2016 01:24:47 -0400
Content-Disposition: inline
In-Reply-To: <20160317111136.GA21745@lanh>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289191>

On Thu, Mar 17, 2016 at 06:11:36PM +0700, Duy Nguyen wrote:

> Git's top directory is crowded and I think it's agreed that moving
> test-* to t/helper is a good move. I just wanted to check if we could
> take this opportunity (after v2.8.0) to move some other files too. I
> propose the following new subdirs

I guess I don't really see the "crowded" problem, but perhaps that is
because I am more or less familiar with where things are in git's code
base. I suppose if you were looking for a "utility" function, you might
look in "util" and therefore have a smaller set of files to check.

But I think we also run into the opposite problem: I am looking for some
particular function, but I can't find it, because I am looking in "util"
and it is in some other directory. And when files move around, it makes
history harder to follow (maybe that is because git sucks and we need to
make it better, but certainly I run into mild annoyances with the
builtin/ rename when digging in history).

And you have a similar problem when creating new files. Which slot do
they go in? What if they could feasibly go into two slots?

So there can be friction either way. In practice I find I just use ctags
to jump to the functions I am interested in, and I don't care that much
about filenames.

The reorganization that _would_ be more interesting to me is not files
in directories, but rather functions in files. I wish everything were
designed more as modules with a pair of matching ".c" and ".h" files,
with a public interface defined in the ".h", and messier, private stuff
in the ".c". But we have some real dumping grounds:

  1. cache.h has the declarations for at least a dozen different
     modules; besides being hard to navigate, it causes more frequent
     recompilation than necessary.

  2. a few of the .c files could probably be split (e.g., dir.c is where
     all of the pathspec code lives, even though that is used for much
     more than filesystem access these days).

Splitting those up would _also_ introduce friction (and actually worse
than whole-file renames, because finding code movement between files is
an even harder / more expensive problem). But I feel like it would buy a
lot more in terms of code clarity, and in reducing the scope of code
which has access to private, static interfaces.

-Peff
