From: Gerrit Pape <pape@smarden.org>
Subject: [PATCH] gitweb: choose appropriate view for file type if a= parameter missing
Date: Thu, 10 May 2007 07:32:07 +0000
Message-ID: <20070510073207.21562.qmail@25d0c789693af2.315fe32.mid.smarden.org>
References: <20070509221928.17244.qmail@f9729cdcdf57d1.315fe32.mid.smarden.org> <7vvef1o2ni.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu May 10 09:31:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hm380-0005t5-05
	for gcvg-git@gmane.org; Thu, 10 May 2007 09:31:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755269AbXEJHbv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 May 2007 03:31:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756542AbXEJHbv
	(ORCPT <rfc822;git-outgoing>); Thu, 10 May 2007 03:31:51 -0400
Received: from a.ns.smarden.org ([212.42.242.37]:44869 "HELO a.mx.smarden.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755269AbXEJHbu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2007 03:31:50 -0400
Received: (qmail 21563 invoked by uid 1000); 10 May 2007 07:32:07 -0000
Mail-Followup-To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vvef1o2ni.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46835>

gitweb URLs use the a= parameter for the view to use on the given path, such
as "blob" or "tree".  Currently, if a gitweb URL omits the a= parameter,
gitweb just shows the top-level repository summary, regardless of the path
given.  gitweb could instead choose an appropriate view based on the file
type: blob for blobs (files), tree for trees (directories), and summary if
no path given (the URL included no f= parameter, or an empty f= parameter).

Apart from making gitweb more robust and supporting URL editing more easily,
this change would aid the creation of shortcuts to git repositories using
simple substitution, such as:
http://example.org/git/?p=path/to/repo.git;hb=HEAD;f=%s

With this patch, if given the hash through the h= parameter, or the hash
base (hb=) and a filename (f=), gitweb uses cat-file -t to automatically set
the a= parameter.

This feature was requested by Josh Triplett through
 http://bugs.debian.org/410465

Signed-off-by: Gerrit Pape <pape@smarden.org>
---

On Wed, May 09, 2007 at 07:04:01PM -0700, Junio C Hamano wrote:
> I'd however request a few changes to the proposed commit log
> message:
>
>  * "See http://..." is not the primary information, but "see
>    ... for further details"; please have it at the end, not at
>    the beginning.

Okay.

>  * Was the patch authored by you, or Josh?  If the former,
>    what's his name doing here?  Perhaps you wanted to say
>    "Reported by Josh Triplett"?

Sometimes I'm lazy, it was just a copy&paste from the Debian bug report
submitted by Josh.

Regards, Gerrit.

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
