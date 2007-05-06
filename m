From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 5/6] gitweb: Show combined diff for merge commits in 'commitdiff' view
Date: Mon,  7 May 2007 01:10:07 +0200
Message-ID: <11784930131751-git-send-email-jnareb@gmail.com>
References: <11784930091585-git-send-email-jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 07 01:06:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hkpnx-00085v-Vy
	for gcvg-git@gmane.org; Mon, 07 May 2007 01:06:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751975AbXEFXFz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 May 2007 19:05:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751998AbXEFXFz
	(ORCPT <rfc822;git-outgoing>); Sun, 6 May 2007 19:05:55 -0400
Received: from qb-out-0506.google.com ([72.14.204.227]:26571 "EHLO
	qb-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751975AbXEFXFx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 May 2007 19:05:53 -0400
Received: by qb-out-0506.google.com with SMTP id a16so3059604qbd
        for <git@vger.kernel.org>; Sun, 06 May 2007 16:05:53 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=f2WfMrkfouvRkmxYLLK66rv8rN8cCKh3PgNMCKML4GJN0Oy9y0UNYtQM0//52D5lp8InQBPfbQm1lPB03gSFWe8Rpr1YnvYNcVPmc47nKkWiZa9UpexUwCvA5u/5YE4Q4nwEJe8/D2owCRw+JzwLm06vigilBhrWGv5s1EmC9pg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=pyQcq2l+Al/qsLs2vu6zgRlWNTo9BTuwXoISZgU6utBd6+pJLU8eevj+GrgoNcmQJi9fvqvm+qra74m/m4EZTIQHAZ/dhtL4aAe9KRABeeCouBOqMy9i8M1xhrebDlvvCp+spEHKxMcVpPo8M79H8HPUAKTOF4N73TUj0a+TjX0=
Received: by 10.64.148.8 with SMTP id v8mr8878321qbd.1178492752801;
        Sun, 06 May 2007 16:05:52 -0700 (PDT)
Received: from roke.D-201 ( [89.229.25.173])
        by mx.google.com with ESMTP id e10sm4759300qbe.2007.05.06.16.05.45;
        Sun, 06 May 2007 16:05:47 -0700 (PDT)
Received: from roke.D-201 (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id l46NADqP015924;
	Mon, 7 May 2007 01:10:13 +0200
Received: (from jnareb@localhost)
	by roke.D-201 (8.13.4/8.13.4/Submit) id l46NADGu015923;
	Mon, 7 May 2007 01:10:13 +0200
X-Mailer: git-send-email 1.5.1.3
In-Reply-To: <11784930091585-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46389>

When 'commitdiff' action is requested without 'hp' (hash parent)
parameter, and commit given by 'h' (hash) parameter is merge commit,
show merge as combined diff.

Earlier for merge commits without 'hp' parameter diff to first parent
was shown.

Note that in compact combined (--cc) format 'uninteresting' hunks
omission mechanism can make that there is no patch corresponding to
line in raw format (difftree) output. That is why (at least for now)
we use --combined and not --cc format for showing commitdiff for merge
commits.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Note the following fragment of combined diff format description from
git-diff-tree(1) man page; note the final sentence

-c::
        This flag changes the way a merge commit is displayed
        (which means it is useful only when the command is given
        one <tree-ish>, or '--stdin').  It shows the differences
        from each of the parents to the merge result simultaneously
        instead of showing pairwise diff between a parent and the
        result one at a time (which is what the '-m' option does).
        Furthermore, _it lists only files which were modified
        from all parents_.

This means that now 'commitdiff' would show empty diff for all trival
(tree-level) merges, which I think is a majority of merges. Is showing
empty diff better than diff to first parent for merges, then? Or do we
need some way to show from which parent was final version of a file
taken?

Currently there is no way to generate 'commitdiff' view to one of the
parents by clicking some link directly from 'commitdiff' view: you
have to go via 'commit' view (click on commit subject, which functions
as switch between 'commitdiff' and 'commit' views, then on "diff" link
next to one of the parents in commit header). Perhaps this can be
improved with improving difftree/whatchanged output for combined
diff.

 gitweb/gitweb.perl |   12 +++++++-----
 1 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index b3e2e07..c0e2473 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -4391,8 +4391,10 @@ sub git_commitdiff {
 		}
 	}
 
+	my $hash_parent_param = $hash_parent;
 	if (!defined $hash_parent) {
-		$hash_parent = $co{'parent'} || '--root';
+		$hash_parent_param =
+			@{$co{'parents'}} > 1 ? '-c' : $co{'parent'} || '--root';
 	}
 
 	# read commitdiff
@@ -4401,7 +4403,7 @@ sub git_commitdiff {
 	if ($format eq 'html') {
 		open $fd, "-|", git_cmd(), "diff-tree", '-r', @diff_opts,
 			"--no-commit-id", "--patch-with-raw", "--full-index",
-			$hash_parent, $hash, "--"
+			$hash_parent_param, $hash, "--"
 			or die_error(undef, "Open git-diff-tree failed");
 
 		while (my $line = <$fd>) {
@@ -4413,7 +4415,7 @@ sub git_commitdiff {
 
 	} elsif ($format eq 'plain') {
 		open $fd, "-|", git_cmd(), "diff-tree", '-r', @diff_opts,
-			'-p', $hash_parent, $hash, "--"
+			'-p', $hash_parent_param, $hash, "--"
 			or die_error(undef, "Open git-diff-tree failed");
 
 	} else {
@@ -4469,10 +4471,10 @@ TEXT
 
 	# write patch
 	if ($format eq 'html') {
-		git_difftree_body(\@difftree, $hash, $hash_parent);
+		git_difftree_body(\@difftree, $hash, $hash_parent || @{$co{'parents'}});
 		print "<br/>\n";
 
-		git_patchset_body($fd, \@difftree, $hash, $hash_parent);
+		git_patchset_body($fd, \@difftree, $hash, $hash_parent || @{$co{'parents'}});
 		close $fd;
 		print "</div>\n"; # class="page_body"
 		git_footer_html();
-- 
1.5.1.3
