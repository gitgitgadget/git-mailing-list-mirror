Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 776481F6C1
	for <e@80x24.org>; Mon, 15 Aug 2016 21:54:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932249AbcHOVyr (ORCPT <rfc822;e@80x24.org>);
	Mon, 15 Aug 2016 17:54:47 -0400
Received: from mta02.prd.rdg.aluminati.org ([94.76.243.215]:51206 "EHLO
	mta02.prd.rdg.aluminati.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752957AbcHOVyr (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Aug 2016 17:54:47 -0400
Received: from mta02.prd.rdg.aluminati.org (localhost [127.0.0.1])
	by mta.aluminati.local (Postfix) with ESMTP id 7084F232BA;
	Mon, 15 Aug 2016 22:54:45 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by mta02.prd.rdg.aluminati.org (Postfix) with ESMTP id 607C333E9;
	Mon, 15 Aug 2016 22:54:45 +0100 (BST)
X-Quarantine-ID: <wmLNUigBO0Fn>
X-Virus-Scanned: Debian amavisd-new at mta02.prd.rdg.aluminati.org
Received: from mta.aluminati.local ([127.0.0.1])
	by localhost (mta02.prd.rdg.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id wmLNUigBO0Fn; Mon, 15 Aug 2016 22:54:43 +0100 (BST)
Received: from john.keeping.me.uk (unknown [10.2.0.9])
	by mta02.prd.rdg.aluminati.org (Postfix) with ESMTPSA id EEB1B33E5;
	Mon, 15 Aug 2016 22:54:39 +0100 (BST)
Date:	Mon, 15 Aug 2016 22:54:39 +0100
From:	John Keeping <john@keeping.me.uk>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	"Tom Tanner (BLOOMBERG/ LONDON)" <ttanner2@bloomberg.net>,
	davvid@gmail.com, git@vger.kernel.org
Subject: [PATCH v2] difftool: always honor fatal error exit codes
Message-ID: <20160815215439.kwt4jmjrtcufjmih@john.keeping.me.uk>
References: <57B19B9F0205070000390238_0_29566@p057>
 <xmqqa8gdhjgd.fsf@gitster.mtv.corp.google.com>
 <20160815213526.6m7gu2v3fhtmx6wj@john.keeping.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160815213526.6m7gu2v3fhtmx6wj@john.keeping.me.uk>
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

POSIX specifies 127 as the exit status for "command not found", 126 for
"command found but is not executable" and values greater than 128 if the
command terminated because it received a signal [1] and at least bash
and dash follow this specification, while diff utilities generally use
"1" for the exit status we want to ignore.

Handle any value of 126 or greater as a special value indicating that
some form of fatal error occurred.

[1] http://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_08_02

Signed-off-by: John Keeping <john@keeping.me.uk>
---
On Mon, Aug 15, 2016 at 10:35:26PM +0100, John Keeping wrote:
> On Mon, Aug 15, 2016 at 01:21:22PM -0700, Junio C Hamano wrote:
> > "Tom Tanner (BLOOMBERG/ LONDON)" <ttanner2@bloomberg.net> writes:
> > 
> > > From: gitster@pobox.com
> > > To: john@keeping.me.uk
> > > Cc: Tom Tanner (BLOOMBERG/ LONDON), davvid@gmail.com, git@vger.kernel.org
> > > At: 08/14/16 04:21:18
> > >
> > > John Keeping <john@keeping.me.uk> writes:
> > > ...
> > >> POSIX specifies 127 as the exit status for "command not found" and 126
> > >> for "command found but is not executable" [1] and at least bash and dash
> > >> follow this specification, while diff utilities generally use "1" for
> > >> the exit status we want to ignore.
> > >>
> > >> Handle 126 and 127 as special values, assuming that they always mean
> > >> that the command could not be executed.
> > >
> > > Sounds like a reasonable thing to do.  Will queue; thanks.
> > 
> > > Would it be possible to also treat signals (128 and above) as
> > > 'special' values as well (as I've seen some merge tools self
> > > destruct like that from time to time)
> > 
> > Certainly, it feels safer to notice an unusual exit status code and
> > error out to force the user to take notice, but that reasoning
> > assumes that "128 and above" are noteworthy exceptions.
> 
> Reading further in POSIX:
> 
> 	The exit status of a command that terminated because it received
> 	a signal shall be reported as greater than 128.
> 
> I think if we accept the argument above about diff utilities generally
> using low numbers for the status values we're ignoring intentionally,
> then we can just treat any value above 125 as a fatal error.

Here's what that looks like.

 git-difftool--helper.sh | 7 +++++++
 t/t7800-difftool.sh     | 6 ++++++
 2 files changed, 13 insertions(+)

diff --git a/git-difftool--helper.sh b/git-difftool--helper.sh
index 84d6cc0..7bfb673 100755
--- a/git-difftool--helper.sh
+++ b/git-difftool--helper.sh
@@ -86,6 +86,13 @@ else
 	do
 		launch_merge_tool "$1" "$2" "$5"
 		status=$?
+		if test $status -ge 126
+		then
+			# Command not found (127), not executable (126) or
+			# exited via a signal (>= 128).
+			exit $status
+		fi
+
 		if test "$status" != 0 &&
 			test "$GIT_DIFFTOOL_TRUST_EXIT_CODE" = true
 		then
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
2.9.3.728.g30b24b4

