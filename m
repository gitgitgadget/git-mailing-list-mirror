From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 2/3] gitweb: Filter out commit ID from @difftree in git_commit and git_commitdiff
Date: Tue, 24 Oct 2006 13:54:49 +0200
Message-ID: <200610241354.49396.jnareb@gmail.com>
References: <200610241349.54685.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Oct 24 13:55:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GcKsV-0005Jy-VE
	for gcvg-git@gmane.org; Tue, 24 Oct 2006 13:55:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030389AbWJXLz0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Oct 2006 07:55:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030397AbWJXLzZ
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Oct 2006 07:55:25 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:25187 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1030389AbWJXLzY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Oct 2006 07:55:24 -0400
Received: by ug-out-1314.google.com with SMTP id 32so174707ugm
        for <git@vger.kernel.org>; Tue, 24 Oct 2006 04:55:14 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=bL1iHG4r7OU3Kpq23WZUYucpfoLXiUO51BkchCSgDXJrHHEAa0L0KavLlJ3VkHrxt/W1h5E1j9vxCQUS6HeQGQm+0QGK9NbOSMc6vdB3x2noxAjzVe1u7Y1RG3bGEX1zjjGe5Y7xzy3jg4LOEF2p/e9L7ROomLh+Oa/ZgIxM+E0=
Received: by 10.66.220.17 with SMTP id s17mr8656966ugg;
        Tue, 24 Oct 2006 04:55:14 -0700 (PDT)
Received: from host-81-190-23-110.torun.mm.pl ( [81.190.23.110])
        by mx.google.com with ESMTP id b35sm582575ugd.2006.10.24.04.55.13;
        Tue, 24 Oct 2006 04:55:14 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <200610241349.54685.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29972>

Filter out commit ID output that git-diff-tree adds when called with
only one <tree-ish> (not only for --stdin) in git_commit and
git_commitdiff.

This also works with older git versions, which doesn't have
--no-commit-id option to git-diff-tree.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.perl |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 8ac60be..a88e0a8 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3009,6 +3009,9 @@ sub git_commit {
 	my @difftree = map { chomp; $_ } <$fd>;
 	close $fd or die_error(undef, "Reading git-diff-tree failed");
 
+	# filter out commit ID output
+	@difftree = grep(!/^[0-9a-fA-F]{40}$/, @difftree);
+
 	# non-textual hash id's can be cached
 	my $expires;
 	if ($hash =~ m/^[0-9a-fA-F]{40}$/) {
@@ -3327,7 +3330,9 @@ sub git_commitdiff {
 		while (chomp(my $line = <$fd>)) {
 			# empty line ends raw part of diff-tree output
 			last unless $line;
-			push @difftree, $line;
+			# filter out commit ID output
+			push @difftree, $line
+				unless $line =~ m/^[0-9a-fA-F]{40}$/;
 		}
 
 	} elsif ($format eq 'plain') {
-- 
1.4.2.1
