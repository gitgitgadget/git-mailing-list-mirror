From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH] t/t9700/test.pl: don't access private object members, use public access methods
Date: Mon, 28 Jun 2010 17:51:02 -0500
Message-ID: <OYRSzEHOHSti8exa5KJzWIUEyJ8xb2sfcvm4pUcvYhBXldZMw8JzP6a6cRcRRIZjiOtW9kzmnVA@cipher.nrlssc.navy.mil>
Cc: git@vger.kernel.org, avarab@gmail.com,
	Brandon Casey <drafnel@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Jun 29 00:51:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OTNAt-0004ON-Ge
	for gcvg-git-2@lo.gmane.org; Tue, 29 Jun 2010 00:51:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755521Ab0F1Wva (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jun 2010 18:51:30 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:51760 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753083Ab0F1Wva (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jun 2010 18:51:30 -0400
Received: by mail.nrlssc.navy.mil id o5SMpAYM027406; Mon, 28 Jun 2010 17:51:10 -0500
X-OriginalArrivalTime: 28 Jun 2010 22:51:10.0449 (UTC) FILETIME=[66F7C610:01CB1714]
X-Virus-Scanned: clamav-milter 0.95.3 at mail1
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149871>

From: Brandon Casey <drafnel@gmail.com>

This test is accessing private object members of the Test::More and
Test::Builder objects.  Older versions of Test::More did not implement
these variables using a hash.

My system complains as follows:

   Can't coerce array into hash at <snip>/t/t9700/test.pl line 13.
   BEGIN failed--compilation aborted at <snip>/t/t9700/test.pl line 15.

There are public access methods available for retrieving and setting these
variables, so let's use them instead.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---
 t/t9700/test.pl |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t9700/test.pl b/t/t9700/test.pl
index f2820d2..671f38d 100755
--- a/t/t9700/test.pl
+++ b/t/t9700/test.pl
@@ -10,8 +10,8 @@ use Test::More qw(no_plan);
 BEGIN {
 	# t9700-perl-git.sh kicks off our testing, so we have to go from
 	# there.
-	Test::More->builder->{Curr_Test} = 1;
-	Test::More->builder->{No_Ending} = 1;
+	Test::More->builder->current_test(1);
+	Test::More->builder->no_ending(1);
 }
 
 use Cwd;
@@ -113,7 +113,7 @@ like($last_commit, qr/^[0-9a-fA-F]{40}$/, 'rev-parse returned hash');
 my $dir_commit = $r2->command_oneline('log', '-n1', '--pretty=format:%H', '.');
 isnt($last_commit, $dir_commit, 'log . does not show last commit');
 
-printf "1..%d\n", Test::More->builder->{Curr_Test};
+printf "1..%d\n", Test::More->builder->current_test;
 
 my $is_passing = eval { Test::More->is_passing };
 exit($is_passing ? 0 : 1) unless $@ =~ /Can't locate object method/;
-- 
1.6.6.2
