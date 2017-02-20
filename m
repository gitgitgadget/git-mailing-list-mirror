Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 884EC201A9
	for <e@80x24.org>; Mon, 20 Feb 2017 15:33:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753554AbdBTPd1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Feb 2017 10:33:27 -0500
Received: from avasout06.plus.net ([212.159.14.18]:51054 "EHLO
        avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753258AbdBTPd0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Feb 2017 10:33:26 -0500
Received: from deneb ([80.229.24.9])
        by avasout06 with smtp
        id n3ZP1u0020BmcFC013ZQA3; Mon, 20 Feb 2017 15:33:24 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=QoEu5R6d c=1 sm=1 tr=0
 a=E/9URZZQ5L3bK/voZ0g0HQ==:117 a=E/9URZZQ5L3bK/voZ0g0HQ==:17
 a=kj9zAlcOel0A:10 a=n2v9WMKugxEA:10 a=-An2I_7KAAAA:8 a=aCVza-qCjIvJvQUNRNEA:9
 a=CjuIK1q_8ugA:10 a=Sq34B_EcNBM9_nrAYB9S:22
Received: from mac by deneb with local (Exim 4.84_2)
        (envelope-from <mac@mcrowe.com>)
        id 1cfpxr-0002ov-02; Mon, 20 Feb 2017 15:33:23 +0000
Date:   Mon, 20 Feb 2017 15:33:22 +0000
From:   Mike Crowe <mac@mcrowe.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: git diff --quiet exits with 1 on clean tree with CRLF conversions
Message-ID: <20170220153322.GA8352@mcrowe.com>
References: <20170217212633.GA24937@mcrowe.com>
 <xmqqr32wqxr6.fsf@gitster.mtv.corp.google.com>
 <20170217221958.GA12163@mcrowe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170217221958.GA12163@mcrowe.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Friday 17 February 2017 at 22:19:58 +0000, Mike Crowe wrote:
> On Friday 17 February 2017 at 14:05:17 -0800, Junio C Hamano wrote:
> > Mike Crowe <mac@mcrowe.com> writes:
> > 
> > > If "git diff --quiet" finds it necessary to compare actual file contents,
> > > and a file requires CRLF conversion, then it incorrectly exits with an exit
> > > code of 1 even if there have been no changes.
> > >
> > > The patch below adds a test file that shows the problem.
> > 
> > If "git diff" does not show any output and "git diff --exit-code" or
> > "git diff --quiet" says there are differences, then it is a bug.
> > 
> > I would however have expected that any culprit would involve a code
> > that says "under QUICK option, we do not have to bother doing
> > this".  The part you quoted:
> > 
> > > 	if (!DIFF_FILE_VALID(p->one) || /* (1) */
> > > 	    !DIFF_FILE_VALID(p->two) ||
> > > 	    (p->one->oid_valid && p->two->oid_valid) ||
> > > 	    (p->one->mode != p->two->mode) ||
> > > 	    diff_populate_filespec(p->one, CHECK_SIZE_ONLY) ||
> > > 	    diff_populate_filespec(p->two, CHECK_SIZE_ONLY) ||
> > > 	    (p->one->size != p->two->size) ||
> > > 	    !diff_filespec_is_identical(p->one, p->two)) /* (2) */
> > > 		p->skip_stat_unmatch_result = 1;
> > 
> > is used by "git diff" with and without "--quiet", afacr, so I
> > suspect that the bug lies somewhere else.
> 
> I can't say that I really understand the code fully, but it appears that
> the first pass generates a queue of files that contain differences. The
> result of the quiet diff comes from the size of that queue,
> diff_queued_diff.nr, being non-zero in diffcore_std. I'm assuming that the
> result of the noisy diff comes from actually comparing the files.
> 
> But, I've only spent a short while looking so I may have got the wrong end
> of the stick.

Tricking Git into checking the actual file contents (by passing
--ignore-space-change for example) is sufficient to ensure that the exit
status is never 1 when it should be zero. (Of course that option has other
unwanted effects in this case.)

I think that if there's a risk that file contents will undergo conversion
then this should force the diff to check the file contents. Something like:

diff --git a/diff.c b/diff.c
index 051761b..bee1662 100644
--- a/diff.c
+++ b/diff.c
@@ -3413,13 +3413,14 @@ void diff_setup_done(struct diff_options *options)
 	/*
 	 * Most of the time we can say "there are changes"
 	 * only by checking if there are changed paths, but
-	 * --ignore-whitespace* options force us to look
-	 * inside contents.
+	 * --ignore-whitespace* options or text conversion
+	 * force us to look inside contents.
 	 */
 
 	if (DIFF_XDL_TST(options, IGNORE_WHITESPACE) ||
 	    DIFF_XDL_TST(options, IGNORE_WHITESPACE_CHANGE) ||
-	    DIFF_XDL_TST(options, IGNORE_WHITESPACE_AT_EOL))
+	    DIFF_XDL_TST(options, IGNORE_WHITESPACE_AT_EOL) ||
+	    DIFF_OPT_TST(options, ALLOW_TEXTCONV))
 		DIFF_OPT_SET(options, DIFF_FROM_CONTENTS);
 	else
 		DIFF_OPT_CLR(options, DIFF_FROM_CONTENTS);

This solves the problem for me and my test case now passes. Unfortunately
it breaks the 'removing and adding subproject' test case in
t3040-subprojects-basic at the line:

 test_expect_code 1 git diff -M --name-status --exit-code HEAD^ HEAD

presumably because after the rename has been detected the file contents are
identical. :( A rename of a single file appears to still be handled
correctly.

Mike.
