From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 5/7] gitweb: Added parse_difftree_raw_line function for later use
Date: Thu, 17 Aug 2006 11:21:26 +0200
Message-ID: <11558064893592-git-send-email-jnareb@gmail.com>
References: <11558064883957-git-send-email-jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 17 11:22:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GDe4e-0002Cb-AJ
	for gcvg-git@gmane.org; Thu, 17 Aug 2006 11:22:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932465AbWHQJVn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 Aug 2006 05:21:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932459AbWHQJVm
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Aug 2006 05:21:42 -0400
Received: from mail.fuw.edu.pl ([193.0.80.14]:19336 "EHLO mail.fuw.edu.pl")
	by vger.kernel.org with ESMTP id S932460AbWHQJVj (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Aug 2006 05:21:39 -0400
Received: from front.fuw.edu.pl (front.fuw.edu.pl [193.0.83.59])
	by mail.fuw.edu.pl (8.13.6/8.13.6) with ESMTP id k7H9KPjP023252
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 17 Aug 2006 11:20:27 +0200
Received: from front.fuw.edu.pl (IDENT:10582@localhost [127.0.0.1])
	by front.fuw.edu.pl (8.13.3/8.12.4) with ESMTP id k7H9LTTH003713;
	Thu, 17 Aug 2006 11:21:29 +0200
Received: (from jnareb@localhost)
	by front.fuw.edu.pl (8.13.3/8.12.4/Submit) id k7H9LT5o003712;
	Thu, 17 Aug 2006 11:21:29 +0200
To: git@vger.kernel.org
X-Mailer: git-send-email 1.3.0
In-Reply-To: <11558064883957-git-send-email-jnareb@gmail.com>
X-Scanned-By: MIMEDefang 2.56 on 193.0.80.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25567>

Adds parse_difftree_raw_line function which parses one line of "raw"
format diff-tree output into a hash.

For later use in git_difftree_body, git_commitdiff and
git_commitdiff_plain, git_search.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.perl |   27 +++++++++++++++++++++++++++
 1 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index d37e7f1..b3f38bf 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -851,6 +851,33 @@ sub parse_ref {
 	return %ref_item;
 }
 
+sub parse_difftree_raw_line {
+	my $line = shift;
+	my %res;
+
+	# ':100644 100644 03b218260e99b78c6df0ed378e59ed9205ccc96d 3b93d5e7cc7f7dd4ebed13a5cc1a4ad976fc94d8 M	ls-files.c'
+	# ':100644 100644 7f9281985086971d3877aca27704f2aaf9c448ce bc190ebc71bbd923f2b728e505408f5e54bd073a M	rev-tree.c'
+	if ($line =~ m/^:([0-7]{6}) ([0-7]{6}) ([0-9a-fA-F]{40}) ([0-9a-fA-F]{40}) (.)([0-9]{0,3})\t(.*)$/) {
+		$res{'from_mode'} = $1;
+		$res{'to_mode'} = $2;
+		$res{'from_id'} = $3;
+		$res{'to_id'} = $4;
+		$res{'status'} = $5;
+		$res{'similarity'} = $6;
+		if ($res{'status'} eq 'R' || $res{'status'} eq 'C') { # renamed or copied
+			($res{'from_file'}, $res{'to_file'}) = map(unquote, split("\t", $7));
+		} else {
+			$res{'file'} = unquote($7);
+		}
+	}
+	# 'c512b523472485aef4fff9e57b229d9d243c967f'
+	#elsif ($line =~ m/^([0-9a-fA-F]{40})$/) {
+	#	$res{'commit'} = $1;
+	#}
+
+	return wantarray ? %res : \%res;
+}
+
 ## ......................................................................
 ## parse to array of hashes functions
 
-- 
1.4.1.1
