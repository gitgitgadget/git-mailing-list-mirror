From: Mark A Rada <marada@uwaterloo.ca>
Subject: [PATCH] gitweb: squelch harmless variable scoping errors
Date: Sat, 8 Aug 2009 12:50:35 -0400
Message-ID: <F203660D-5123-475D-8288-F398EA670002@mailservices.uwaterloo.ca>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 08 19:03:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZpJs-0006SN-0a
	for gcvg-git-2@gmane.org; Sat, 08 Aug 2009 19:03:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752498AbZHHRCj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Aug 2009 13:02:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752417AbZHHRCj
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Aug 2009 13:02:39 -0400
Received: from mailservices.uwaterloo.ca ([129.97.128.141]:41824 "EHLO
	psyche.uwaterloo.ca" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752087AbZHHRCj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Aug 2009 13:02:39 -0400
X-Greylist: delayed 712 seconds by postgrey-1.27 at vger.kernel.org; Sat, 08 Aug 2009 13:02:38 EDT
Received: from [192.168.1.102] (CPE0018397ddc22-CM001225dfe86e.cpe.net.cable.rogers.com [174.117.223.147])
	(authenticated bits=0)
	by psyche.uwaterloo.ca (8.13.1/8.13.1) with ESMTP id n78GoZpU030369
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sat, 8 Aug 2009 12:50:40 -0400
X-Mailer: Apple Mail (2.936)
X-UUID: 1fb16d18-3b10-4d36-8b3e-c50916fb03ae
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125289>

I fiddled around a bit and this solution seems to work, but is a bit  
odd, as
the method is declared obsolete in the Perl documentation (v5.8.8).

What do you think?

--
Mark A Rada (ferrous26)
marada@uwaterloo.ca


--->8---
This will use the 'vars' method of declaring global variables instead
of the 'our' method.

Though 'vars' has been obsoleted, it has the advantage of pre-declaring
global symbols; this ensures that those symbols will be available to
routines loaded later, whereas 'our' does not seem to do this.

The result is that when using mod_perl you will no longer get any
warnings printed to your error_log.

Signed-off-by: Mark Rada <marada@uwaterloo.ca>
---
gitweb/gitweb.perl |    8 +++++---
1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 37120a3..0544aa2 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -57,12 +57,14 @@ if ($path_info) {
our $GIT = "++GIT_BINDIR++/git";

# absolute fs-path which will be prepended to the project path
-#our $projectroot = "/pub/scm";
-our $projectroot = "++GITWEB_PROJECTROOT++";
+use vars qw($projectroot);
+#$projectroot = "/pub/scm";
+$projectroot = "++GITWEB_PROJECTROOT++";

# fs traversing limit for getting project list
# the number is relative to the projectroot
-our $project_maxdepth = "++GITWEB_PROJECT_MAXDEPTH++";
+use vars qw($project_maxdepth);
+$project_maxdepth = "++GITWEB_PROJECT_MAXDEPTH++";

# target of the home link on top of all pages
our $home_link = $my_uri || "/";
-- 
1.6.4
