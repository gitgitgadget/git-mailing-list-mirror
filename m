From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH/RFC] gitweb: Separate features with no project specific
	override
Date: Sun, 12 Oct 2008 15:05:41 +0200
Message-ID: <20081012130157.26825.67398.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>, Petr Baudis <pasky@suse.cz>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 12 15:07:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kp0ey-0007Za-IY
	for gcvg-git-2@gmane.org; Sun, 12 Oct 2008 15:07:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752744AbYJLNFt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Oct 2008 09:05:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752122AbYJLNFt
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Oct 2008 09:05:49 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:36071 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752040AbYJLNFs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Oct 2008 09:05:48 -0400
Received: by nf-out-0910.google.com with SMTP id d3so543674nfc.21
        for <git@vger.kernel.org>; Sun, 12 Oct 2008 06:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:subject:to:cc
         :date:message-id:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=mTeOH9sKvLBMcLiXNTIHxJ4txHL/GIacJM8EtVbRB/4=;
        b=PeaZKPRXmerSFd56rOFAn2KbRSvoyX/Zgv3NGWB75pEIBOOsOphTYS0oaBXuC7IbM6
         r7o28x1Kk2NWvIzf8CKwIhXkrTAnyW8RZ2IXV/SHpeqst1l0/qKkPqk7SMCUbxn6Ekpz
         Ms4rUGO9ka5DCO8ABGMACr3Cn6+BNc1hog++s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:subject:to:cc:date:message-id:user-agent:mime-version
         :content-type:content-transfer-encoding;
        b=WtG9CYIJ7UP0CV6FqlQyWKfc2/CwplyplERqAa7dM1xCeydhDtyx2qcJA+ZT65qdmH
         cxsofoP265pG4U2AHXim5bFQunK3+DKX7/JwN8dQmHENsEEaFWorvekDay4AeTGkxbwH
         llATuiWuNMvBt2lSK+xg7nZ0f87gc9fU3grn0=
Received: by 10.210.42.20 with SMTP id p20mr3736038ebp.4.1223816746133;
        Sun, 12 Oct 2008 06:05:46 -0700 (PDT)
Received: from localhost.localdomain (abxa211.neoplus.adsl.tpnet.pl [83.8.250.211])
        by mx.google.com with ESMTPS id 20sm7728116eyk.4.2008.10.12.06.05.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 12 Oct 2008 06:05:44 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m9CD5fVU026880;
	Sun, 12 Oct 2008 15:05:42 +0200
User-Agent: StGIT/0.14.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98018>

Put features for which project specific override is not supported into
separate %global_feature hash, updating gitweb_check_feature()
subroutine to use it.

While at it remove stale comment for 'pathinfo' feature; requiring to
use workaround specified was fixed in b65910f (gitweb: remove
PATH_INFO from $my_url and $my_uri).

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This patch has the advantage of clear separation of non-overridable
and overridable features; currently the only difference is lack of
subroutine and comment on feature.  For non-overridable features the
complexisty of {'sub'=>..., 'override'=>..., 'default'=>...} is not
needed.

It has the disadvantage of invalidating old gitweb configuration, and
that now there are two sources of gitweb config.

FIX IT: some spurious "HASH.." is printed to STDERR (by my 'run gitweb
from command line' script), which I didn't found yet.

 gitweb/gitweb.perl |   59 ++++++++++++++++++++++++----------------------------
 1 files changed, 27 insertions(+), 32 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index cc6edbe..82068f9 100755
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
@@ -248,6 +241,18 @@ our %feature = (
 		'sub' => \&feature_pickaxe,
 		'override' => 0,
 		'default' => [1]},
+);
+
+our %global_feature = (
+	# feature => [ default options...] (array reference)
+	#
+	# For those features project specific override is not supported.
+	#
+	# use gitweb_check_feature(<feature>) to check if <feature> is enabled
+
+	# Enable text search, which will list the commits which match author,
+	# committer or commit text to a given string.  Enabled by default.
+	'search' => [1],
 
 	# Make gitweb use an alternative format of the URLs which can be
 	# more readable and natural-looking: project name is embedded
@@ -257,16 +262,8 @@ our %feature = (
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
@@ -277,11 +274,8 @@ our %feature = (
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
@@ -296,12 +290,9 @@ our %feature = (
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
@@ -315,16 +306,20 @@ our %feature = (
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
+	my $name = shift;
+
+	if (exists $global_feature{$name}) {
+		return @{$global_feature{$name}};
+	}
+
 	return unless exists $feature{$name};
+
 	my ($sub, $override, @defaults) = (
 		$feature{$name}{'sub'},
 		$feature{$name}{'override'},

-- 
Stacked GIT 0.14.3
git version 1.6.0.2
