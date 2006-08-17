From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 6/7] gitweb: Sort query string parameters in href() function
Date: Thu, 17 Aug 2006 11:21:27 +0200
Message-ID: <1155806489764-git-send-email-jnareb@gmail.com>
References: <11558064883957-git-send-email-jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 17 11:22:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GDe4h-0002Cb-1I
	for gcvg-git@gmane.org; Thu, 17 Aug 2006 11:22:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932459AbWHQJVr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 Aug 2006 05:21:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932461AbWHQJVr
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Aug 2006 05:21:47 -0400
Received: from mail.fuw.edu.pl ([193.0.80.14]:21128 "EHLO mail.fuw.edu.pl")
	by vger.kernel.org with ESMTP id S932464AbWHQJVm (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Aug 2006 05:21:42 -0400
Received: from front.fuw.edu.pl (front.fuw.edu.pl [193.0.83.59])
	by mail.fuw.edu.pl (8.13.6/8.13.6) with ESMTP id k7H9KQ8f023256
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 17 Aug 2006 11:20:27 +0200
Received: from front.fuw.edu.pl (IDENT:10582@localhost [127.0.0.1])
	by front.fuw.edu.pl (8.13.3/8.12.4) with ESMTP id k7H9LTg3003719;
	Thu, 17 Aug 2006 11:21:30 +0200
Received: (from jnareb@localhost)
	by front.fuw.edu.pl (8.13.3/8.12.4/Submit) id k7H9LTjv003718;
	Thu, 17 Aug 2006 11:21:29 +0200
To: git@vger.kernel.org
X-Mailer: git-send-email 1.3.0
In-Reply-To: <11558064883957-git-send-email-jnareb@gmail.com>
X-Scanned-By: MIMEDefang 2.56 on 193.0.80.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25566>

Introduction of a href() function to generate an URL for the CGI,
while making it easier to change the encoding of actions into URLs,
changed also the ordering of parameters in query string, and in URL.

This patch tries to bring back old ordering of query string
parameters. Probably it is not worth the cost; this is an RFC.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.perl |   23 ++++++++++++++++++++++-
 1 files changed, 22 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index b3f38bf..d132aab 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -197,8 +197,29 @@ sub href(%) {
 		hash_base => "hb",
 		page => "pg",
 		searchtext => "s",
+		order => "o",
 	);
 
+	my %ordering = (
+		project => 0,
+		action => 1,
+		order => 2,
+		hash => 10,
+		hash_parent => 11,
+		hash_base => 12,
+		page => 20,
+		file_name => 21,
+		searchtext => 22,
+	);
+
+	sub byordering ($$) {
+		if (exists $ordering{$_[0]} && exists $ordering{$_[1]}) {
+			return $ordering{$_[0]} <=> $ordering{$_[1]};
+		} else {
+			return $_[0] cmp $_[1];
+		}
+	}
+
 	my %params = @_;
 	$params{"project"} ||= $project;
 
@@ -210,7 +231,7 @@ sub href(%) {
 			} else {
 				"$_=$params{$_}";
 			}
-		} keys %params ) );
+		} sort byordering keys %params ) );
 
 	return $href;
 }
-- 
1.4.1.1
