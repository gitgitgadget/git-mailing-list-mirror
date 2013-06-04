From: benoit.person@gmail.com
Subject: [PATCH] git-remote-mediawiki: use git.pm functions for credentials
Date: Tue,  4 Jun 2013 13:11:32 +0200
Message-ID: <1370344292-7088-1-git-send-email-benoit.person@ensimag.fr>
Cc: celestin.matte@ensimag.fr,
	Benoit Person <benoit.person@ensimag.fr>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 04 13:13:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjpAh-0007oU-JW
	for gcvg-git-2@plane.gmane.org; Tue, 04 Jun 2013 13:12:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753189Ab3FDLM4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Jun 2013 07:12:56 -0400
Received: from mail-ea0-f180.google.com ([209.85.215.180]:35421 "EHLO
	mail-ea0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751026Ab3FDLMy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jun 2013 07:12:54 -0400
Received: by mail-ea0-f180.google.com with SMTP id k10so62909eaj.39
        for <git@vger.kernel.org>; Tue, 04 Jun 2013 04:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=ld7JktfkDkJU7nCEEAjA37bYmnBa/EtS/uJsvj2k+tM=;
        b=roTOHPcubCZmZ8ilLfA6MdjKyr6Efla7kw/cNg201NzobkUOT/t6BKH/aOfmDJcMjI
         ePw9851V/CSnXrI1iuYJfSbuYKvKvjvnzF8swc584R7vIQPuebtWwnq+itDDvZm81HgL
         1uI0iMqhGB2tkTgJfyXEs3lJULt7De7rKT+rR4ESAekWjNPMJR8LiQQ1b/2B16QrwnJ+
         fXWJmvplkz1GCjg1rEYMEa2HvLA6p7LaV/28FcW4oNxI+GsgIi143lNaj5j6F0qJyYyr
         mAjYpsUNorHN4bzeBWH7MY7FxEM+Y9d1dCZMnCpwxbhkMW+S0r+JUBdDh75TjkY+VqPZ
         H8XA==
X-Received: by 10.14.47.136 with SMTP id t8mr26424837eeb.47.1370344372035;
        Tue, 04 Jun 2013 04:12:52 -0700 (PDT)
Received: from localhost.localdomain (ip-54.net-81-220-163.rev.numericable.fr. [81.220.163.54])
        by mx.google.com with ESMTPSA id y10sm91077830eev.3.2013.06.04.04.12.50
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 04 Jun 2013 04:12:51 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.7.gc2f33ed.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226340>

From: Benoit Person <benoit.person@ensimag.fr>

In 52dce6d, a new credential function was added to git.pm, based on
git-remote-mediawiki's functions. The logical follow-up is to use
those functions in git-remote-mediawiki.

Signed-off-by: Benoit Person <benoit.person@ensimag.fr>
Signed-off-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
---
 contrib/mw-to-git/git-remote-mediawiki.perl | 66 ++++-------------------------
 1 file changed, 9 insertions(+), 57 deletions(-)

diff --git a/contrib/mw-to-git/git-remote-mediawiki.perl b/contrib/mw-to-git/git-remote-mediawiki.perl
index 9c14c1f..9fb281e 100755
--- a/contrib/mw-to-git/git-remote-mediawiki.perl
+++ b/contrib/mw-to-git/git-remote-mediawiki.perl
@@ -13,6 +13,7 @@
 
 use strict;
 use MediaWiki::API;
+use Git;
 use DateTime::Format::ISO8601;
 
 # By default, use UTF-8 to communicate with Git and the user
@@ -156,57 +157,6 @@ while (<STDIN>) {
 
 ########################## Functions ##############################
 
-## credential API management (generic functions)
-
-sub credential_read {
-	my %credential;
-	my $reader = shift;
-	my $op = shift;
-	while (<$reader>) {
-		my ($key, $value) = /([^=]*)=(.*)/;
-		if (not defined $key) {
-			die "ERROR receiving response from git credential $op:\n$_\n";
-		}
-		$credential{$key} = $value;
-	}
-	return %credential;
-}
-
-sub credential_write {
-	my $credential = shift;
-	my $writer = shift;
-	# url overwrites other fields, so it must come first
-	print $writer "url=$credential->{url}\n" if exists $credential->{url};
-	while (my ($key, $value) = each(%$credential) ) {
-		if (length $value && $key ne 'url') {
-			print $writer "$key=$value\n";
-		}
-	}
-}
-
-sub credential_run {
-	my $op = shift;
-	my $credential = shift;
-	my $pid = open2(my $reader, my $writer, "git credential $op");
-	credential_write($credential, $writer);
-	print $writer "\n";
-	close($writer);
-
-	if ($op eq "fill") {
-		%$credential = credential_read($reader, $op);
-	} else {
-		if (<$reader>) {
-			die "ERROR while running git credential $op:\n$_";
-		}
-	}
-	close($reader);
-	waitpid($pid, 0);
-	my $child_exit_status = $? >> 8;
-	if ($child_exit_status != 0) {
-		die "'git credential $op' failed with code $child_exit_status.";
-	}
-}
-
 # MediaWiki API instance, created lazily.
 my $mediawiki;
 
@@ -217,22 +167,24 @@ sub mw_connect_maybe {
 	$mediawiki = MediaWiki::API->new;
 	$mediawiki->{config}->{api_url} = "$url/api.php";
 	if ($wiki_login) {
-		my %credential = (url => $url);
-		$credential{username} = $wiki_login;
-		$credential{password} = $wiki_passwd;
-		credential_run("fill", \%credential);
+		my %credential = (
+			'url' => $url,
+			'username' => $wiki_login,
+			'password' => $wiki_passwd
+		);
+		Git::credential \%credential;
 		my $request = {lgname => $credential{username},
 			       lgpassword => $credential{password},
 			       lgdomain => $wiki_domain};
 		if ($mediawiki->login($request)) {
-			credential_run("approve", \%credential);
+			Git::credential \%credential, 'approve';
 			print STDERR "Logged in mediawiki user \"$credential{username}\".\n";
 		} else {
 			print STDERR "Failed to log in mediawiki user \"$credential{username}\" on $url\n";
 			print STDERR "  (error " .
 				$mediawiki->{error}->{code} . ': ' .
 				$mediawiki->{error}->{details} . ")\n";
-			credential_run("reject", \%credential);
+			Git::credential \%credential, 'reject';
 			exit 1;
 		}
 	}
-- 
1.8.3.rc3.7.gc2f33ed.dirty
