From: Matt McCutchen <matt@mattmccutchen.net>
Subject: [PATCH] gitweb: add $prevent_xss option to prevent XSS by
 repository content
Date: Sat, 07 Feb 2009 19:00:09 -0500
Message-ID: <1234051209.3299.26.camel@mattlaptop2.local>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 08 01:01:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVx7D-0001jI-9A
	for gcvg-git-2@gmane.org; Sun, 08 Feb 2009 01:01:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755923AbZBHAAO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Feb 2009 19:00:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755614AbZBHAAO
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Feb 2009 19:00:14 -0500
Received: from mailbigip.dreamhost.com ([208.97.132.5]:37574 "EHLO
	homiemail-a7.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755923AbZBHAAM (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 Feb 2009 19:00:12 -0500
Received: from [129.2.207.241] (ml2.student.umd.edu [129.2.207.241])
	by homiemail-a7.g.dreamhost.com (Postfix) with ESMTP id BC94F73CB2;
	Sat,  7 Feb 2009 16:00:10 -0800 (PST)
X-Mailer: Evolution 2.24.4 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108903>

Add a gitweb configuration variable $prevent_xss that disables features
to prevent content in repositories from launching cross-site scripting
(XSS) attacks in the gitweb domain.  Currently, this option makes gitweb
ignore README.html (a better solution may be worked out in the future)
and serve a blob_plain file of an untrusted type with
"Content-Disposition: attachment", which tells the browser not to show
the file at its original URL.

The XSS prevention is currently off by default.

Signed-off-by: Matt McCutchen <matt@mattmccutchen.net>
---

I found these vulnerabilities a few weeks ago during a security audit of
my Web site and discussed them with Junio Hamano, Jeff King, and Jakub
Narebski.  Unfortunately, it's hard to close them without a loss of
functionality that may be unacceptable to some sites.  We decided to go
ahead and publicize the issue with this patch, which will give sites a
choice to keep the functionality or prevent XSS depending on their
needs.  Input is invited from webmasters on a better solution to be
added in the future.

Matt

 gitweb/README      |    9 ++++++++-
 gitweb/gitweb.perl |   21 +++++++++++++++++++--
 2 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/gitweb/README b/gitweb/README
index a9dc2e5..8433dd1 100644
--- a/gitweb/README
+++ b/gitweb/README
@@ -212,6 +212,11 @@ not include variables usually directly set during build):
    Rename detection options for git-diff and git-diff-tree. By default
    ('-M'); set it to ('-C') or ('-C', '-C') to also detect copies, or
    set it to () if you don't want to have renames detection.
+ * $prevent_xss
+   If true, some gitweb features are disabled to prevent content in
+   repositories from launching cross-site scripting (XSS) attacks.  Set this
+   to true if you don't trust the content of your repositories. The default
+   is false.
 

 Projects list file format
@@ -258,7 +263,9 @@ You can use the following files in repository:
    A .html file (HTML fragment) which is included on the gitweb project
    summary page inside <div> block element. You can use it for longer
    description of a project, to provide links (for example to project's
-   homepage), etc.
+   homepage), etc. This is recognized only if XSS prevention is off
+   ($prevent_xss is false); a way to include a readme safely when XSS
+   prevention is on may be worked out in the future.
  * description (or gitweb.description)
    Short (shortened by default to 25 characters in the projects list page)
    single line description of a project (of a repository). Plain text file;
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index f27dbb6..5410874 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -132,6 +132,10 @@ our $fallback_encoding = 'latin1';
 # - one might want to include '-B' option, e.g. '-B', '-M'
 our @diff_opts = ('-M'); # taken from git_commit
 
+# Disables features that would allow repository owners to inject script into
+# the gitweb domain.
+our $prevent_xss = 0;
+
 # information about snapshot formats that gitweb is capable of serving
 our %known_snapshot_formats = (
 	# name => {
@@ -4503,7 +4507,9 @@ sub git_summary {
 
 	print "</table>\n";
 
-	if (-s "$projectroot/$project/README.html") {
+	# If XSS prevention is on, we don't include README.html.
+	# TODO: Allow a readme in some safe format.
+	if (!$prevent_xss && -s "$projectroot/$project/README.html") {
 		print "<div class=\"title\">readme</div>\n" .
 		      "<div class=\"readme\">\n";
 		insert_file("$projectroot/$project/README.html");
@@ -4764,10 +4770,21 @@ sub git_blob_plain {
 		$save_as .= '.txt';
 	}
 
+	# With XSS prevention on, blobs of all types except a few known safe
+	# ones are served with "Content-Disposition: attachment" to make sure
+	# they don't run in our security domain.  For certain image types,
+	# blob view writes an <img> tag referring to blob_plain view, and we
+	# want to be sure not to break that by serving the image as an
+	# attachment (though Firefox 3 doesn't seem to care).
+	my $sandbox = $prevent_xss &&
+		$type !~ m!^(?:text/plain|image/(?:gif|png|jpeg))$!;
+
 	print $cgi->header(
 		-type => $type,
 		-expires => $expires,
-		-content_disposition => 'inline; filename="' . $save_as . '"');
+		-content_disposition =>
+			($sandbox ? 'attachment' : 'inline')
+			. '; filename="' . $save_as . '"');
 	undef $/;
 	binmode STDOUT, ':raw';
 	print <$fd>;
-- 
1.6.2.rc0.7.g013dd.dirty
