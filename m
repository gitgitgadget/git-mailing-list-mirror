From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 1/5] gitweb: Fix error in git_patchest_body for file creation/deletion patch
Date: Sun,  7 Jan 2007 02:52:23 +0100
Message-ID: <1168134751748-git-send-email-jnareb@gmail.com>
References: <100171.86639.qm@web31814.mail.mud.yahoo.com>
Cc: Luben Tuikov <ltuikov@yahoo.com>, Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 07 02:52:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3NDI-0001C8-6h
	for gcvg-git@gmane.org; Sun, 07 Jan 2007 02:52:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932315AbXAGBwc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 6 Jan 2007 20:52:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932314AbXAGBwc
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Jan 2007 20:52:32 -0500
Received: from nf-out-0910.google.com ([64.233.182.191]:5836 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932308AbXAGBwb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jan 2007 20:52:31 -0500
Received: by nf-out-0910.google.com with SMTP id o25so8960302nfa
        for <git@vger.kernel.org>; Sat, 06 Jan 2007 17:52:30 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=oTE7iUEndOeq3v15euVJePSHlGXXL9Lj4XS4JowxorcIQzejy+RJMnCLFCDjnHSeII8NebbEUoJCLY2eEueswnGnUXnp/1jcrshobkgPR8d38yjEhiGs8IkAdqwY0fb/eJc2ejpxTNmem3+kJdqU8YtE1o1OMU1QkABU9l77nCo=
Received: by 10.49.13.14 with SMTP id q14mr26607988nfi.1168134750158;
        Sat, 06 Jan 2007 17:52:30 -0800 (PST)
Received: from roke.D-201 ( [81.190.18.145])
        by mx.google.com with ESMTP id r33sm101828946nfc.2007.01.06.17.52.29;
        Sat, 06 Jan 2007 17:52:29 -0800 (PST)
Received: from roke.D-201 (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id l071qVkg007248;
	Sun, 7 Jan 2007 02:52:32 +0100
Received: (from jnareb@localhost)
	by roke.D-201 (8.13.4/8.13.4/Submit) id l071qV19007247;
	Sun, 7 Jan 2007 02:52:31 +0100
To: git@vger.kernel.org
X-Mailer: git-send-email 1.4.4.3
In-Reply-To: <100171.86639.qm@web31814.mail.mud.yahoo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36110>

$from_id, $to_id variables should be local per PATCH.

Fix error in git_patchset_body for file creation (deletion) patches,
where instead of /dev/null as from-file (to-file) diff header line, it
had link to previous file with current file name.  This error occured
only if there was another patch before file creation (deletion) patch.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Luben Tuikov wrote:

> The second bug is displaying a renamed file with the
> same name as the one of the preceding "patch". Saw
> this one today when I pulled.
> 
> To exhibit these, you need to "commitdiff" a commit
> which has at least one rename and at least one regular
> diff preceding the rename.

I think this should also fix this bug.

 gitweb/gitweb.perl |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 7906280..04c8015 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2378,7 +2378,6 @@ sub git_patchset_body {
 	my $patch_line;
 	my $diffinfo;
 	my (%from, %to);
-	my ($from_id, $to_id);
 
 	print "<div class=\"patchset\">\n";
 
@@ -2392,6 +2391,7 @@ sub git_patchset_body {
  PATCH:
 	while ($patch_line) {
 		my @diff_header;
+		my ($from_id, $to_id);
 
 		# git diff header
 		#assert($patch_line =~ m/^diff /) if DEBUG;
@@ -2439,11 +2439,15 @@ sub git_patchset_body {
 				$from{'href'} = href(action=>"blob", hash_base=>$hash_parent,
 				                     hash=>$diffinfo->{'from_id'},
 				                     file_name=>$from{'file'});
+			} else {
+				delete $from{'href'};
 			}
 			if ($diffinfo->{'status'} ne "D") { # not deleted file
 				$to{'href'} = href(action=>"blob", hash_base=>$hash,
 				                   hash=>$diffinfo->{'to_id'},
 				                   file_name=>$to{'file'});
+			} else {
+				delete $to{'href'};
 			}
 			# this is first patch for raw difftree line with $patch_idx index
 			# we index @$difftree array from 0, but number patches from 1
-- 
1.4.4.3
