From: Jeff King <peff@peff.net>
Subject: git-status producing incorrect results
Date: Thu, 14 Feb 2008 11:45:05 -0500
Message-ID: <20080214164505.GA21932@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Kristian =?utf-8?B?SMO4Z3NiZXJn?= <krh@redhat.com>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Feb 14 17:45:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPhDX-0004LK-9Q
	for gcvg-git-2@gmane.org; Thu, 14 Feb 2008 17:45:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754641AbYBNQpK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Feb 2008 11:45:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754450AbYBNQpK
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Feb 2008 11:45:10 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1618 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753213AbYBNQpI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Feb 2008 11:45:08 -0500
Received: (qmail 8707 invoked by uid 111); 14 Feb 2008 16:45:06 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 14 Feb 2008 11:45:06 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Feb 2008 11:45:05 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73887>

There seems to be a bug in "git-status" in next (but not in master). I
bisected it to:

  commit d1f2d7e8ca65504722108e2db710788f66c34c6c
  Author: Linus Torvalds <torvalds@linux-foundation.org>
  Date:   Sat Jan 19 17:27:12 2008 -0800

  Make run_diff_index() use unpack_trees(), not read_tree()

Basically, doing a partial commit when a new file has been added to the
index but isn't part of the partial commit will cause that new file to
be listed as part of the index. You can reproduce it with:

  mkdir trash && cd trash && git init &&
  touch file && git add file && git commit -m one &&
  touch added && git add added &&
  echo modified >file && git status file

Even more exciting, the later commit cf558704 causes an infinite loop
(but still has the bad behavior), which is then fixed in 9cb76b8c (which
still has the bad behavior, in addition to printing the "bug in
wt_status_print_untracked" message to indicate that we found something
funny in the index).

I _think_ of all of this is caused by the fact that builtin-commit looks
in the regular index, but then gives us an alternate index. This didn't
matter before because we were discarding the index so many time anyway.

The patch below fixes it by discarding and re-reading the index if we
are doing a partial commit, but I suspect it may just be papering over
the problem again. We probably need to have two separate index_states,
and pass in the correct one to wt-status (rather than giving it the
filename and having it read into the_index).

diff --git a/builtin-commit.c b/builtin-commit.c
index c63ff82..005362e 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -313,6 +313,10 @@ static char *prepare_index(int argc, const char **argv, const char *prefix)
 	if (write_cache(fd, active_cache, active_nr) ||
 	    close_lock_file(&false_lock))
 		die("unable to write temporary index file");
+
+	discard_cache();
+	read_cache_from(false_lock.filename);
+
 	return false_lock.filename;
 }
 
-Peff
