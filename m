Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FE27C4338F
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 08:10:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6636B61371
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 08:10:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235295AbhHWILE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Aug 2021 04:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235443AbhHWIK4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Aug 2021 04:10:56 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74F0AC061575
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 01:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=qN6zie32eJk47iuKi6DCOpSF1WlhduqDz8T6XVVSwzg=;
        t=1629706214; x=1630915814; b=nUCWTdPGOXJ+ydPhRuSMI8u5kvhaftOFXF50hSI4ylPKryY
        qx3ZyePtShLL1UNJRjfNbP30QilmO1cB6xNb0964N9PTjEm2E7an2/pFr4kzw49Pm9SDkkvtn9bE+
        Y5AaDw/gIBiO3zM02rvNfObmXF/PpF1VXutMkr8CqEsOfmX9fmfxMSbDuuvLuske6fKSFH61xi1R4
        XfEi73D6QhR5+kWX4bu+Gee51VToCX7PgC/y8XehCRvHVYrC8slzHVqDiGxWAROgPMfYTl2q1UjzL
        VD28Hn4oJhmtJR2hfOnhN/K4CD+JpyFeXPV/48COK7zpWjkx1QKKZjDEZWSEnGhQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1mI523-00ElMk-IG; Mon, 23 Aug 2021 10:10:11 +0200
Message-ID: <caafaf945ec43ba606b054bf4c4faa42e35a8db1.camel@sipsolutions.net>
Subject: Re: [PATCH] multi-pack-index: fix --object-dir from outside repo
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org,
        Taylor Blau <me@ttaylorr.com>
Date:   Mon, 23 Aug 2021 10:10:10 +0200
In-Reply-To: <xmqqo89osi0b.fsf@gitster.g>
References: <20210820193504.37044-1-johannes@sipsolutions.net>
         <04ed58aa-94fa-010e-f4db-f41cd51876a5@gmail.com>
         <4d65ef5b0a9e4104d763facc42d10a20557d054d.camel@sipsolutions.net>
         <xmqqo89osi0b.fsf@gitster.g>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 2021-08-23 at 01:05 -0700, Junio C Hamano wrote:
> Johannes Berg <johannes@sipsolutions.net> writes:
> 
> > I just needed to go outside the current test git directory, the tests
> > are running in a way that the current working directory is already the
> > git tree I'm operating in.
> > 
> > > Even if you mean to use "cd",
> > > please do so within a sub-shell.
> > 
> > I thought about it, but clearly all the tests are run in a sub-shell, so
> > it didn't seem necessary? But happy to change, I don't really care
> > either way.
> 
> Please learn to care before you write your next test, then ;-)

Hey now, I'm fixing your segfaults ;-)

> These tests are not run in a sub-shell; they are eval'ed, so that
> the assignment they make to variables can persist and affect the
> next test piece.

Makes sense. FWIW, the test *did* restore the CWD so things worked, and
subshells are actually ugly (need to import test-lib-functions.sh again
if you want to use those), but I'll make it work somehow.


More importantly, how do you feel about the "cd /"?

The tests are always run in a place where there's a parent git folder
(even if it's git itself), so you cannot reproduce the segfault in a
test without the "cd /", though I guess "cd /tmp" would also work or
something, but "cd /" felt pretty safe, hopefully not many people have
"/.git" on their system.

johannes

