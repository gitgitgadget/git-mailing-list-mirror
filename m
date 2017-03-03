Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D8FDC20133
	for <e@80x24.org>; Fri,  3 Mar 2017 17:01:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751734AbdCCRBu (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Mar 2017 12:01:50 -0500
Received: from avasout06.plus.net ([212.159.14.18]:40407 "EHLO
        avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751754AbdCCRBp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Mar 2017 12:01:45 -0500
Received: from deneb ([80.229.24.9])
        by avasout06 with smtp
        id rV1i1u0040BmcFC01V1j1h; Fri, 03 Mar 2017 17:01:43 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=QoEu5R6d c=1 sm=1 tr=0
 a=E/9URZZQ5L3bK/voZ0g0HQ==:117 a=E/9URZZQ5L3bK/voZ0g0HQ==:17
 a=8nJEP1OIZ-IA:10 a=6Iz7jQTuP9IA:10 a=ybZZDoGAAAAA:8 a=-An2I_7KAAAA:8
 a=YtztpdHs-eMnB8EqWicA:9 a=_zN_YUlkvOLGN9i-:21 a=rKTFkQOd2Ub_rn0C:21
 a=wPNLvfGTeEIA:10 a=0RhZnL1DYvcuLYC8JZ5M:22 a=Sq34B_EcNBM9_nrAYB9S:22
Received: from mac by deneb with local (Exim 4.84_2)
        (envelope-from <mac@mcrowe.com>)
        id 1cjqaM-0003jx-5l; Fri, 03 Mar 2017 17:01:42 +0000
Date:   Fri, 3 Mar 2017 17:01:42 +0000
From:   Mike Crowe <mac@mcrowe.com>
To:     Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v1 1/1] git diff --quiet exits with 1 on clean tree with
 CRLF conversions
Message-ID: <20170303170142.GA14150@mcrowe.com>
References: <xmqqshmyhtnu.fsf@gitster.mtv.corp.google.com>
 <20170301170444.14274-1-tboegi@web.de>
 <20170301212535.GA6878@mcrowe.com>
 <5d92d3b8-f438-9be5-9742-22f8cd8fe03d@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5d92d3b8-f438-9be5-9742-22f8cd8fe03d@web.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Torsten,

Your patch has been superseded, but I thought I ought to answer your
questions rather than leave them hanging.

On Thursday 02 March 2017 at 19:17:00 +0100, Torsten Bögershausen wrote:
> On 2017-03-01 22:25, Mike Crowe wrote:
> > On Wednesday 01 March 2017 at 18:04:44 +0100, tboegi@web.de wrote:
> >> From: Junio C Hamano <gitster@pobox.com>
> >>
> >> git diff --quiet may take a short-cut to see if a file is changed
> >> in the working tree:
> >> Whenever the file size differs from what is recorded in the index,
> >> the file is assumed to be changed and git diff --quiet returns
> >> exit with code 1
> >>
> >> This shortcut must be suppressed whenever the line endings are converted
> >> or a filter is in use.
> >> The attributes say "* text=auto" and a file has
> >> "Hello\nWorld\n" in the index with a length of 12.
> >> The file in the working tree has "Hello\r\nWorld\r\n" with a length of 14.
> >> (Or even "Hello\r\nWorld\n").
> >> In this case "git add" will not do any changes to the index, and
> >> "git diff -quiet" should exit 0.
> >>
> >> Add calls to would_convert_to_git() before blindly saying that a different
> >> size means different content.
> >>
> >> Reported-By: Mike Crowe <mac@mcrowe.com>
> >> Signed-off-by: Torsten Bögershausen <tboegi@web.de>
> >> ---
> >> This is what I can come up with, collecting all the loose ends.
> >> I'm not sure if Mike wan't to have the Reported-By with a
> >> Signed-off-by ?
> >> The other question is, if the commit message summarizes the discussion
> >> well enough ?
> >>
> >> diff.c                    | 18 ++++++++++++++----
> >>  t/t0028-diff-converted.sh | 27 +++++++++++++++++++++++++++
> >>  2 files changed, 41 insertions(+), 4 deletions(-)
> >>  create mode 100755 t/t0028-diff-converted.sh
> >>
> >> diff --git a/diff.c b/diff.c
> >> index 051761b..c264758 100644
> >> --- a/diff.c
> >> +++ b/diff.c
> >> @@ -4921,9 +4921,10 @@ static int diff_filespec_check_stat_unmatch(struct diff_filepair *p)
> >>  	 *    differences.
> >>  	 *
> >>  	 * 2. At this point, the file is known to be modified,
> >> -	 *    with the same mode and size, and the object
> >> -	 *    name of one side is unknown.  Need to inspect
> >> -	 *    the identical contents.
> >> +	 *    with the same mode and size, the object
> >> +	 *    name of one side is unknown, or size comparison
> >> +	 *    cannot be depended upon.  Need to inspect the
> >> +	 *    contents.
> >>  	 */
> >>  	if (!DIFF_FILE_VALID(p->one) || /* (1) */
> >>  	    !DIFF_FILE_VALID(p->two) ||
> >> @@ -4931,7 +4932,16 @@ static int diff_filespec_check_stat_unmatch(struct diff_filepair *p)
> >>  	    (p->one->mode != p->two->mode) ||
> >>  	    diff_populate_filespec(p->one, CHECK_SIZE_ONLY) ||
> >>  	    diff_populate_filespec(p->two, CHECK_SIZE_ONLY) ||
> >> -	    (p->one->size != p->two->size) ||
> >> +
> >> +	    /*
> >> +	     * only if eol and other conversions are not involved,
> >> +	     * we can say that two contents of different sizes
> >> +	     * cannot be the same without checking their contents.
> >> +	     */
> >> +	    (!would_convert_to_git(p->one->path) &&
> >> +	     !would_convert_to_git(p->two->path) &&
> >> +	     (p->one->size != p->two->size)) ||
> >> +
> >>  	    !diff_filespec_is_identical(p->one, p->two)) /* (2) */
> >>  		p->skip_stat_unmatch_result = 1;
> >>  	return p->skip_stat_unmatch_result;
> >> diff --git a/t/t0028-diff-converted.sh b/t/t0028-diff-converted.sh
> >> new file mode 100755
> >> index 0000000..3d5ab95
> >> --- /dev/null
> >> +++ b/t/t0028-diff-converted.sh
> >> @@ -0,0 +1,27 @@
> >> +#!/bin/sh
> >> +#
> >> +# Copyright (c) 2017 Mike Crowe
> >> +#
> >> +# These tests ensure that files changing line endings in the presence
> >> +# of .gitattributes to indicate that line endings should be ignored
> >> +# don't cause 'git diff' or 'git diff --quiet' to think that they have
> >> +# been changed.
> >> +
> >> +test_description='git diff with files that require CRLF conversion'
> >> +
> >> +. ./test-lib.sh
> >> +
> >> +test_expect_success setup '
> >> +	echo "* text=auto" >.gitattributes &&
> >> +	printf "Hello\r\nWorld\r\n" >crlf.txt &&
> >> +	git add .gitattributes crlf.txt &&
> >> +	git commit -m "initial"
> >> +'
> >> +
> >> +test_expect_success 'quiet diff works on file with line-ending change that has no effect on repository' '
> >> +	printf "Hello\r\nWorld\n" >crlf.txt &&
> >> +	git status &&
> >> +	git diff --quiet
> >> +'
> >> +
> >> +test_done
> >

[snip]

> > Also, I think I've found a behaviour change with this fix. Consider:
> > 
> >  echo "* text=auto" >.gitattributes
> >  printf "Hello\r\nWorld\r\n" >crlf.txt
> That should give
> "Hello\nWorld\n" in the index:
> 
> git add .gitattributes crlf.txt
> warning: CRLF will be replaced by LF in ttt/crlf.txt.
> The file will have its original line endings in your working directory.
> tb@mac:/tmp/ttt> git commit -m "initial"
> [master (root-commit) 354f657] initial
>  2 files changed, 3 insertions(+)
>  create mode 100644 ttt/.gitattributes
>  create mode 100644 ttt/crlf.txt
> tb@mac:/tmp/ttt> git ls-files --eol
> i/lf    w/lf    attr/text=auto          .gitattributes
> i/lf    w/crlf  attr/text=auto          crlf.txt
> tb@mac:/tmp/ttt>
> 
> >  git add .gitattributes crlf.txt
> >  git commit -m "initial"
> > 
> >  printf "\r\n" >>crlf.txt
> > 
> > With the above patch, both "git diff" and "git diff --quiet" report that
> > there are no changes. Previously Git would report the extra newline
> > correctly.
> Wait a second.
> Which extra newline "correctly" ?

The extra newline I appended with the printf "\r\n" >> crlf.txt

> The "git diff" command is about the changes which will be done to the index.
> Regardless if you have any of these in the working tree on disk:
> 
> "Hello\nWorld\n"
> "Hello\nWorld\r\n"
> "Hello\r\nWorld\n"
> "Hello\r\nWorld\r\n"
> 
> "git status" and "git diff --quiet"
> should not report any changes.

But I didn't have any of those. I ended up with:

 "Hello\nWorld\n"

in the index, and

 "Hello\r\nWorld\r\n\r\n"

in the working tree, but the extra newline was not reported by git diff.

> So I don't know if there is a mis-understanding about "git diff" on your side,
> or if I miss something.

I don't think it matters any more since Junio's patch didn't suffer from
this problem.

Thanks.

Mike.
