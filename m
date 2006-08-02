From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] gitweb: use single quotes for values replaced by the Makefile
Date: Wed, 02 Aug 2006 13:50:53 -0700
Message-ID: <7vmzamuaj6.fsf@assigned-by-dhcp.cox.net>
References: <20060802192333.GA30861@coredump.intra.peff.net>
	<E1G8N9c-0004GK-Gz@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 02 22:51:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G8NgB-0002Lj-Ag
	for gcvg-git@gmane.org; Wed, 02 Aug 2006 22:51:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751355AbWHBUuz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 Aug 2006 16:50:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751359AbWHBUuz
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Aug 2006 16:50:55 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:19450 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1751355AbWHBUuz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Aug 2006 16:50:55 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060802205054.CFDE12581.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 2 Aug 2006 16:50:54 -0400
To: Jeff King <peff@peff.net>
In-Reply-To: <E1G8N9c-0004GK-Gz@moooo.ath.cx> (Matthias Lederhofer's message
	of "Wed, 2 Aug 2006 22:17:20 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24683>

I understand that (1) "@@FOO@@" is problematic, (2) being able
to run gitweb/gitweb.perl while coming up with improvements is
nice, but (3) not being able to say "/etc/foo/$ENV{SITE_NAME}"
is quite a drawback on the deployment side.

So why don't we use something other than @@, perhaps "++FOO++"?

I'm inclined to take these two patches:

    gitweb: optionally read config from GITWEB_CONFIG (Jeff King)
    gitweb: require $ENV{'GITWEB_CONFIG'} (Matthias Lederhofer)

so on top of them something like this?

-- >8 --
[PATCH] gitweb: do not use @@FOO@@ for replaced tokens

This makes it easier to run gitweb/gitweb.perl without token substitution.
Using @@ makes Perl emit "unintended interpolation" warnings.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 Makefile           |   18 +++++++++---------
 gitweb/gitweb.perl |   18 +++++++++---------
 2 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/Makefile b/Makefile
index a2b4aca..3816ef7 100644
--- a/Makefile
+++ b/Makefile
@@ -584,15 +584,15 @@ git-status: git-commit
 gitweb/gitweb.cgi: gitweb/gitweb.perl
 	rm -f $@ $@+
 	sed -e '1s|#!.*perl|#!$(PERL_PATH_SQ)|' \
-	    -e 's|@@GIT_VERSION@@|$(GIT_VERSION)|g' \
-	    -e 's|@@GIT_BINDIR@@|$(bindir)|g' \
-	    -e 's|@@GITWEB_CONFIG@@|$(GITWEB_CONFIG)|g' \
-	    -e 's|@@GITWEB_SITENAME@@|$(GITWEB_SITENAME)|g' \
-	    -e 's|@@GITWEB_PROJECTROOT@@|$(GITWEB_PROJECTROOT)|g' \
-	    -e 's|@@GITWEB_LIST@@|$(GITWEB_LIST)|g' \
-	    -e 's|@@GITWEB_HOMETEXT@@|$(GITWEB_HOMETEXT)|g' \
-	    -e 's|@@GITWEB_CSS@@|$(GITWEB_CSS)|g' \
-	    -e 's|@@GITWEB_LOGO@@|$(GITWEB_LOGO)|g' \
+	    -e 's|++GIT_VERSION++|$(GIT_VERSION)|g' \
+	    -e 's|++GIT_BINDIR++|$(bindir)|g' \
+	    -e 's|++GITWEB_CONFIG++|$(GITWEB_CONFIG)|g' \
+	    -e 's|++GITWEB_SITENAME++|$(GITWEB_SITENAME)|g' \
+	    -e 's|++GITWEB_PROJECTROOT++|$(GITWEB_PROJECTROOT)|g' \
+	    -e 's|++GITWEB_LIST++|$(GITWEB_LIST)|g' \
+	    -e 's|++GITWEB_HOMETEXT++|$(GITWEB_HOMETEXT)|g' \
+	    -e 's|++GITWEB_CSS++|$(GITWEB_CSS)|g' \
+	    -e 's|++GITWEB_LOGO++|$(GITWEB_LOGO)|g' \
 	    $< >$@+
 	chmod +x $@+
 	mv $@+ $@
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index c7f13e7..3cd2b89 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -18,18 +18,18 @@ use File::Find qw();
 binmode STDOUT, ':utf8';
 
 our $cgi = new CGI;
-our $version = "@@GIT_VERSION@@";
+our $version = "++GIT_VERSION++";
 our $my_url = $cgi->url();
 our $my_uri = $cgi->url(-absolute => 1);
 our $rss_link = "";
 
 # core git executable to use
 # this can just be "git" if your webserver has a sensible PATH
-our $GIT = "@@GIT_BINDIR@@/git";
+our $GIT = "++GIT_BINDIR++/git";
 
 # absolute fs-path which will be prepended to the project path
 #our $projectroot = "/pub/scm";
-our $projectroot = "@@GITWEB_PROJECTROOT@@";
+our $projectroot = "++GITWEB_PROJECTROOT++";
 
 # location for temporary files needed for diffs
 our $git_temp = "/tmp/gitweb";
@@ -39,18 +39,18 @@ our $home_link = $my_uri;
 
 # name of your site or organization to appear in page titles
 # replace this with something more descriptive for clearer bookmarks
-our $site_name = "@@GITWEB_SITENAME@@" || $ENV{'SERVER_NAME'} || "Untitled";
+our $site_name = "++GITWEB_SITENAME++" || $ENV{'SERVER_NAME'} || "Untitled";
 
 # html text to include at home page
-our $home_text = "@@GITWEB_HOMETEXT@@";
+our $home_text = "++GITWEB_HOMETEXT++";
 
 # URI of default stylesheet
-our $stylesheet = "@@GITWEB_CSS@@";
+our $stylesheet = "++GITWEB_CSS++";
 # URI of GIT logo
-our $logo = "@@GITWEB_LOGO@@";
+our $logo = "++GITWEB_LOGO++";
 
 # source of projects list
-our $projects_list = "@@GITWEB_LIST@@";
+our $projects_list = "++GITWEB_LIST++";
 
 # default blob_plain mimetype and default charset for text/plain blob
 our $default_blob_plain_mimetype = 'text/plain';
@@ -60,7 +60,7 @@ # file to use for guessing MIME types be
 # (relative to the current git repository)
 our $mimetypes_file = undef;
 
-our $GITWEB_CONFIG = "@@GITWEB_CONFIG@@";
+our $GITWEB_CONFIG = "++GITWEB_CONFIG++";
 require $GITWEB_CONFIG if -e $GITWEB_CONFIG;
 
 if (defined($ENV{'GITWEB_CONFIG'}) && -e $ENV{'GITWEB_CONFIG'}) {
-- 
1.4.2.rc2.g767b2
