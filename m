From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] ls-tree: add --full-tree option
Date: Thu, 25 Dec 2008 16:54:23 -0800
Message-ID: <7v63l7rc1s.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Deskin Miller <deskinm@umich.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 26 01:55:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LG0zU-0001HX-8Y
	for gcvg-git-2@gmane.org; Fri, 26 Dec 2008 01:55:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752308AbYLZAy3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Dec 2008 19:54:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752207AbYLZAy3
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Dec 2008 19:54:29 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:45491 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752178AbYLZAy2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Dec 2008 19:54:28 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 31EB18A5E7;
	Thu, 25 Dec 2008 19:54:28 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id C9EAB8A5E4; Thu,
 25 Dec 2008 19:54:24 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: BF6E0BB4-D2E7-11DD-BF7C-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103915>

The established behaviour of "git ls-tree $commit" run from a subdirectory
"sub/dir" in a work tree is to limit the output to the paths in the
subdirectory, and strip off the leading "sub/dir" from the output, since
3c5e846 (ls-tree: major rewrite to do pathspec, 2005-11-26).

This was a "usability" feature made back in the days when the line between
Porcelain and plumbing was blurry, and in retrospect, it probably was
misguided.  The behaviour may be what the end user would expect when the
command is run interactively from a subdirectory, but it also means that a
scripted Porcelain that wants to use the command to list the full contents
of a tree object has to do cd_to_toplevel (and save the output from
"rev-parse --show-prefix" before doing so, so that it can be used as a
pathspec if it wants to limit its operation to the original subdirectory
in other commands).

This new option makes the command operate on the full tree object,
regardless of where in the work tree it is run from.  It also implies the
behaviour that is triggered by the existing --full-name option.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 * There was a discussion on #git between Ilari and deskin this morning;
   hopefully I captured what they wanted correctly.

   I do not care too deeply with this change myself, though...

 builtin-ls-tree.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/builtin-ls-tree.c b/builtin-ls-tree.c
index cb61717..c386aa5 100644
--- a/builtin-ls-tree.c
+++ b/builtin-ls-tree.c
@@ -156,6 +156,11 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
 				chomp_prefix = 0;
 				break;
 			}
+			if (!strcmp(argv[1]+2, "full-tree")) {
+				ls_tree_prefix = prefix = NULL;
+				chomp_prefix = 0;
+				break;
+			}
 			if (!prefixcmp(argv[1]+2, "abbrev=")) {
 				abbrev = strtoul(argv[1]+9, NULL, 10);
 				if (abbrev && abbrev < MINIMUM_ABBREV)
-- 
1.6.1
