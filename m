From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC PATCHv2 01/10] gitweb: href(..., -path_info => 0|1)
Date: Tue,  9 Feb 2010 11:30:18 +0100
Message-ID: <1265711427-15193-2-git-send-email-jnareb@gmail.com>
References: <1265711427-15193-1-git-send-email-jnareb@gmail.com>
Cc: John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	John 'Warthog9' Hawley <warthog9@kernel.org>,
	Petr Baudis <pasky@suse.cz>, Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 09 11:31:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NenN7-0003mJ-04
	for gcvg-git-2@lo.gmane.org; Tue, 09 Feb 2010 11:31:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753467Ab0BIKao (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Feb 2010 05:30:44 -0500
Received: from mail-fx0-f220.google.com ([209.85.220.220]:37995 "EHLO
	mail-fx0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751911Ab0BIKam (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Feb 2010 05:30:42 -0500
Received: by fxm20 with SMTP id 20so3026604fxm.21
        for <git@vger.kernel.org>; Tue, 09 Feb 2010 02:30:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=pE1ztaa7Ixm5G31aH66PMQecypQtZi3zBRw8PGZ9e3E=;
        b=MMA4hHYYJJLOu36+RBxTq/ClMfROoBLDrQdw6Qdn5eH2VDWrxiP34W0kJGcSDDvM9X
         7RQtKW3JVoY6OhyT3KoM5QAcm8qKk+kjmQFopsFYWf9OeoTBeFO6gHUijknYhyVNDcW4
         hiOwdNsWGluzRs+MdFHZRIZvZ3VyuhPFIbDMY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=s/N+YBAM2Nkw+Cw1/QODMMYM0oqJx3r3vFEBnaDNK6+jaAIcOr/M5am295sxPskFkE
         JcSmdZxtGE6QxB4jDmR7iQfe1VrRCXQ8ynXWgVG4jiUmC1fdmUSrkoD4x+vlU8Y/S9yk
         VjddjIELw3dS2qlwSI6BREF7404NF3PTD0sYg=
Received: by 10.223.94.201 with SMTP id a9mr11938fan.78.1265711440183;
        Tue, 09 Feb 2010 02:30:40 -0800 (PST)
Received: from localhost.localdomain (abvg140.neoplus.adsl.tpnet.pl [83.8.204.140])
        by mx.google.com with ESMTPS id 16sm2344332fxm.8.2010.02.09.02.30.38
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 09 Feb 2010 02:30:39 -0800 (PST)
X-Mailer: git-send-email 1.6.6.1
In-Reply-To: <1265711427-15193-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139385>

If named boolean option -path_info is passed to href() subroutine, use
its value to decide whether to generate path_info URL form.  If this
option is not passed, href() queries 'pathinfo' feature to check
whether to generate path_info URL (if generating path_info link is
possible at all).

href(-replay=>1, -path_info=>0) is meant to be used to generate a key
for caching gitweb output; alternate solution would be to use freeze()
from Storable (core module) on %input_params hash (or its reference),
e.g.:
  $key = freeze \%input_params;
or other serialization technique.

While at it document extra options/flags to href().

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
There is no change in the patch with v2; only the explanation in the
commit message got changed a bit.


The reason behind -path_info=>0 is that we want to have the same cache
entry (the same cache file) regardless of whether we use path_info
URL, or non-path_info URL.

J.H. recommends using href(...,full=>1), to be able to have two gitweb
installations (or one gitweb installation but with $projects_root 
depending on virtual server used) to share cache without worrying
that they would stomp over each other cache entries.  On the other
hand this means that moving to another server [name], or changin
[virtual] location of gitweb, means that you need to re-cache
everything.  The discussion can be found in:
  http://thread.gmane.org/gmane.comp.version-control.git/136913/focus=137061

Note that in the caching patch by J.H. from "Gitweb caching v5" thread
(and top commit in git://git.kernel.org/pub/scm/git/warthog9/gitweb.git,
gitweb-ml-v5 branch) the key was generated as "$my_url?".$ENV{'QUERY_STRING'}
which wouldn't work with path_info URLs, but on the other hand gitweb
at git.kernel.org doesn't use path_info URLs (perhaps even doesn't
support them).

Using href(replay=>1,full=>1,path_info=>0) has additional advantage
over using $cgi->self_url() in that it also does not depend on
ordering of parameters in handcrafted URLs.

 gitweb/gitweb.perl |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 1f6978a..97ea3ec 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -970,6 +970,10 @@ exit;
 ## ======================================================================
 ## action links
 
+# possible values of extra options
+# -full => 0|1      - use absolute/full URL ($my_uri/$my_url as base)
+# -replay => 1      - start from a current view (replay with modifications)
+# -path_info => 0|1 - don't use/use path_info URL (if possible)
 sub href {
 	my %params = @_;
 	# default is to use -absolute url() i.e. $my_uri
@@ -986,7 +990,8 @@ sub href {
 	}
 
 	my $use_pathinfo = gitweb_check_feature('pathinfo');
-	if ($use_pathinfo and defined $params{'project'}) {
+	if (defined $params{'project'} &&
+	    (exists $params{-path_info} ? $params{-path_info} : $use_pathinfo)) {
 		# try to put as many parameters as possible in PATH_INFO:
 		#   - project name
 		#   - action
-- 
1.6.6.1
