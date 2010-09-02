From: Steven Walter <stevenrwalter@gmail.com>
Subject: [PATCH] git-svn: check_cherry_pick should exclude commits already in our history
Date: Thu,  2 Sep 2010 12:46:48 -0400
Message-ID: <1283446008-10858-1-git-send-email-stevenrwalter@gmail.com>
Cc: Steven Walter <swalter@lpdev.prtdev.lexmark.com>
To: git@vger.kernel.org, normalperson@yhbt.net
X-From: git-owner@vger.kernel.org Thu Sep 02 18:47:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OrCwQ-00083x-6o
	for gcvg-git-2@lo.gmane.org; Thu, 02 Sep 2010 18:47:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752948Ab0IBQrE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Sep 2010 12:47:04 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:41981 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752646Ab0IBQrD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Sep 2010 12:47:03 -0400
Received: by ywh1 with SMTP id 1so280035ywh.19
        for <git@vger.kernel.org>; Thu, 02 Sep 2010 09:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer;
        bh=3KUDZiDVawjHwbUD1prsnl+XPuz2pfBIuq9ydjhzV94=;
        b=PxuUQGFiJihf4CY2bM7V8ciWfphVt0h9fpuVV0XP4YQvV4bihOtMnEdS/mT+Vr6Krd
         nSPdk9nowxoyzJ25Mo7ROH+Ne//PQokzrYmfbKsNBbXIJ+fmfYudk+mmJVF5Vn77eUWe
         8Q4lJnhdkNjm83s7uuqUM0UTIVogeTAF5fNwU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=n6LDcWsEk66h9pfpDxdEJoWDk3bF55dYCHNsd8octJDLpLnCzp0lS2GBJ5QFOyiaMP
         0rgKkRIr6oWszWjp6Ff1yHQM81IncjaP48RXjxnlHrvGvjFPQoiKrTvFy7f19fbCQHlh
         Fllk6DrZBrXFGhSNUQCXtATNNQBo/CxcoKxhM=
Received: by 10.151.63.42 with SMTP id q42mr269083ybk.258.1283446019925;
        Thu, 02 Sep 2010 09:46:59 -0700 (PDT)
Received: from brock (adsl-234-158-248.bgk.bellsouth.net [74.234.158.248])
        by mx.google.com with ESMTPS id w24sm2324412ybk.1.2010.09.02.09.46.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 02 Sep 2010 09:46:58 -0700 (PDT)
Received: from srwalter by brock with local (Exim 4.71)
	(envelope-from <srwalter@dervierte>)
	id 1OrCwC-0002pf-L4; Thu, 02 Sep 2010 12:46:56 -0400
X-Mailer: git-send-email 1.7.0.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155146>

From: Steven Walter <swalter@lpdev.prtdev.lexmark.com>

The merge-base between @$parents and $merge_tip may have been reached
through a merge commit.  This means that some commits that are ancestors
of @$parents will not be ancestors of $merge_base.  The mergeinfo
property will not list commits that are ancestors of @$parents, so we
need to explicitly exclude them.
---
 git-svn.perl |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 7a72f75..70edf80 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -3087,9 +3087,10 @@ sub _rev_list {
 sub check_cherry_pick {
 	my $base = shift;
 	my $tip = shift;
+	my $parents = shift;
 	my @ranges = @_;
 	my %commits = map { $_ => 1 }
-		_rev_list("--no-merges", $tip, "--not", $base);
+		_rev_list("--no-merges", $tip, "--not", $base, @$parents);
 	for my $range ( @ranges ) {
 		delete @commits{_rev_list($range)};
 	}
@@ -3249,6 +3250,7 @@ sub find_extra_svn_parents {
 		# double check that there are no missing non-merge commits
 		my (@incomplete) = check_cherry_pick(
 			$merge_base, $merge_tip,
+			$parents,
 			@$ranges,
 		       );
 
-- 
1.7.0.5.gbc75a
