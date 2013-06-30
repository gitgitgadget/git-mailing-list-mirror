From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH/RFC 2/4] contrib: contacts: add support for multiple patches
Date: Sun, 30 Jun 2013 07:08:30 -0400
Message-ID: <1372590512-21341-3-git-send-email-sunshine@sunshineco.com>
References: <1372590512-21341-1-git-send-email-sunshine@sunshineco.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 30 13:10:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UtFWs-0000lE-FT
	for gcvg-git-2@plane.gmane.org; Sun, 30 Jun 2013 13:10:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752055Ab3F3LKn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Jun 2013 07:10:43 -0400
Received: from mail-ie0-f170.google.com ([209.85.223.170]:43412 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752020Ab3F3LKe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Jun 2013 07:10:34 -0400
Received: by mail-ie0-f170.google.com with SMTP id e11so7480307iej.29
        for <git@vger.kernel.org>; Sun, 30 Jun 2013 04:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=HZOzwid/QgFdDIrblLTxWkCNWb9x4LPoy29tTYvX62k=;
        b=tkmOjH6ogh64PTVHxngXBjjKvSXUg7eg/EpV/mumgysPmNuoXxwMHrDOUWo+7H7LAg
         XZLaee8XCTD335f1U+yrG3czvX8j+563yNNJlpBro+sJ8VVXMWz7Zjg7j6jrASm2muqs
         C7+PELnYiZp3A2UNADgaxpH/WYe4dmdEd34Q4NVGYNBQxLcnm+Q3q0g4hh4eTkD7utmz
         vGVCQbIUik1onMx6iPpRiktsmX5XjBP7IK5/rfeMPuwL9VThChriogTcHwzmXMlwll88
         IU8/mdJGa9Q2CduvhdLbjAiLnpdMeMbVdyMgppUGR+E7TmiAAwWC/Csdj8r1jV8Q+iGq
         5TkA==
X-Received: by 10.50.85.114 with SMTP id g18mr11258963igz.14.1372590634207;
        Sun, 30 Jun 2013 04:10:34 -0700 (PDT)
Received: from localhost.localdomain (user-12l3dfg.cable.mindspring.com. [69.81.181.240])
        by mx.google.com with ESMTPSA id ir8sm7931119igb.6.2013.06.30.04.10.32
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 30 Jun 2013 04:10:33 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.2
In-Reply-To: <1372590512-21341-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229267>

Accept multiple patch files rather than only one. For example:

  % git contacts feature/*.patch

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 contrib/contacts/git-contacts | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/contrib/contacts/git-contacts b/contrib/contacts/git-contacts
index 9007bae..ab11670 100755
--- a/contrib/contacts/git-contacts
+++ b/contrib/contacts/git-contacts
@@ -3,7 +3,7 @@
 # List people who might be interested in a patch.  Useful as the argument to
 # git-send-email --cc-cmd option, and in other situations.
 #
-# Usage: git contacts <file>
+# Usage: git contacts <file> ...
 
 use strict;
 use warnings;
@@ -13,6 +13,7 @@ my $since = '5-years-ago';
 my $min_percent = 10;
 my $labels_rx = qr/(?:Signed-off|Reviewed|Acked)-by/;
 my $id_rx = qr/[0-9a-f]{40}/i;
+my %seen;
 
 sub format_contact {
 	my ($name, $email) = @_;
@@ -68,7 +69,9 @@ sub get_blame {
 	while (<$f>) {
 		if (/^$id_rx/o) {
 			my $id = $&;
-			$commits->{$id} = { id => $id, contacts => {} };
+			$commits->{$id} = { id => $id, contacts => {} }
+				unless $seen{$id};
+			$seen{$id} = 1;
 		}
 	}
 	close $f;
@@ -93,6 +96,7 @@ sub commits_from_patch {
 	while (<$f>) {
 		if (/^From ($id_rx) /o) {
 			$id = $1;
+			$seen{$id} = 1;
 			last;
 		}
 	}
@@ -100,10 +104,8 @@ sub commits_from_patch {
 	close $f;
 }
 
-exit 1 unless @ARGV == 1;
-
 my %commits;
-commits_from_patch(\%commits, $ARGV[0]);
+commits_from_patch(\%commits, $_) for (@ARGV);
 import_commits(\%commits);
 
 my %count_per_person;
-- 
1.8.3.2
