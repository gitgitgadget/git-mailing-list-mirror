From: Kevin Ballard <kevin@sb.org>
Subject: [PATCH] Trim leading / off of paths in git-svn prop_walk
Date: Wed,  9 Jan 2008 01:37:20 -0500
Message-ID: <1199860640-74118-1-git-send-email-kevin@sb.org>
Cc: gitster@pobox.com, Kevin Ballard <kevin@sb.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 09 07:39:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCUbQ-0006Ni-4g
	for gcvg-git-2@gmane.org; Wed, 09 Jan 2008 07:39:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751558AbYAIGjY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jan 2008 01:39:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751500AbYAIGjY
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Jan 2008 01:39:24 -0500
Received: from hapkido.dreamhost.com ([66.33.216.122]:46494 "EHLO
	hapkido.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750793AbYAIGjX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jan 2008 01:39:23 -0500
Received: from randymail-a11.g.dreamhost.com (mailbigip.dreamhost.com [208.97.132.5])
	by hapkido.dreamhost.com (Postfix) with ESMTP id 9DD1A179D69
	for <git@vger.kernel.org>; Tue,  8 Jan 2008 22:39:22 -0800 (PST)
Received: from localhost.localdomain (c-24-62-230-0.hsd1.ma.comcast.net [24.62.230.0])
	by randymail-a11.g.dreamhost.com (Postfix) with ESMTP id 914FB109E8B;
	Tue,  8 Jan 2008 22:37:21 -0800 (PST)
X-Mailer: git-send-email 1.5.4.rc2.68.ge708a-dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69957>

prop_walk adds a leading / to all subdirectory paths. Unfortunately
this causes a problem when the remote repo lives in a subdirectory itself,
as the leading / causes subsequent PROPFIND calls to be executed on
the wrong path. Trimming the / before calling the PROPFIND fixes this problem.

Signed-off-by: Kevin Ballard <kevin@sb.org>
---
All tests passed after this change, but since it seems to only apply
to WebDAV SVN repos I saw no way to add a new test.
 git-svn.perl |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 3308fe1..d5316eb 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -1858,6 +1858,7 @@ sub rel_path {
 sub prop_walk {
 	my ($self, $path, $rev, $sub) = @_;
 
+	$path =~ s#^/##;
 	my ($dirent, undef, $props) = $self->ra->get_dir($path, $rev);
 	$path =~ s#^/*#/#g;
 	my $p = $path;
-- 
1.5.4.rc2.68.ge708a-dirty
