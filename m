From: Luke Lu <git@vicaya.com>
Subject: [PATCH] Speed up project listing for large working trees by limiting find depth
Date: Tue, 16 Oct 2007 15:37:33 -0700
Message-ID: <1192574253-13641-1-git-send-email-git@vicaya.com>
Cc: gitster@pobox.com, Luke Lu <git@vicaya.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 17 00:42:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ihv6y-0005ve-A0
	for gcvg-git-2@gmane.org; Wed, 17 Oct 2007 00:42:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761320AbXJPWlT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 18:41:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761425AbXJPWlT
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 18:41:19 -0400
Received: from alnrmhc15.comcast.net ([204.127.225.95]:64489 "EHLO
	alnrmhc15.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761300AbXJPWlS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 18:41:18 -0400
Received: from localhost.localdomain (c-98-207-63-2.hsd1.ca.comcast.net[98.207.63.2])
          by comcast.net (alnrmhc15) with SMTP
          id <20071016223802b1500i1jgce>; Tue, 16 Oct 2007 22:38:03 +0000
X-Mailer: git-send-email 1.5.3.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61271>

Simple gitweb patch to speed up project listing on checked out repos
with large trees. It was spending minutes in perl (5.8.8 macports).
It's taking a fraction of a second after the patch. Resubmitted per
Andreas Ericsson's advice.

---
 gitweb/gitweb.perl |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 3064298..a30eef9 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1509,16 +1509,20 @@ sub git_get_projects_list {
 		# remove the trailing "/"
 		$dir =~ s!/+$!!;
 		my $pfxlen = length("$dir");
+		my $pfxdepth = ($dir =~ tr!/!!);
 
 		File::Find::find({
 			follow_fast => 1, # follow symbolic links
 			follow_skip => 2, # ignore duplicates
+			no_chdir => 1, # don't chdir into every directory
 			dangling_symlinks => 0, # ignore dangling symlinks, silently
 			wanted => sub {
 				# skip project-list toplevel, if we get it.
 				return if (m!^[/.]$!);
 				# only directories can be git repositories
 				return unless (-d $_);
+				# don't traverse too deep (Find is super slow on os x)
+				return if tr!/!! - $pfxdepth > 2 && ($File::Find::prune = 1);
 
 				my $subdir = substr($File::Find::name, $pfxlen + 1);
 				# we check related file in $projectroot
-- 
1.5.3.4
