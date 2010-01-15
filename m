From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Add push --set-upstream
Date: Fri, 15 Jan 2010 12:17:45 -0500
Message-ID: <20100115171745.GB2115@coredump.intra.peff.net>
References: <1263573407-13642-1-git-send-email-ilari.liusvaara@elisanet.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Fri Jan 15 18:17:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVpo4-00022F-Fx
	for gcvg-git-2@lo.gmane.org; Fri, 15 Jan 2010 18:17:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757866Ab0AORRu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2010 12:17:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757744Ab0AORRu
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jan 2010 12:17:50 -0500
Received: from peff.net ([208.65.91.99]:46842 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756510Ab0AORRt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2010 12:17:49 -0500
Received: (qmail 27627 invoked by uid 107); 15 Jan 2010 17:22:39 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 15 Jan 2010 12:22:39 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 15 Jan 2010 12:17:45 -0500
Content-Disposition: inline
In-Reply-To: <1263573407-13642-1-git-send-email-ilari.liusvaara@elisanet.fi>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137085>

On Fri, Jan 15, 2010 at 06:36:47PM +0200, Ilari Liusvaara wrote:

> Frequent complaint is lack of easy way to set up upstream (tracking)
> references for git pull to work as part of push command. So add switch
> --set-upstream (-u) to do just that.

Huzzah, finally this feature is done right. I even like the name.

>  Documentation/git-push.txt |    8 +++++++-
>  builtin-push.c             |    1 +
>  transport.c                |   35 +++++++++++++++++++++++++++++++++++
>  transport.h                |    1 +
>  4 files changed, 44 insertions(+), 1 deletions(-)

No tests. But since in writing this you have crossed an item off of my
long-term todo, I feel obliged to help out by providing some. :)

The patch below is squash-able, but note that the final test, "git push
-u HEAD" is marked as broken. We should probably support that. I suspect
is is an issue of dereferencing symrefs before doing the
prefixcmp("refs/heads/", ...) but I haven't checked yet.

diff --git a/t/t5523-push-upstream.sh b/t/t5523-push-upstream.sh
new file mode 100755
index 0000000..e977553
--- /dev/null
+++ b/t/t5523-push-upstream.sh
@@ -0,0 +1,48 @@
+#!/bin/sh
+
+test_description='push with --set-upstream'
+. ./test-lib.sh
+
+test_expect_success 'setup bare parent' '
+	git init --bare parent &&
+	git remote add upstream parent
+'
+
+test_expect_success 'setup local commit' '
+	echo content >file &&
+	git add file &&
+	git commit -m one
+'
+
+check_config() {
+	(echo $2; echo $3) >expect.$1
+	(git config branch.$1.remote
+	 git config branch.$1.merge) >actual.$1
+	test_cmp expect.$1 actual.$1
+}
+
+test_expect_success 'push -u master:master' '
+	git push -u upstream master:master &&
+	check_config master upstream refs/heads/master
+'
+
+test_expect_success 'push -u master:other' '
+	git push -u upstream master:other &&
+	check_config master upstream refs/heads/other
+'
+
+test_expect_success 'push -u --all' '
+	git branch all1 &&
+	git branch all2 &&
+	git push -u --all &&
+	check_config all1 upstream refs/heads/all1 &&
+	check_config all2 upstream refs/heads/all2
+'
+
+test_expect_failure 'push -u HEAD' '
+	git checkout -b headbranch &&
+	git push -u upstream HEAD &&
+	check_config headbranch upstream refs/heads/headbranch
+'
+
+test_done
