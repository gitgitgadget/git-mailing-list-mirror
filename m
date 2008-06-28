From: Avery Pennarun <apenwarr@gmail.com>
Subject: [PATCH v2] git-svn: avoid filling up the disk with temp files.
Date: Sat, 28 Jun 2008 19:33:56 -0400
Message-ID: <1214696036-8294-1-git-send-email-apenwarr@gmail.com>
References: <1214686673-28099-1-git-send-email-apenwarr@gmail.com>
Cc: Avery Pennarun <apenwarr@gmail.com>
To: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>,
	Adam Roben <aroben@apple.com>,
	Samuel Bronson <naesten@gmail.com>, B.Steinbrink@gmx.de,
	gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Jun 29 01:35:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCjwm-0003Ti-Ej
	for gcvg-git-2@gmane.org; Sun, 29 Jun 2008 01:35:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751338AbYF1XeE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Jun 2008 19:34:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751241AbYF1XeD
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Jun 2008 19:34:03 -0400
Received: from static-216-18-85-234.gtcust.grouptelecom.net ([216.18.85.234]:14139
	"EHLO mailhost.pwcorp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751235AbYF1XeB (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 28 Jun 2008 19:34:01 -0400
Received: from weaver.open.versabanq.com ([10.65.1.2]) by mailhost.pwcorp.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 28 Jun 2008 19:33:57 -0400
Received: (qmail 23968 invoked from network); 28 Jun 2008 23:33:56 -0000
Received: from unknown (HELO averyp-server.pwcorp.com) (10.65.1.129)
  by weaver.open.versabanq.com with SMTP; 28 Jun 2008 23:33:56 -0000
Received: by averyp-server.pwcorp.com (Postfix, from userid 1000)
	id 3DFD513E87; Sat, 28 Jun 2008 19:33:56 -0400 (EDT)
X-Mailer: git-send-email 1.5.4.3
In-Reply-To: <1214686673-28099-1-git-send-email-apenwarr@gmail.com>
X-OriginalArrivalTime: 28 Jun 2008 23:33:57.0901 (UTC) FILETIME=[6FBC5BD0:01C8D977]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86748>

Commit ffe256f9bac8a40ff751a9341a5869d98f72c285 ("git-svn: Speed up fetch")
introduced changes that create a temporary file for each object fetched by
svn.  These files should be deleted automatically, but perl apparently
doesn't do this until the process exits (or perhaps when its garbage
collector runs).

This means that on a large fetch, especially with lots of branches, we
sometimes fill up /tmp completely, which prevents the next temp file from
being written completely.  This is aggravated by the fact that a new temp
file is created for each updated file, even if that update produces a file
identical to one already in git.  Thus, it can happen even if there's lots
of disk space to store the finished repository.

We weren't adequately checking for write errors, so this would result in an
invalid file getting committed, which caused git-svn to fail later with an
invalid checksum.

This patch adds a check to syswrite() so similar problems don't lead to
corruption in the future.  It also unlink()'s each temp file explicitly
when we're done with it, so the disk doesn't need to fill up.

Signed-off-by: Avery Pennarun <apenwarr@gmail.com>
---

Please use this in favour of the "Revert "git-svn: Speed up fetch" I sent
earlier.  I ended up having a surprise inspiration that led to a real fix :)

 git-svn.perl |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 263d66c..0011387 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -3243,7 +3243,9 @@ sub close_file {
 		my ($tmp_fh, $tmp_filename) = File::Temp::tempfile(UNLINK => 1);
 		my $result;
 		while ($result = sysread($fh, my $string, 1024)) {
-			syswrite($tmp_fh, $string, $result);
+			my $wrote = syswrite($tmp_fh, $string, $result);
+			defined($wrote) && $wrote == $result
+				or croak("write $tmp_filename: $!\n");
 		}
 		defined $result or croak $!;
 		close $tmp_fh or croak $!;
@@ -3251,6 +3253,7 @@ sub close_file {
 		close $fh or croak $!;
 
 		$hash = $::_repository->hash_and_insert_object($tmp_filename);
+		unlink($tmp_filename);
 		$hash =~ /^[a-f\d]{40}$/ or die "not a sha1: $hash\n";
 		close $fb->{base} or croak $!;
 	} else {
-- 
1.5.4.3
