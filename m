From: Jeff King <peff@peff.net>
Subject: [BUG] gitattribute macro expansion oddity
Date: Tue, 10 Jan 2012 02:03:01 -0500
Message-ID: <20120110070300.GA17086@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Henrik =?utf-8?Q?Grubbstr=C3=B6m?= <grubba@grubba.org>,
	git-dev@github.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 10 08:03:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RkVjs-0000k4-Rt
	for gcvg-git-2@lo.gmane.org; Tue, 10 Jan 2012 08:03:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756115Ab2AJHDH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jan 2012 02:03:07 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:33450
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754465Ab2AJHDE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jan 2012 02:03:04 -0500
Received: (qmail 7437 invoked by uid 107); 10 Jan 2012 07:09:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 10 Jan 2012 02:09:57 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 10 Jan 2012 02:03:01 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188226>

I'm seeing some very odd behavior with git's attribute expansion for
diffs. You can see it with this repository:

  git clone git://github.com/libgit2/libgit2sharp.git

Try a diff of a non-binary file:

  $ git show 2a0f4bf7 LibGit2Sharp/Configuration.cs
  ...
  diff --git a/LibGit2Sharp/Configuration.cs b/LibGit2Sharp/Configuration.cs
  index 83cc9d6..9ab0b60 100644
  --- a/LibGit2Sharp/Configuration.cs
  +++ b/LibGit2Sharp/Configuration.cs

Looks OK. Now try a diff that also has a binary file (that is marked
such via gitattributes):

  $ git show 2a0f4bf7 Lib/NativeBinaries/x86/git2.dll \
                      LibGit2Sharp/Configuration.cs
  ...
  diff --git a/Lib/NativeBinaries/x86/git2.dll b/Lib/NativeBinaries/x86/git2.dll
  index dab0d04..8de18ab 100644
  Binary files a/Lib/NativeBinaries/x86/git2.dll and b/Lib/NativeBinaries/x86/git2.dll differ
  diff --git a/LibGit2Sharp/Configuration.cs b/LibGit2Sharp/Configuration.cs
  index 83cc9d6..9ab0b60 100644
  Binary files a/LibGit2Sharp/Configuration.cs and b/LibGit2Sharp/Configuration.cs differ

Now the Configuration.cs blobs appear binary!

It has nothing to do with pathspecs; if you do a non-limited diff of
2a0f4bf7, you'll see many of the files appear as binary. Running it
through the debugger, it looks like we are getting wrong diff attribute
values for later paths, as if the earlier lookups are somehow polluting
the attribute stack.

The gitattributes in this repository look reasonably sane, but even if
they were not, nothing should make a file have different attributes
based on other files that were diffed.

Bisection points to ec775c4 (attr: Expand macros immediately when
encountered., 2010-04-06), but it's too late for me to dig further
tonight. Cc'ing Junio as the author of the attr code and Henrik as the
author of ec775c4.

-Peff
