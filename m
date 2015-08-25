From: Jeff King <peff@peff.net>
Subject: Re: bug: git branch -d and case-insensitive file-systems
Date: Tue, 25 Aug 2015 01:21:23 -0400
Message-ID: <20150825052123.GA523@sigill.intra.peff.net>
References: <CAJrRhQz1UmnDi6Giejetfoh3aPX08aYcgY-neZfcKjpUav0=sA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Aaron Dufour <thedufer@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 25 07:21:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZU6fr-0006qM-3X
	for gcvg-git-2@plane.gmane.org; Tue, 25 Aug 2015 07:21:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752900AbbHYFV0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Aug 2015 01:21:26 -0400
Received: from cloud.peff.net ([50.56.180.127]:49541 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752114AbbHYFV0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Aug 2015 01:21:26 -0400
Received: (qmail 31566 invoked by uid 102); 25 Aug 2015 05:21:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 25 Aug 2015 00:21:26 -0500
Received: (qmail 32183 invoked by uid 107); 25 Aug 2015 05:21:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 25 Aug 2015 01:21:26 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 25 Aug 2015 01:21:23 -0400
Content-Disposition: inline
In-Reply-To: <CAJrRhQz1UmnDi6Giejetfoh3aPX08aYcgY-neZfcKjpUav0=sA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276506>

On Mon, Aug 24, 2015 at 12:11:13PM -0400, Aaron Dufour wrote:

> I use git (2.2.1) on OS X (10.9.5) and recently my repo got into a bad
> state.  I think this involves a mis-handling of case-insensitive file
> systems.
> 
> This reproduces the problem:
> 
>     > git init
>     Initialized empty Git repository in /Users/aarond_local/code/git-test/.git/
>     > git commit --allow-empty -m 'first commit'
>     [master (root-commit) 923d8b8] first commit
>     > git checkout -b feature
>     Switched to a new branch 'feature'
>     > git checkout -b Feature
>     fatal: A branch named 'Feature' already exists.
>     > git checkout -B Feature
>     Switched to and reset branch 'Feature'
>     > git branch -d feature
>     Deleted branch feature (was 923d8b8).
>     > git log
>     fatal: bad default revision 'HEAD'

I don't work on a case-insensitive filesystem, so my knowledge may be
out of date, but as far as I know, we do not do anything special to
handle ref case-sensitivity. I expect your problem would go away with
this patch:

diff --git a/builtin/branch.c b/builtin/branch.c
index 58aa84f..c5545de 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -19,6 +19,7 @@
 #include "column.h"
 #include "utf8.h"
 #include "wt-status.h"
+#include "dir.h"
 
 static const char * const builtin_branch_usage[] = {
 	N_("git branch [<options>] [-r | -a] [--merged | --no-merged]"),
@@ -223,7 +224,7 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 		int flags = 0;
 
 		strbuf_branchname(&bname, argv[i]);
-		if (kinds == REF_LOCAL_BRANCH && !strcmp(head, bname.buf)) {
+		if (kinds == REF_LOCAL_BRANCH && !strcmp_icase(head, bname.buf)) {
 			error(_("Cannot delete the branch '%s' "
 			      "which you are currently on."), bname.buf);
 			ret = 1;

but I think that is just the tip of the iceberg. E.g. (on a vfat
filesystem I just created):

  $ git init
  $ git commit -q --allow-empty -m one
  $ git branch foo
  $ git branch FOO
  fatal: A branch named 'FOO' already exists.

  $ git pack-refs --all --prune ;# usually run as part of git-gc
  $ git commit -q --allow-empty -m two
  $ git branch FOO
  $ git for-each-ref --format='%(refname) %(subject)'
  refs/heads/FOO two
  refs/heads/foo one
  refs/heads/master two

Now the patch I showed above would do the wrong thing. Running "git
checkout foo; git branch -d FOO" would be rejected, even though I really
do have two separate branches.

It would be a much more invasive change to fix this correctly. It is
probably less work overall to move to a pluggable ref system, and to
design ref storage that isn't dependent on the filesystem (this work is
already underway).

In the meantime, I think the best advice for mixed-case branch names on
a case-insensitive filesystem is: don't.

-Peff
