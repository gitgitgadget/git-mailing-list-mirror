From: Jeff King <peff@peff.net>
Subject: [PATCH] use custom rename score during --follow
Date: Fri, 16 Dec 2011 06:27:50 -0500
Message-ID: <20111216112749.GA16314@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 16 12:28:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RbVxL-0002Yj-0r
	for gcvg-git-2@lo.gmane.org; Fri, 16 Dec 2011 12:28:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751223Ab1LPL1z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Dec 2011 06:27:55 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:43987
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750755Ab1LPL1y (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Dec 2011 06:27:54 -0500
Received: (qmail 3327 invoked by uid 107); 16 Dec 2011 11:34:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 16 Dec 2011 06:34:34 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 16 Dec 2011 06:27:50 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187270>

If you provide a custom rename score on the command line,
like:

  git log -M50 --follow foo.c

it is completely ignored, and there is no way to --follow
with a looser rename score. Instead, let's use the same
rename score that will be used for generating diffs. This is
convenient, and mirrors what we do with the break-score.

You can see an example of it being useful in git.git:

  $ git log --oneline --summary --follow \
	    Documentation/technical/api-string-list.txt
  86d4b52 string-list: Add API to remove an item from an unsorted list
  1d2f80f string_list: Fix argument order for string_list_append
  e242148 string-list: add unsorted_string_list_lookup()
  0dda1d1 Fix two leftovers from path_list->string_list
  c455c87 Rename path_list to string_list
   create mode 100644 Documentation/technical/api-string-list.txt

  $ git log --oneline --summary -M40 --follow \
	  Documentation/technical/api-string-list.txt
  86d4b52 string-list: Add API to remove an item from an unsorted list
  1d2f80f string_list: Fix argument order for string_list_append
  e242148 string-list: add unsorted_string_list_lookup()
  0dda1d1 Fix two leftovers from path_list->string_list
  c455c87 Rename path_list to string_list
   rename Documentation/technical/{api-path-list.txt => api-string-list.txt} (47%)
  328a475 path-list documentation: document all functions and data structures
  530e741 Start preparing the API documents.
   create mode 100644 Documentation/technical/api-path-list.txt

You could have two separate rename scores, one for following
and one for diff. But almost nobody is going to want that,
and it would just be unnecessarily confusing. Besides which,
we re-use the diff results from try_to_follow_renames for
the actual diff output, which means having them as separate
scores is actively wrong. E.g., with the current code, you
get:

  $ git log --oneline --diff-filter=R --name-status \
            -M90 --follow git.spec.in
  27dedf0 GIT 0.99.9j aka 1.0rc3
  R084    git-core.spec.in        git.spec.in
  f85639c Rename the RPM from "git" to "git-core"
  R098    git.spec.in     git-core.spec.in

The first one should not be considered a rename by the -M
score we gave, but we print it anyway, since we blindly
re-use the diff information from the follow (which uses the
default score). So this could also be considered simply a
bug-fix, as with the current code "-M" is completely ignored
when using "--follow".

Signed-off-by: Jeff King <peff@peff.net>
---
I posted this a long time ago as a "you could do it like this" patch:

  http://thread.gmane.org/gmane.comp.version-control.git/160681

but never actually dug more to make sure it wasn't having any weird
effects on the diff output. As it turns out, I think it is not only not
having a bad effect, but is actively fixing a bug. :)

 tree-diff.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/tree-diff.c b/tree-diff.c
index 7a51d09..28ad6db 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -209,6 +209,7 @@ static void try_to_follow_renames(struct tree_desc *t1, struct tree_desc *t2, co
 	diff_opts.output_format = DIFF_FORMAT_NO_OUTPUT;
 	diff_opts.single_follow = opt->pathspec.raw[0];
 	diff_opts.break_opt = opt->break_opt;
+	diff_opts.rename_score = opt->rename_score;
 	paths[0] = NULL;
 	diff_tree_setup_paths(paths, &diff_opts);
 	if (diff_setup_done(&diff_opts) < 0)
-- 
1.7.7.4.13.g57bf4
