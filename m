From: Luben Tuikov <ltuikov@yahoo.com>
Subject: [PATCH] gitweb.cgi: Customization
Date: Tue, 1 Aug 2006 14:19:48 -0700 (PDT)
Message-ID: <20060801211948.99497.qmail@web31804.mail.mud.yahoo.com>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Tue Aug 01 23:20:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G81ee-00046m-Sa
	for gcvg-git@gmane.org; Tue, 01 Aug 2006 23:19:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750791AbWHAVTu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 Aug 2006 17:19:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750831AbWHAVTu
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Aug 2006 17:19:50 -0400
Received: from web31804.mail.mud.yahoo.com ([68.142.207.67]:51044 "HELO
	web31804.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750791AbWHAVTt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Aug 2006 17:19:49 -0400
Received: (qmail 99499 invoked by uid 60001); 1 Aug 2006 21:19:48 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=yvArWIjwH8h3jDSdhidKFBUuwO6tcATLM1HDeLA/F06U1G2KRThPM1PWpXcbTrHQnCXyzTRYgxuF645gd5ymCxReGOXNpQfVrunMKy7x3ur678mphFbXCe2Hyj0x0wZXqMLui5OoK6WKsliniB474scltO41Us2gw9SDqqpQ8cs=  ;
Received: from [64.215.88.90] by web31804.mail.mud.yahoo.com via HTTP; Tue, 01 Aug 2006 14:19:48 PDT
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24612>

The file "Gitweb_customization.pm" now holds customizable
variables used by "gitweb.cgi".  It is read by "gitweb.cgi"
from @INC, which includes ".", at compile time.

Copy "Gitweb_customization.pm" to where your "gitweb.cgi" or
its link lives.  The values therein are default values,
please change them as per your setup.  From then on, you
only need to update (copy) "gitweb.cgi" in order to upgrade
it, without editing or patching "gitweb.cgi" itself.

Signed-off-by: Luben Tuikov <ltuikov@yahoo.com>
---
 gitweb/Gitweb_customization.pm |   43 ++++++++++++++++++++++++++++++++++++++++
 gitweb/gitweb.cgi              |   31 +----------------------------
 2 files changed, 44 insertions(+), 30 deletions(-)

diff --git a/gitweb/Gitweb_customization.pm b/gitweb/Gitweb_customization.pm
new file mode 100644
index 0000000..8bfa19a
--- /dev/null
+++ b/gitweb/Gitweb_customization.pm
@@ -0,0 +1,43 @@
+package    Gitweb_customization;
+require    Exporter;
+
+our @ISA = qw(Exporter);
+our @EXPORT = qw($GIT $projectroot $projects_list $home_text $site_name
+		 $stylesheet $default_blob_plain_mimetype
+		 $default_text_plain_charset $mimetypes_file);
+
+# core git executable to use
+# this can just be "git" if your webserver has a sensible PATH
+our $GIT = "/usr/bin/git";
+
+# absolute fs-path which will be prepended to the project path
+our $projectroot = "/pub/git";
+
+# source of projects list
+# Directory format:
+#our $projects_list = $projectroot;
+# File (shown below) each line in the file is:
+#        [directory.git]<space>[owner.name]
+# (ignore leading whitespace and perl comment char),
+#   where [owner.name] is a sequence of chars with '+' for a space.
+our $projects_list = "index/index.aux";
+
+# html text to include at home page
+our $home_text = "indextext.html";
+
+# name of your site or organization to appear in page titles
+# replace this with something more descriptive for clearer bookmarks
+our $site_name = $ENV{'SERVER_NAME'} || "Untitled";
+
+# URI of default stylesheet
+our $stylesheet = "gitweb.css";
+
+# default blob_plain mimetype and default charset for text/plain blob
+our $default_blob_plain_mimetype = 'text/plain';
+our $default_text_plain_charset  = undef;
+
+# file to use for guessing MIME types before trying /etc/mime.types
+# (relative to the current git repository)
+our $mimetypes_file = undef;
+
+1;
diff --git a/gitweb/gitweb.cgi b/gitweb/gitweb.cgi
index 9448b72..5251fac 100755
--- a/gitweb/gitweb.cgi
+++ b/gitweb/gitweb.cgi
@@ -15,6 +15,7 @@ use CGI::Carp qw(fatalsToBrowser);
 use Encode;
 use Fcntl ':mode';
 use File::Find qw();
+use Gitweb_customization;
 binmode STDOUT, ':utf8';
 
 our $cgi = new CGI;
@@ -23,14 +24,6 @@ our $my_url = $cgi->url();
 our $my_uri = $cgi->url(-absolute => 1);
 our $rss_link = "";
 
-# core git executable to use
-# this can just be "git" if your webserver has a sensible PATH
-our $GIT = "/usr/bin/git";
-
-# absolute fs-path which will be prepended to the project path
-#our $projectroot = "/pub/scm";
-our $projectroot = "/home/kay/public_html/pub/scm";
-
 # version of the core git binary
 our $git_version = qx($GIT --version) =~ m/git version (.*)$/ ? $1 : "unknown";
 
@@ -43,28 +36,6 @@ if (! -d $git_temp) {
 # target of the home link on top of all pages
 our $home_link = $my_uri;
 
-# name of your site or organization to appear in page titles
-# replace this with something more descriptive for clearer bookmarks
-our $site_name = $ENV{'SERVER_NAME'} || "Untitled";
-
-# html text to include at home page
-our $home_text = "indextext.html";
-
-# URI of default stylesheet
-our $stylesheet = "gitweb.css";
-
-# source of projects list
-#our $projects_list = $projectroot;
-our $projects_list = "index/index.aux";
-
-# default blob_plain mimetype and default charset for text/plain blob
-our $default_blob_plain_mimetype = 'text/plain';
-our $default_text_plain_charset  = undef;
-
-# file to use for guessing MIME types before trying /etc/mime.types
-# (relative to the current git repository)
-our $mimetypes_file = undef;
-
 # input validation and dispatch
 our $action = $cgi->param('a');
 if (defined $action) {
-- 
1.4.2.rc2.gd2da4
