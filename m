From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH] import-tars: separate author from committer
Date: Fri, 20 Mar 2009 10:57:50 +0100
Message-ID: <1237543070-4909-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Junio C Hamano <junkio@cox.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 20 10:59:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkbW5-0006vt-Ud
	for gcvg-git-2@gmane.org; Fri, 20 Mar 2009 10:59:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751614AbZCTJ60 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2009 05:58:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751283AbZCTJ6Y
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Mar 2009 05:58:24 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:32808 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751080AbZCTJ6Y (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2009 05:58:24 -0400
Received: by fxm2 with SMTP id 2so832315fxm.37
        for <git@vger.kernel.org>; Fri, 20 Mar 2009 02:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=Uff9Xg7Fy1h6wnpBPsu92dQpBU5Z96N6LdSiwKBnlvo=;
        b=n4n9WsIwUJbw8ntNxBq/vcY2Gr3x10E/mXABYHXAmcPEs9ABejihE7Dp9se4BGaPSy
         zbuo/E3OaQIF0ipbqEM+wZz649LmnYydK8V+WBT7UQyDuOx2cYd92ZaI+R5TtFx986ot
         E8I4EPQT1GFMtE+xSp37HjjnEzBk6QIfZwGJU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=nFwWVlwrisb9yobceJmzS1oorBeYL96BZBttkzhWaMdjOVMzGKa8cfLDwDRKfKMQ57
         oGTRkR/tyO//Uk0wth+eJdp1I6qlGt9nZXi4zzXmtYmcwZ6pHxsgUH2D0l59VRl2EzWX
         PDhNjJG/OQKtbGiGF5JkEPv1GFTY7c2GkuRTg=
Received: by 10.86.71.1 with SMTP id t1mr1302449fga.36.1237543101058;
        Fri, 20 Mar 2009 02:58:21 -0700 (PDT)
Received: from localhost ([94.37.14.72])
        by mx.google.com with ESMTPS id 12sm1697079fgg.12.2009.03.20.02.58.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 20 Mar 2009 02:58:20 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.254.g84bde
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113929>

The import-tars script is typically employed to (re)create the past
history of a project from stored tars. Although assigning authorship in
these cases can be a somewhat arbitrary process, it makes sense to set
the author to whoever created the tars in the first place (if it's
known), and (s)he can in general be different from the committer
(whoever is running the script).

Implement this by having separate author and committer data, making them
settable from the usual GIT_* environment variables.
---

Or should I have made the ENV access a separate patch?

 contrib/fast-import/import-tars.perl |   16 +++++++++++-----
 1 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/contrib/fast-import/import-tars.perl b/contrib/fast-import/import-tars.perl
index 23aeb25..6309d14 100755
--- a/contrib/fast-import/import-tars.perl
+++ b/contrib/fast-import/import-tars.perl
@@ -14,13 +14,18 @@ die "usage: import-tars *.tar.{gz,bz2,Z}\n" unless @ARGV;
 
 my $branch_name = 'import-tars';
 my $branch_ref = "refs/heads/$branch_name";
-my $committer_name = 'T Ar Creator';
-my $committer_email = 'tar@example.com';
+my $author_name = $ENV{'GIT_AUTHOR_NAME'} || 'T Ar Creator';
+my $author_email = $ENV{'GIT_AUTHOR_EMAIL'} || 'tar@example.com';
+my $committer_name = $ENV{'GIT_COMMITTER_NAME'} || `git config --get user.name`;
+my $committer_email = $ENV{'GIT_COMMITTER_EMAIL'} || `git config --get user.email`;
+
+chomp($committer_name, $committer_email);
 
 open(FI, '|-', 'git', 'fast-import', '--quiet')
 	or die "Unable to start git fast-import: $!\n";
 foreach my $tar_file (@ARGV)
 {
+	my $commit_time = time;
 	$tar_file =~ m,([^/]+)$,;
 	my $tar_name = $1;
 
@@ -39,7 +44,7 @@ foreach my $tar_file (@ARGV)
 		die "Unrecognized compression format: $tar_file\n";
 	}
 
-	my $commit_time = 0;
+	my $author_time = 0;
 	my $next_mark = 1;
 	my $have_top_dir = 1;
 	my ($top_dir, %files);
@@ -92,7 +97,7 @@ foreach my $tar_file (@ARGV)
 		}
 		$files{$path} = [$next_mark++, $mode];
 
-		$commit_time = $mtime if $mtime > $commit_time;
+		$author_time = $mtime if $mtime > $author_time;
 		$path =~ m,^([^/]+)/,;
 		$top_dir = $1 unless $top_dir;
 		$have_top_dir = 0 if $top_dir ne $1;
@@ -100,6 +105,7 @@ foreach my $tar_file (@ARGV)
 
 	print FI <<EOF;
 commit $branch_ref
+author $author_name <$author_email> $author_time +0000
 committer $committer_name <$committer_email> $commit_time +0000
 data <<END_OF_COMMIT_MESSAGE
 Imported from $tar_file.
@@ -119,7 +125,7 @@ EOF
 	print FI <<EOF;
 tag $tar_name
 from $branch_ref
-tagger $committer_name <$committer_email> $commit_time +0000
+tagger $author_name <$author_email> $author_time +0000
 data <<END_OF_TAG_MESSAGE
 Package $tar_name
 END_OF_TAG_MESSAGE
-- 
1.6.2.254.g84bde
