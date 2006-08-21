From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 1/2] gitweb: Added parse_difftree_raw_line function for later use
Date: Mon, 21 Aug 2006 23:07:00 +0200
Message-ID: <200608212307.00712.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Mon Aug 21 23:09:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GFH19-0000mQ-2q
	for gcvg-git@gmane.org; Mon, 21 Aug 2006 23:09:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751116AbWHUVJD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 Aug 2006 17:09:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751125AbWHUVJD
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Aug 2006 17:09:03 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:31005 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751116AbWHUVJC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Aug 2006 17:09:02 -0400
Received: by nf-out-0910.google.com with SMTP id o25so1994315nfa
        for <git@vger.kernel.org>; Mon, 21 Aug 2006 14:09:01 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=TSAHJJJ1IKqcu0qX3kt3dfB/V6G/wo7zi7WYO983RhzdmF5ls6is+dtxI8o6yun2vSATpWFwku6xEXaGpXpoUqp7Ryyz5oRG4rjRrX3CnrVVTbZsKEtELbOCPikBdfHPkSaccByCy3hWDHHRQj5FbsB4owc0pJ2nO3V+VLXe4wU=
Received: by 10.48.254.10 with SMTP id b10mr54928nfi;
        Mon, 21 Aug 2006 14:09:01 -0700 (PDT)
Received: from host-81-190-21-215.torun.mm.pl ( [81.190.21.215])
        by mx.gmail.com with ESMTP id d2sm334118nfe.2006.08.21.14.09.00;
        Mon, 21 Aug 2006 14:09:01 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25822>

Adds parse_difftree_raw_line function which parses one line of "raw"
format diff-tree output into a hash.

For later use in git_difftree_body, git_commitdiff and
git_commitdiff_plain, git_search.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Based on 'next' branch, commit v1.4.2-gfec6879

>From the four functions which parse git-diff-tree raw format, 
git_commitdiff and git_commitdiff_plain are to be rewriten to
use patch (or patch + raw) format of git-diff-tree, and
git_search is to be split into git_search_commit and 
git_search_pickaxe.

Patch introducing parse_difftree_raw_line to git_difftree_body
is next.

 gitweb/gitweb.perl |   27 +++++++++++++++++++++++++++
 1 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 063735d..824fc53 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -918,6 +918,33 @@ sub parse_ref {
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
