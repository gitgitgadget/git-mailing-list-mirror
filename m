From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 1/1] send-email: allow to compose only prepared cover letter
Date: Tue, 13 Oct 2015 19:12:48 +0300
Message-ID: <1444752768-82136-1-git-send-email-andriy.shevchenko@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 13 18:13:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zm2CR-0005Xq-76
	for gcvg-git-2@plane.gmane.org; Tue, 13 Oct 2015 18:13:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932618AbbJMQNJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Oct 2015 12:13:09 -0400
Received: from mga14.intel.com ([192.55.52.115]:1334 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932527AbbJMQNI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Oct 2015 12:13:08 -0400
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP; 13 Oct 2015 09:13:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.17,678,1437462000"; 
   d="scan'208";a="791672651"
Received: from black.fi.intel.com ([10.237.72.93])
  by orsmga001.jf.intel.com with ESMTP; 13 Oct 2015 09:12:51 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 474B447; Tue, 13 Oct 2015 19:12:50 +0300 (EEST)
X-Mailer: git-send-email 2.5.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279504>

Since @rev_list_opts contains everything that goes to the git format-patch
including an additional option like '--cover-letter' we might be interested to
compose it before send.

My often use case is to do:
	% git format-patch --cover-letter --subject-prefix="PATCH vN" rev1^..revXYZ
	% $GIT_EDITOR 0000-*
	% git send-email 00* # assumes series less than 100 patches
	% rm -f 00*

Since git-send-email may send directly from repository it would be nice to
reduce above to just
	% git send-email --compose --cover-letter --subject-prefix="PATCH vN" rev1^..revXYZ

P.S. Going further we can even introduce something like --valid-cmd to
send-email to run, for example, checkpatch.pl.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 git-send-email.perl | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index e3ff44b..fc62d28 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -631,7 +631,10 @@ sub get_patch_subject {
 	die "No subject line in $fn ?";
 }
 
-if ($compose) {
+if ($compose and @rev_list_opts and grep { $_ eq '--cover-letter' } @rev_list_opts) {
+	# Cover letter always goes first
+	do_edit($files[0]);
+} elsif ($compose) {
 	# Note that this does not need to be secure, but we will make a small
 	# effort to have it be unique
 	$compose_filename = ($repo ?
-- 
2.5.3
