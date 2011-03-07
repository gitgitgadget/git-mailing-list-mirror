From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 2/3] gitweb: Modularized git_get_project_description to be more generic
Date: Tue,  8 Mar 2011 00:13:34 +0100
Message-ID: <1299539616-19991-3-git-send-email-jnareb@gmail.com>
References: <1299539616-19991-1-git-send-email-jnareb@gmail.com>
Cc: Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Petr Baudis <pasky@suse.cz>, "J.H." <warthog9@kernel.org>,
	Sebastien Cevey <seb@cine7.net>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 08 00:14:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pwjcx-0004la-Tl
	for gcvg-git-2@lo.gmane.org; Tue, 08 Mar 2011 00:14:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756668Ab1CGXOH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Mar 2011 18:14:07 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:56633 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756385Ab1CGXOG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Mar 2011 18:14:06 -0500
Received: by mail-bw0-f46.google.com with SMTP id 15so4166784bwz.19
        for <git@vger.kernel.org>; Mon, 07 Mar 2011 15:14:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=nYPSwuAXfJbFBR5NQHO9fUnv4JnwYT4NyUhnZI5IngU=;
        b=IdKkZtW/b8vKIby0feCGFfx+dOe3AENuZlpR5pm3SBukDPhXDteQHTl3X6+ADp0JiK
         rsM+V85PwYCjH6+R4x1b08V6C9K+o3f8aD7bl3tIe6dQqsapWjgGcH4UFjFdVDfJBV7S
         ucpbns7G08uFi6HHhaO4Z8b9pidlJPxU+fSgY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=XrVMdAY6KITMqpG1xM7qVt6oUe090z+lt249swvid8b75say9mRoQ2gxPlGNUQhhxf
         62VUGvuurQCbiO2yKKAEYQrCVxIwSfx9JDmRc31omoLOPpFEULiFqo9HsHNgH6ZvNF/0
         HjTbJrtb53vxy3//ZiUr1OuLEDPFxWCscd26w=
Received: by 10.204.20.136 with SMTP id f8mr3772234bkb.174.1299539645314;
        Mon, 07 Mar 2011 15:14:05 -0800 (PST)
Received: from localhost.localdomain (abvd192.neoplus.adsl.tpnet.pl [83.8.201.192])
        by mx.google.com with ESMTPS id l1sm75621bkl.1.2011.03.07.15.14.03
        (version=SSLv3 cipher=OTHER);
        Mon, 07 Mar 2011 15:14:04 -0800 (PST)
X-Mailer: git-send-email 1.7.3
In-Reply-To: <1299539616-19991-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168615>

From: Sebastien Cevey <seb@cine7.net>

Introduce a git_get_file_or_project_config utility function to
retrieve a repository variable either from a plain text file in the
$GIT_DIR or else from 'gitweb.$variable' in the repository config
(e.g. 'description').

This would be used in next commit to retrieve category for a project,
which is to be stored in the same way as project description.

Signed-off-by: Sebastien Cevey <seb@cine7.net>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.perl |   24 ++++++++++++++++--------
 1 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 0020b13..c032cd4 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2550,18 +2550,26 @@ sub git_get_path_by_hash {
 ## ......................................................................
 ## git utility functions, directly accessing git repository
 
-sub git_get_project_description {
-	my $path = shift;
+# get the value of config variable either from file named as the variable
+# itself in the repository ($GIT_DIR/$name file), or from gitweb.$name
+# configuration variable in the repository config file.
+sub git_get_file_or_project_config {
+	my ($path, $name) = @_;
 
 	$git_dir = "$projectroot/$path";
-	open my $fd, '<', "$git_dir/description"
-		or return git_get_project_config('description');
-	my $descr = <$fd>;
+	open my $fd, '<', "$git_dir/$name"
+		or return git_get_project_config($name);
+	my $conf = <$fd>;
 	close $fd;
-	if (defined $descr) {
-		chomp $descr;
+	if (defined $conf) {
+		chomp $conf;
 	}
-	return $descr;
+	return $conf;
+}
+
+sub git_get_project_description {
+	my $path = shift;
+	return git_get_file_or_project_config($path, 'description');
 }
 
 sub git_get_project_ctags {
-- 
1.7.3
