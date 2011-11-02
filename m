From: Ben Walton <bwalton@artsci.utoronto.ca>
Subject: [PATCH] Escape file:// URL's to meet subversion SVN::Ra requirements
Date: Wed,  2 Nov 2011 12:38:15 -0400
Message-ID: <1320251895-6348-2-git-send-email-bwalton@artsci.utoronto.ca>
References: <1320251895-6348-1-git-send-email-bwalton@artsci.utoronto.ca>
Cc: git@vger.kernel.org, Ben Walton <bwalton@artsci.utoronto.ca>
To: normalperson@yhbt.net
X-From: git-owner@vger.kernel.org Wed Nov 02 17:38:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RLdpY-0002Ki-DF
	for gcvg-git-2@lo.gmane.org; Wed, 02 Nov 2011 17:38:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933215Ab1KBQiV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Nov 2011 12:38:21 -0400
Received: from garcia.cquest.utoronto.ca ([192.82.128.9]:49860 "EHLO
	garcia.cquest.utoronto.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932709Ab1KBQiU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Nov 2011 12:38:20 -0400
Received: from pinkfloyd.chass.utoronto.ca ([128.100.160.254]:35076 ident=93)
	by garcia.cquest.utoronto.ca with esmtp (Exim 4.63)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1RLdpU-0002RG-8Y; Wed, 02 Nov 2011 12:38:20 -0400
Received: from bwalton by pinkfloyd.chass.utoronto.ca with local (Exim 4.72)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1RLdpU-0001gU-7R; Wed, 02 Nov 2011 12:38:20 -0400
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <1320251895-6348-1-git-send-email-bwalton@artsci.utoronto.ca>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184645>

Previously only http/https URL's were uri escaped.  When building
against subversion 1.7, this was causing a segfault in perl after
an assertion failure in the SVN::Ra bindings during in t9134.

Changing 'trash directory' to 'trash_directory' worked around the
problem.

After a colleague reported this problem to the subversion list, it
was determined that the problem is in git, not svn.[1]  The SVN code
expects URL's and paths to be pre-escaped.

We now also escape file:// URL's in the Git::SVN::Ra->escape_url
code path.

[1] http://news.gmane.org/gmane.comp.version-control.subversion.devel

Signed-off-by: Ben Walton <bwalton@artsci.utoronto.ca>
---
 git-svn.perl |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 351e743..b00c188 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -5366,6 +5366,9 @@ sub escape_url {
 	if ($url =~ m#^(https?)://([^/]+)(.*)$#) {
 		my ($scheme, $domain, $uri) = ($1, $2, escape_uri_only($3));
 		$url = "$scheme://$domain$uri";
+	} elsif ($url =~ m#^(file)://(.*)$#) {
+		my ($scheme, $uri) = ($1, escape_uri_only($2));
+		$url = "$scheme://$uri";
 	}
 	$url;
 }
-- 
1.7.7.1
