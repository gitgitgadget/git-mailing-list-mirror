From: "John 'Warthog9' Hawley" <warthog9@kernel.org>
Subject: [PATCH 1/6] GITWEB - Load Checking
Date: Thu, 10 Dec 2009 23:45:38 +0000
Message-ID: <1260488743-25855-2-git-send-email-warthog9@kernel.org>
References: <1260488743-25855-1-git-send-email-warthog9@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------1.6.5.2"
Cc: "John 'Warthog9' Hawley" <warthog9@eaglescrag.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 11 00:47:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NIsj3-0005nb-TS
	for gcvg-git-2@lo.gmane.org; Fri, 11 Dec 2009 00:47:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757541AbZLJXq7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Dec 2009 18:46:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757287AbZLJXq6
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Dec 2009 18:46:58 -0500
Received: from hera.kernel.org ([140.211.167.34]:39930 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757343AbZLJXqz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Dec 2009 18:46:55 -0500
Received: from hera.kernel.org (localhost [127.0.0.1])
	by hera.kernel.org (8.14.3/8.14.3) with ESMTP id nBANjt0b025977
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 10 Dec 2009 23:45:56 GMT
Received: (from warthog9@localhost)
	by hera.kernel.org (8.14.3/8.14.2/Submit) id nBANjt4U025976;
	Thu, 10 Dec 2009 23:45:55 GMT
X-Mailer: git-send-email 1.6.5.5
In-Reply-To: <1260488743-25855-1-git-send-email-warthog9@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=AWL,BAYES_05,
	UNPARSEABLE_RELAY autolearn=ham version=3.2.5
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on hera.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135053>

From: John 'Warthog9' Hawley <warthog9@eaglescrag.net>

This is a multi-part message in MIME format.
--------------1.6.5.2
Content-Type: text/plain; charset=UTF-8; format=fixed
Content-Transfer-Encoding: 8bit


This changes the behavior, slightly, of gitweb so that it verifies
that the box isn't inundated with before attempting to serve gitweb.
If the box is overloaded, it basically returns a 503 server unavailable
until the load falls below the defined threshold.  This helps dramatically
if you have a box that's I/O bound, reaches a certain load and you
don't want gitweb, the I/O hog that it is, increasing the pain the
server is already undergoing.

adds $maxload configuration variable.  Default is a load of 300,
which for most cases should never be hit.

Please note this makes the assumption that /proc/loadavg exists
as there is no good way to read load averages on a great number of
platforms [READ: Windows], or that it's reasonably accurate.

Signed-off-by: John 'Warthog9' Hawley <warthog9@eaglescrag.net>
---
 gitweb/gitweb.perl |   24 ++++++++++++++++++++++++
 1 files changed, 24 insertions(+), 0 deletions(-)


--------------1.6.5.2
Content-Type: text/x-patch; name="0001-GITWEB-Load-Checking.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="0001-GITWEB-Load-Checking.patch"

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 7e477af..813e48f 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -221,6 +221,11 @@ our %avatar_size = (
 	'double'  => 32
 );
 
+# Used to set the maximum load that we will still respond to gitweb queries.
+# if we exceed this than we do the processing to figure out if there's a mirror
+# and redirect to it, or to just return 503 server busy
+our $maxload = 300;
+
 # You define site-wide feature defaults here; override them with
 # $GITWEB_CONFIG as necessary.
 our %feature = (
@@ -551,6 +556,25 @@ if (-e $GITWEB_CONFIG) {
 	do $GITWEB_CONFIG_SYSTEM if -e $GITWEB_CONFIG_SYSTEM;
 }
 
+# loadavg throttle
+sub get_loadavg() {
+    my $load;
+    my @loads;
+
+    open($load, '<', '/proc/loadavg') or return 0;
+    @loads = split(/\s+/, scalar <$load>);
+    close($load);
+    return $loads[0];
+}
+
+if (get_loadavg() > $maxload) {
+    print "Content-Type: text/plain\n";
+    print "Status: 503 Excessive load on server\n";
+    print "\n";
+    print "The load average on the server is too high\n";
+    exit 0;
+}
+
 # version of the core git binary
 our $git_version = qx("$GIT" --version) =~ m/git version (.*)$/ ? $1 : "unknown";
 $number_of_git_cmds++;

--------------1.6.5.2--
