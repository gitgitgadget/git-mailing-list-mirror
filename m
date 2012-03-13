From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 2/7] test: use numstat instead of diffstat in funny-names test
Date: Mon, 12 Mar 2012 23:58:59 -0500
Message-ID: <20120313045859.GB12550@burratino>
References: <1328019840-6168-1-git-send-email-pclouds@gmail.com>
 <1328100907-20397-1-git-send-email-pclouds@gmail.com>
 <20120313045100.GA12474@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Frederik Schwarzer <schwarzerf@gmail.com>,
	Brandon Casey <drafnel@gmail.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 13 05:59:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7JpP-0003C5-IT
	for gcvg-git-2@plane.gmane.org; Tue, 13 Mar 2012 05:59:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757773Ab2CME7O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Mar 2012 00:59:14 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:58176 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751604Ab2CME7N (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Mar 2012 00:59:13 -0400
Received: by ghrr11 with SMTP id r11so148415ghr.19
        for <git@vger.kernel.org>; Mon, 12 Mar 2012 21:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=f9tAgkB4fG6VogBTvFpqOHhe3yEWIAoVVyxHv9y1Fc0=;
        b=UjuU3k5Q9PcTieiAIIpBVusp0ghri4erXSAVv1vVFYbL/gJaBzHlETo+fO2e1ELIoE
         iY4DZWqhovV6qPPPs9RnyrmSbjvjqPbPgpLDBwxbYdpBreUogfDVm5TIxFMEWQoTfgZS
         yvgyvM0d0pdSTVTZygKjc6foOYjXyMdKWvAw3T63ONVeP77jKHsOelK8iqutDzR6UhMP
         HHIabG24dRZ7fNdI5ZN2HmCEJGUdrbh305Leadbhuo7tg4wumNiuQZcGUERBQvJakBPy
         Ix1zJD8UCmT6VM5428TTMAP+HwIxRJZ7uLBZJAnU7Mk0iOvjYla6FAz6ddloPShwSP6Z
         PRrA==
Received: by 10.60.28.103 with SMTP id a7mr10166684oeh.24.1331614752910;
        Mon, 12 Mar 2012 21:59:12 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id b3sm24317964obp.6.2012.03.12.21.59.11
        (version=SSLv3 cipher=OTHER);
        Mon, 12 Mar 2012 21:59:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120313045100.GA12474@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192973>

This test script checks that git's plumbing commands quote filenames
with special characters like space, tab, and double-quote
appropriately in their input and output.

Since commit v1.7.9.2~13 (Use correct grammar in diffstat summary
line, 2012-02-01), the final "1 file changed, 1 insertion(+)" line
from diffstats is translatable, meaning tests that rely on exact "git
apply --stat" output have to be skipped when git is not configured to
produce output in the C locale (for example, when GETTEXT_POISON is
enabled).  So:

 - Tweak the three "git apply --stat" tests that check "git apply"'s
   input parsing to use --numstat instead.

   --numstat output is more reliable, does not vary with locale, and
   is itself easier to parse.  These tests are mainly about how "git
   apply" parses its input so this should not result in much loss of
   coverage.

 - Add a new "apply --stat" test to check the quoting in --stat output
   format.

This wins back a little of the test coverage lost with the patch
"test: use test_i18ncmp to check --stat output" when GETTEXT_POISON is
enabled.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
The above description is too noisy.  The intent is:

 The funny-names tests that use "apply --stat" are doing two things:

  - making sure "git apply" can parse a patch that uses funny
    filenames
  - making sure that "git apply --stat" can produce a diffstat
    that uses funny filenames

 Only the latter requires using --stat instead of --numstat.  The
 former is intended for humans and varies by locale, while the
 latter is a format meant to stay more stable between versions
 and thus is more convenient to use in tests.

 This patch makes all but one of these "apply --stat" tests use
 --numstat instead, for the above reasons.

so someone (probably I) will need to consolidate the descriptions in
a spare moment.

 t/t3300-funny-names.sh |   27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/t/t3300-funny-names.sh b/t/t3300-funny-names.sh
index 644aa219..9114893b 100755
--- a/t/t3300-funny-names.sh
+++ b/t/t3300-funny-names.sh
@@ -171,28 +171,35 @@ cat >expected <<\EOF
 EOF
 '
 
-test_expect_success TABS_IN_FILENAMES 'git diff-tree rename with-funny applied' \
+test_expect_success TABS_IN_FILENAMES 'diffstat for rename with funny chars' \
 	'git diff-index -M -p $t0 |
 	 git apply --stat | sed -e "s/|.*//" -e "s/ *\$//" >current &&
 	 test_i18ncmp expected current'
 
+test_expect_success TABS_IN_FILENAMES 'numstat for rename with funny chars' \
+	'cat >expected <<-\EOF &&
+	0	0	"tabs\t,\" (dq) and spaces"
+	EOF
+	 git diff-index -M -p $t0 >diff &&
+	 git apply --numstat <diff >current &&
+	 test_cmp expected current'
+
 test_expect_success TABS_IN_FILENAMES 'setup expect' '
 cat > expected <<\EOF
- no-funny
- "tabs\t,\" (dq) and spaces"
- 2 files changed, 3 insertions(+), 3 deletions(-)
+0	3	no-funny
+3	0	"tabs\t,\" (dq) and spaces"
 EOF
 '
 
-test_expect_success TABS_IN_FILENAMES 'git diff-tree delete with-funny applied' \
+test_expect_success TABS_IN_FILENAMES 'numstat without -M for funny rename' \
 	'git diff-index -p $t0 |
-	 git apply --stat | sed -e "s/|.*//" -e "s/ *\$//" >current &&
-	 test_i18ncmp expected current'
+	 git apply --numstat >current &&
+	 test_cmp expected current'
 
-test_expect_success TABS_IN_FILENAMES 'git apply non-git diff' \
+test_expect_success TABS_IN_FILENAMES 'numstat for non-git funny rename diff' \
 	'git diff-index -p $t0 |
 	 sed -ne "/^[-+@]/p" |
-	 git apply --stat | sed -e "s/|.*//" -e "s/ *\$//" >current &&
-	 test_i18ncmp expected current'
+	 git apply --numstat >current &&
+	 test_cmp expected current'
 
 test_done
-- 
1.7.9.2
