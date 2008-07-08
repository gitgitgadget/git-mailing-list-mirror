From: Junio C Hamano <gitster@pobox.com>
Subject: What should "git branch --merged master" do?
Date: Mon, 07 Jul 2008 23:49:13 -0700
Message-ID: <7v8wwcx446.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pierre Habouzit <madcoder@debian.org>,
	Lars Hjemli <hjemli@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 08 08:50:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KG71t-000405-Lr
	for gcvg-git-2@gmane.org; Tue, 08 Jul 2008 08:50:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755203AbYGHGt1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jul 2008 02:49:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755264AbYGHGt1
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jul 2008 02:49:27 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:43462 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755203AbYGHGtY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jul 2008 02:49:24 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 9537D28FB5;
	Tue,  8 Jul 2008 02:49:21 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 7A74A28FB4; Tue,  8 Jul 2008 02:49:16 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: FEA6BFE2-4CB9-11DD-AC2F-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87723>

e8b404c (git-branch: add support for --merged and --no-merged, 2008-04-17)
introduced "git branch --merged" to show the branches that are contained
within the current HEAD.  I.e. the ones that you can say "git branch -d"
and do not have to say "-D" to delete.

Currently "git branch --merged master" fails with a message:

	fatal: A branch named 'master' already exists.

but --merged and its opposite --no-merged are in spirit very similar to
another option --contains in that it is meant to be used as a way to
influence which branches are _reported_, and not about creating a new
branch.

Perhaps we should change them to default to HEAD (to retain the current
behaviour) but take a commit, and show branches that are merged to the
commit or not yet fully merged to the commit, respectively?

Incidentally, "git branch --with" fails without the mandatory commit
argument, and if we are going to do the above, we probably should default
the argument to HEAD as well.

Here is an attempt to update --with but I am not happy with it.

The patch makes

	$ git branch --contains

work as expected, but breaks

	$ git branch --contains master

You need to spell "git branch --contains=master" instead.  Which means it
is a regression and cannot be applied.  I suspect I am not using
parse_options() in an optimal way, but I did not find a way for my
callback to tell "I consumed the next parameter and it was mine" or "The
next one is not my optional parameter" back to the parse_options(), so
probably parse_options() need to be fixed to update this without
regression, I suspect.

 builtin-branch.c |   12 +++++++-----
 1 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/builtin-branch.c b/builtin-branch.c
index d279702..ee722a2 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -411,7 +411,7 @@ static int opt_parse_with_commit(const struct option *opt, const char *arg, int
 	struct commit *commit;
 
 	if (!arg)
-		return -1;
+		arg = "HEAD";
 	if (get_sha1(arg, sha1))
 		die("malformed object name %s", arg);
 	commit = lookup_commit_reference(sha1);
@@ -438,13 +438,15 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		OPT_BOOLEAN( 0 , "color",  &branch_use_color, "use colored output"),
 		OPT_SET_INT('r', NULL,     &kinds, "act on remote-tracking branches",
 			REF_REMOTE_BRANCH),
-		OPT_CALLBACK(0, "contains", &with_commit, "commit",
-			     "print only branches that contain the commit",
-			     opt_parse_with_commit),
+		{
+			OPTION_CALLBACK, 0, "contains", &with_commit, "commit",
+			"print only branches that contain the commit",
+			PARSE_OPT_OPTARG, opt_parse_with_commit,
+		},
 		{
 			OPTION_CALLBACK, 0, "with", &with_commit, "commit",
 			"print only branches that contain the commit",
-			PARSE_OPT_HIDDEN, opt_parse_with_commit,
+			PARSE_OPT_HIDDEN | PARSE_OPT_OPTARG, opt_parse_with_commit,
 		},
 		OPT__ABBREV(&abbrev),
 
