Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C6ED01FD99
	for <e@80x24.org>; Sat, 13 Aug 2016 11:30:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752262AbcHMLah (ORCPT <rfc822;e@80x24.org>);
	Sat, 13 Aug 2016 07:30:37 -0400
Received: from mta01.prd.rdg.aluminati.org ([94.76.243.214]:58316 "EHLO
	mta01.prd.rdg.aluminati.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752180AbcHMLah (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 13 Aug 2016 07:30:37 -0400
Received: from mta01.prd.rdg.aluminati.org (localhost [127.0.0.1])
	by mta.aluminati.local (Postfix) with ESMTP id 23D62C4702;
	Sat, 13 Aug 2016 12:30:35 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by mta01.prd.rdg.aluminati.org (Postfix) with ESMTP id 1A94520CD8;
	Sat, 13 Aug 2016 12:30:35 +0100 (BST)
X-Quarantine-ID: <2OsYIaR26nYJ>
X-Virus-Scanned: Debian amavisd-new at mta01.prd.rdg.aluminati.org
Received: from mta.aluminati.local ([127.0.0.1])
	by localhost (mta01.prd.rdg.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 2OsYIaR26nYJ; Sat, 13 Aug 2016 12:30:32 +0100 (BST)
Received: from john.keeping.me.uk (unknown [10.2.0.10])
	by mta01.prd.rdg.aluminati.org (Postfix) with ESMTPSA id 6EF916212F;
	Sat, 13 Aug 2016 12:30:29 +0100 (BST)
Date:	Sat, 13 Aug 2016 12:30:28 +0100
From:	John Keeping <john@keeping.me.uk>
To:	"Tom Tanner (BLOOMBERG/ LONDON)" <ttanner2@bloomberg.net>,
	David Aguilar <davvid@gmail.com>
Cc:	git@vger.kernel.org
Subject: [PATCH] difftool: always honor "command not found" exit code
Message-ID: <20160813113028.uwedje6fzuc3cuzr@john.keeping.me.uk>
References: <57AD772501C207A400390148_0_15304@p057>
 <20160813103639.mxscvfyztee4hbvh@john.keeping.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160813103639.mxscvfyztee4hbvh@john.keeping.me.uk>
User-Agent: Mutt/1.6.2 (2016-06-11)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

At the moment difftool's "trust exit code" logic always suppresses the
exit status of the diff utility we invoke.  This is useful because we
don't want to exit just because diff returned "1" because the files
differ, but it's confusing if the shell returns an error because the
selected diff utility is not found.

POSIX specifies 127 as the exit status for "command not found" and 126
for "command found but is not executable" [1] and at least bash and dash
follow this specification, while diff utilities generally use "1" for
the exit status we want to ignore.

Handle 126 and 127 as special values, assuming that they always mean
that the command could not be executed.

[1] http://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_08_02

Signed-off-by: John Keeping <john@keeping.me.uk>
---
On Sat, Aug 13, 2016 at 11:36:39AM +0100, John Keeping wrote:
> It would be nice if there was a way to differentiate between complete
> failure and just the diff tool exiting with a non-zero return status
> because the files differ, but I'm not sure whether we can do that
> reliably.  POSIX uses 127 and 126 as errors that mean the command didn't
> run [1] so it may be sensible to to treat those as special values.

Something like this perhaps?  I think this is probably safe, but it's
always possible that some diff utility does use 126 or 127 as a "normal"
exit status.  I'm not sure what we can do about that other than add a
"really, really don't trust the exit status" option!

 git-difftool--helper.sh | 18 ++++++++++++++----
 t/t7800-difftool.sh     |  6 ++++++
 2 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/git-difftool--helper.sh b/git-difftool--helper.sh
index 84d6cc0..68877d4 100755
--- a/git-difftool--helper.sh
+++ b/git-difftool--helper.sh
@@ -86,11 +86,21 @@ else
 	do
 		launch_merge_tool "$1" "$2" "$5"
 		status=$?
-		if test "$status" != 0 &&
-			test "$GIT_DIFFTOOL_TRUST_EXIT_CODE" = true
-		then
+		case "$status" in
+		0)
+			: OK
+			;;
+		126|127)
+			# Command not found or not executable
 			exit $status
-		fi
+			;;
+		*)
+			if test "$GIT_DIFFTOOL_TRUST_EXIT_CODE" = true
+			then
+				exit $status
+			fi
+			;;
+		esac
 		shift 7
 	done
 fi
diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
index 2974900..70a2de4 100755
--- a/t/t7800-difftool.sh
+++ b/t/t7800-difftool.sh
@@ -124,6 +124,12 @@ test_expect_success PERL 'difftool stops on error with --trust-exit-code' '
 	test_cmp expect actual
 '
 
+test_expect_success PERL 'difftool honors exit status if command not found' '
+	test_config difftool.nonexistent.cmd i-dont-exist &&
+	test_config difftool.trustExitCode false &&
+	test_must_fail git difftool -y -t nonexistent branch
+'
+
 test_expect_success PERL 'difftool honors --gui' '
 	difftool_test_setup &&
 	test_config merge.tool bogus-tool &&
-- 
2.9.2.639.g855ae9f

