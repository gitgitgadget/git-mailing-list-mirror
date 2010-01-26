From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] t1506: more test for @{upstream} syntax
Date: Tue, 26 Jan 2010 08:07:45 -0500
Message-ID: <20100126130745.GB28179@coredump.intra.peff.net>
References: <1263980322-4142-1-git-send-email-gitster@pobox.com>
 <1263980322-4142-2-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 26 14:07:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZl98-0006JG-6g
	for gcvg-git-2@lo.gmane.org; Tue, 26 Jan 2010 14:07:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752466Ab0AZNHv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jan 2010 08:07:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752147Ab0AZNHu
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Jan 2010 08:07:50 -0500
Received: from peff.net ([208.65.91.99]:37957 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751398Ab0AZNHu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jan 2010 08:07:50 -0500
Received: (qmail 23909 invoked by uid 107); 26 Jan 2010 13:07:48 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 26 Jan 2010 08:07:48 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 26 Jan 2010 08:07:45 -0500
Content-Disposition: inline
In-Reply-To: <1263980322-4142-2-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138036>

On Wed, Jan 20, 2010 at 01:38:41AM -0800, Junio C Hamano wrote:

> This adds a few more tests that exercises @{upstream} syntax by commands
> that operate differently when they are given branch name as opposed to a
> refname (i.e. where "master" and "refs/heads/master" makes a difference).

Overall this looks good, but there are a few minor defects. I haven't
had a chance to fix them yet, but here are tests showing them. I hope to
get to them pre-1.7.0, but please feel free to take a crack at them if
you want.

The first one is that @{usptream} silently becomes @{0}. I think
we need to double-check whether approxidate found absolutely nothing,
and complain if that is the case.

diff --git a/t/t0101-at-syntax.sh b/t/t0101-at-syntax.sh
new file mode 100755
index 0000000..da43386
--- /dev/null
+++ b/t/t0101-at-syntax.sh
@@ -0,0 +1,41 @@
+#!/bin/sh
+
+test_description='various @{whatever} syntax tests'
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	test_commit one &&
+	test_commit two
+'
+
+check_at() {
+	echo "$2" >expect &&
+	git log -1 --format=%s "$1" >actual &&
+	test_cmp expect actual
+}
+
+test_expect_success '@{0} shows current' '
+	check_at @{0} two
+'
+
+test_expect_success '@{1} shows old' '
+	check_at @{1} one
+'
+
+test_expect_success '@{now} shows current' '
+	check_at @{now} two
+'
+
+test_expect_success '@{30.years.ago} shows old' '
+	check_at @{30.years.ago} one
+'
+
+test_expect_success 'silly approxidates work' '
+	check_at @{3.hot.dogs.and.30.years.ago} one
+'
+
+test_expect_failure 'complain about total nonsense' '
+	test_must_fail git log -1 --format=%s @{utter.bogosity}
+'
+
+test_done

The second one is that "log -g branch@{u}" shows the correct commits
(from the upstream of "branch"), but displays the incorrect reflog
information (it shows information for "branch", not for its upstream).

diff --git a/t/t1507-rev-parse-upstream.sh b/t/t1507-rev-parse-upstream.sh
index 95c9b09..cbe1b25 100755
--- a/t/t1507-rev-parse-upstream.sh
+++ b/t/t1507-rev-parse-upstream.sh
@@ -107,4 +107,18 @@ test_expect_success 'checkout other@{u}' '
 	test_cmp expect actual
 '
 
+cat >expect <<EOF
+commit 8f489d01d0cc65c3b0f09504ec50b5ed02a70bd5
+Reflog: refs/heads/master@{0} (C O Mitter <committer@example.com>)
+Reflog message: branch: Created from HEAD
+Author: A U Thor <author@example.com>
+Date:   Thu Apr 7 15:15:13 2005 -0700
+
+    3
+EOF
+test_expect_failure 'log -g other@{u}' '
+	git log -1 -g other@{u} >actual &&
+	test_cmp expect actual
+'
+
 test_done
