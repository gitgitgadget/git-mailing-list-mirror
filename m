From: "John 'Warthog9' Hawley" <warthog9@kernel.org>
Subject: [PATCH 2/6] GITWEB - Missmatching git w/ gitweb
Date: Thu, 10 Dec 2009 23:45:39 +0000
Message-ID: <1260488743-25855-3-git-send-email-warthog9@kernel.org>
References: <1260488743-25855-1-git-send-email-warthog9@kernel.org>
 <1260488743-25855-2-git-send-email-warthog9@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------1.6.5.2"
Cc: "John 'Warthog9' Hawley" <warthog9@eaglescrag.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 11 00:47:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NIsj3-0005nb-D7
	for gcvg-git-2@lo.gmane.org; Fri, 11 Dec 2009 00:47:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757493AbZLJXq5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Dec 2009 18:46:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757287AbZLJXq4
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Dec 2009 18:46:56 -0500
Received: from hera.kernel.org ([140.211.167.34]:39923 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757067AbZLJXqy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Dec 2009 18:46:54 -0500
Received: from hera.kernel.org (localhost [127.0.0.1])
	by hera.kernel.org (8.14.3/8.14.3) with ESMTP id nBANjuof025983
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 10 Dec 2009 23:45:56 GMT
Received: (from warthog9@localhost)
	by hera.kernel.org (8.14.3/8.14.2/Submit) id nBANjuII025982;
	Thu, 10 Dec 2009 23:45:56 GMT
X-Mailer: git-send-email 1.6.5.5
In-Reply-To: <1260488743-25855-2-git-send-email-warthog9@kernel.org>
X-Spam-Status: No, score=-2.2 required=5.0 tests=AWL,BAYES_00,
	UNPARSEABLE_RELAY autolearn=ham version=3.2.5
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on hera.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135051>

From: John 'Warthog9' Hawley <warthog9@eaglescrag.net>

This is a multi-part message in MIME format.
--------------1.6.5.2
Content-Type: text/plain; charset=UTF-8; format=fixed
Content-Transfer-Encoding: 8bit


This adds $missmatch_git so that gitweb can run with a miss-matched
git install.  Gitweb, generally, runs fine on a very broad range of
git versions, but it's not always practicle or useful to upgrade it
every time you upgrade git.

This allows the administrator to realize they are miss-matched, and
should they be so inclined, disable the check entirely and run in
a miss-matched fasion.

This is more here to give an obvious warning as to whats going on
vs. silently failing.

Signed-off-by: John 'Warthog9' Hawley <warthog9@eaglescrag.net>
---
 gitweb/gitweb.perl |   22 ++++++++++++++++++++++
 1 files changed, 22 insertions(+), 0 deletions(-)


--------------1.6.5.2
Content-Type: text/x-patch; name="0002-GITWEB-Missmatching-git-w-gitweb.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="0002-GITWEB-Missmatching-git-w-gitweb.patch"

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 813e48f..d84f4c0 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -221,6 +221,9 @@ our %avatar_size = (
 	'double'  => 32
 );
 
+# This is here to allow for missmatch git & gitweb versions
+our $missmatch_git = '';
+
 # Used to set the maximum load that we will still respond to gitweb queries.
 # if we exceed this than we do the processing to figure out if there's a mirror
 # and redirect to it, or to just return 503 server busy
@@ -579,6 +582,25 @@ if (get_loadavg() > $maxload) {
 our $git_version = qx("$GIT" --version) =~ m/git version (.*)$/ ? $1 : "unknown";
 $number_of_git_cmds++;
 
+# There's a pretty serious flaw that we silently fail if git doesn't find something it needs
+# a quick and simple check is to have gitweb do a simple check - are we running on the same
+# version of git that we shipped with - if not, throw up an error so that people doing
+# first installs don't have to debug perl to figure out whats going on
+if (
+	$git_version ne $version
+	&&
+	$missmatch_git eq ''
+){
+	git_header_html();
+	print "<p><b>*** Warning ***</b></p>\n";
+	print "<p>\n";
+	print "This version of gitweb was compiled for <b>$version</b> however git version <b>$git_version</b> was found<br/>\n";
+	print "If you are sure this version of git works with this version of gitweb - please define <b>\$missmatch_git</b> to a non empty string in your git config file.\n";
+	print "</p>\n";
+	git_footer_html();
+	exit;
+}
+
 $projects_list ||= $projectroot;
 
 # ======================================================================

--------------1.6.5.2--
