From: Jeff King <peff@peff.net>
Subject: Re: "git status" should warn/error when it cannot lists a directory
Date: Tue, 3 Feb 2015 00:36:43 -0500
Message-ID: <20150203053642.GB1262@peff.net>
References: <CADgNjamcR+b-_DKzScU=35idAgG542B7CaJC2AqAE9Srvsq17g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Andrew Wong <andrew.kw.w@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 03 06:37:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YIWAW-0002uU-So
	for gcvg-git-2@plane.gmane.org; Tue, 03 Feb 2015 06:37:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966120AbbBCFgr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Feb 2015 00:36:47 -0500
Received: from cloud.peff.net ([50.56.180.127]:44412 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S966111AbbBCFgp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Feb 2015 00:36:45 -0500
Received: (qmail 8350 invoked by uid 102); 3 Feb 2015 05:36:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 02 Feb 2015 23:36:45 -0600
Received: (qmail 6492 invoked by uid 107); 3 Feb 2015 05:36:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 03 Feb 2015 00:36:44 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 03 Feb 2015 00:36:43 -0500
Content-Disposition: inline
In-Reply-To: <CADgNjamcR+b-_DKzScU=35idAgG542B7CaJC2AqAE9Srvsq17g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263307>

On Mon, Feb 02, 2015 at 11:58:33AM -0500, Andrew Wong wrote:

> When "git status" recurses a directory that isn't readable (but
> executable), it should print out a warning/error. Currently, if there
> are untracked files in these directories, git wouldn't be able to
> discover them. Ideally, "git status" should return a non-zero exit
> code as well.

Also, I think "git add ." would silently ignore such directories, which
is probably a bad thing if you are relying on it to capture the whole
directory's state. Similarly, I think we would ignore transient
errors (like EMFILE) or other EACCES problems (like a mode 0700
directory owned by somebody else).

> The problem seems to be In read_directory_recursive() from dir.c. When
> opendir() returns null, we continue on ignoring any error. Is there a
> scenario where returning null is expected? We can simply call perror()
> here, but it would be nice if we can propagate the error to the exit
> code too. How would we do that?

I think we should report an error on EACCES. Perhaps somebody is happy
that "git add" ignores unreadable directories, but the right solution is
for them to put those directories in their .gitignore (and/or use
"--ignore-errors").

People may want to ignore ENOENT in this situation, though. That is a
sign that somebody is racily modifying the directory while git is
running. That's generally a bad idea, but it is not a big deal for us to
skip such a directory (after all, we might racily have missed its
existence in the first place, so all bets are off).

>From a cursory look, I'd agree that hitting the opendir() in
read_directory_recursive is the right place to start. I'd silently
ignore ENOENT, and propagate the rest.

That code is too low-level to call die() directly, I think, so you will
need to propagate the error back. Adding a new error-value to the "enum
path_treatment" could work, but it will probably be rather clumsy
getting it all the way back up to the original caller. It will probably
be much easier to:

  1. Give dir_struct an error flag, and set it whenever the traversal
     sees an error. Callers can check the flag at the appropriate level
     and ignore or die() as appropriate.

  2. Teach dir_struct a "quiet" flag. If not set, emit a warning()
     deep in the code. Alternatively, you could collect a set of
     error-producing pathnames (along with their errno values), and
     the caller could decide whether to print them itself (this is
     similar to how DIR_COLLECT_IGNORED works).

-Peff
