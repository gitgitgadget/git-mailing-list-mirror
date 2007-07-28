From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] gitweb: Simplify 'opt' parameter validation, add "no merges" feeds
Date: Sat, 28 Jul 2007 16:27:32 +0200
Message-ID: <11856328582066-git-send-email-jnareb@gmail.com>
Cc: Luben Tuikov <ltuikov@yahoo.com>, Petr Baudis <pasky@suse.cz>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 28 16:28:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEnH0-00071f-21
	for gcvg-git@gmane.org; Sat, 28 Jul 2007 16:28:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751857AbXG1O15 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 28 Jul 2007 10:27:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751900AbXG1O1p
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Jul 2007 10:27:45 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:40603 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751831AbXG1O1n (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jul 2007 10:27:43 -0400
Received: by ug-out-1314.google.com with SMTP id j3so836246ugf
        for <git@vger.kernel.org>; Sat, 28 Jul 2007 07:27:42 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:received:from:to:cc:subject:date:message-id:x-mailer;
        b=JK2aAhB7m0h7JvzgFrz4MfbDLRPc7hFZ7m+Ej7ePULFMF4XNmxPMSRkl2nVVYuDpNLHDyBreTbKN8our/1OzqkvnQlf8tMw+dXHKmKC/+cigNQ5v5c76vKCdUC8+3AUauILmpMpkXSoiQK7kJgEukpaQX+mj38b2eaWBk1PPNik=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:subject:date:message-id:x-mailer;
        b=dyCQgScyiFSQoMCIDgQPX6y53gVqcePAiL98waa6/xoOEe7JJZWNmOlAAxdMt69F8Sv86hwnDdNBXcD8wjFbp8SYh+J5hnQ+tyjyf/2qAJy1Y7eW2zTPzwk1lZLYjc12G0JG3exTVhK0a9xo1WpZP0XuUup6oZ34+USQB47oOO4=
Received: by 10.67.101.8 with SMTP id d8mr3760154ugm.1185632861944;
        Sat, 28 Jul 2007 07:27:41 -0700 (PDT)
Received: from roke.D-201 ( [89.229.8.65])
        by mx.google.com with ESMTPS id c22sm1736644ika.2007.07.28.07.27.40
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 28 Jul 2007 07:27:41 -0700 (PDT)
Received: from roke.D-201 (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id l6SERe4C023426;
	Sat, 28 Jul 2007 16:27:40 +0200
Received: (from jnareb@localhost)
	by roke.D-201 (8.13.4/8.13.4/Submit) id l6SERcdd023425;
	Sat, 28 Jul 2007 16:27:38 +0200
X-Mailer: git-send-email 1.5.3.rc3.14.g0bd7-dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54036>

Simplify and make more readable validation of 'opt' (extra options)
parameter, using exists($hash{key}) instead of grepping keys of a hash
for value.

Move 'opt' parameter to be the last (for now) in the URL.

Make use of '--no-merges' extra option ('opt') by adding "no merges"
RSS and Atom feeds to the HTML header.  Note that alternate format
links in the RSS and Atom views do not use '--no-merges' option yet!

Adds tests for the 'opt' parameter to t9500-gitweb-standalone-no-errors.sh

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This patch could (and probablu should) be split into four separate
patches: simplify 'opt' parameter validation, move 'opt' parameter
to be last in the generated URL, add tests for 'opt' parameter, and
add an example of using 'opt' parameter in the form of feeds without
merges.  But I wanted to avoid generating micro-commits.

This patch is based on 'master'.

 gitweb/gitweb.perl                     |   17 ++++++++++++-----
 t/t9500-gitweb-standalone-no-errors.sh |   28 ++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+), 5 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index b381692..668be42 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -436,12 +436,11 @@ my %allowed_options = (
 
 our @extra_options = $cgi->param('opt');
 if (defined @extra_options) {
-	foreach(@extra_options)
-	{
-		if (not grep(/^$_$/, keys %allowed_options)) {
+	foreach my $opt (@extra_options) {
+		if (not exists $allowed_options{$opt}) {
 			die_error(undef, "Invalid option parameter");
 		}
-		if (not grep(/^$action$/, @{$allowed_options{$_}})) {
+		if (not grep(/^$action$/, @{$allowed_options{$opt}})) {
 			die_error(undef, "Invalid option parameter for this action");
 		}
 	}
@@ -598,7 +597,6 @@ sub href(%) {
 		action => "a",
 		file_name => "f",
 		file_parent => "fp",
-		extra_options => "opt",
 		hash => "h",
 		hash_parent => "hp",
 		hash_base => "hb",
@@ -608,6 +606,7 @@ sub href(%) {
 		searchtext => "s",
 		searchtype => "st",
 		snapshot_format => "sf",
+		extra_options => "opt",
 	);
 	my %mapping = @mapping;
 
@@ -2267,9 +2266,17 @@ EOF
 		printf('<link rel="alternate" title="%s log RSS feed" '.
 		       'href="%s" type="application/rss+xml" />'."\n",
 		       esc_param($project), href(action=>"rss"));
+		printf('<link rel="alternate" title="%s log RSS feed (no merges)" '.
+		       'href="%s" type="application/rss+xml" />'."\n",
+		       esc_param($project), href(action=>"rss",
+		                                 extra_options=>"--no-merges"));
 		printf('<link rel="alternate" title="%s log Atom feed" '.
 		       'href="%s" type="application/atom+xml" />'."\n",
 		       esc_param($project), href(action=>"atom"));
+		printf('<link rel="alternate" title="%s log Atom feed (no merges)" '.
+		       'href="%s" type="application/atom+xml" />'."\n",
+		       esc_param($project), href(action=>"atom",
+		                                 extra_options=>"--no-merges"));
 	} else {
 		printf('<link rel="alternate" title="%s projects list" '.
 		       'href="%s" type="text/plain; charset=utf-8"/>'."\n",
diff --git a/t/t9500-gitweb-standalone-no-errors.sh b/t/t9500-gitweb-standalone-no-errors.sh
index d948724..fa32598 100755
--- a/t/t9500-gitweb-standalone-no-errors.sh
+++ b/t/t9500-gitweb-standalone-no-errors.sh
@@ -521,4 +521,32 @@ test_expect_success \
 	'gitweb_run "p=.git;a=log"'
 test_debug 'cat gitweb.log'
 
+# ----------------------------------------------------------------------
+# extra options
+
+test_expect_success \
+	'opt: log --no-merges' \
+	'gitweb_run "p=.git;a=log;opt=--no-merges"'
+test_debug 'cat gitweb.log'
+
+test_expect_success \
+	'opt: atom --no-merges' \
+	'gitweb_run "p=.git;a=log;opt=--no-merges"'
+test_debug 'cat gitweb.log'
+
+test_expect_success \
+	'opt: "file" history --no-merges' \
+	'gitweb_run "p=.git;a=history;f=file;opt=--no-merges"'
+test_debug 'cat gitweb.log'
+
+test_expect_success \
+	'opt: log --no-such-option (invalid option)' \
+	'gitweb_run "p=.git;a=log;opt=--no-such-option"'
+test_debug 'cat gitweb.log'
+
+test_expect_success \
+	'opt: tree --no-merges (invalid option for action)' \
+	'gitweb_run "p=.git;a=tree;opt=--no-merges"'
+test_debug 'cat gitweb.log'
+
 test_done
-- 
1.5.2.4
