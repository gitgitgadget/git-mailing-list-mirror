From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC 3/3] ls-files/dir: use is_git_repo to detect
 submodules
Date: Sat, 5 Dec 2015 02:37:44 -0500
Message-ID: <20151205073744.GC21639@sigill.intra.peff.net>
References: <1449252917-3877-1-git-send-email-a.krey@gmx.de>
 <1449252917-3877-3-git-send-email-a.krey@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Andreas Krey <a.krey@gmx.de>
X-From: git-owner@vger.kernel.org Sat Dec 05 08:37:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a57Pk-00089t-8U
	for gcvg-git-2@plane.gmane.org; Sat, 05 Dec 2015 08:37:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752340AbbLEHhr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Dec 2015 02:37:47 -0500
Received: from cloud.peff.net ([50.56.180.127]:37696 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752133AbbLEHhr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Dec 2015 02:37:47 -0500
Received: (qmail 12493 invoked by uid 102); 5 Dec 2015 07:37:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 05 Dec 2015 01:37:47 -0600
Received: (qmail 1145 invoked by uid 107); 5 Dec 2015 07:37:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 05 Dec 2015 02:37:50 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 05 Dec 2015 02:37:44 -0500
Content-Disposition: inline
In-Reply-To: <1449252917-3877-3-git-send-email-a.krey@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282030>

On Fri, Dec 04, 2015 at 07:15:17PM +0100, Andreas Krey wrote:

> Using resolve_gitlink_ref to check for submodules
> creates submodule list entries even when it isn't
> one, and causes O(n^2) runtime behaviour in repos
> with many untracked directories.
> 
> Use is_git_repo instead for detection.
> 
> Signed-off-by: Andreas Krey <a.krey@gmx.de>
> ---
> This looks good, but it breaks test - at least
> number 67 ('../bar/a/b/c works with relative local
> path - ../foo/bar.git') in t7400-submodule-basic.sh
> 
> I don't really understand yet how to fix that,
> but it is due to resolve_gitlink_ref looking
> for a valid HEAD which is_git_repo doesn't.

Hrm. Weird. You'd think it would break with the existing code if I do
this, then:

diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index 540771c..944e9f5 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -754,7 +754,7 @@ test_expect_success '../bar/a/b/c works with relative local path - ../foo/bar.gi
 		cp pristine-.git-config .git/config &&
 		cp pristine-.gitmodules .gitmodules &&
 		mkdir -p a/b/c &&
-		(cd a/b/c; git init) &&
+		(cd a/b/c; git init && git commit --allow-empty -m foo) &&
 		git config remote.origin.url ../foo/bar.git &&
 		git submodule add ../bar/a/b/c ./a/b/c &&
 		git submodule init &&

But it doesn't. So presumably there is a mismatch where some other code
expects that anything which gets marked as a repo in the code you
changed can also be resolved to a sha1. I'm not sure where that other
code is though (in git-submodule.sh, or elsewhere in add).

Perhaps we end up in index_path(), which then barfs? That would explain
this (run in the trash directory after the test fails):

  $ cd reltest && git add a/b/c
  error: unable to index file a/b/c/
  fatal: adding files failed

We know it is a git dir, but there is no sha1 for us to actually add as
the gitlink entry.

If that is the case, then there is either some very tricky refactoring
required, or what we are trying to do here is simply wrong. Maybe it
would be simpler to just speed up resolve_gitlink_ref with a better data
structure.

-Peff
