From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH (resend)] gitweb: Fix 'history' view for deleted files with
	history
Date: Sun, 13 Apr 2008 14:12:15 +0200
Message-ID: <20080413121018.3951.45328.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 13 14:19:44 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jl1BL-0000Hk-OW
	for gcvg-git-2@gmane.org; Sun, 13 Apr 2008 14:19:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754442AbYDMMSn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Apr 2008 08:18:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755477AbYDMMSn
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Apr 2008 08:18:43 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:48860 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754406AbYDMMSm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Apr 2008 08:18:42 -0400
Received: by fg-out-1718.google.com with SMTP id l27so1142309fgb.17
        for <git@vger.kernel.org>; Sun, 13 Apr 2008 05:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:subject:to:date:message-id:user-agent:mime-version:content-type:content-transfer-encoding;
        bh=HOjKcMGgN6Q1Rlym901yCUS6jBVu3DFBbFVNSgEvmEg=;
        b=nhmGbUjqXAddAO4bz0jJb2z1sS1d0HnKa1GC1yFJ81w5ik68L0dnjcVrwd5YmBblX/s9kdCAksEq3IkhzF6DuZscGhG6kAa0vXFgznFdRF+7lJfcSrmD5lrYI8pG+gI7tlVixBcq/BZXPnDi4Nvn6nPa6EMJnce4ubBKRYLfiuY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:subject:to:date:message-id:user-agent:mime-version:content-type:content-transfer-encoding;
        b=CPmBKW4V5pVqvUB3so5x5D38BsxDAeLrwqLpKRtyVBywKXuj7XB8O+djfAXVxIeXrGClsBBEoioLG2moNixBllsOkV0GUBhqlS6UWo5+1QI7lgPP4PrHYzvVud68Xb50/LmKANhL/CdTajQCOHkdJdWoyTFBl6NmYWALMdY0blM=
Received: by 10.86.89.4 with SMTP id m4mr10741506fgb.45.1208088742985;
        Sun, 13 Apr 2008 05:12:22 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.231.63])
        by mx.google.com with ESMTPS id c22sm7670983ika.3.2008.04.13.05.12.19
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 13 Apr 2008 05:12:21 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m3DCCFNE003990
	for <git@vger.kernel.org>; Sun, 13 Apr 2008 14:12:17 +0200
User-Agent: StGIT/0.14.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79405>

When asked for history of a file which is not present in given branch
("HEAD", i.e. current branch, or given by transient $hash_hase ('hb')
parameter), but is present deeper in the history (meaning that "git
rev-list --full-history $hash_base -- $file_name" is not empty), and
there is no $hash ('h') parameter set for a file, gitweb would spew
multiple of "Use of uninitialized value" warnings, and some links
would be missing.  This commit fixes this bug.

This bug occurs in the rare cases when "git log -- <path>" is empty
and "git log --full-history -- <path>" is not, or to be more exact in
the cases when full-history starts later than given branch.  It can
happen if you are using handcrafted gitwb URL, or if you follow
generic 'history' link or bookmark for a file which got deleted.

Gitweb tried to get file type ('tree', or 'blob', or even 'commit')
from the commit we start searching from (where the file was not
present), and not among found commits.  This was the cause of "Use of
uninitialized value" warnings.

This commit also add tests for such situation to t9500 test.


While we are it, return HTTP error if there is _no_ history; it means
that file or directory was not found (for given branch).  Also error
out if type of item could not be found: it should not happen now, but
better be sure.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Resend after 1.5.5 release, this time with the test added (which fails
before this patch, and succeds after it).

Commit message was slightly reworded, and improved.

 gitweb/gitweb.perl                     |   18 +++++++++++++++---
 t/t9500-gitweb-standalone-no-errors.sh |   16 ++++++++++++++++
 2 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index e69d7fd..a48bebb 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -5176,14 +5176,26 @@ sub git_history {
 	my $refs = git_get_references();
 	my $limit = sprintf("--max-count=%i", (100 * ($page+1)));
 
+	my @commitlist = parse_commits($hash_base, 101, (100 * $page),
+	                               $file_name, "--full-history");
+	if (!@commitlist) {
+		die_error('404 Not Found', "No such file or directory on given branch");
+	}
+
 	if (!defined $hash && defined $file_name) {
-		$hash = git_get_hash_by_path($hash_base, $file_name);
+		# some commits could have deleted file in question,
+		# and not have it in tree, but one of them has to have it
+		for (my $i = 0; $i <= @commitlist; $i++) {
+			$hash = git_get_hash_by_path($commitlist[$i]{'id'}, $file_name);
+			last if defined $hash;
+		}
 	}
 	if (defined $hash) {
 		$ftype = git_get_type($hash);
 	}
-
-	my @commitlist = parse_commits($hash_base, 101, (100 * $page), $file_name, "--full-history");
+	if (!defined $ftype) {
+		die_error(undef, "Unknown type of object");
+	}
 
 	my $paging_nav = '';
 	if ($page > 0) {
diff --git a/t/t9500-gitweb-standalone-no-errors.sh b/t/t9500-gitweb-standalone-no-errors.sh
index 796cd7d..061a259 100755
--- a/t/t9500-gitweb-standalone-no-errors.sh
+++ b/t/t9500-gitweb-standalone-no-errors.sh
@@ -483,6 +483,22 @@ test_expect_success \
 	'gitweb_run "p=.git;a=history;f=file"'
 test_debug 'cat gitweb.log'
 
+test_expect_success \
+	'logs: history (implicit HEAD, non-existent file)' \
+	'gitweb_run "p=.git;a=history;f=non-existent"'
+test_debug 'cat gitweb.log'
+
+test_expect_success \
+	'logs: history (implicit HEAD, deleted file)' \
+	'git checkout master &&
+	 echo "to be deleted" > deleted_file &&
+	 git add deleted_file &&
+	 git commit -m "Add file to be deleted" &&
+	 git rm deleted_file &&
+	 git commit -m "Delete file" &&
+	 gitweb_run "p=.git;a=history;f=deleted_file"'
+test_debug 'cat gitweb.log'
+
 # ----------------------------------------------------------------------
 # feed generation
 
