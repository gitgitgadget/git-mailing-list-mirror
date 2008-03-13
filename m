From: Marc-Andre Lureau <marcandre.lureau@gmail.com>
Subject: [PATCH] git-cvsimport: fix initial checkout
Date: Thu, 13 Mar 2008 21:09:38 +0200
Message-ID: <1205435378-10411-1-git-send-email-marcandre.lureau@gmail.com>
Cc: Martin Langhoff <martin@catalyst.net.nz>,
	Marc-Andre Lureau <marcandre.lureau@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 13 20:10:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZsp2-0000JH-DV
	for gcvg-git-2@gmane.org; Thu, 13 Mar 2008 20:10:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753494AbYCMTJ5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Mar 2008 15:09:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754133AbYCMTJ5
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Mar 2008 15:09:57 -0400
Received: from mu-out-0910.google.com ([209.85.134.189]:24067 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752409AbYCMTJ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Mar 2008 15:09:56 -0400
Received: by mu-out-0910.google.com with SMTP id i10so9104984mue.5
        for <git@vger.kernel.org>; Thu, 13 Mar 2008 12:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer;
        bh=jAWy3jnsjDfveo13OMpRQqBIkrJIkcU7SeMlWBSm2AI=;
        b=Orwv1sG5QcguC84AJM2swF91HQ2Tpk6EiyklFMe1jIs7rKlTVtOjqd9FFBQrYq1ItS6lqvywvidvRyZtbdca7ZoMw+gO6PqzwqjDQAr+UxDQgS5h/RfJ7c2m+cMuBc9xxRJ1yEvC7IVpXfr3Vj5ecD7/2I1yhg0S7j7e4L3JgGU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=CnuZRvcadFeAOUUgCwKKxngANNbidcSVcFz5a4doSYNV0ZmEPve+KZczMH2G6yvARsRl9V/8dBo6ENzlddYaYrzQek7LpyqlaIoELsMDPWqpnFWYVzkND6J7a0MhJTs9kBXJEBJ9VevsJ7fnJUYEn0iVQhMpfm8wKlQ2KZcm0j0=
Received: by 10.78.100.1 with SMTP id x1mr27239673hub.47.1205435392575;
        Thu, 13 Mar 2008 12:09:52 -0700 (PDT)
Received: from localhost ( [88.113.0.245])
        by mx.google.com with ESMTPS id c24sm536752ika.10.2008.03.13.12.09.43
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 13 Mar 2008 12:09:49 -0700 (PDT)
X-Mailer: git-send-email 1.5.4.4.534.gfb90c.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77130>

git-symbolic-ref HEAD returns master reference, even if the file does
not exists. That prevents the initial checkout and fails in
git-rev-parse. The patch checks the existence of the reference file
before assuming an original branch exists. There might be better
solutions than checking file existence.
---
 git-cvsimport.perl |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index 95c5eec..1512fe4 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -570,12 +570,16 @@ unless (-d $git_dir) {
 	open(F, "git-symbolic-ref HEAD |") or
 		die "Cannot run git-symbolic-ref: $!\n";
 	chomp ($last_branch = <F>);
-	$last_branch = basename($last_branch);
-	close(F);
-	unless ($last_branch) {
+	if (-f "$git_dir/$last_branch") {
+	    $last_branch = basename($last_branch);
+	    unless ($last_branch) {
 		warn "Cannot read the last branch name: $! -- assuming 'master'\n";
 		$last_branch = "master";
+	    }
+	} else {
+	    $last_branch = "";
 	}
+	close(F);
 	$orig_branch = $last_branch;
 	$tip_at_start = `git-rev-parse --verify HEAD`;
 
@@ -953,6 +957,7 @@ while (<CVS>) {
 		print "* UNKNOWN LINE * $_\n";
 	}
 }
+
 commit() if $branch and $state != 11;
 
 unless ($opt_P) {
-- 
1.5.4.4.534.gfb90c.dirty
