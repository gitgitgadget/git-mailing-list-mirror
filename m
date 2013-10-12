From: arnaud.brejeon@gmail.com
Subject: [PATCH 2/2] Add SVN trust-server-cert parameter to git svn to accept SSL server certificates from unknwon authorities without prompting
Date: Sat, 12 Oct 2013 11:23:30 +0200
Message-ID: <1381569810-2167-2-git-send-email-arnaud.brejeon@gmail.com>
References: <1381569810-2167-1-git-send-email-arnaud.brejeon@gmail.com>
Cc: arnaudbrejeon <arnaud.brejeon@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 12 11:23:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUvQJ-0006oO-Kn
	for gcvg-git-2@plane.gmane.org; Sat, 12 Oct 2013 11:23:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753506Ab3JLJXn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Oct 2013 05:23:43 -0400
Received: from mail-we0-f175.google.com ([74.125.82.175]:43564 "EHLO
	mail-we0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753372Ab3JLJXm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Oct 2013 05:23:42 -0400
Received: by mail-we0-f175.google.com with SMTP id t61so5269771wes.34
        for <git@vger.kernel.org>; Sat, 12 Oct 2013 02:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VUxEq0nFIyZ6Ie06Ft/z3iMNzK0U0d08UbcJpa4Z/tY=;
        b=yIJS0Fet2nM/Fs4F/8ug+DJ26IdXD2RvOeNzpyaschjmjMQ92TAzSiVGNECv6ivu7a
         BHdBIa3JQK9WMO/ABSpKEbJRXLrlHMNTDaW4bJ7T8WUEURcFFfqGhQ5VCQD/LKpENg7S
         2yNkFuip6MlWppUskO7wKLfCTpseKQrKl0EXbPB7Wbfk0ZQZ7N/OUz3aMkp9JGq7G5cZ
         P7dMImra2bmkUvsWQKESkW2EFimTUv1ZpDBNkkx4OpmBz4lllXDeKlHDTpevI0u50hU4
         y+RwaRt4MUJf6HpW66RGdqenEAHvOBrTf/NJIBj0M/exu9aRL+79O3jjzLat8H5NjVhR
         N1ZA==
X-Received: by 10.180.89.206 with SMTP id bq14mr6714475wib.56.1381569821540;
        Sat, 12 Oct 2013 02:23:41 -0700 (PDT)
Received: from localhost.localdomain (APuteaux-552-1-53-143.w90-35.abo.wanadoo.fr. [90.35.84.143])
        by mx.google.com with ESMTPSA id ma3sm13466473wic.1.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 12 Oct 2013 02:23:41 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.2 (Apple Git-33)
In-Reply-To: <1381569810-2167-1-git-send-email-arnaud.brejeon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236045>

From: arnaudbrejeon <arnaud.brejeon@gmail.com>

Signed-off-by: Arnaud Brejeon <arnaud.brejeon <at> gmail.com>
---
 git-svn.perl           |    1 +
 perl/Git/SVN/Prompt.pm |    9 ++++++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/git-svn.perl b/git-svn.perl
index 07f0a6c..3dfd4d3 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -124,6 +124,7 @@ $Git::SVN::Fetcher::_placeholder_filename = ".gitignore";
 $_q ||= 0;
 my %remote_opts = ( 'username=s' => \$Git::SVN::Prompt::_username,
                     'password=s' => \$Git::SVN::Prompt::_password,
+                    'trust-server-cert' => \$Git::SVN::Prompt::_trust_server_cert,
                     'config-dir=s' => \$Git::SVN::Ra::config_dir,
                     'no-auth-cache' => \$Git::SVN::Prompt::_no_auth_cache,
                     'ignore-paths=s' => \$Git::SVN::Fetcher::_ignore_regex,
diff --git a/perl/Git/SVN/Prompt.pm b/perl/Git/SVN/Prompt.pm
index a94a847..71459ad 100644
--- a/perl/Git/SVN/Prompt.pm
+++ b/perl/Git/SVN/Prompt.pm
@@ -2,7 +2,7 @@ package Git::SVN::Prompt;
 use strict;
 use warnings;
 require SVN::Core;
-use vars qw/$_no_auth_cache $_username $_password/;
+use vars qw/$_no_auth_cache $_username $_password $_trust_server_cert/;
 
 sub simple {
 	my ($cred, $realm, $default_username, $may_save, $pool) = @_;
@@ -32,6 +32,13 @@ sub simple {
 sub ssl_server_trust {
 	my ($cred, $realm, $failures, $cert_info, $may_save, $pool) = @_;
 	$may_save = undef if $_no_auth_cache;
+
+	if ( defined $_trust_server_cert)
+	{
+		$cred->may_save($may_save);	
+		return $SVN::_Core::SVN_NO_ERROR;
+	}
+	
 	print STDERR "Error validating server certificate for '$realm':\n";
 	{
 		no warnings 'once';
-- 
1.7.10.2 (Apple Git-33)
