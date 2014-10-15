From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 15/25] reflog test: test interaction with detached HEAD
Date: Tue, 14 Oct 2014 17:52:13 -0700
Message-ID: <20141015005213.GS32245@google.com>
References: <20141015004522.GD32245@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ronnie Sahlberg <sahlberg@google.com>,
	Junio C Hamano <gitster@pobox.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Oct 15 02:52:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XeCpA-0002vE-Mu
	for gcvg-git-2@plane.gmane.org; Wed, 15 Oct 2014 02:52:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932587AbaJOAwR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Oct 2014 20:52:17 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:35009 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932191AbaJOAwQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Oct 2014 20:52:16 -0400
Received: by mail-pa0-f46.google.com with SMTP id fa1so232076pad.19
        for <git@vger.kernel.org>; Tue, 14 Oct 2014 17:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=UsefRCl9BlAnHK5S9SUWUMNegaUyoNkzlQu2NAiWsuo=;
        b=VQTltH9dSPwZf9t0/YWX4kEaTVH8kVbzh/McDikTuutzTIMdrRAVCzgnyo7cSATIB/
         qgFr9R2n56KAo+yx7DOO3nBIRYUcs/Xkjz9jsZ95BzZkDcSiEwafDHL2MEabRibA18Wh
         UpupHJfkMroyFVRsDDHVkhQdCAAo9TgFgJolFAVdqav/vHQaNIgAgzxJONxAzZyVXVyR
         vyHzD3IxPRGdFxXOATP5qERCP7H6Q5aTaW7z+MosduVvAsAD2NOwGp3lLgczRSGScxgm
         nkcZNdwB7/XCe2YeaxSRqdjyPvucREiz5lnfURKm3/b9aJAt4+ugUMEa8dDBsKZGC1Ec
         I+5Q==
X-Received: by 10.70.90.138 with SMTP id bw10mr8764396pdb.73.1413334336021;
        Tue, 14 Oct 2014 17:52:16 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:c43b:1934:40ef:9a07])
        by mx.google.com with ESMTPSA id ar1sm8556707pbc.20.2014.10.14.17.52.14
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 14 Oct 2014 17:52:15 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20141015004522.GD32245@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Junio C Hamano <gitster@pobox.com>
Date: Sat, 13 Sep 2014 10:52:25 -0700

A proposed patch produced broken HEAD reflog entries when checking out
anything other than a branch.  The testsuite still passed, so it took
a few days for the bug to be noticed.

Add tests checking the content of the reflog after detaching and
reattaching HEAD so we don't have to rely on manual testing to catch
such problems in the future.

[jn: using 'log -g --format=%H' instead of parsing --oneline output,
 resetting state in each test so they can be safely reordered or
 skipped]

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Reviewed-by: Ronnie Sahlberg <sahlberg@google.com>
---
 t/t1413-reflog-detach.sh | 70 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)
 create mode 100755 t/t1413-reflog-detach.sh

diff --git a/t/t1413-reflog-detach.sh b/t/t1413-reflog-detach.sh
new file mode 100755
index 0000000..c730600
--- /dev/null
+++ b/t/t1413-reflog-detach.sh
@@ -0,0 +1,70 @@
+#!/bin/sh
+
+test_description='Test reflog interaction with detached HEAD'
+. ./test-lib.sh
+
+reset_state () {
+	git checkout master &&
+	cp saved_reflog .git/logs/HEAD
+}
+
+test_expect_success setup '
+	test_tick &&
+	git commit --allow-empty -m initial &&
+	git branch side &&
+	test_tick &&
+	git commit --allow-empty -m second &&
+	cat .git/logs/HEAD >saved_reflog
+'
+
+test_expect_success baseline '
+	reset_state &&
+	git rev-parse master master^ >expect &&
+	git log -g --format=%H >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'switch to branch' '
+	reset_state &&
+	git rev-parse side master master^ >expect &&
+	git checkout side &&
+	git log -g --format=%H >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'detach to other' '
+	reset_state &&
+	git rev-parse master side master master^ >expect &&
+	git checkout side &&
+	git checkout master^0 &&
+	git log -g --format=%H >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'detach to self' '
+	reset_state &&
+	git rev-parse master master master^ >expect &&
+	git checkout master^0 &&
+	git log -g --format=%H >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'attach to self' '
+	reset_state &&
+	git rev-parse master master master master^ >expect &&
+	git checkout master^0 &&
+	git checkout master &&
+	git log -g --format=%H >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'attach to other' '
+	reset_state &&
+	git rev-parse side master master master^ >expect &&
+	git checkout master^0 &&
+	git checkout side &&
+	git log -g --format=%H >actual &&
+	test_cmp expect actual
+'
+
+test_done
-- 
2.1.0.rc2.206.gedb03e5
