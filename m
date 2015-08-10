From: Jeff King <peff@peff.net>
Subject: [PATCH 0/17] removing questionable uses of git_path
Date: Mon, 10 Aug 2015 05:27:32 -0400
Message-ID: <20150810092731.GA9027@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 10 11:27:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZOjN8-0000AV-Bs
	for gcvg-git-2@plane.gmane.org; Mon, 10 Aug 2015 11:27:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754123AbbHJJ1y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2015 05:27:54 -0400
Received: from cloud.peff.net ([50.56.180.127]:42794 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754490AbbHJJ1h (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Aug 2015 05:27:37 -0400
Received: (qmail 30524 invoked by uid 102); 10 Aug 2015 09:27:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 10 Aug 2015 04:27:38 -0500
Received: (qmail 2950 invoked by uid 107); 10 Aug 2015 09:27:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 10 Aug 2015 05:27:48 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Aug 2015 05:27:32 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275566>

Recently Michael and I were working on a patch series (not yet
published), which did something like:


  const char *path = git_path("foo");

  ... do stuff with path ...

  for_each_ref(some_callback, NULL);

  ... do some other stuff ...

  unlink(path);

Clever readers may have spotted the bug immediately, but we did not,
until we found that random loose refs were being deleted from the
repository.

The problem is that git_path uses a static buffer that gets overwritten
by subsequent calls. The ref code uses it to iterate over all of the
loose refs in a directory, so our original path is trashed before
for_each_ref returns. Except to make it even more exciting, git_path
actually has a ring of _four_ buffers, so any trivial test you write
will probably work just fine; it's only when you use a real repository
that it causes problems (and then, only if the code path is such that
the loose refs were not previously accessed and cached!).

Michael likened git_path to "a hand-grenade with the pin pulled out",
and I tend to agree. On the other hand, it's pretty darn useful to be
able to get a quick path without having to deal with memory allocation
and ownership.  This patch series tries to document the danger, and
remove some of the more questionable uses. I don't know whether this is
fixing any actual latent bugs; I traced a number of the code paths
manually, but never found a bug. There were some near misses, though,
which make me believe that seemingly-unrelated refactoring could
introduce a bug.

I stopped short of trying to eradicate git_path entirely, and settled
for:

  git grep -E '[^_](git_|mk)path\('

producing a fairly tame-looking set of function calls. It's OK to pass
the result of git_path() to a system call, or something that is a thin
wrapper around one (e.g., strbuf_read_file).

I think this takes us most of the way there. I left out a few cases
where introducing allocations would have been awkward, and I verified
that there were no bugs (e.g., rerere_path). And I left out a few spots
that conflict with topics in "next" (and luckily, in all cases what is
in next makes the problem go away, so we do not have to follow-up for
those sites).

Along the way, there are a few cleanups (e.g., I polished off the recent
hold_lock_file_for_append topic which was on the list, as it had some
problematic calls).

  [01/17]: cache.h: clarify documentation for git_path, et al
  [02/17]: cache.h: complete set of git_path_submodule helpers
  [03/17]: t5700: modernize style
  [04/17]: add_to_alternates_file: don't add duplicate entries
  [05/17]: remove hold_lock_file_for_append
  [06/17]: prefer git_pathdup to git_path in some possibly-dangerous cases
  [07/17]: prefer mkpathdup to mkpath in assignments
  [08/17]: remote.c: drop extraneous local variable from migrate_file
  [09/17]: refs.c: remove extra git_path calls from read_loose refs
  [10/17]: path.c: drop git_path_submodule
  [11/17]: refs.c: simplify strbufs in reflog setup and writing
  [12/17]: refs.c: avoid repeated git_path calls in rename_tmp_log
  [13/17]: refs.c: avoid git_path assignment in lock_ref_sha1_basic
  [14/17]: refs.c: remove_empty_directories can take a strbuf
  [15/17]: find_hook: keep our own static buffer
  [16/17]: get_repo_path: refactor path-allocation
  [17/17]: memoize common git-path "constant" files

-Peff
