From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 5/7] test: use --numstat instead of --stat in "git stash
 show" tests
Date: Tue, 13 Mar 2012 00:01:32 -0500
Message-ID: <20120313050132.GE12550@burratino>
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
X-From: git-owner@vger.kernel.org Tue Mar 13 06:01:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7Jrr-0004Di-I6
	for gcvg-git-2@plane.gmane.org; Tue, 13 Mar 2012 06:01:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964943Ab2CMFBr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Mar 2012 01:01:47 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:57981 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752372Ab2CMFBq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Mar 2012 01:01:46 -0400
Received: by gghe5 with SMTP id e5so148861ggh.19
        for <git@vger.kernel.org>; Mon, 12 Mar 2012 22:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=mw4Ih1hCM2AnU6pb4Rb/CKAjfvTa7oanx3S79GOEj/0=;
        b=nVZGsJX4iwUhHikZA6R79++mAxZO9ISsSfoCEJmEuO/71wXgF7R7jNr1uAA1+CvxLK
         PB7fdndP5Ra8Q2SkpGD2RgePRYycY1rmFkC5KqHzBM4Aj44V7IGeFCO/MWONBwGq29pH
         a21Jmo5gD+Aa7CFk18HiWMwxRejb2FLenrz1OFV35iLCZ8kB3ZKEyniYU62MCxCqhwMT
         kfrHhMTvri/XtTgxWIjT7sedCh/cQJP0D524D7vX5wdj8NKwDvPMKmjNlSypoe81YG/4
         RqWOBWa+KZte/TJV4TaO5MrGud4YwFJJi18ift8jUtskzK6oKalFNLy4aM2hzBjcGkD0
         ZMow==
Received: by 10.182.154.5 with SMTP id vk5mr10443999obb.24.1331614905455;
        Mon, 12 Mar 2012 22:01:45 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id q6sm24310188obz.17.2012.03.12.22.01.44
        (version=SSLv3 cipher=OTHER);
        Mon, 12 Mar 2012 22:01:45 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120313045100.GA12474@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192976>

git's diff --stat output is intended for human consumption and
since v1.7.9.2~13 (2012-02-01) varies by locale.  Add a test checking
that git stash show defaults to --stat and tweak the rest of the
"stash show" tests that showed a diffstat to use numstat.

This way, there are fewer tests to tweak if the diffstat format
changes again.  This also improves test coverage when running tests
with git configured not to write its output in the C locale (e.g.,
via GETTEXT_POISON=Yes).

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/t3903-stash.sh |   36 ++++++++++++++++++++++++------------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index c69e4da1..3addb804 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -432,6 +432,24 @@ test_expect_success 'stash branch - stashes on stack, stash-like argument' '
 	test $(git ls-files --modified | wc -l) -eq 1
 '
 
+test_expect_success 'stash show format defaults to --stat' '
+	git stash clear &&
+	test_when_finished "git reset --hard HEAD" &&
+	git reset --hard &&
+	echo foo >> file &&
+	git stash &&
+	test_when_finished "git stash drop" &&
+	echo bar >> file &&
+	STASH_ID=$(git stash create) &&
+	git reset --hard &&
+	cat >expected <<-EOF &&
+	 file |    1 +
+	 1 file changed, 1 insertion(+)
+	EOF
+	git stash show ${STASH_ID} >actual &&
+	test_i18ncmp expected actual
+'
+
 test_expect_success 'stash show - stashes on stack, stash-like argument' '
 	git stash clear &&
 	test_when_finished "git reset --hard HEAD" &&
@@ -442,12 +460,9 @@ test_expect_success 'stash show - stashes on stack, stash-like argument' '
 	echo bar >> file &&
 	STASH_ID=$(git stash create) &&
 	git reset --hard &&
-	cat >expected <<-EOF &&
-	 file |    1 +
-	 1 file changed, 1 insertion(+)
-	EOF
-	git stash show ${STASH_ID} >actual &&
-	test_i18ncmp expected actual
+	echo "1	0	file" >expected &&
+	git stash show --numstat ${STASH_ID} >actual &&
+	test_cmp expected actual
 '
 
 test_expect_success 'stash show -p - stashes on stack, stash-like argument' '
@@ -480,12 +495,9 @@ test_expect_success 'stash show - no stashes on stack, stash-like argument' '
 	echo foo >> file &&
 	STASH_ID=$(git stash create) &&
 	git reset --hard &&
-	cat >expected <<-EOF &&
-	 file |    1 +
-	 1 file changed, 1 insertion(+)
-	EOF
-	git stash show ${STASH_ID} >actual &&
-	test_i18ncmp expected actual
+	echo "1	0	file" >expected &&
+	git stash show --numstat ${STASH_ID} >actual &&
+	test_cmp expected actual
 '
 
 test_expect_success 'stash show -p - no stashes on stack, stash-like argument' '
-- 
1.7.9.2
