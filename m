From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 6/6] gitweb: Show combined diff for merge commits in 'commit' view
Date: Mon,  7 May 2007 01:10:08 +0200
Message-ID: <11784930133424-git-send-email-jnareb@gmail.com>
References: <11784930091585-git-send-email-jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 07 01:06:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hkpny-00085v-G8
	for gcvg-git@gmane.org; Mon, 07 May 2007 01:06:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751998AbXEFXF5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 May 2007 19:05:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752024AbXEFXF5
	(ORCPT <rfc822;git-outgoing>); Sun, 6 May 2007 19:05:57 -0400
Received: from nz-out-0506.google.com ([64.233.162.235]:18946 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751980AbXEFXFx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 May 2007 19:05:53 -0400
Received: by nz-out-0506.google.com with SMTP id o1so1374488nzf
        for <git@vger.kernel.org>; Sun, 06 May 2007 16:05:53 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=n+/MlX2YMLaFRhu6vQUTEwLzsPw4RolfJPC23DJV5820agtwe4UuSOSx1mY4p398Uav4uQ/CdHZfCE3AZdyYf3aigSWeMfpGQXKSCFzU1W0m8LRPfNUq2vmw2yzgvqM6MuV+1spNWi9Ytky0R1IBlNUgedoHOxnPg0wWU48e6hk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=T8Nap0be85yfsnnlN94SzlEc/3YcOAw6oBAy+WpRkpcDoRGceF4ZS8tIkLU4xwXDlWEQPaJf60K6c9ONRK6IRVcLnzBx6HHM7AY9WP4fYuPz92dHJ4Ey8Y2DI8yVwUNQGQG40Cve+5O7hRtkbpZYCZgZYRGOzDbXeOyOLi37n44=
Received: by 10.65.159.2 with SMTP id l2mr8921160qbo.1178492753281;
        Sun, 06 May 2007 16:05:53 -0700 (PDT)
Received: from roke.D-201 ( [89.229.25.173])
        by mx.google.com with ESMTP id e16sm4755794qbe.2007.05.06.16.05.46;
        Sun, 06 May 2007 16:05:48 -0700 (PDT)
Received: from roke.D-201 (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id l46NADPk015928;
	Mon, 7 May 2007 01:10:13 +0200
Received: (from jnareb@localhost)
	by roke.D-201 (8.13.4/8.13.4/Submit) id l46NADap015927;
	Mon, 7 May 2007 01:10:13 +0200
X-Mailer: git-send-email 1.5.1.3
In-Reply-To: <11784930091585-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46390>

When commit shown is a merge commit (has more than one parent),
display combined difftree output (result of git-diff-tree -c).
Earlier (since commit 549ab4a30703012ff3a12b5455d319216805a8db)
difftree output (against first parent) was not printed for merges.

Examples of non-trivial merges:
  5bac4a671907604b5fb4e24ff682d5b0e8431931 (includes rename)
  addafaf92eeb86033da91323d0d3ad7a496dae83 (five parents)
  95f97567c1887d77f3a46b42d8622c76414d964d (evil merge)

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
The same note as for the patch before apply: for trivial merges there
is no difftree output. But for 'commit' view it doesn't matter much
because there was no difftree output at all for merges.

I plan to add HTML diffstat (using divs with set background color and
set width for bar graph for diff stats) for merges for 'commit' view
(diffstat to first parent, aka. "damages"), and text diffstat for
'commitdiff_plain' view. It would be controlled by new %feature.
But if somebody else want to implement this, feel free.


Examples are included to make it possible to check combined diff
output in gitweb: the sha1 of commits should be turned into
hyperlinks (committags support), and you can click on them to go to
'commit' view.

 gitweb/gitweb.perl |   20 ++++++++------------
 1 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index c0e2473..53e6dce 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -4026,14 +4026,13 @@ sub git_commit {
 		$parent = "--root";
 	}
 	my @difftree;
-	if (@$parents <= 1) {
-		# difftree output is not printed for merges
-		open my $fd, "-|", git_cmd(), "diff-tree", '-r', "--no-commit-id",
-			@diff_opts, $parent, $hash, "--"
-			or die_error(undef, "Open git-diff-tree failed");
-		@difftree = map { chomp; $_ } <$fd>;
-		close $fd or die_error(undef, "Reading git-diff-tree failed");
-	}
+	open my $fd, "-|", git_cmd(), "diff-tree", '-r', "--no-commit-id",
+		@diff_opts, 
+		(@$parents <= 1 ? $parent : '-c'),
+		$hash, "--"
+		or die_error(undef, "Open git-diff-tree failed");
+	@difftree = map { chomp; $_ } <$fd>;
+	close $fd or die_error(undef, "Reading git-diff-tree failed");
 
 	# non-textual hash id's can be cached
 	my $expires;
@@ -4111,10 +4110,7 @@ sub git_commit {
 	git_print_log($co{'comment'});
 	print "</div>\n";
 
-	if (@$parents <= 1) {
-		# do not output difftree/whatchanged for merges
-		git_difftree_body(\@difftree, $hash, $parent);
-	}
+	git_difftree_body(\@difftree, $hash, @$parents);
 
 	git_footer_html();
 }
-- 
1.5.1.3
