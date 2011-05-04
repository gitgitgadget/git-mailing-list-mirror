From: Michael Grubb <devel@dailyvoid.com>
Subject: [PATCH v5] Add default merge options for all branches
Date: Wed, 04 May 2011 17:07:18 -0500
Message-ID: <4DC1CE16.5030808@dailyvoid.com>
References: <20110503090351.GA27862@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 05 00:07:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHkEH-0005gQ-LU
	for gcvg-git-2@lo.gmane.org; Thu, 05 May 2011 00:07:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755250Ab1EDWH2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2011 18:07:28 -0400
Received: from 75.98.162.166.static.a2webhosting.com ([75.98.162.166]:57031
	"EHLO dailyvoid.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1753579Ab1EDWH1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2011 18:07:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=default; d=dailyvoid.com;
	h=Received:Message-ID:Date:From:User-Agent:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Source:X-Source-Args:X-Source-Dir;
	b=nZ37mmgBdyhI7nByQ7Lid4vIcJDLo7fG8WN5ApUpkXPQsjPGw86JIoTlp/i/hO8ViaUD7yJPKHDhcuHpcny+Nj41G7r+xnNH9zb+4KhoJqNWn2A4dc8sxiAfcWwjOTVd;
Received: from adsl-99-59-251-170.dsl.ltrkar.sbcglobal.net ([99.59.251.170] helo=macbook.local)
	by a2s24.a2hosting.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <devel@dailyvoid.com>)
	id 1QHkEA-0006pR-FI; Wed, 04 May 2011 18:07:26 -0400
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.2.17) Gecko/20110414 Thunderbird/3.1.10
In-Reply-To: <20110503090351.GA27862@elie>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - a2s24.a2hosting.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - dailyvoid.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172778>

Add merge.ff flag to support turning off fast-forward merges by default.
This flag is overridden if any branch.x.mergeoptions turn it back on.

 Documentation/merge-config.txt |    6 ++++++
 builtin/merge.c                |    3 +++
 2 files changed, 9 insertions(+), 0 deletions(-)

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Reported-by: Michael Grubb <devel@dailyvoid.com>
---
 Documentation/merge-config.txt |    6 ++++++
 builtin/merge.c                |    3 +++
 t/t7600-merge.sh               |   23 +++++++++++++++++++++++
 3 files changed, 32 insertions(+), 0 deletions(-)

diff --git a/Documentation/merge-config.txt b/Documentation/merge-config.txt
index 8920258..2aa4408 100644
--- a/Documentation/merge-config.txt
+++ b/Documentation/merge-config.txt
@@ -16,6 +16,12 @@ merge.defaultToUpstream::
 	to their corresponding remote tracking branches, and the tips of
 	these tracking branches are merged.
 
+merge.ff::
+	Do not generate a merge commit if the merge resolved as a
+	fast-forward; only update the branch pointer instead.  Setting
+	this to `false` would be equivalent to giving `--no-ff` from
+	the command line.
+
 merge.log::
 	In addition to branch names, populate the log message with at
 	most the specified number of one-line descriptions from the
diff --git a/builtin/merge.c b/builtin/merge.c
index d171c63..5194f04 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -541,6 +541,9 @@ static int git_merge_config(const char *k, const char *v, void *cb)
 		if (is_bool && shortlog_len)
 			shortlog_len = DEFAULT_MERGE_LOG_LEN;
 		return 0;
+	} else if (!strcmp(k, "merge.ff")) {
+		allow_fast_forward = git_config_bool(k, v);
+		return 0;
 	} else if (!strcmp(k, "merge.defaulttoupstream")) {
 		default_to_upstream = git_config_bool(k, v);
 		return 0;
diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index e84e822..21c25d4 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -415,6 +415,29 @@ test_expect_success 'merge c0 with c1 (no-ff)' '
 
 test_debug 'git log --graph --decorate --oneline --all'
 
+test_expect_success 'merge c0 with c1 (merge.ff=false)' '
+	git reset --hard c0 &&
+	git config merge.ff false &&
+	test_tick &&
+	git merge c1 &&
+	git config --remove-section merge &&
+	verify_merge file result.1 &&
+	verify_parents $c0 $c1
+'
+test_debug 'git log --graph --decorate --oneline --all'
+
+test_expect_success 'combine branch.master.mergeoptions with merge.ff' '
+	git reset --hard c0 &&
+	git config branch.master.mergeoptions --ff
+	git config merge.ff false
+	test_tick &&
+	git merge c1 &&
+	git config --remove-section "branch.master" &&
+	git config --remove-section "merge" &&
+	verify_merge file result.1 &&
+	verify_parents "$c0"
+'
+
 test_expect_success 'combining --squash and --no-ff is refused' '
 	test_must_fail git merge --squash --no-ff c1 &&
 	test_must_fail git merge --no-ff --squash c1
