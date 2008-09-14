From: Alec Berryman <alec@thened.net>
Subject: [PATCH] git-svn: Always create a new RA when calling do_switch for svn://
Date: Sun, 14 Sep 2008 17:14:16 -0400
Message-ID: <1221426856-2652-3-git-send-email-alec@thened.net>
References: <1221426856-2652-1-git-send-email-alec@thened.net>
 <1221426856-2652-2-git-send-email-alec@thened.net>
Cc: Alec Berryman <alec@thened.net>
To: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sun Sep 14 23:26:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kez78-0008WG-0B
	for gcvg-git-2@gmane.org; Sun, 14 Sep 2008 23:26:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754357AbYINVZY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Sep 2008 17:25:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754384AbYINVZW
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Sep 2008 17:25:22 -0400
Received: from 129.210.68.208.dnsptr.net ([208.68.210.129]:59869 "EHLO
	ives.vdov.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753698AbYINVZS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Sep 2008 17:25:18 -0400
Received: from localhost (localhost [127.0.0.1])
	by ives.vdov.net (Postfix) with ESMTP id B91E424EEC2;
	Sun, 14 Sep 2008 16:15:06 -0500 (CDT)
Received: from ives.vdov.net ([127.0.0.1])
	by localhost (ives.vdov.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id q4qdSNenEP3d; Sun, 14 Sep 2008 16:15:05 -0500 (CDT)
Received: from localhost (pool-96-237-12-178.bstnma.east.verizon.net [96.237.12.178])
	by ives.vdov.net (Postfix) with ESMTPSA id D0BE024EDBD;
	Sun, 14 Sep 2008 16:15:04 -0500 (CDT)
X-Mailer: git-send-email 1.6.0.2.231.gfc858
In-Reply-To: <1221426856-2652-2-git-send-email-alec@thened.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95867>

Not doing so caused the "Malformed network data" error when a directoy
was deleted and replaced with a copy from an older version.

Signed-off-by: Alec Berryman <alec@thened.net>
---
 git-svn.perl                                       |   25 ++--
 ...126-git-svn-follow-deleted-readded-directory.sh |   22 ++
 t/t9126/follow-deleted-readded.dump                |  201 ++++++++++++++++++++
 3 files changed, 235 insertions(+), 13 deletions(-)
 create mode 100755 t/t9126-git-svn-follow-deleted-readded-directory.sh
 create mode 100644 t/t9126/follow-deleted-readded.dump

diff --git a/git-svn.perl b/git-svn.perl
index 88066c9..af8279a 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -4010,20 +4010,19 @@ sub gs_do_switch {
 	my $old_url = $full_url;
 	$full_url .= '/' . escape_uri_only($path) if length $path;
 	my ($ra, $reparented);
-	if ($old_url ne $full_url) {
-		if ($old_url !~ m#^svn(\+ssh)?://#) {
-			SVN::_Ra::svn_ra_reparent($self->{session}, $full_url,
-			                          $pool);
-			$self->{url} = $full_url;
-			$reparented = 1;
-		} else {
-			$_[0] = undef;
-			$self = undef;
-			$RA = undef;
-			$ra = Git::SVN::Ra->new($full_url);
-			$ra_invalid = 1;
-		}
+
+	if ($old_url =~ m#^svn(\+ssh)?://#) {
+		$_[0] = undef;
+		$self = undef;
+		$RA = undef;
+		$ra = Git::SVN::Ra->new($full_url);
+		$ra_invalid = 1;
+	} elsif ($old_url ne $full_url) {
+		SVN::_Ra::svn_ra_reparent($self->{session}, $full_url, $pool);
+		$self->{url} = $full_url;
+		$reparented = 1;
 	}
+
 	$ra ||= $self;
 	$url_b = escape_url($url_b);
 	my $reporter = $ra->do_switch($rev_b, '', 1, $url_b, $editor, $pool);
diff --git a/t/t9126-git-svn-follow-deleted-readded-directory.sh b/t/t9126-git-svn-follow-deleted-readded-directory.sh
new file mode 100755
index 0000000..edec640
--- /dev/null
+++ b/t/t9126-git-svn-follow-deleted-readded-directory.sh
@@ -0,0 +1,22 @@
+#!/bin/sh
+#
+# Copyright (c) 2008 Alec Berryman
+
+test_description='git svn fetch repository with deleted and readded directory'
+
+. ./lib-git-svn.sh
+
+# Don't run this by default; it opens up a port.
+require_svnserve
+
+test_expect_success 'load repository' '
+    svnadmin load -q "$rawsvnrepo" < "$TEST_DIRECTORY"/t9126/follow-deleted-readded.dump
+    '
+
+test_expect_success 'fetch repository' '
+    start_svnserve &&
+    git svn init svn://127.0.0.1:$SVNSERVE_PORT &&
+    git svn fetch
+    '
+
+test_done
diff --git a/t/t9126/follow-deleted-readded.dump b/t/t9126/follow-deleted-readded.dump
new file mode 100644
index 0000000..19da5d1
--- /dev/null
+++ b/t/t9126/follow-deleted-readded.dump
@@ -0,0 +1,201 @@
+SVN-fs-dump-format-version: 2
+
+UUID: 1807dc6f-c693-4cda-9710-00e1be8c1f21
+
+Revision-number: 0
+Prop-content-length: 56
+Content-length: 56
+
+K 8
+svn:date
+V 27
+2008-09-14T19:53:13.006748Z
+PROPS-END
+
+Revision-number: 1
+Prop-content-length: 111
+Content-length: 111
+
+K 7
+svn:log
+V 12
+Create trunk
+K 10
+svn:author
+V 4
+alec
+K 8
+svn:date
+V 27
+2008-09-14T19:53:13.239689Z
+PROPS-END
+
+Node-path: trunk
+Node-kind: dir
+Node-action: add
+Prop-content-length: 10
+Content-length: 10
+
+PROPS-END
+
+
+Revision-number: 2
+Prop-content-length: 119
+Content-length: 119
+
+K 7
+svn:log
+V 20
+Create trunk/project
+K 10
+svn:author
+V 4
+alec
+K 8
+svn:date
+V 27
+2008-09-14T19:53:13.548860Z
+PROPS-END
+
+Node-path: trunk/project
+Node-kind: dir
+Node-action: add
+Prop-content-length: 10
+Content-length: 10
+
+PROPS-END
+
+
+Revision-number: 3
+Prop-content-length: 111
+Content-length: 111
+
+K 7
+svn:log
+V 12
+add new file
+K 10
+svn:author
+V 4
+alec
+K 8
+svn:date
+V 27
+2008-09-14T19:53:15.433630Z
+PROPS-END
+
+Node-path: trunk/project/foo
+Node-kind: file
+Node-action: add
+Prop-content-length: 10
+Text-content-length: 4
+Text-content-md5: d3b07384d113edec49eaa6238ad5ff00
+Content-length: 14
+
+PROPS-END
+foo
+
+
+Revision-number: 4
+Prop-content-length: 116
+Content-length: 116
+
+K 7
+svn:log
+V 17
+change foo to bar
+K 10
+svn:author
+V 4
+alec
+K 8
+svn:date
+V 27
+2008-09-14T19:53:17.339884Z
+PROPS-END
+
+Node-path: trunk/project/foo
+Node-kind: file
+Node-action: change
+Text-content-length: 4
+Text-content-md5: c157a79031e1c40f85931829bc5fc552
+Content-length: 4
+
+bar
+
+
+Revision-number: 5
+Prop-content-length: 114
+Content-length: 114
+
+K 7
+svn:log
+V 15
+don't like that
+K 10
+svn:author
+V 4
+alec
+K 8
+svn:date
+V 27
+2008-09-14T19:53:19.335001Z
+PROPS-END
+
+Node-path: trunk/project
+Node-action: delete
+
+
+Revision-number: 6
+Prop-content-length: 110
+Content-length: 110
+
+K 7
+svn:log
+V 11
+reset trunk
+K 10
+svn:author
+V 4
+alec
+K 8
+svn:date
+V 27
+2008-09-14T19:53:19.845897Z
+PROPS-END
+
+Node-path: trunk/project
+Node-kind: dir
+Node-action: add
+Node-copyfrom-rev: 4
+Node-copyfrom-path: trunk/project
+
+
+Revision-number: 7
+Prop-content-length: 113
+Content-length: 113
+
+K 7
+svn:log
+V 14
+change to quux
+K 10
+svn:author
+V 4
+alec
+K 8
+svn:date
+V 27
+2008-09-14T19:53:21.367947Z
+PROPS-END
+
+Node-path: trunk/project/foo
+Node-kind: file
+Node-action: change
+Text-content-length: 5
+Text-content-md5: d3b07a382ec010c01889250fce66fb13
+Content-length: 5
+
+quux
+
+
-- 
1.6.0.2.231.gfc858
