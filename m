From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: [updated2 PATCH] git-svn: Same default as cvsimport when using
	--use-log-author
Date: Tue, 29 Apr 2008 23:20:32 +0200
Message-ID: <20080429212032.8983.28194.stgit@aristoteles.cuci.nl>
References: <20080429211356.GA6825@cuci.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 29 23:21:25 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqxGI-0004P1-Q8
	for gcvg-git-2@gmane.org; Tue, 29 Apr 2008 23:21:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758026AbYD2VUe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2008 17:20:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757216AbYD2VUe
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Apr 2008 17:20:34 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:48751 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751632AbYD2VUd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2008 17:20:33 -0400
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id 8C6FD545F; Tue, 29 Apr 2008 23:20:32 +0200 (CEST)
In-Reply-To: <20080429211356.GA6825@cuci.nl>
User-Agent: StGIT/0.14.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80737>

When using git-cvsimport, the author is inferred from the cvs commit,
e.g. cvs commit logname is foobaruser, then the author field in git
results in:

Author: foobaruser <foobaruser>

Which is not perfect, but perfectly acceptable given the circumstances.

The default git-svn import however, results in:

Author: foobaruser <foobaruser@acf43c95-373e-0410-b603-e72c3f656dc1>

When using mixes of imports, from CVS and SVN into the same git
repository, you'd like to harmonise the imports to the format cvsimport
uses.
git-svn supports an experimental option --use-log-author which currently
results in the same logentry as without that option when no From: or
Signed-off-by: is found in the logentry ($email currently ends up empty,
and hence is generated again).

This patches harmonises the result with cvsimport, and makes
git-svn --use-log-author produce:

Author: foobaruser <foobaruser>

Signed-off-by: Stephen R. van den Berg <srb@cuci.nl>
---

 git-svn.perl |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)


diff --git a/git-svn.perl b/git-svn.perl
index b151049..67726c1 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -2426,13 +2426,15 @@ sub make_log_entry {
 			$name_field = $1;
 		}
 		if (!defined $name_field) {
-			#
+			if (!defined $email) {
+				$email = $name;
+			}
 		} elsif ($name_field =~ /(.*?)\s+<(.*)>/) {
 			($name, $email) = ($1, $2);
 		} elsif ($name_field =~ /(.*)@/) {
 			($name, $email) = ($1, $name_field);
 		} else {
-			($name, $email) = ($name_field, 'unknown');
+			($name, $email) = ($name_field, $name_field);
 		}
 	}
 	if (defined $headrev && $self->use_svm_props) {
