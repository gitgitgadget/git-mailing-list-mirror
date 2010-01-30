From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 4/8 v6] gitweb: Check that $site_header etc. are defined before using them
Date: Sat, 30 Jan 2010 23:30:41 +0100
Message-ID: <1264890645-28310-5-git-send-email-jnareb@gmail.com>
References: <1264890645-28310-1-git-send-email-jnareb@gmail.com>
Cc: John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	John 'Warthog9' Hawley <warthog9@kernel.org>,
	Petr Baudis <pasky@suse.cz>, Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 30 23:31:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NbLqm-0008Ua-M0
	for gcvg-git-2@lo.gmane.org; Sat, 30 Jan 2010 23:31:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754315Ab0A3WbJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Jan 2010 17:31:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753978Ab0A3WbI
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jan 2010 17:31:08 -0500
Received: from mail-fx0-f220.google.com ([209.85.220.220]:46818 "EHLO
	mail-fx0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753998Ab0A3WbF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jan 2010 17:31:05 -0500
Received: by fxm20 with SMTP id 20so3058038fxm.21
        for <git@vger.kernel.org>; Sat, 30 Jan 2010 14:31:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=cJVVvQ9GhocvsARgynUatPEzP3z+wWcXo+dekG1UgOY=;
        b=vI3rulm7R4s6xgABAtBRclH0xcTqybV3v6UsQvWbSZFZkGpPG23dn53U0NamK/0cgY
         c/Bk/1nTGinA6+ItEcQTpzMz8GqCeeCeIBsS3dxsK7r1kE85KQdRRL7zAK/MBWHYtVvw
         wlR0mZDti0epor0VFcn22s5fnzuTV9sTyAyMg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=HUOCKo4Oo8brUKovsLyyptCP28njkq7mITzCQTs2yqTn8jR0S0ZtCv/nv5S7pLsGqp
         AhlSAOD7lUOVh8Vc9sef2zIzqULzSTA6moXCuCZBsPehXPT/YCRDPCBVWo5at5v21bjk
         wL5NfPL+kKrCMJ1JMcbbsAcPRUU/ExJFwyCUg=
Received: by 10.223.14.140 with SMTP id g12mr2362734faa.50.1264890664112;
        Sat, 30 Jan 2010 14:31:04 -0800 (PST)
Received: from localhost.localdomain (abwu191.neoplus.adsl.tpnet.pl [83.8.244.191])
        by mx.google.com with ESMTPS id 15sm1157284fxm.6.2010.01.30.14.31.02
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 30 Jan 2010 14:31:03 -0800 (PST)
X-Mailer: git-send-email 1.6.6.1
In-Reply-To: <1264890645-28310-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138506>

From: John 'Warthog9' Hawley <warthog9@kernel.org>

If one of $site_header, $site_footer or $home_text is not defined you
get extraneous errors in the web logs, for example (line wrapped for
better readibility):

 [Wed Jan 13 16:55:42 2010] [error] [client ::1] [Wed Jan 13 16:55:42 2010]
 gitweb.cgi: Use of uninitialized value $site_header in -f at
 /var/www/gitweb/gitweb.cgi line 3287., referer: http://git/gitweb.cgi

This ensures that those variables are defined before trying to use it.

Note that such error can happen only because of an error in gitweb
config file; building gitweb.cgi can make mentioned variables holding
empty string (it is even the default), but they not undefined.

Signed-off-by: John 'Warthog9' Hawley <warthog9@kernel.org>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Changes from version from 'Gitweb caching v5' and
  git://git.kernel.org/pub/scm/git/warthog9/gitweb.git gitweb-ml-v5

* Check explicitly that $site_header is defined, and not only that it
  is false-ish
* Check also for $site_footer and $home_text being defined
* Slightly more detailed commit message


I have decided not to protect against undefined $projects_list, as
such check would have to be more complicated and quite different from
checks for $site_header, $site_footer and $home_text.

Note that it is purely defensive programming, as this should not
happen unless there are very strange errors in gitweb config file.

 gitweb/gitweb.perl |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index e2522cc..a4148d3 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3254,7 +3254,7 @@ EOF
 	print "</head>\n" .
 	      "<body>\n";
 
-	if (-f $site_header) {
+	if (defined $site_header && -f $site_header) {
 		insert_file($site_header);
 	}
 
@@ -3355,7 +3355,7 @@ sub git_footer_html {
 		print "</div>\n"; # class="page_footer"
 	}
 
-	if (-f $site_footer) {
+	if (defined $site_footer && -f $site_footer) {
 		insert_file($site_footer);
 	}
 
@@ -4781,7 +4781,7 @@ sub git_project_list {
 	}
 
 	git_header_html();
-	if (-f $home_text) {
+	if (defined $home_text && -f $home_text) {
 		print "<div class=\"index_include\">\n";
 		insert_file($home_text);
 		print "</div>\n";
-- 
1.6.6.1
