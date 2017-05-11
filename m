Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2BAA91FF34
	for <e@80x24.org>; Thu, 11 May 2017 06:53:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752639AbdEKGw7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 May 2017 02:52:59 -0400
Received: from mailhub.007spb.ru ([84.204.203.130]:34262 "EHLO
        mailhub.007spb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750917AbdEKGw6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2017 02:52:58 -0400
Received: from tigra (tigra.domain007.com [192.168.2.102])
        by hermes.domain007.com (Postfix) with SMTP id 74B79D400A6;
        Thu, 11 May 2017 09:52:55 +0300 (MSK)
Date:   Thu, 11 May 2017 09:52:55 +0300
From:   Konstantin Khomoutov <kostix+git@007spb.ru>
To:     Jonny Gilchrist <jonnygilchrist@gmail.com>
Cc:     Samuel Lijin <sxlijin@gmail.com>, git@vger.kernel.org
Subject: Re: git log --follow after subtree merge
Message-ID: <20170511065255.leesebylo4jyj45j@tigra>
References: <CA+qhfwO4=1X9fNCW2PeKSgqUHV-z26qhvr_yXfz1QGApJ_roRQ@mail.gmail.com>
 <CAJZjrdX-oAP7GFcPJ_FVNCMuErF7DNkq97KhjwgBX_G5tGXoFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+qhfwO4=1X9fNCW2PeKSgqUHV-z26qhvr_yXfz1QGApJ_roRQ@mail.gmail.com>
 <CAJZjrdX-oAP7GFcPJ_FVNCMuErF7DNkq97KhjwgBX_G5tGXoFg@mail.gmail.com>
User-Agent: NeoMutt/20170306 (1.8.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 10, 2017 at 02:15:23PM -0500, Samuel Lijin wrote:

> On Wed, May 10, 2017 at 9:46 AM, Jonny Gilchrist
> <jonnygilchrist@gmail.com> wrote:
> > Hi,
> >
> > After doing a subtree merge, using 'git log' and 'git log --follow' on
> > files in the subtree show only the merge commit in which they were
> > added.
> >
> > After reading around I understand that the issue is that git log
> > --follow doesn't track renames that occur during a merge.
> 
> Try git log --follow -M. (You may also want to combine this with -l and/or -C).
> 
> > Has there been any work (or are there any plans) to allow git log
> > --follow to work in this case? I couldn't find anything in the mailing
> > list archives aside from a couple of threads from 2011 explaining the
> > issue.

Please note that technicaly there wasn't any "rename during merging":
the subtree merge took the three object of the tip commit you were
merging and recorded in in the merge commit as appearing under another
tree object -- identifying the directory which was used as the subtree
prefix.  The result is that the merge commit and the commits recorded
after it have the files of the merged-in history under that prefix, but
the merged-in history itself has them "as is".

Since Git does not record renames (that is, the `git mv` command does
not record a rename either -- the file it "moves" merely "reappears" in
the next commit under a different name), there are two solutions to your
problem.  The first one is to use the usual heuristics of rename/copy
detection at the time of the history traversal -- as suggested by
Samuel.

The second one -- if you don't need the merged-in history to be kept
"pristine" -- is to first run a `git filter-branch` command on it to
relocate the files in all the reachable commits it contains under the
same prefix which you have used for subtree merge and then do that
subtree merge.

Of course, that only works if that history is "yours" and the merging is
considered to be a one-off operation (that is, you won't be updating the
original merged-in line of development).

