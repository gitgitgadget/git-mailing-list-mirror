From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [RFC] Git.pm: stat the FD to ensure the file is really open
Date: Fri, 31 Oct 2014 01:26:48 +0000
Message-ID: <20141031012648.GA25698@dcvr.yhbt.net>
References: <20141030220836.GA7873@dcvr.yhbt.net>
 <4DCE1FB9-F0FA-48FD-866C-67E7C2E97951@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Kyle J. McKay" <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 31 02:26:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xk0zN-0007JR-1I
	for gcvg-git-2@plane.gmane.org; Fri, 31 Oct 2014 02:26:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758132AbaJaB0t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Oct 2014 21:26:49 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:40368 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751384AbaJaB0s (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Oct 2014 21:26:48 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 98FBE1F7EC;
	Fri, 31 Oct 2014 01:26:48 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <4DCE1FB9-F0FA-48FD-866C-67E7C2E97951@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Kyle J. McKay" <mackyle@gmail.com> wrote:
> On Oct 30, 2014, at 15:08, Eric Wong wrote:
> >For a (currently) unknown reason, Git::SVN::Fetcher::close_file
> >sometimes triggers "Bad file descriptor" errors on syswrite when
> >writing symlink contents on the "svn_hash" tempfile.
> >
> >The current IO::Handle::opened call in Git.pm is not a
> >sufficient check, as the underlying file descriptor is closed
> >without the PerlIO layer knowing about it.  This is likely a bug
> >inside libsvn (1.6.17), as none of the Git.pm or Git::SVN
> >modules close IOs without the knowledge of the PerlIO layer.
> >
> >Cc: Kyle J. McKay <mackyle@gmail.com>
> >Signed-off-by: Eric Wong <normalperson@yhbt.net>
> >---
> >Kyle/Junio: thoughts?  I'm running out of time to track this down
> >so it might be necessary for 2.2-rc0.  What's even stranger is
> >I cannot always reproduce the problem even without this patch,
> >so it may be only triggered by network latency...
> >Thanks.
> 
> With this patch added, do you then see the warning:
> 
>   carp "Temp file '", $name,
> 	"' was closed. Opening replacement.";
> 
> From _temp_cache?  It would seem odd if you didn't unless there was
> only one symlink involved.

Nope.  $$temp_fd was defined so the message is not hit.
Is suppose we can also make the following change:

--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -1282,11 +1282,9 @@ sub _temp_cache {
 				$name . "' already in use");
 		}
 	} else {
-		if (defined $$temp_fd) {
-			# then we're here because of a closed handle.
-			carp "Temp file '", $name,
-				"' was closed. Opening replacement.";
-		}
+		# then we're here because of a closed handle.
+		carp "Temp file '", $name,
+			"' was closed. Opening replacement.";
 		my $fname;
 
 		my $tmpdir;

> I suspect that symlinks were rare in the repositories I was testing
> against.  I wonder if having a test svn repo that adds several new
> symlinks for several revisions in a row might trigger this problem
> more robustly.
> 
> The _repository->temp_acquire('svn_hash') call is assigned to a "my"
> variable and then has Git::temp_release called on it later in the
> same function and the only calls made on it in between are
> Git::temp_path, so I don't see how the libsvn library could be
> responsible for closing it since it looks to me like it never sees
> it.  But I'm looking at v2.1.2 of Fetcher.pm, so if some other calls
> have been inserted there since then.

I stared at it for a long while and could not figure out what was going
on, either.  The other temp_acquire users are far less straightforward
and did not get mysteriously closed.

> The changes themselves look okay, but eeewwww.  I don't see how
> libsvn can see the svn_hash fd to close it unless it's randomly
> closing fds.

Right.  Even worse, I can't even get it to trigger anymore...
Thanks for your response!
