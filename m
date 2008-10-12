From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH/RFC v2] gitweb: Separate %global_features
Date: Sun, 12 Oct 2008 23:00:25 +0200
Message-ID: <20081012205925.29606.36935.stgit@localhost.localdomain>
References: <20081012130157.26825.67398.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>, Petr Baudis <pasky@suse.cz>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 12 23:02:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kp850-0006nM-IP
	for gcvg-git-2@gmane.org; Sun, 12 Oct 2008 23:02:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752702AbYJLVBF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Oct 2008 17:01:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752496AbYJLVBE
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Oct 2008 17:01:04 -0400
Received: from ey-out-2122.google.com ([74.125.78.26]:14893 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752369AbYJLVBC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Oct 2008 17:01:02 -0400
Received: by ey-out-2122.google.com with SMTP id 6so492588eyi.37
        for <git@vger.kernel.org>; Sun, 12 Oct 2008 14:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:subject:to:cc
         :date:message-id:in-reply-to:references:user-agent:mime-version
         :content-type:content-transfer-encoding;
        bh=Xs0oxTbpKUOhSYIcvyrqNO7eY2p9gylZbRfia1bOVME=;
        b=Gw/XEXBCGsdyYRD3T6tv6fBOLhA/7bFO+fvqZLlPbP+8KqM8dnO4xPmb1WuWeRXMhi
         8mmYCfUmUGi+ptFf6RX4Uo5M3lkkeTkxuBPz6c0wq68TT6kAJAReWHGHACAgqk7Q7Tjb
         tg2l0go5PKPZyN9m4Lsoycv9JTNmirZ7kHPSs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:subject:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-type:content-transfer-encoding;
        b=cqXECUNznjBHktk8rVlxzoMe+NtPBrv4AbBE/B71qTy1wcMsGDA56YPkZKZZ0Yn4Wj
         tRRfUnk2yN2altVKflfHdE0WENLOjflLEDZzdIvT7bFRCKJaHoY2vPXV15o/QisswzIZ
         SKBzY5ZsNonC/4ygIZyIU0JjC2+Ah0tggqggU=
Received: by 10.210.81.3 with SMTP id e3mr4337488ebb.107.1223845260273;
        Sun, 12 Oct 2008 14:01:00 -0700 (PDT)
Received: from localhost.localdomain (abxa211.neoplus.adsl.tpnet.pl [83.8.250.211])
        by mx.google.com with ESMTPS id 5sm8572207eyh.2.2008.10.12.14.00.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 12 Oct 2008 14:00:59 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m9CL0P3u029644;
	Sun, 12 Oct 2008 23:00:31 +0200
In-Reply-To: <20081012130157.26825.67398.stgit@localhost.localdomain>
User-Agent: StGIT/0.14.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98054>

Put features for which project specific override is not supported into
separate %global_feature hash, updating gitweb_check_feature()
subroutine to use it.  For backward compatibility with existing gitweb
configuration setups $feature{<feature>}{'default'} has preference
over $global_feature{<feature>}.

While at it remove stale comment for 'pathinfo' feature; requiring to
use workaround specified was fixed in b65910f (gitweb: remove
PATH_INFO from $my_url and $my_uri).

FIX IT: some spurious "HASH.." is printed to STDERR.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This should be backward compatibile...

 gitweb/gitweb.perl |   66 ++++++++++++++++++++++++++--------------------------
 1 files changed, 33 insertions(+), 33 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index cc6edbe..88bedec 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -215,13 +215,6 @@ our %feature = (
 		'override' => 0,
 		'default' => ['tgz']},
 
-	# Enable text search, which will list the commits which match author,
-	# committer or commit text to a given string.  Enabled by default.
-	# Project specific override is not supported.
-	'search' => {
-		'override' => 0,
-		'default' => [1]},
-
 	# Enable grep search, which will list the files in currently selected
 	# tree containing the given string. Enabled by default. This can be
 	# potentially CPU-intensive, of course.
@@ -248,6 +241,20 @@ our %feature = (
 		'sub' => \&feature_pickaxe,
 		'override' => 0,
 		'default' => [1]},
+);
+
+our %global_feature = (
+	# feature => [ default options...] (array reference)
+	#
+	# For those features project specific override is not supported.
+	# Note that for backwards compatibility of existing gitweb
+	# configurations $feature{<feature>}{'default'} has preference.
+
+	# use gitweb_check_feature(<feature>) to check if <feature> is enabled
+
+	# Enable text search, which will list the commits which match author,
+	# committer or commit text to a given string.  Enabled by default.
+	'search' => [1],
 
 	# Make gitweb use an alternative format of the URLs which can be
 	# more readable and natural-looking: project name is embedded
@@ -257,16 +264,8 @@ our %feature = (
 	# generates links.
 
 	# To enable system wide have in $GITWEB_CONFIG
-	# $feature{'pathinfo'}{'default'} = [1];
-	# Project specific override is not supported.
-
-	# Note that you will need to change the default location of CSS,
-	# favicon, logo and possibly other files to an absolute URL. Also,
-	# if gitweb.cgi serves as your indexfile, you will need to force
-	# $my_uri to contain the script name in your $GITWEB_CONFIG.
-	'pathinfo' => {
-		'override' => 0,
-		'default' => [0]},
+	# $global_feature{'pathinfo'} = [1];
+	'pathinfo' => [0],
 
 	# Make gitweb consider projects in project root subdirectories
 	# to be forks of existing projects. Given project $projname.git,
@@ -277,11 +276,8 @@ our %feature = (
 	# to be listed after the main project.
 
 	# To enable system wide have in $GITWEB_CONFIG
-	# $feature{'forks'}{'default'} = [1];
-	# Project specific override is not supported.
-	'forks' => {
-		'override' => 0,
-		'default' => [0]},
+	# $global_feature{'forks'} = [1];
+	'forks' => [0],
 
 	# Insert custom links to the action bar of all project pages.
 	# This enables you mainly to link to third-party scripts integrating
@@ -296,12 +292,9 @@ our %feature = (
 	# hash base (hb gitweb parameter); %% expands to %.
 
 	# To enable system wide have in $GITWEB_CONFIG e.g.
-	# $feature{'actions'}{'default'} = [('graphiclog',
+	# $global_feature{'actions'} = [('graphiclog',
 	# 	'/git-browser/by-commit.html?r=%n', 'summary')];
-	# Project specific override is not supported.
-	'actions' => {
-		'override' => 0,
-		'default' => []},
+	'actions' => [],
 
 	# Allow gitweb scan project content tags described in ctags/
 	# of project repository, and display the popular Web 2.0-ish
@@ -315,16 +308,23 @@ our %feature = (
 	# a pretty tag cloud instead of just a list of tags.
 
 	# To enable system wide have in $GITWEB_CONFIG
-	# $feature{'ctags'}{'default'} = ['path_to_tag_script'];
+	# $global_feature{'ctags'} = ['path_to_tag_script'];
 	# Project specific override is not supported.
-	'ctags' => {
-		'override' => 0,
-		'default' => [0]},
+	'ctags' => [0],
 );
 
 sub gitweb_check_feature {
-	my ($name) = @_;
-	return unless exists $feature{$name};
+	my $name = shift;
+
+	# %feature has precedence over %global_feature for backward
+	# compatibility with pre-existing gitweb configuration setups
+	unless (exists $feature{$name}) {
+		if (exists $global_feature{$name}) {
+			return @{$global_feature{$name}};
+		}
+		return;
+	}
+
 	my ($sub, $override, @defaults) = (
 		$feature{$name}{'sub'},
 		$feature{$name}{'override'},
