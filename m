From: Dmitry Statyvka <dstatyvka@tmsoft-ltd.kiev.ua>
Subject: [PATCH] git svn: add an option to recode pathnames
Date: Wed, 29 Jul 2009 12:16:53 +0300
Message-ID: <ylnfxcfdeyq.fsf@tmsoft-ltd.kiev.ua>
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Wed Jul 29 11:43:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MW5hL-0008UC-8p
	for gcvg-git-2@gmane.org; Wed, 29 Jul 2009 11:43:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753638AbZG2Jni (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jul 2009 05:43:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753632AbZG2Jni
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Jul 2009 05:43:38 -0400
Received: from relay.tmsoft-ltd.com.ua ([213.186.204.178]:43828 "EHLO
	relay.tmsoft-ltd.com.ua" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753629AbZG2Jnh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jul 2009 05:43:37 -0400
X-Greylist: delayed 1481 seconds by postgrey-1.27 at vger.kernel.org; Wed, 29 Jul 2009 05:43:37 EDT
Received: from relay.tmsoft-ltd.com.ua (localhost.localdomain [127.0.0.1])
	by relay.tmsoft-ltd.com.ua (Carrier Pigeon) with ESMTP id 4D5F01765
	for <git@vger.kernel.org>; Wed, 29 Jul 2009 12:18:53 +0300 (EEST)
Received: from BEGEMOT.tmsoft-ltd.kiev.ua (begemot.magistr [192.168.92.101])
	by relay.tmsoft-ltd.com.ua (Carrier Pigeon) with ESMTP
	for <git@vger.kernel.org>; Wed, 29 Jul 2009 12:18:53 +0300 (EEST)
Apparently-To: <dstatyvka@tmsoft-ltd.kiev.ua>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124339>

Introduce new option 'svn.pathnameenc' that instructs git svn to recode
pathnames to given encoding.  It's useful for windows users and for those
who works in non-utf8 locales, since otherwise they'll have corrupted file
names with non-ascii characters.

Signed-off-by: Dmitry Statyvka <dstatyvka@tmsoft-ltd.kiev.ua>
---
 git-svn.perl |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index ef1d30d..bdd9af0 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -3343,6 +3343,7 @@ sub new {
 	$self->{absent_dir} = {};
 	$self->{absent_file} = {};
 	$self->{gii} = $git_svn->tmp_index_do(sub { Git::IndexInfo->new });
+	$self->{pathnameencoding} = Git::config('svn.pathnameenc');
 	$self;
 }
 
@@ -3426,6 +3427,10 @@ sub open_directory {
 
 sub git_path {
 	my ($self, $path) = @_;
+	if (my $enc = $self->{pathnameencoding}) {
+		require Encode;
+		Encode::from_to($path, 'UTF-8', $enc);
+	}
 	if ($self->{path_strip}) {
 		$path =~ s!$self->{path_strip}!! or
 		  die "Failed to strip path '$path' ($self->{path_strip})\n";
@@ -3814,6 +3819,10 @@ sub split_path {
 
 sub repo_path {
 	my ($self, $path) = @_;
+	if (my $enc = $self->{pathnameencoding}) {
+		require Encode;
+		Encode::from_to($path, $enc, 'UTF-8');
+	}
 	$self->{path_prefix}.(defined $path ? $path : '');
 }
 
-- 
1.6.3.2.1299.gee46c
