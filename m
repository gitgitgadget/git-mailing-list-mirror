Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ACC2CCA481
	for <git@archiver.kernel.org>; Tue, 19 Jul 2022 11:59:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237710AbiGSL7e (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jul 2022 07:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237765AbiGSL7P (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jul 2022 07:59:15 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD165474F4
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 04:57:31 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 8B079223BC;
        Tue, 19 Jul 2022 11:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1658231850; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0DA2I3Xwv1bI71vSA6AeGr0Qhp3agEqx+hS2hvpP3tA=;
        b=EBRL2VMSkP9VcNc0F3HIXY8fM/rvcaRNh+0I/pzBREWWdRZwIch09TAJ9+qsnAx5Cm7ibb
        /goFtB1veEXl0a/V8wYfakhR9lIIbf8V5VnWjVocVYQLAR0I8KLQUj/F9X0uZl+uukfi+1
        GLaRCRgyHG1GWfqcoi7z/jRzYLotkfM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1658231850;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0DA2I3Xwv1bI71vSA6AeGr0Qhp3agEqx+hS2hvpP3tA=;
        b=KICEehiXpRGbdvD1TqtNyUpaFI5isoBYYCRlRTduuTWwg/gGQkbISIQyXBL59tMK7UY5uq
        Ftrm84FQ24VHR3BA==
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 6A94A2C145;
        Tue, 19 Jul 2022 11:57:30 +0000 (UTC)
Date:   Tue, 19 Jul 2022 13:57:29 +0200
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     Stephen Finucane <stephen@that.guru>, git@vger.kernel.org
Subject: Re: Feature request: provide a persistent IDs on a commit
Message-ID: <20220719115729.GV17705@kitsune.suse.cz>
References: <bdbe9b7c1123f70c0b4325d778af1df8fea2bb1b.camel@that.guru>
 <220718.86ilnuw8jo.gmgdl@evledraar.gmail.com>
 <61333be26339440d9bae8f12fd1a4faeb5e68ab6.camel@that.guru>
 <220719.86y1wpuy5o.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <220719.86y1wpuy5o.gmgdl@evledraar.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 19, 2022 at 01:09:02PM +0200, Ævar Arnfjörð Bjarmason wrote:
> 
> On Tue, Jul 19 2022, Stephen Finucane wrote:
> 
> > On Mon, 2022-07-18 at 20:50 +0200, Ævar Arnfjörð Bjarmason wrote:
> >> On Mon, Jul 18 2022, Stephen Finucane wrote:
> >> 
> >> > ...to track evolution of a patch through time.
> >> > 
> >> > tl;dr: How hard would it be to retrofit an 'ChangeID' concept à la the 'Change-
> >> > ID' trailer used by Gerrit into git core?
> >> > 
> >> > Firstly, apologies in advance if this is the wrong forum to post a feature
> >> > request. I help maintain the Patchwork project [1], which a web-based tool that
> >> > provides a mechanism to track the state of patches submitted to a mailing list
> >> > and make sure stuff doesn't slip through the crack. One of our long-term goals
> >> > has been to track the evolution of an individual patch through multiple
> >> > revisions. This is surprisingly hard goal because oftentimes there isn't a whole
> >> > lot to work with. One can try to guess whether things are the same by inspecting
> >> > the metadata of the commit (subject, author, commit message, and the diff
> >> > itself) but each of these metadata items are subject to arbitrary changes and
> >> > are therefore fallible.
> >> > 
> >> > One of the mechanisms I've seen used to address this is the 'Change-ID' trailer
> >> > used by Gerrit. For anyone that hasn't seen this, the Gerrit server provides a
> >> > git commit hook that you can install locally. When installed, this appends a
> >> > 'Change-ID' trailer to each and every commit message. In this way, the evolution
> >> > of a patch (or a "change", in Gerrit parlance) can be tracked through time since
> >> > the Change ID provides an authoritative answer to the question "is this still
> >> > the same patch". Unfortunately, there are still some obvious downside to this
> >> > approach. Not only does this additional trailer clutter your commit messages but
> >> > it's also something the user must install themselves. While Gerrit can insist
> >> > that this is installed before pushing a change, this isn't an option for any of
> >> > the common forges nor is it something git-send-email supports.
> >> 
> >> git format-patch+send-email will send your trailers along as-is, how
> >> doesn't it support Change-Id. Does it need some support that any other
> >> made-up trailer doesn't?
> >
> > It supports sending the trailers, sure. What it doesn't support is insisting you
> > send this specific trailer (Change-Id). Only Gerrit can do this (server side,
> > thankfully, which means you don't need to ask all contributors to install this
> > hook if you want to rely on it for tooling, CI, etc.).
> 
> Ah, it's still unclear to me what you're proposing here though. That
> send-email always (generates?) or otherwise insists on the trailer, that
> it can be configured ot add it?

And isn't send-email time too late?

That would mean that you get new ID for every version of the patch sent.

Thanks

Michal
