From: Gerrit Pape <pape@smarden.org>
Subject: [PATCH] gitweb: choose appropriate view for file type if a= parameter missing.
Date: Wed, 9 May 2007 22:19:28 +0000
Message-ID: <20070509221928.17244.qmail@f9729cdcdf57d1.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: 410465@bugs.debian.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 10 00:19:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HluVd-0001c7-Pv
	for gcvg-git@gmane.org; Thu, 10 May 2007 00:19:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758805AbXEIWTO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 May 2007 18:19:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758803AbXEIWTO
	(ORCPT <rfc822;git-outgoing>); Wed, 9 May 2007 18:19:14 -0400
Received: from a.ns.smarden.org ([212.42.242.37]:43326 "HELO a.mx.smarden.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758805AbXEIWTN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2007 18:19:13 -0400
Received: (qmail 17245 invoked by uid 1000); 9 May 2007 22:19:28 -0000
Mail-Followup-To: git@vger.kernel.org, 410465@bugs.debian.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46800>

See http://bugs.debian.org/410465

gitweb URLs use the a= parameter for the view to use on the given path, such
as "blob" or "tree".  Currently, if a gitweb URL omits the a= parameter,
gitweb just shows the top-level repository summary, regardless of the path
given.  gitweb could instead choose an appropriate view based on the file
type: blob for blobs (files), tree for trees (directories), and summary if no
path given (the URL included no f= parameter, or an empty f= parameter).

Apart from making gitweb more robust and supporting URL editing more easily,
this change would aid the creation of shortcuts to git repositories using
simple substitution, such as:
http://example.org/git/?p=path/to/repo.git;hb=HEAD;f=%s

- Josh Triplett

Signed-off-by: Gerrit Pape <pape@smarden.org>
---
 gitweb/gitweb.perl |   14 ++++++++++----
 1 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 90243fd..21864c6 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -458,10 +458,16 @@ my %actions = (
 	"project_index" => \&git_project_index,
 );
 
-if (defined $project) {
-	$action ||= 'summary';
-} else {
-	$action ||= 'project_list';
+if (!defined $action) {
+	if (defined $hash) {
+		$action = git_get_type($hash);
+	} elsif (defined $hash_base && defined $file_name) {
+		$action = git_get_type("$hash_base:$file_name");
+	} elsif (defined $project) {
+		$action = 'summary';
+	} else {
+		$action = 'project_list';
+	}
 }
 if (!defined($actions{$action})) {
 	die_error(undef, "Unknown action");
-- 
1.5.1.3
