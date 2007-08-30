From: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
Subject: [PATCH] simplify history by default
Date: Thu, 30 Aug 2007 09:25:12 +0300
Message-ID: <20070830062512.GB16312@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git discussion list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 30 08:34:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQdc2-0004g6-HV
	for gcvg-git@gmane.org; Thu, 30 Aug 2007 08:34:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753708AbXH3Gej (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Aug 2007 02:34:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753673AbXH3Gej
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Aug 2007 02:34:39 -0400
Received: from p02c11o145.mxlogic.net ([208.65.144.78]:41624 "EHLO
	p02c11o145.mxlogic.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753565AbXH3Gei (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Aug 2007 02:34:38 -0400
X-Greylist: delayed 559 seconds by postgrey-1.27 at vger.kernel.org; Thu, 30 Aug 2007 02:34:38 EDT
Received: from unknown [194.90.237.34] (EHLO p02c11o145.mxlogic.net)
	by p02c11o145.mxlogic.net (mxl_mta-5.1.0-1)
	with ESMTP id ef466d64.2085649328.144759.00-542.p02c11o145.mxlogic.net (envelope-from <mst@dev.mellanox.co.il>);
	Thu, 30 Aug 2007 00:34:38 -0600 (MDT)
Received: from unknown [194.90.237.34] (EHLO mtlexch01.mtl.com)
	by p02c11o145.mxlogic.net (mxl_mta-5.1.0-1)
	with ESMTP id 0d266d64.2683571120.142671.00-003.p02c11o145.mxlogic.net (envelope-from <mst@dev.mellanox.co.il>);
	Thu, 30 Aug 2007 00:25:20 -0600 (MDT)
Received: from mellanox.co.il ([10.4.4.50]) by mtlexch01.mtl.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 30 Aug 2007 09:28:04 +0300
Received: by mellanox.co.il (sSMTP sendmail emulation); Thu, 30 Aug 2007 09:24:28 +0300
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-OriginalArrivalTime: 30 Aug 2007 06:28:04.0861 (UTC) FILETIME=[EC1992D0:01C7EACE]
X-Spam: [F=0.5300163998; S=0.530(2007082901); SS=0.500]
X-MAIL-FROM: <mst@dev.mellanox.co.il>
X-SOURCE-IP: [194.90.237.34]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57003>

Simplify history if --no-merges is set, even if no pathspec
is given.

Signed-off-by: Michael S. Tsirkin <mst@dev.mellanox.co.il>

---

Hi!
If I merge in a branch with -s ours, plain git log will still
show commits from this branch:

$git checkout b
$git merge -s ours a
$ git log --pretty=oneline
185166cad796945c52769033f16a4c1c9cd02f08 Merge branch 'a' into b
4ee339d9c905dcc39e208fd476a5ca1163d2f8b3 commit for branch b
a2c872723eb585665c5e092059cc97115e63e80f commit for branch a
0b4a099bd90c2ffcd21273afd59a0ee7d182a084 initial commit

If I limit the log to a path (any path), git log
simplifies the commit history:

$git log --pretty=oneline -- .
4ee339d9c905dcc39e208fd476a5ca1163d2f8b3 commit for branch b
0b4a099bd90c2ffcd21273afd59a0ee7d182a084 initial commit

Which is better IMO, because the a branch is actually ignored.
But, is this behaviour documented? I actually discovered
this trick looking at the source:
	setup_revisions does
		/* First, search for "--" */
		seen_dashdash = 0;
		for (i = 1; i < argc; i++) {
			const char *arg = argv[i];
			if (strcmp(arg, "--"))
				continue;
			argv[i] = NULL;
			argc = i;
			revs->prune_data = get_pathspec(revs->prefix, argv + i + 1);
			seen_dashdash = 1;
			break;
		}

	so prune_data seems to be set if there's a path spec; and then

		if (revs->prune_data) {
			diff_tree_setup_paths(revs->prune_data, &revs->pruning);
			/* Can't prune commits with rename following: the paths change.. */
			if (!revs->diffopt.follow_renames)
				revs->prune_fn = try_to_simplify_commit;
			if (!revs->full_diff)
				diff_tree_setup_paths(revs->prune_data, &revs->diffopt);
		}

	so try_to_simplify_commit is only called if there is prune_data,


Further, man git-rev-list says
--full-history::

	Show also parts of history irrelevant to current state of a given path.
		This turns off history simplification, which removed merges
		which didn't change anything at all at some child. It will still
		actually simplify away merges that didn't change anything at all
		into either child.

which makes it seem like the default should be to do history simplification, but
what actually happens is that the default is not to do simplification
unless you give a path, in which case the default is to do simplification,
and --full-history changes this:

$git-rev-list HEAD
185166cad796945c52769033f16a4c1c9cd02f08
4ee339d9c905dcc39e208fd476a5ca1163d2f8b3
a2c872723eb585665c5e092059cc97115e63e80f
0b4a099bd90c2ffcd21273afd59a0ee7d182a084

So it didn't hide branch a.

Wouldn't it make sense to make the simplified form a default, or enable it if
--no-merges is set, or add a flag to enable history simplification, or at
least document this better?

The following patch implements the second option.
Comments?

I would also really like to see, by default:
$ git log --pretty=oneline
185166cad796945c52769033f16a4c1c9cd02f08 Merge branch 'a' into b
4ee339d9c905dcc39e208fd476a5ca1163d2f8b3 commit for branch b
0b4a099bd90c2ffcd21273afd59a0ee7d182a084 initial commit
Opinions?

diff --git a/revision.c b/revision.c
index 51fff0e..746eb9f 100644
--- a/revision.c
+++ b/revision.c
@@ -1262,7 +1262,9 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, const ch
 			revs->prune_fn = try_to_simplify_commit;
 		if (!revs->full_diff)
 			diff_tree_setup_paths(revs->prune_data, &revs->diffopt);
-	}
+	} else if (revs->no_merges) /* Simplification can hide merge commits */
+		revs->prune_fn = try_to_simplify_commit;
+
 	if (revs->combine_merges) {
 		revs->ignore_merges = 0;
 		if (revs->dense_combined_merges && !revs->diffopt.output_format)

-- 
MST
