Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 28DE61FF40
	for <e@80x24.org>; Mon, 19 Dec 2016 22:30:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932923AbcLSW32 (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Dec 2016 17:29:28 -0500
Received: from locusts.copyleft.no ([188.94.218.116]:57507 "EHLO
        mail.mailgateway.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932473AbcLSW31 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2016 17:29:27 -0500
X-Greylist: delayed 1442 seconds by postgrey-1.27 at vger.kernel.org; Mon, 19 Dec 2016 17:29:27 EST
Received: from mail-qk0-f178.google.com ([209.85.220.178])
        by mail.mailgateway.no with esmtpsa (TLSv1:AES128-SHA:128)
        (Exim 4.72 (FreeBSD))
        (envelope-from <johan@herland.net>)
        id 1cJ63f-000Ivg-Sz
        for git@vger.kernel.org; Mon, 19 Dec 2016 23:05:24 +0100
Received: by mail-qk0-f178.google.com with SMTP id t184so29673098qkd.0
        for <git@vger.kernel.org>; Mon, 19 Dec 2016 14:05:23 -0800 (PST)
X-Gm-Message-State: AIkVDXKP+CP69w8kdilpijvMJiTt5oxCiDM5K7+l0d3SAHLlldu6+llIqyHCiLa2QEPXWrFIMBYdEqBR+aSjfg==
X-Received: by 10.55.144.70 with SMTP id s67mr2742748qkd.290.1482185117765;
 Mon, 19 Dec 2016 14:05:17 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.170.79 with HTTP; Mon, 19 Dec 2016 14:05:17 -0800 (PST)
In-Reply-To: <20161219021212.15978-1-mh@glandium.org>
References: <20161219021212.15978-1-mh@glandium.org>
From:   Johan Herland <johan@herland.net>
Date:   Mon, 19 Dec 2016 23:05:17 +0100
X-Gmail-Original-Message-ID: <CALKQrgepfK3Unk-pq4ZpU2EmoPg6u8KYPkgEAKU1F1D1N9WtqA@mail.gmail.com>
Message-ID: <CALKQrgepfK3Unk-pq4ZpU2EmoPg6u8KYPkgEAKU1F1D1N9WtqA@mail.gmail.com>
Subject: Re: [PATCH] fast-import: properly fanout notes when tree is imported
To:     Mike Hommey <mh@glandium.org>
Cc:     Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 19, 2016 at 3:12 AM, Mike Hommey <mh@glandium.org> wrote:
> In typical uses of fast-import, trees are inherited from a parent
> commit. In that case, the tree_entry for the branch looks like:
>
>   .versions[1].sha1 = $some_sha1
>   .tree = <tree structure loaded from $some_sha1>
>
> However, when trees are imported, rather than inherited, that is not the
> case. One can import a tree with a filemodify command, replacing the
> root tree object.
>
> e.g.
>   "M 040000 $some_sha1 \n"
>
> In this case, the tree_entry for the branch looks like:
>
>   .versions[1].sha1 = $some_sha1
>   .tree = NULL
>
> When adding new notes with the notemodify command, do_change_note_fanout
> is called to get a notes count, and to do so, it loops over the
> tree_entry->tree, but doesn't do anything when the tree is NULL.
>
> In the latter case above, it means do_change_note_fanout thinks the tree
> contains no note, and new notes are added with no fanout.

s/note,/notes,/

>
> Interestingly, do_change_note_fanout does check whether subdirectories
> have a NULL .tree, in which case it uses load_tree(). Which means the
> right behaviour happens when using the filemodify command to import
> subdirectories.
>
> This change makes do_change_note_fanount call load_tree() whenever the
> tree_entry it is given has no tree loaded, making all cases handled
> equally.
>
> Signed-off-by: Mike Hommey <mh@glandium.org>

Acked-by: Johan Herland <johan@herland.net>
