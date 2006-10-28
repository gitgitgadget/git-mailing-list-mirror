X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] gitweb: Move git_get_last_activity subroutine earlier
Date: Sat, 28 Oct 2006 19:43:40 +0200
Message-ID: <200610281943.40456.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sat, 28 Oct 2006 17:43:37 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=ZXywoh2uCDlDLRbIPWx+VZmpZaF6ZRJmDfoIbCwrCyPsR2a7bYYl8bhAQ15qTDoeBo3O0zoumUSBjCdXX3izTw+rWES6EMxZSNqpKd89dStQPxgA8xLR+JIlah7SZEwvyGtUV7UDNY/SLjDUwkN74eh2YkfCXSXLIW+WcZ2sClE=
User-Agent: KMail/1.9.3
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30383>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GdsCv-00044e-Gn for gcvg-git@gmane.org; Sat, 28 Oct
 2006 19:42:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751153AbWJ1Rmy (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 28 Oct 2006
 13:42:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751227AbWJ1Rmy
 (ORCPT <rfc822;git-outgoing>); Sat, 28 Oct 2006 13:42:54 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:60706 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1751153AbWJ1Rmx
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 28 Oct 2006 13:42:53 -0400
Received: by ug-out-1314.google.com with SMTP id 32so898341ugm for
 <git@vger.kernel.org>; Sat, 28 Oct 2006 10:42:52 -0700 (PDT)
Received: by 10.66.221.19 with SMTP id t19mr1525149ugg; Sat, 28 Oct 2006
 10:42:52 -0700 (PDT)
Received: from host-81-190-18-116.torun.mm.pl ( [81.190.18.116]) by
 mx.google.com with ESMTP id 34sm858650uga.2006.10.28.10.42.51; Sat, 28 Oct
 2006 10:42:52 -0700 (PDT)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Good test for git-pickaxe (git-blame2).

 gitweb/gitweb.perl |   36 ++++++++++++++++++------------------
 1 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 5f6a562..cbab3c9 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -976,6 +976,24 @@ sub git_get_project_owner {
 	return $owner;
 }
 
+sub git_get_last_activity {
+	my ($path) = @_;
+	my $fd;
+
+	$git_dir = "$projectroot/$path";
+	open($fd, "-|", git_cmd(), 'for-each-ref',
+	     '--format=%(refname) %(committer)',
+	     '--sort=-committerdate',
+	     'refs/heads') or return;
+	my $most_recent = <$fd>;
+	close $fd or return;
+	if ($most_recent =~ / (\d+) [-+][01]\d\d\d$/) {
+		my $timestamp = $1;
+		my $age = time - $timestamp;
+		return ($age, age_string($age));
+	}
+}
+
 sub git_get_references {
 	my $type = shift || "";
 	my %refs;
@@ -1082,24 +1100,6 @@ sub parse_tag {
 	return %tag
 }
 
-sub git_get_last_activity {
-	my ($path) = @_;
-	my $fd;
-
-	$git_dir = "$projectroot/$path";
-	open($fd, "-|", git_cmd(), 'for-each-ref',
-	     '--format=%(refname) %(committer)',
-	     '--sort=-committerdate',
-	     'refs/heads') or return;
-	my $most_recent = <$fd>;
-	close $fd or return;
-	if ($most_recent =~ / (\d+) [-+][01]\d\d\d$/) {
-		my $timestamp = $1;
-		my $age = time - $timestamp;
-		return ($age, age_string($age));
-	}
-}
-
 sub parse_commit {
 	my $commit_id = shift;
 	my $commit_text = shift;
-- 
1.4.3.3
