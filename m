From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 5/6] gitweb: Modularized git_get_project_description to be more generic
Date: Fri, 29 Apr 2011 19:52:00 +0200
Message-ID: <1304099521-27617-6-git-send-email-jnareb@gmail.com>
References: <1304099521-27617-1-git-send-email-jnareb@gmail.com>
Cc: John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	John 'Warthog9' Hawley <warthog9@kernel.org>,
	Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Petr Baudis <pasky@suse.cz>, Sebastien Cevey <seb@cine7.net>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 29 19:52:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFrs4-0001Q3-Ua
	for gcvg-git-2@lo.gmane.org; Fri, 29 Apr 2011 19:52:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760769Ab1D2Rwh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2011 13:52:37 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:35897 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760761Ab1D2Rwc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2011 13:52:32 -0400
Received: by mail-fx0-f46.google.com with SMTP id 17so2635553fxm.19
        for <git@vger.kernel.org>; Fri, 29 Apr 2011 10:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=QBp/dbjmCQi7M+UibVCGDmRN98oJbVlc9iEB0dFrhUw=;
        b=KQurcRAxUaOa8fe1Kgi/yxJnyJ+20mso9cV6pesGGhnG2VgVAKAwHr4pY7rGPtQGKS
         9l/vPZiusuNDAA1XlpdzUvRSoi/dCD7d/rOEEju5ZNCkKJ3LUNTHcedXME1ZFipSUult
         rGbCnnMM9OihSwmINw6SahB+uAzH3zzuxnwY8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=J1LBmcuOkCsTI1JG0sq+Sl+BOttKqq/kp4d2An8DB1EvC1TtNpqPULY2NR9esY1UJC
         MiIUJfzmaFZOJkjhQHeua2/19iDqrD7imEGxRTB2i8SOuz24NAidfreEgQNs0ElyFX6t
         DcJC1NAYCT+MBtHaLeoTPPuVIo7bJ3joEjqvA=
Received: by 10.223.59.81 with SMTP id k17mr1447875fah.94.1304099552315;
        Fri, 29 Apr 2011 10:52:32 -0700 (PDT)
Received: from localhost.localdomain (abvr62.neoplus.adsl.tpnet.pl [83.8.215.62])
        by mx.google.com with ESMTPS id n26sm962346fam.37.2011.04.29.10.52.30
        (version=SSLv3 cipher=OTHER);
        Fri, 29 Apr 2011 10:52:31 -0700 (PDT)
X-Mailer: git-send-email 1.7.3
In-Reply-To: <1304099521-27617-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172478>

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
index f8d5722..e8685ac 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2562,18 +2562,26 @@ sub git_get_path_by_hash {
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
 
 # supported formats:
-- 
1.7.3
