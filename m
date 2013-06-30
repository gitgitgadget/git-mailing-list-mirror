From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH/RFC 3/4] contrib: contacts: add ability to parse from committish
Date: Sun, 30 Jun 2013 07:08:31 -0400
Message-ID: <1372590512-21341-4-git-send-email-sunshine@sunshineco.com>
References: <1372590512-21341-1-git-send-email-sunshine@sunshineco.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 30 13:10:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UtFWt-0000lE-03
	for gcvg-git-2@plane.gmane.org; Sun, 30 Jun 2013 13:10:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752057Ab3F3LKo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Jun 2013 07:10:44 -0400
Received: from mail-ie0-f178.google.com ([209.85.223.178]:46007 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752029Ab3F3LKg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Jun 2013 07:10:36 -0400
Received: by mail-ie0-f178.google.com with SMTP id u16so6861771iet.23
        for <git@vger.kernel.org>; Sun, 30 Jun 2013 04:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=jKNS7lgErX8hbKO4VBa6N7EDtdOWUllokiu+WhiccHs=;
        b=ZpY0goXq3t33O+AKS2I0WFoLfrx7+/wzko0VFU9p2QBQ/Br/1wkxTXUcGvBMNC/Bzc
         3xX/h+QbCsJT6Yj3MmEJSXOn7tthpAo7vlkqVArdaLloA0f2ZiM4Ynx5xGT8/mcDwjDc
         5E8kw+lDyuMa73BppReR0Ist+TJvn7ss5LKoDGHRZnFils28qhMCrMTzeNJu2BkmvSZD
         9uHGQKKNq0FrDvJ5vkeR3Yt1+Y3eHxazVfwajbFNuyFXn0ePXD5806INMrI1pzu/znZF
         Nb44Mue4LxCNISvOtd4/Xa3K4zWulpxHBXr/KW7kUEW1+GzuLBsN5YLL1yLrmZ+6jMw+
         D2ng==
X-Received: by 10.50.56.20 with SMTP id w20mr10946774igp.40.1372590635913;
        Sun, 30 Jun 2013 04:10:35 -0700 (PDT)
Received: from localhost.localdomain (user-12l3dfg.cable.mindspring.com. [69.81.181.240])
        by mx.google.com with ESMTPSA id ir8sm7931119igb.6.2013.06.30.04.10.34
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 30 Jun 2013 04:10:35 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.2
In-Reply-To: <1372590512-21341-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229268>

Committishes can be mentioned along with patch files in the same
invocation. For example:

  % git contacts master..feature extra/*.patch

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 contrib/contacts/git-contacts | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/contrib/contacts/git-contacts b/contrib/contacts/git-contacts
index ab11670..abb90a1 100755
--- a/contrib/contacts/git-contacts
+++ b/contrib/contacts/git-contacts
@@ -3,7 +3,7 @@
 # List people who might be interested in a patch.  Useful as the argument to
 # git-send-email --cc-cmd option, and in other situations.
 #
-# Usage: git contacts <file> ...
+# Usage: git contacts <file | rev-list option> ...
 
 use strict;
 use warnings;
@@ -104,8 +104,32 @@ sub commits_from_patch {
 	close $f;
 }
 
+sub commits_from_rev_args {
+	my ($commits, $args) = @_;
+	open my $f, '-|', qw(git rev-list --reverse), @$args or die;
+	while (<$f>) {
+		chomp;
+		my $id = $_;
+		$seen{$id} = 1;
+		open my $g, '-|', qw(git show -C --oneline), $id or die;
+		scan_hunks($commits, $id, $g);
+		close $g;
+	}
+	close $f;
+}
+
+my (@files, @rev_args);
+for (@ARGV) {
+	if (-e) {
+		push @files, $_;
+	} else {
+		push @rev_args, $_;
+	}
+}
+
 my %commits;
-commits_from_patch(\%commits, $_) for (@ARGV);
+commits_from_patch(\%commits, $_) for (@files);
+commits_from_rev_args(\%commits, \@rev_args) if @rev_args;
 import_commits(\%commits);
 
 my %count_per_person;
-- 
1.8.3.2
