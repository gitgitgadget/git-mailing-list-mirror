From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH (amend)] gitweb: Check if requested object exists
Date: Sat, 12 May 2007 21:16:34 +0200
Message-ID: <200705122116.34486.jnareb@gmail.com>
References: <200705120135.30150.jnareb@gmail.com> <7vzm4a7sv3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun May 13 01:54:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hn1QJ-0007N7-T8
	for gcvg-git@gmane.org; Sun, 13 May 2007 01:54:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755569AbXELXys (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 12 May 2007 19:54:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755470AbXELXys
	(ORCPT <rfc822;git-outgoing>); Sat, 12 May 2007 19:54:48 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:43729 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755569AbXELXyr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 May 2007 19:54:47 -0400
Received: by ug-out-1314.google.com with SMTP id 44so1071310uga
        for <git@vger.kernel.org>; Sat, 12 May 2007 16:54:46 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-disposition:message-id:content-type:content-transfer-encoding;
        b=Xih9Gy/I9/i8X5M01K63CWOs0KKcY9DrdZuXAyMwe2LAOx+TbZLJGQhWFKZO67HfweKRcDrrU5CdWxrw8Q++f+QFCKUuvbjHPJS34Su47YT6DLQ8UxXs9GilqWtLJvSsNLib2HJgV6T4zZnrTb47vsFe7OTrvE5DyDdKcE8vuwU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-disposition:message-id:content-type:content-transfer-encoding;
        b=WDlwHIALl4sJ4KLTkxww5Z0zCCxBvUktoeLp9kM5BLmquGUcwk4+exX5S/q/gayOce4xURf6nmk9f2grQqsxJrrQF3SJ6i58tc9pEjOcBV5mDqIaW9kmoDg7FyROj3SM+erR5tTMZ+/2GgeeFH/3Yirr9rZlBuKQvPnUhrBWtOQ=
Received: by 10.67.98.9 with SMTP id a9mr2306048ugm.1179014086072;
        Sat, 12 May 2007 16:54:46 -0700 (PDT)
Received: from host-89-229-25-173.torun.mm.pl ( [89.229.25.173])
        by mx.google.com with ESMTP id u6sm10568381uge.2007.05.12.16.54.44;
        Sat, 12 May 2007 16:54:45 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <7vzm4a7sv3.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47111>

Try to avoid "Use of uninitialized value ..." errors caused by bad
revision, incorrect filename, wrong object id, bad file etc. (wrong
value of 'h', 'hb', 'f', etc. parameters). This avoids polluting web
server errors log.

Correct git_get_hash_by_path and parse_commit_text (and, in turn,
parse_commit) to return undef if object does not exist.  Check in
git_tag if requested tag exists.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This patch is replacement of earlier "bandaid" patch

  [PATCH] gitweb: Avoid "Use of uninitialized value" errors (written to logs)
  Message-Id: <200705120135.30150.jnareb@gmail.com>

This one tries to cure causes, not put bandaid over symptoms.
It also passes my gitweb test.

One thing that is left is to fix "Use of initialized value..." warnings
for empty repositories (initialized, but without any commits). But I
don't think that this corner case is terribly important.

 gitweb/gitweb.perl |   16 +++++++++++++++-
 1 files changed, 15 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 21864c6..74556f7 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1060,6 +1060,11 @@ sub git_get_hash_by_path {
 	my $line = <$fd>;
 	close $fd or return undef;
 
+	if (!defined $line) {
+		# there is no tree or hash given by $path at $base
+		return undef;
+	}
+
 	#'100644 blob 0fa3f3a66fb6a137f6ec2c19351ed4d807070ffa	panic.c'
 	$line =~ m/^([0-9]+) (.+) ([0-9a-fA-F]{40})\t/;
 	if (defined $type && $type ne $2) {
@@ -1376,8 +1381,12 @@ sub parse_commit_text {
 
 	pop @commit_lines; # Remove '\0'
 
+	if (! @commit_lines) {
+		return;
+	}
+
 	my $header = shift @commit_lines;
-	if (!($header =~ m/^[0-9a-fA-F]{40}/)) {
+	if ($header !~ m/^[0-9a-fA-F]{40}/) {
 		return;
 	}
 	($co{'id'}, my @parents) = split ' ', $header;
@@ -3409,6 +3418,11 @@ sub git_tag {
 	git_header_html();
 	git_print_page_nav('','', $head,undef,$head);
 	my %tag = parse_tag($hash);
+
+	if (! %tag) {
+		die_error(undef, "Unknown tag object");
+	}
+
 	git_print_header_div('commit', esc_html($tag{'name'}), $hash);
 	print "<div class=\"title_text\">\n" .
 	      "<table cellspacing=\"0\">\n" .
-- 
1.5.1.4
