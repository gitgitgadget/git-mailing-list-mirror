From: Steven Walter <stevenrwalter@gmail.com>
Subject: [PATCH] git-svn: check_cherry_pick should exclude commits already in our history
Date: Thu,  2 Sep 2010 18:32:06 -0400
Message-ID: <1283466726-12643-1-git-send-email-stevenrwalter@gmail.com>
References: <20100902214707.GA2761@dcvr.yhbt.net>
Cc: Steven Walter <swalter@lpdev.prtdev.lexmark.com>,
	Steven Walter <stevenrwalter@gmail.com>
To: git@vger.kernel.org, normalperson@yhbt.net
X-From: git-owner@vger.kernel.org Fri Sep 03 00:32:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OrIKS-0004Cy-CH
	for gcvg-git-2@lo.gmane.org; Fri, 03 Sep 2010 00:32:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753497Ab0IBWcO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Sep 2010 18:32:14 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:47760 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752958Ab0IBWcN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Sep 2010 18:32:13 -0400
Received: by gyd8 with SMTP id 8so429259gyd.19
        for <git@vger.kernel.org>; Thu, 02 Sep 2010 15:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=sJV04eKpEb15ygS2789jZoWl2y5WAJspkuJsUnBL8B0=;
        b=NyUcD1EDsRE9+aiucBugNO/dgJn0yHM5f0A1iIGNcmvLRej5NnYZj7O/B4UsGgWjct
         3Bhd2q/yOK+oyqrdYYWb5UrJ1d0TQHjOIYL3/VwpYLtAkKrUEqAgaYd5rpQlHJvQlelK
         hp+sZsLDtgMVsAULxn/2xBSeREke2kCqZw2X0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=CfVIAk387Bt1pk76oExNlFxsCUjE5oJVMtXY0jWtul4p29StzwxoUNYJWo0xz3CVGb
         ipa0So5+1eLMqN87gIWAQI4a0IbGrexGzVdpW0FTG22sLQNM6kzNlUGw8qgxUBh3QTi5
         jOWo+eqXnQFRRru601TrjiADtLSOMHj26euKg=
Received: by 10.150.148.20 with SMTP id v20mr274ybd.109.1283466732767;
        Thu, 02 Sep 2010 15:32:12 -0700 (PDT)
Received: from brock (adsl-234-158-248.bgk.bellsouth.net [74.234.158.248])
        by mx.google.com with ESMTPS id q38sm2606190yba.6.2010.09.02.15.32.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 02 Sep 2010 15:32:11 -0700 (PDT)
Received: from srwalter by brock with local (Exim 4.71)
	(envelope-from <srwalter@dervierte>)
	id 1OrIKH-0003IS-Tm; Thu, 02 Sep 2010 18:32:09 -0400
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <20100902214707.GA2761@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155215>

From: Steven Walter <swalter@lpdev.prtdev.lexmark.com>

The merge-base between @$parents and $merge_tip may have been reached
through a merge commit.  This means that some commits that are ancestors
of @$parents will not be ancestors of $merge_base.  The mergeinfo
property will not list commits that are ancestors of @$parents, so we
need to explicitly exclude them.

Signed-off-by: Steven Walter <stevenrwalter@gmail.com>
Acked-by: Eric Wong <normalperson@yhbt.net>
---
 git-svn.perl |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 9b046b6..c7c4dcd 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -3118,9 +3118,10 @@ sub _rev_list {
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
@@ -3296,6 +3297,7 @@ sub find_extra_svn_parents {
 		# double check that there are no missing non-merge commits
 		my (@incomplete) = check_cherry_pick(
 			$merge_base, $merge_tip,
+			$parents,
 			@$ranges,
 		       );
 
-- 
1.7.0.4
