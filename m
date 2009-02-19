From: Peter Oberndorfer <kumbayo84@arcor.de>
Subject: [PATCH] git-svn: try to read the dcommit url from the config file
Date: Thu, 19 Feb 2009 19:30:10 +0100
Message-ID: <200902191930.10139.kumbayo84@arcor.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 19 19:37:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaDll-0003ZR-Pc
	for gcvg-git-2@gmane.org; Thu, 19 Feb 2009 19:37:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752093AbZBSSfm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2009 13:35:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751725AbZBSSfl
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Feb 2009 13:35:41 -0500
Received: from mail-in-02.arcor-online.net ([151.189.21.42]:54529 "EHLO
	mail-in-02.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751531AbZBSSfk (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Feb 2009 13:35:40 -0500
Received: from mail-in-01-z2.arcor-online.net (mail-in-01-z2.arcor-online.net [151.189.8.13])
	by mx.arcor.de (Postfix) with ESMTP id A60773FE392
	for <git@vger.kernel.org>; Thu, 19 Feb 2009 19:35:38 +0100 (CET)
Received: from mail-in-06.arcor-online.net (mail-in-06.arcor-online.net [151.189.21.46])
	by mail-in-01-z2.arcor-online.net (Postfix) with ESMTP id 738092BF27C
	for <git@vger.kernel.org>; Thu, 19 Feb 2009 19:35:38 +0100 (CET)
Received: from oberndorfer.lan (91-114-188-13.adsl.highway.telekom.at [91.114.188.13])
	(Authenticated sender: kumbayo84@arcor.de)
	by mail-in-06.arcor-online.net (Postfix) with ESMTPSA id EB80A39A66B
	for <git@vger.kernel.org>; Thu, 19 Feb 2009 19:35:37 +0100 (CET)
X-DKIM: Sendmail DKIM Filter v2.6.0 mail-in-06.arcor-online.net EB80A39A66B
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1235068538; bh=awi3xivv1S8Vse/Adrb2DwrZHVOnDxSdgCJyFpIcGWQ=;
	h=From:Date:Subject:To:MIME-Version:Content-Transfer-Encoding:
	 Message-Id; b=ZoP/F3g6zIaSeB9XjuGQoy7aiZwFVdXhi1gS3hBV6HZZvJW/pUis
	Ia6bCwzTIfsJdO05jW+YhL5ymv0hnT7xwdqaYlJpdS5NibkQQdE1FtvNS3uOIyAMjhB
	ecJRZdHBW1CppWebxS9ZAY6+K4/IMT9FK3sZWvSf0XyKpODpX6mI=
X-Mailbox-Line: From 0edfa51119a44068050339a8e6bdbfc75afdaa5f Mon Sep 17 00:00:00 2001
Content-Disposition: inline
X-Virus-Scanned: ClamAV 0.94.2/9013/Thu Feb 19 17:34:10 2009 on mail-in-06.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110728>

The commit url is determined in the following order
--commit-url commandline
svn-remote.<name>.dcommiturl
svn-remote.<name>.url

Signed-off-by: Peter Oberndorfer <kumbayo84@arcor.de>
---

I find it really boring to always specify --commit-url on the git svn dcommit command line.
And it tends to fall out of my bash_history since i do not commit often.
Setting up the commit url 1 time should be enough.

I feel that the config key: part im the documentation should get more exposure or explanation.
Maybe somebody can suggest some wording?

Also the dcommiturl name is still a suggestion

My kdelibs git-svn config file no looks like this:

[svn-remote "svn"]
	url = svn://anonsvn.kde.org/home/kde/trunk/KDE/kdelibs
	fetch = :refs/remotes/git-svn
	dcommiturl = svn+ssh://username@svn.kde.org/home/kde/trunk/KDE/kdelibs


 Documentation/git-svn.txt |    2 ++
 git-svn.perl              |   12 +++++++++++-
 2 files changed, 13 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index 3d45654..0d11428 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -169,6 +169,8 @@ and have no uncommitted changes.
 	reused if a user is later given access to an alternate transport
 	method (e.g. `svn+ssh://` or `https://`) for commit.
 
+config key: svn-remote.<name>.dcommiturl
+
 	Using this option for any other purpose (don't ask)
 	is very strongly discouraged.
 --
diff --git a/git-svn.perl b/git-svn.perl
index 83cb36f..2ad3603 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -438,7 +438,17 @@ sub cmd_dcommit {
 		die "Unable to determine upstream SVN information from ",
 		    "$head history.\nPerhaps the repository is empty.";
 	}
-	$url = defined $_commit_url ? $_commit_url : $gs->full_url;
+
+	if (defined $_commit_url) {
+		$url = $_commit_url;
+	} else {
+		$url = eval { command_oneline('config', '--get',
+			      "svn-remote.$gs->{repo_id}.dcommiturl") };
+		if (!$url) {
+			$url = $gs->full_url
+		}
+	}
+
 	my $last_rev = $_revision if defined $_revision;
 	if ($url) {
 		print "Committing to $url ...\n";
-- 
1.6.1.3
