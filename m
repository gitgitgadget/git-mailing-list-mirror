From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] git-svn: fix following renamed paths when tracking a single path
Date: Mon, 7 Apr 2008 00:08:03 -0700
Message-ID: <20080407070803.GA7736@soma>
References: <3bc895b00804030647o652e432cqb5a90eafbac906b2@mail.gmail.com> <3bc895b00804030659p21dcae2av2cad3db41935fa4e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Santhosh <santhoshmani@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 07 09:08:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JilTI-00022E-An
	for gcvg-git-2@gmane.org; Mon, 07 Apr 2008 09:08:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752412AbYDGHIJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Apr 2008 03:08:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752256AbYDGHIH
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Apr 2008 03:08:07 -0400
Received: from hand.yhbt.net ([66.150.188.102]:44574 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752129AbYDGHIG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Apr 2008 03:08:06 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 09C517F41D5;
	Mon,  7 Apr 2008 00:08:04 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <3bc895b00804030659p21dcae2av2cad3db41935fa4e@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78950>

When using git-svn to follow only a single (empty) path per
svn-remote (i.e. not using --stdlayout), following the history
of a renamed path was broken in
c586879cdfa4f8181a14e953a9152a4639eef333.

This reverts the regression for the single (emtpy) path per
svn-remote case.

To avoid breaking the tests in a committed revision, this is an
addendum to a patch originally submitted by

  Santhosh Kumar Mani <santhoshmani@gmail.com>:
  > git-svn: add test for renamed directory fetch
  >
  > This test tries to fetch a directory which had renames in the
  > history from a SVN repository.

  [ew: unneccesary dependency on the starting an HTTP server
   removed from Santhosh's original test.]

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---

 Thanks Santhosh!

 git-svn.perl                         |    5 +-
 t/t9121-git-svn-fetch-renamed-dir.sh |   20 ++++++++
 t/t9121/renamed-dir.dump             |   90 ++++++++++++++++++++++++++++++++++
 3 files changed, 113 insertions(+), 2 deletions(-)
 create mode 100755 t/t9121-git-svn-fetch-renamed-dir.sh
 create mode 100644 t/t9121/renamed-dir.dump

diff --git a/git-svn.perl b/git-svn.perl
index 1b44cbe..81afb5c 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -2239,12 +2239,13 @@ sub find_parent_branch {
 		# just grow a tail if we're not unique enough :x
 		$ref_id .= '-' while find_ref($ref_id);
 		print STDERR "Initializing parent: $ref_id\n";
-		my ($u, $p) = ($new_url, '');
+		my ($u, $p, $repo_id) = ($new_url, '', $ref_id);
 		if ($u =~ s#^\Q$url\E(/|$)##) {
 			$p = $u;
 			$u = $url;
+			$repo_id = $self->{repo_id};
 		}
-		$gs = Git::SVN->init($u, $p, $self->{repo_id}, $ref_id, 1);
+		$gs = Git::SVN->init($u, $p, $repo_id, $ref_id, 1);
 	}
 	my ($r0, $parent) = $gs->find_rev_before($r, 1);
 	if (!defined $r0 || !defined $parent) {
diff --git a/t/t9121-git-svn-fetch-renamed-dir.sh b/t/t9121-git-svn-fetch-renamed-dir.sh
new file mode 100755
index 0000000..5143ed6
--- /dev/null
+++ b/t/t9121-git-svn-fetch-renamed-dir.sh
@@ -0,0 +1,20 @@
+#!/bin/sh
+#
+# Copyright (c) 2008 Santhosh Kumar Mani
+
+
+test_description='git-svn can fetch renamed directories'
+
+. ./lib-git-svn.sh
+
+test_expect_success 'load repository with renamed directory' "
+	svnadmin load -q $rawsvnrepo < ../t9121/renamed-dir.dump
+	"
+
+test_expect_success 'init and fetch repository' "
+	git svn init $svnrepo/newname &&
+	git svn fetch
+	"
+
+test_done
+
diff --git a/t/t9121/renamed-dir.dump b/t/t9121/renamed-dir.dump
new file mode 100644
index 0000000..5f9127b
--- /dev/null
+++ b/t/t9121/renamed-dir.dump
@@ -0,0 +1,90 @@
+SVN-fs-dump-format-version: 2
+
+UUID: 06b9b3ad-f546-4fbe-8328-fcb4e6ef5c3f
+
+Revision-number: 0
+Prop-content-length: 56
+Content-length: 56
+
+K 8
+svn:date
+V 27
+2008-04-02T09:11:59.778557Z
+PROPS-END
+
+Revision-number: 1
+Prop-content-length: 117
+Content-length: 117
+
+K 7
+svn:log
+V 14
+initial import
+K 10
+svn:author
+V 8
+santhosh
+K 8
+svn:date
+V 27
+2008-04-02T09:13:03.170863Z
+PROPS-END
+
+Node-path: name
+Node-kind: dir
+Node-action: add
+Prop-content-length: 10
+Content-length: 10
+
+PROPS-END
+
+
+Node-path: name/a.txt
+Node-kind: file
+Node-action: add
+Prop-content-length: 71
+Text-content-length: 6
+Text-content-md5: b1946ac92492d2347c6235b4d2611184
+Content-length: 77
+
+K 13
+svn:mime-type
+V 10
+text/plain
+K 13
+svn:eol-style
+V 2
+LF
+PROPS-END
+hello
+
+
+Revision-number: 2
+Prop-content-length: 109
+Content-length: 109
+
+K 7
+svn:log
+V 7
+renamed
+K 10
+svn:author
+V 8
+santhosh
+K 8
+svn:date
+V 27
+2008-04-02T09:14:22.952186Z
+PROPS-END
+
+Node-path: newname
+Node-kind: dir
+Node-action: add
+Node-copyfrom-rev: 1
+Node-copyfrom-path: name
+
+
+Node-path: name
+Node-action: delete
+
+
-- 
Eric Wong
