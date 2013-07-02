From: Tony Finch <dot@dotat.at>
Subject: [PATCH v2] gitweb: allow extra breadcrumbs to prefix the trail
Date: Tue, 2 Jul 2013 16:49:08 +0100
Message-ID: <E1UugA8-00054D-DL@hermes-2.csi.cam.ac.uk>
References: <E1Uu3IT-0008U1-3c@hermes-2.csi.cam.ac.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 04 11:49:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UugAE-00034a-M4
	for gcvg-git-2@plane.gmane.org; Thu, 04 Jul 2013 11:49:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753738Ab3GDJtT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Jul 2013 05:49:19 -0400
X-Warning: Original message contained 8-bit characters, however during
	   the SMTP transport session the receiving system did not announce
	   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
	   message does not have MIME headers (RFC 2045-2049) to enable
	   encoding change, we had very little choice.
X-Warning: We ASSUME it is less harmful to add the MIME headers, and
	   convert the text to Quoted-Printable, than not to do so,
	   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
X-Warning: We don't know what character set the user used, thus we had to
	   write these MIME-headers with our local system default value.
Received: from ppsw-33.csi.cam.ac.uk ([131.111.8.133]:48009 "EHLO
	ppsw-33.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753387Ab3GDJtS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jul 2013 05:49:18 -0400
X-Cam-AntiVirus: no malware found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Received: from hermes-2.csi.cam.ac.uk ([131.111.8.54]:49896)
	by ppsw-33.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.157]:25)
	with esmtpa (EXTERNAL:fanf2) id 1UugA8-0006wF-hP (Exim 4.80_167-5a66dd3) for git@vger.kernel.org
	(return-path <fanf2@hermes.cam.ac.uk>); Thu, 04 Jul 2013 10:49:16 +0100
Received: from fanf2 by hermes-2.csi.cam.ac.uk (hermes.cam.ac.uk)
	with local id 1UugA8-00054D-DL (Exim 4.72) for git@vger.kernel.org
	(return-path <fanf2@hermes.cam.ac.uk>); Thu, 04 Jul 2013 10:49:16 +0100
In-Reply-To: <E1Uu3IT-0008U1-3c@hermes-2.csi.cam.ac.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229565>

There are often parent pages logically above the gitweb projects
list, e.g. home pages of the organization and department that host
the gitweb server. This change allows you to include links to those
pages in gitweb's breadcrumb trail.

Signed-off-by: Tony Finch <dot@dotat.at>
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
---

This update includes the documentation improvements suggested by
Jonathan Nieder and Jakub Nar=C4=99bski.

 Documentation/gitweb.conf.txt | 22 ++++++++++++++++++++--
 gitweb/gitweb.perl            |  6 ++++++
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/Documentation/gitweb.conf.txt b/Documentation/gitweb.conf.=
txt
index ea0526e..305db63 100644
--- a/Documentation/gitweb.conf.txt
+++ b/Documentation/gitweb.conf.txt
@@ -336,8 +336,26 @@ $home_link_str::
 	used as the first component of gitweb's "breadcrumb trail":
 	`<home link> / <project> / <action>`.  Can be set at build time using
 	the `GITWEB_HOME_LINK_STR` variable.  By default it is set to "projec=
ts",
-	as this link leads to the list of projects.  Other popular choice it =
to
-	set it to the name of site.
+	as this link leads to the list of projects.  Another popular choice i=
s to
+	set it to the name of site.  Note that it is treated as raw HTML so i=
t
+	should not be set from untrusted sources.
+
+@extra_breadcrumbs::
+	Additional links to be added to the start of the breadcrumb trail bef=
ore
+	the home link, to pages that are logically "above" the gitweb project=
s
+	list, such as the organization and department which host the gitweb
+	server. Each element of the list is a reference to an array, in which
+	element 0 is the link text (equivalent to `$home_link_str`) and eleme=
nt
+	1 is the target URL (equivalent to `$home_link`).
++
+For example, the following setting produces a breadcrumb trail like
+"home / dev / projects / ..." where "projects" is the home link.
+----------------------------------------------------------------------=
------
+    our @extra_breadcrumbs =3D (
+      [ 'home' =3D> 'https://www.example.org/' ],
+      [ 'dev'  =3D> 'https://dev.example.org/' ],
+    );
+----------------------------------------------------------------------=
------
=20
 $logo_url::
 $logo_label::
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 8d69ada..436f17a 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -85,6 +85,9 @@ our $project_maxdepth =3D "++GITWEB_PROJECT_MAXDEPTH+=
+";
 # string of the home link on top of all pages
 our $home_link_str =3D "++GITWEB_HOME_LINK_STR++";
=20
+# extra breadcrumbs preceding the home link
+our @extra_breadcrumbs =3D ();
+
 # name of your site or organization to appear in page titles
 # replace this with something more descriptive for clearer bookmarks
 our $site_name =3D "++GITWEB_SITENAME++"
@@ -3982,6 +3985,9 @@ sub print_nav_breadcrumbs_path {
 sub print_nav_breadcrumbs {
 	my %opts =3D @_;
=20
+	for my $crumb (@extra_breadcrumbs) {
+		print $cgi->a({-href =3D> esc_url($crumb->[1])}, $crumb->[0]) . " / =
";
+	}
 	print $cgi->a({-href =3D> esc_url($home_link)}, $home_link_str) . " /=
 ";
 	if (defined $project) {
 		my @dirname =3D split '/', $project;
--=20
1.8.3.1.605.g85318f5
