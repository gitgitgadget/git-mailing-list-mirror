Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 283171F461
	for <e@80x24.org>; Fri, 30 Aug 2019 14:27:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728021AbfH3O1c (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Aug 2019 10:27:32 -0400
Received: from cloud.peff.net ([104.130.231.41]:34682 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727751AbfH3O1b (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Aug 2019 10:27:31 -0400
Received: (qmail 12841 invoked by uid 109); 30 Aug 2019 14:27:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 30 Aug 2019 14:27:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6446 invoked by uid 111); 30 Aug 2019 14:29:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 30 Aug 2019 10:29:01 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 30 Aug 2019 10:27:30 -0400
From:   Jeff King <peff@peff.net>
To:     Dmitry Nikulin <pastafariant@gmail.com>
Cc:     phillip.wood@dunelm.org.uk, Junio C Hamano <gitster@pobox.com>,
        git@vger.kernel.org
Subject: Re: git-diff passes <rev>:<path> args to GIT_EXTERNAL_DIFF
 incorrectly?
Message-ID: <20190830142730.GB16327@sigill.intra.peff.net>
References: <CAH53SykX12SN83=gey8KS_x3cGkXH758sfEieskXnnvos8DMcA@mail.gmail.com>
 <xmqqtva0zkvu.fsf@gitster-ct.c.googlers.com>
 <CAH53SymNwjrh_CzXVVtU5xABuGQWMsXhRDYyRzyHEwuxLWA2NQ@mail.gmail.com>
 <9c280a3f-6a1a-61d1-a255-1dcf0671d39c@gmail.com>
 <CAH53SykQWLtjt0gWVrz5KyH-9WyqaQ0GtkhmyLt09QEqcAS_dw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAH53SykQWLtjt0gWVrz5KyH-9WyqaQ0GtkhmyLt09QEqcAS_dw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 30, 2019 at 04:23:13PM +0300, Dmitry Nikulin wrote:

> On Fri, 30 Aug 2019 at 13:16, Phillip Wood <phillip.wood123@gmail.com> wrote:
> > I'm not sure why the last argument is being split in
> > your example. It is not split in the example below
> 
> I have replicated the splitting issue on my small demo repo [1]:
> 
> $ env GIT_EXTERNAL_DIFF=./print_argv.py git diff -M origin/branch1
> origin/branch1-mv -- file1.txt file1-mv.txt
> ['./print_argv.py',
>  'file1.txt',
>  '/tmp/EWaCSc_file1.txt',
>  '2bef330804cb3f6962e45a72a12a3071ee9b5888',
>  '100644',
>  '/tmp/mtEiSc_file1-mv.txt',
>  'f8fd6737fbe5a45c97ba9c9de495dc46ff11eccd',
>  '100644',
>  'file1-mv.txt',
>  'similarity index 90%\n'
>  'rename from file1.txt\n'
>  'rename to file1-mv.txt\n'
>  'index 2bef330..f8fd673 100644\n']

Interesting. I _don't_ see that splitting when I run the same command in
your demo repo (nor, looking at Git's code, do I see how it could
happen; we always add the metainfo as a single argument).

> This is, however, tangential to the original problem: documenting the
> external diff CLI interface for diffing two blobs. Here is what I am
> seeing:
> 
> $ env GIT_EXTERNAL_DIFF=./print_argv.py git diff
> origin/branch1:file1.txt origin/branch1-mv:file1-mv.txt
> ['./print_argv.py',
>  'file1.txt',
>  '/tmp/n9USvy_file1.txt',
>  '2bef330804cb3f6962e45a72a12a3071ee9b5888',
>  '100644',
>  '/tmp/Zst0uy_file1-mv.txt',
>  'f8fd6737fbe5a45c97ba9c9de495dc46ff11eccd',
>  '100644',
>  'file1-mv.txt',
>  'index 2bef330..f8fd673 100644\n']
> 
> The meaning and origin of the last arg remains mysterious, and the
> other args do not conform to the published documentation[2], which
> states that the args should be:
> 
>     path old-file old-hex old-mode new-file new-hex new-mode
> 
> Instead the args that are passed are:
> 
>     path old-filename old-file old-hex old-mode new-file new-hex
> new-mode new-filename something

I think you have an extra "old-filename" in the second list. Without
that, the first 7 arguments are as documented.

The last two are:

  - when the destination path differs from the source path, we append
    it. This is generally a sign of a rename/copy, though it triggers
    in the blob case because Git has been manually given a pair of files
    with non-matching names.

  - the final one is metainfo that Git typically prints between the
    "diff" header and the diff itself. This is added only when we add
    the filename, and would generally carry information about the rename
    (but of course since there isn't one, it has only the index line).

These were both added by 427dcb4bca ([PATCH] Diff overhaul, adding half
of copy detection., 2005-05-21). I think the intent was that existing
diff commands would/could ignore the extra arguments.

Certainly the world would be a better place if those were described in
the external-diff documentation (specifically in relation to renames,
which is their intended use).

As for the behavior in the blob-diff case, I think it's _pretty_
reasonable. It's certainly useful to give the new-filename. The metainfo
is mostly useless in this case, and potentially could be suppressed if
the pair is not an actual rename/copy. But I also think it's not hurting
much (and a script can tell that's what's going on by the lack of rename
lines in the metainfo).

-Peff
