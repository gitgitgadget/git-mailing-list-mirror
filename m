From: Monard Vong <travelingsoul86@gmail.com>
Subject: [PATCH] git-svn: Avoid systematic prompt for client certificate when using "git svn branch"
Date: Thu, 24 Jul 2014 18:25:59 +0200
Message-ID: <1406219159-4644-1-git-send-email-travelingsoul86@gmail.com>
References: <254135>
Cc: Monard Vong <travelingsoul86@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 24 18:26:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XALqa-0004Hi-UH
	for gcvg-git-2@plane.gmane.org; Thu, 24 Jul 2014 18:26:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759544AbaGXQ0V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2014 12:26:21 -0400
Received: from mail-we0-f177.google.com ([74.125.82.177]:37942 "EHLO
	mail-we0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759438AbaGXQ0U (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2014 12:26:20 -0400
Received: by mail-we0-f177.google.com with SMTP id w62so3046610wes.36
        for <git@vger.kernel.org>; Thu, 24 Jul 2014 09:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=G8fIXVm0VFTnHmfCxPG0zZBw1rWksVSpSYYc02M+GKk=;
        b=UPxVQ+cx+Xe9ALbzjnvStjwAG4oHqwGUF4wYoPLP2yHaFo92HL1RZLJD7ZxjHH/qMF
         MY5J4diUo32aJczEqi4+uEwvGzbyZYEmtmQqabeD6vIANOK4rzuAXeYbTxuoprk/d19T
         qPUV+XGztN7fd2aHsjMYUhSK6rCM9xpX5efPxzdwJCUCOJKEOWGLckn8ltQxw1YLH9tb
         VmVavBOVWGrUcbYNYpn6lKMiBX4ZSX+y+4RI465LgHtbitSubWqE1ooAIRJAqvqAc02v
         Mj2vmdGJ2Lz0rlnYYPgNIfm0H/aWFeW9wEZgM+IF5xCuwS+jlmfnqCSZsPBT3tUflXSZ
         r/ig==
X-Received: by 10.180.75.197 with SMTP id e5mr14644457wiw.76.1406219178869;
        Thu, 24 Jul 2014 09:26:18 -0700 (PDT)
Received: from fedora.localdomain (keyconsulting-31-226.fib.nerim.net. [178.132.31.226])
        by mx.google.com with ESMTPSA id ex4sm24795455wic.2.2014.07.24.09.26.17
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Jul 2014 09:26:17 -0700 (PDT)
X-Mailer: git-send-email 1.9.3
In-Reply-To: <254135>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254166>

When a client certificate is required to connect to a Subversion repository,
the certificate location and password may be stored in Subversion config directory.
Commands like "git svn init/fetch/dcommit" do not prompt for client certificate/password
if the location is set in SVN config file, but "git svn branch" does not use the config
directory, resulting in prompting for certificate location/password all the time.

Build instance of SVN::Client in branch_cmd() with SVN config directory option instead
of authentication baton. SVN::Client then builds its own authentication baton
using information from the config directory.

Signed-off-by: Monard Vong <travelingsoul86@gmail.com>
---
 git-svn.perl | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/git-svn.perl b/git-svn.perl
index 0a32372..1f41ee1 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -1161,7 +1161,9 @@ sub cmd_branch {
 	::_req_svn();
 
 	my $ctx = SVN::Client->new(
-		auth    => Git::SVN::Ra::_auth_providers(),
+		config => SVN::Core::config_get_config(
+			$Git::SVN::Ra::config_dir
+		),
 		log_msg => sub {
 			${ $_[0] } = defined $_message
 				? $_message
-- 
1.9.3
