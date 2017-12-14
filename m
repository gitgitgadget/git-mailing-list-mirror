Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E9C751F407
	for <e@80x24.org>; Thu, 14 Dec 2017 00:20:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751896AbdLNAUv (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Dec 2017 19:20:51 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:49912 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751121AbdLNAUu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Dec 2017 19:20:50 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 7A6C61F407;
        Thu, 14 Dec 2017 00:20:50 +0000 (UTC)
Date:   Thu, 14 Dec 2017 00:20:50 +0000
From:   Eric Wong <e@80x24.org>
To:     "Bennett, Brian" <Brian.Bennett@Transamerica.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: [PATCH] git-svn: convert CRLF to LF in commit message to SVN
Message-ID: <20171214002050.GA32734@whir>
References: <BL2PR05MB2179DEBF7123ACD090E60F2685340@BL2PR05MB2179.namprd05.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <BL2PR05MB2179DEBF7123ACD090E60F2685340@BL2PR05MB2179.namprd05.prod.outlook.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Bennett, Brian" <Brian.Bennett@Transamerica.com> wrote:
> Environment:
> 
> Desktop: Windows 7 Enterprise 64-bit
> svn client (if applicable): 1.8.8 from Apache
> git (https://git-for-windows.github.io/): git version 2.10.1.windows.1
> GitTfs (https://github.com/git-tfs/git-tfs): git-tfs version 0.27.0.0 (TFS client library 14.0.0.0 (MS)) (32-bit)
> Team Foundation Server: 2010
> Visual Studio installation: 2010 and 2015

<snip>

Thanks for the report and research!

> I've researched enough to believe that the commit message
> being used by git svn contains a carriage return character
> (x'0D') and that has not been allowed in Subversion since
> version 1.6 (I can replicate this specific error message using
> an SVN dump file that contains x'0D' characters in the log
> messages.). However, I cannot find where I have any control
> over the log message that git svn is trying to use nor can I
> observe it. Note that I've also used the '-v' switch with the
> 'git svn dcommit', but do not receive anything other than what
> I am showing above.

Maybe git-for-windows isn't filtering CRLF into LF as "git commit"
does on GNU/Linux when the original commit was made?

I had to use "git commit-tree" to reproduce the error in testing
(instead of "git commit)"

Anyways, the one-line fix below should be enough for you.
Care to give it a shot?  Thanks again.


Junio: please pull when Brian confirms, thanks.

The following changes since commit 95ec6b1b3393eb6e26da40c565520a8db9796e9f:

  RelNotes: the eighth batch (2017-12-06 09:29:50 -0800)

are available in the git repository at:

  git://bogomips.org/git-svn.git svn-crlf

for you to fetch changes up to 95450bbbaaacaf2d603a4fbded25d55243dfb291:

  git-svn: convert CRLF to LF in commit message to SVN (2017-12-14 00:09:38 +0000)

----------------------------------------------------------------
Eric Wong (1):
      git-svn: convert CRLF to LF in commit message to SVN

 git-svn.perl                    |  1 +
 t/t9169-git-svn-dcommit-crlf.sh | 27 +++++++++++++++++++++++++++
 2 files changed, 28 insertions(+)
 create mode 100755 t/t9169-git-svn-dcommit-crlf.sh

------8<--------
Subject: [PATCH] git-svn: convert CRLF to LF in commit message to SVN

Subversion since 1.6 does not accept CR characters in the commit
message, so filter it out on our end before 'git svn dcommit' sets
the svn:log property.

Reported-by: Brian Bennett <Brian.Bennett@Transamerica.com>
Signed-off-by: Eric Wong <e@80x24.org>
---
 git-svn.perl                    |  1 +
 t/t9169-git-svn-dcommit-crlf.sh | 27 +++++++++++++++++++++++++++
 2 files changed, 28 insertions(+)
 create mode 100755 t/t9169-git-svn-dcommit-crlf.sh

diff --git a/git-svn.perl b/git-svn.perl
index d2404184ba..aa242d4f4f 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -1865,6 +1865,7 @@ sub get_commit_entry {
 			}
 		}
 		$msgbuf =~ s/\s+$//s;
+		$msgbuf =~ s/\r\n/\n/sg; # SVN 1.6+ disallows CRLF
 		if ($Git::SVN::_add_author_from && defined($author)
 		    && !$saw_from) {
 			$msgbuf .= "\n\nFrom: $author";
diff --git a/t/t9169-git-svn-dcommit-crlf.sh b/t/t9169-git-svn-dcommit-crlf.sh
new file mode 100755
index 0000000000..54b1f61a2a
--- /dev/null
+++ b/t/t9169-git-svn-dcommit-crlf.sh
@@ -0,0 +1,27 @@
+#!/bin/sh
+
+test_description='git svn dcommit CRLF'
+. ./lib-git-svn.sh
+
+test_expect_success 'setup commit repository' '
+	svn_cmd mkdir -m "$test_description" "$svnrepo/dir" &&
+	git svn clone "$svnrepo" work &&
+	(
+		cd work &&
+		echo foo >>foo &&
+		git update-index --add foo &&
+		printf "a\\r\\n\\r\\nb\\r\\nc\\r\\n" >cmt &&
+		p=$(git rev-parse HEAD) &&
+		t=$(git write-tree) &&
+		cmt=$(git commit-tree -p $p $t <cmt) &&
+		git update-ref refs/heads/master $cmt &&
+		git cat-file commit HEAD | tail -n4 >out &&
+		test_cmp cmt out &&
+		git svn dcommit &&
+		printf "a\\n\\nb\\nc\\n" >exp &&
+		git cat-file commit HEAD | sed -ne 6,9p >out &&
+		test_cmp exp out
+	)
+'
+
+test_done
-- 
EW
