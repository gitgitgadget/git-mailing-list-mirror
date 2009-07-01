From: Jeff King <peff@peff.net>
Subject: [RFC/PATCH 2/2] fix missing NUL termination with pretty=tformat
Date: Wed, 1 Jul 2009 03:26:33 -0400
Message-ID: <20090701072632.GB8101@sigio.peff.net>
References: <20090701070252.GA7987@sigio.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Eric Raible <raible@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 01 09:24:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MLuBW-0005HT-EZ
	for gcvg-git-2@gmane.org; Wed, 01 Jul 2009 09:24:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753154AbZGAHYj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jul 2009 03:24:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753150AbZGAHYi
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Jul 2009 03:24:38 -0400
Received: from peff.net ([208.65.91.99]:50427 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753061AbZGAHYi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jul 2009 03:24:38 -0400
Received: (qmail 8121 invoked by uid 1000); 1 Jul 2009 07:26:33 -0000
Content-Disposition: inline
In-Reply-To: <20090701070252.GA7987@sigio.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122568>

When using "git log -z" with --pretty=format's "separator"
semantics, we correctly insert a NUL between each record.
However, with "--pretty=tformat", we output no NULs at all,
whereas we should output one after each commit.

We can't just put a conditional in the code for the
"separator" case; that code is triggered at a completely
different time: when _starting_ a new commit, and we are not
the first commit to be shown. As opposed to termination
semantics, which means we must print the terminator at the
end of each commit.

Adding to the trickiness is that we must handle two cases:
with and without diff output. In fact, there is already a
spot (log-tree.c, ll. 442-445) which adds a hard-coded
newline as a terminator after the commit message. But we
can't just modify that to use the specified line terminator,
because sometimes it is acting as a separator between commit
message and diff, and sometimes it is acting as the
terminator of the whole record.

Simply adding another terminator after each commit has been
shown will end up with doubled newlines for short user
formats (like '%s'). Instead, we add the record terminator
only if it is not a newline, in which case the output will
actually contain a newline followed by the terminator.

Signed-off-by: Jeff King <peff@peff.net>
---
This one is RFC. It is missing tests, but that is because I am not
completely sure what we want the output to look like. With this change,
you still get a newline at the end of a single-line user-formatted
string, like:

  $ git log -z --format:%s
  three
  ^@two
  ^@one
  ^@

As explained above, it is not correct to simply turn that putchar('\n')
into putchar(opt->diffopt.line_termination), since it may be followed by
the diff, in which case we _want_ the newline. But maybe it makes sense
to suppress it if we have an alternate line terminator and we are not
showing the diff.

The case with a diff looks much better:

  $ git log -z -p --format:%s
  three

  diff ...
  ...
  ^@two

  diff ...
  ...
  ^@one

  diff ...
  ...
  ^@

So I'm not sure if it is OK as-is, or if we should add that newline
suppression tweak.  People aren't going to be looking at "-z" output as
a whole, so it is really about whether somebody saying:

  git log -z --pretty=tformat:"XXX %s YYY" | perl -0ne ...

would be surprised to find a newline after "YYY" in each record.

 log-tree.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/log-tree.c b/log-tree.c
index 6f73c17..36930ff 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -557,6 +557,14 @@ int log_tree_commit(struct rev_info *opt, struct commit *commit)
 		show_log(opt);
 		shown = 1;
 	}
+	/*
+	 * If we have a terminator, we want to print it here. Unless
+	 * it is a newline, in which case we will already have just
+	 * printed one at the end of the commit message or at the end
+	 * of the diff, and we will end up doubling it.
+	 */
+	if (opt->use_terminator && opt->diffopt.line_termination != '\n')
+		putchar(opt->diffopt.line_termination);
 	opt->loginfo = NULL;
 	maybe_flush_or_die(stdout, "stdout");
 	return shown;
-- 
1.6.3.3.485.g0f5d4.dirty
