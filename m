From: Charles Bailey <charles@hashpling.org>
Subject: [PATCH] gitweb: add a setting to control the tabstop width
Date: Mon, 3 Mar 2008 22:11:59 +0000
Message-ID: <20080303221159.GA6875@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 03 23:13:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWItt-0006Cz-Fb
	for gcvg-git-2@gmane.org; Mon, 03 Mar 2008 23:12:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752326AbYCCWMM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2008 17:12:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752063AbYCCWML
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Mar 2008 17:12:11 -0500
Received: from pih-relay05.plus.net ([212.159.14.132]:33320 "EHLO
	pih-relay05.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751824AbYCCWMK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2008 17:12:10 -0500
Received: from [212.159.69.125] (helo=hashpling.plus.com)
	 by pih-relay05.plus.net with esmtp (Exim) id 1JWItB-0006y0-Uv; Mon, 03 Mar 2008 22:12:06 +0000
Received: from fermat.hashpling.org (fermat.hashpling.org [127.0.0.1])
	by hashpling.plus.com (8.13.8/8.13.6) with ESMTP id m23MBxfS007368;
	Mon, 3 Mar 2008 22:11:59 GMT
Received: (from charles@localhost)
	by fermat.hashpling.org (8.13.8/8.13.6/Submit) id m23MBx0Y007367;
	Mon, 3 Mar 2008 22:11:59 GMT
Content-Disposition: inline
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Plusnet-Relay: f1a7887bec3f23897db3d77fd66d35ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75987>

Not everyone uses the same tab width. gitweb learns a new setting to
control the tabstop width. The configuration can be set globally and
on a per project basis. The default is 8, preserving existing
behaviour. The configuration variable name is borrowed from the vim
setting with the same behaviour.

Signed-off-by: Charles Bailey <charles@hashpling.org>
---

The untabify function seems the sensible place to make the change. As
untabify is called once per line from various different locations it
also makes sense to cache the result of the config lookup in a package
variable, though this makes the change slightly less neat.

This change should have a minimal impact on performance but it would
appreciate some more eyes and ideally some performance testing on
heavier systems than my own. 

 gitweb/gitweb.perl |   29 ++++++++++++++++++++++++++++-
 1 files changed, 28 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 922dee9..cdabe37 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -108,6 +108,12 @@ our $mimetypes_file = undef;
 # could be even 'utf-8' for the old behavior)
 our $fallback_encoding = 'latin1';
 
+# variable to keep track of the the current tabstop width
+# this is a package variable as the natural place to check the feature is in
+# the untabify function, but as the function is called once per line we don't
+# want to have to recheck the config for each line
+our $tabstop_width;
+
 # rename detection options for git-diff and git-diff-tree
 # - default is '-M', with the cost proportional to
 #   (number of removed files) * (number of new files).
@@ -275,6 +281,18 @@ our %feature = (
 	'forks' => {
 		'override' => 0,
 		'default' => [0]},
+
+	# Tabstop width.  Controls the number of spaces to which tabs are
+	# expanded. Default is 8.
+	# To change system wide add the following to $GITWEB_CONFIG
+	# $feature{'tabstop'}{'default'} = [8];
+	# To have project specific config enable override in $GITWEB_CONFIG
+	# $feature{'tabstop'}{'override'} = 1;
+	# and in project config gitweb.tabstop = <width>
+	'tabstop' => {
+		'sub' => \&feature_tabstop,
+		'override' => 0,
+		'default' => [8]},
 );
 
 sub gitweb_check_feature {
@@ -340,6 +358,11 @@ sub feature_pickaxe {
 	return ($_[0]);
 }
 
+sub feature_tabstop {
+	my ($val) = git_get_project_config('tabstop', '--int');
+	return defined($val) ? ($val) : ($_[0])
+}
+
 # checking HEAD file with -e is fragile if the repository was
 # initialized long time ago (i.e. symlink HEAD) and was pack-ref'ed
 # and then pruned.
@@ -832,8 +855,12 @@ sub unquote {
 sub untabify {
 	my $line = shift;
 
+	if (!defined($tabstop_width)) {
+		($tabstop_width) = gitweb_check_feature('tabstop');
+	}
+
 	while ((my $pos = index($line, "\t")) != -1) {
-		if (my $count = (8 - ($pos % 8))) {
+		if (my $count = ($tabstop_width - ($pos % $tabstop_width))) {
 			my $spaces = ' ' x $count;
 			$line =~ s/\t/$spaces/;
 		}
-- 
1.5.4.3.432.g5ecfc


-- 
Charles Bailey
http://ccgi.hashpling.plus.com/blog/
