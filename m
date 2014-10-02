From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 14/24] reflog test: test interaction with detached HEAD
Date: Wed, 1 Oct 2014 19:10:57 -0700
Message-ID: <20141002021057.GG1175@google.com>
References: <CAL=YDWmtitT7kHsZqXmojbv8eKYwKwVn7c+gC180FPQN1uxBvQ@mail.gmail.com>
 <CAL=YDWnd=GNycrPO-5yq+a_g569fZDOmzpat+AWrXd+5+bXDQA@mail.gmail.com>
 <CAL=YDWka47hV2TMcwcY1hm+RhbiD6HD=_ED4zB84zX5e5ABf4Q@mail.gmail.com>
 <CAL=YDWm9VaKUBRAmmybHzOBhAg_VvNc0KMG0W_uTA02YYzQrzA@mail.gmail.com>
 <20140820231723.GF20185@google.com>
 <20140911030318.GD18279@google.com>
 <20141002014817.GS1175@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Thu Oct 02 04:11:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XZVrF-0001sl-P2
	for gcvg-git-2@plane.gmane.org; Thu, 02 Oct 2014 04:11:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751139AbaJBCLB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Oct 2014 22:11:01 -0400
Received: from mail-pd0-f177.google.com ([209.85.192.177]:56325 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751102AbaJBCLA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Oct 2014 22:11:00 -0400
Received: by mail-pd0-f177.google.com with SMTP id v10so1228094pde.36
        for <git@vger.kernel.org>; Wed, 01 Oct 2014 19:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=7Nvlhm3c883Ho2olyQ3OGsEDWdjQKHTG0c7tnElR1YY=;
        b=xsWMjhPNb28j4B7QXndIsfV+3lb55u+rJT1YJ7b2RordH66TcVWDs/7uSxsWdiP4m9
         V4M7KReZdky4+v25o3yPvbO6FEPi/S2uYhzkT6pKLQjCyJUUYz4qPXRK9LtKpQM4p0L1
         N/LSWuvcJJKuhz9YtZmP7/fvKg7DvLUoFuPaURRNGGovvhtovsDtBWS7qRtkxuDBOI16
         EbSVC08bOvwwDseRcQTVN6aR1tJOfuGPV8tKhmfLUomCCLCAYobnPZfv3AQpfI+zP8Pb
         FDsZXrS7shSeiv82ISD3cZweBBOo44tmOauyOSaReQrl+4mAiWvsE3dR+a5RcclqMMSz
         iSjg==
X-Received: by 10.66.219.6 with SMTP id pk6mr9884415pac.35.1412215859916;
        Wed, 01 Oct 2014 19:10:59 -0700 (PDT)
Received: from google.com (aiede.mtv.corp.google.com [172.27.69.120])
        by mx.google.com with ESMTPSA id w8sm2095967pdo.61.2014.10.01.19.10.59
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 01 Oct 2014 19:10:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20141002014817.GS1175@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257785>

From: Junio C Hamano <gitster@pobox.com>

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
New since v21.  Thanks to Junio for noticing the bug.

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
