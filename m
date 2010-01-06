From: Jeff King <peff@peff.net>
Subject: Re: "git add -i" with path gives "Argument list too long"
Date: Wed, 6 Jan 2010 07:19:27 -0500
Message-ID: <20100106121927.GC7221@coredump.intra.peff.net>
References: <36FEB8A0-968D-4B43-AEFB-9B0E227A1F88@wincent.com>
 <20100105041438.GB12574@coredump.intra.peff.net>
 <AAABEE5B-0419-4344-86E2-7EB550CCFC01@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Wed Jan 06 13:22:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSUuQ-0001eI-Bs
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jan 2010 13:22:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755646Ab0AFMTf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jan 2010 07:19:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755637Ab0AFMTf
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jan 2010 07:19:35 -0500
Received: from peff.net ([208.65.91.99]:40732 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755630Ab0AFMTe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jan 2010 07:19:34 -0500
Received: (qmail 16574 invoked by uid 107); 6 Jan 2010 12:24:19 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 06 Jan 2010 07:24:19 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 06 Jan 2010 07:19:27 -0500
Content-Disposition: inline
In-Reply-To: <AAABEE5B-0419-4344-86E2-7EB550CCFC01@wincent.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136264>

On Tue, Jan 05, 2010 at 01:34:32PM +0100, Wincent Colaiuta wrote:

> >but note that the pathspecs given to ls-files and the path limiters
> >given to diff are not quite the same. So "git add -i '*.c'" will
> >currently find "subdir/foo.c", but would not with the above patch. Is
> >that what you meant when you said "recurse into directories"?
> 
> In my relative ignorance of the finer details here, I meant that I
> would want "diff-index" to give us the exact same set of blobs as we
> get from "ls-files", so as to fix the error without modifying the
> user visible behavior.
> 
> As I said, I personally wouldn't be impacted by the change in
> behavior that your patch produces, but maybe others might.

I also don't care about the globbing feature, though I suppose some
people do. However, I'm not sure add's behavior is all that sensible
now. Interactive add respects the globs, but regular add does not.
Worse, it seems that it notes that the pathspec is a wildcard and does
not even flag an error for failing to find any files. For example:

  $ git init
  $ echo content >foo.c
  $ mkdir subdir && echo content >subdir/bar.c
  $ git add .
  $ echo change >foo.c && echo change >subdir/bar.c
  $ git diff --name-only
  foo.c
  subdir/bar.c
  $ git add foobar ;# should barf, and does
  fatal: pathspec 'foobar' did not match any files
  $ git add '*.c' ;# does not barf, but does not respect wildcard
  $ git diff --name-only
  foo.c
  subdir/bar.c
  $ yes | git add -p '*.c' ;# respects glob
  $ git diff --name-only ;# empty

So it's an consistency that should probably be fixed. And of course it
is tempting to fix it by disabling the globs for the interactive case,
which would not involve writing any new code. ;) But I don't think it is
a good idea to punish people by taking away their feature in the name of
consistency.

-Peff
