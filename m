Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B783C63799
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 11:27:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DE7461279
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 11:27:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240254AbhGUKqR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jul 2021 06:46:17 -0400
Received: from mail.z3ntu.xyz ([128.199.32.197]:46534 "EHLO mail.z3ntu.xyz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238971AbhGUKBU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jul 2021 06:01:20 -0400
Received: by mail.z3ntu.xyz (Postfix, from userid 182)
        id BE2BEC92DA; Wed, 21 Jul 2021 10:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1626864108; bh=DA7q8I5D7/RSMfllfEn3VRm/KKvpxBCB6LBE/iwaXW0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=WYHehVN19/nSY2SwBTC7D0X0hkcWa5iD1NCmP6fKoLigpKQN1muZW134vVUOLtc4H
         OCd2tKdkPEesl1xQ2W99rezHcZET8za7mqV51kXSDQKDuY77sgJd2g2PTYLPR/bMqM
         pW7/7mORJK7ise5+GGtM0NDpphKuHUgyYYJIH/Gk=
Received: from g550jk.localnet (ip-213-127-63-121.ip.prioritytelecom.net [213.127.63.121])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 5ED1CC58DC;
        Wed, 21 Jul 2021 10:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1626864105; bh=DA7q8I5D7/RSMfllfEn3VRm/KKvpxBCB6LBE/iwaXW0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=etk8gRoTS5BpqQAeaaPA1akCZ/is4A5RhGeKof4NqZxo2EoQDcrvepEb1FHyRi3zn
         x5aMZkZsUR2jC50Xk8WCItwlx1+PjKPOq7ajsyaZMfBAt8JVxrOJHVlLEGPA6dJbCq
         62CupIbG83Ulvgtb1jSpNgcUWMdGtgXW6i86sXuI=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     phillip.wood@dunelm.org.uk, Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Luca Weiss via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Denton Liu <liu.denton@gmail.com>
Subject: Re: [PATCH 2/2] merge: make sure to terminate message with newline
Date:   Wed, 21 Jul 2021 12:41:44 +0200
Message-ID: <7464462.Hysq1jLez0@g550jk>
In-Reply-To: <YPMXqLESKApq2uPI@coredump.intra.peff.net>
References: <pull.1048.git.git.1626421416.gitgitgadget@gmail.com> <693954a7-af64-67c5-41b9-b648a9fe3ef2@gmail.com> <YPMXqLESKApq2uPI@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Samstag, 17. Juli 2021 19:47:20 CEST Jeff King wrote:
> On Sat, Jul 17, 2021 at 02:40:55PM +0100, Phillip Wood wrote:
> > > which would cover that case. But Phillip mentioned that our own
> > > fmt_merge_msg() does not include a newline.
> > 
> > I mentioned that we remove the newline that is added by fmt_merge_msg(),
> > not that there is no newline added by fmt_merge_msg() - maybe I wasn't
> > clear enough. In builtin/merge.c:prepare_merge_message() we do
> > 
> > 	fmt_merge_msg(merge_names, merge_msg, &opts);
> > 	if (merge_msg->len)
> > 	
> > 		strbuf_setlen(merge_msg, merge_msg->len - 1);
> 
> Of maybe I didn't read carefully enough. :)
> 
> Either way, thanks for clarifying. Doing something like:
> 
>   cat >.git/hooks/commit-msg <<\EOF
>   #!/bin/sh
>   xxd "$1"
>   EOF
>   chmod +x .git/hooks/commit-msg
> 
>   git merge --no-edit ...
> 
> shows off the problem; the hook sees that intermediate state.
> 
> Likewise if we do:
> 
>   git merge -m "foo" ...
> 
> which similarly suppresses the editor. There are actually two
> interesting cases here:
> 
>   - if merge.log is not set, then we'd see "foo" with no newline
> 
>   - if it is set, we'll get a newline after "foo", but with no newline
>     after the log data
> 
> Likewise for:
> 
>   printf foo >no-newline
>   git merge -F no-newline ...
> 
> So I think we'd probably want to see a 3-patch series:
> 
>   1. Make interpret-trailers handle input missing the final newline.
>      This isn't strictly necessary after patches 2 and 3, but it makes
>      sense to be more robust with unexpected input.
> 
>   2. Drop the newline-stripping from prepare_merge_message(). The
>      examples above show some ways we could cover this in the tests.
>      This will help --no-edit case, but also using merge.log with "-m"
>      or "-F".
> 
>   3. Teach prepare_to_commit() to add the extra newline before letting
>      hooks see the message. This should probably be done only when
>      cleanup_mode != COMMIT_MSG_CLEANUP_NONE.
> 
> Luca, do you want to try revising your series in that direction?
> 
> -Peff

Hi Peff,

if you have a good idea on how to create these patches, feel free to do so.
If not, I can take a shot at it this or next week.

Regards
Luca


