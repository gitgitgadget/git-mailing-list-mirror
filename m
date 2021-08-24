Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37771C4338F
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 10:39:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14B5361265
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 10:39:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236248AbhHXKk0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 06:40:26 -0400
Received: from mail2.odoo.com ([149.202.180.44]:56296 "EHLO mail2.odoo.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235905AbhHXKkZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 06:40:25 -0400
Received: from [10.10.10.121] (host-109-88-121-142.dynamic.voo.be [109.88.121.142])
        (Authenticated sender: xmo)
        by mail2.odoo.com (Postfix) with ESMTPSA id 16988A28EE
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 12:23:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=odoo.com; s=mail;
        t=1629800604; bh=BnxNJPIYA6bLXPMpuuYF0eouDb7ZL5bYVNNEnZAOGKA=;
        h=To:References:Subject:In-Reply-To:From:Date:From;
        z=To:=20git@vger.kernel.org|References:=20<xmqqim68lp20.fsf@gitster
         .c.googlers.com>|Subject:=20=3D?UTF-8?Q?Re=3D3a_Proposal=3Dc3=3Db6
         _git_push_-F?=3D|In-Reply-To:=20<xmqqim68lp20.fsf@gitster.c.google
         rs.com>|From:=20Xavier=20Morel=20<xmo@odoo.com>|Date:=20Tue,=2024=
         20Aug=202021=2012:23:23=20+0200;
        b=h1vXsLk1f4gOA7LtxoOtN7bLpiUHQaIUJksGC+m0Qg4BQfWrcYAjLiXuSxM82e7j6
         /htKT/BNNM/AvBfBHKbGRXi/dZoXHGVu4KXmN9r7VMxWmOiRygsV6Mnk8PvOzKLcp9
         UrCAjJLIsOQwb4A0CyEoyeqn8hBysQatcEoznAgI=
To:     git@vger.kernel.org
References: <xmqqim68lp20.fsf@gitster.c.googlers.com>
Subject: =?UTF-8?Q?Re=3a_Proposal=c3=b6_git_push_-F?=
In-Reply-To: <xmqqim68lp20.fsf@gitster.c.googlers.com>
From:   Xavier Morel <xmo@odoo.com>
Organization: Odoo
Message-ID: <c49da491-f8a3-440f-54e2-295be8dbcfd7@odoo.com>
Date:   Tue, 24 Aug 2021 12:23:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

 > Because the form "--force-with-lease=<this-exact-commit>" is a
 > strict improvement over "--force", but the lazy "guess where the
 > other end should be" form, i.e. "--force-with-lease" alone, is worse
 > than "--force" in that it gives users false sense of security
 > without offering the safety the "lease" mechanism gives.

That seems like a case of the perfect being the enemy of the good.

Generaly, "force with lease" is a better behaviour than "force". It will 
not catch all usage errors, but it will catch lots: again last week 
colleagues had issues which would had been caught by caught by using 
"--force-with-lease" instead" of "-f", but of course "-f" is "the 
default" in rebase-based workflows, what with being so short and sweet.

I found XonqNopp's proposal as I was planning to post a similar message, 
though stricter: I don't think `--force` deserves a short form at all, I 
  believe `-f` should be progressively migrated over to alias to 
`force-with-lease` as it's a significantly better default behaviour, and 
the odd *need* for `--force` (of which I can't personnally remember one) 
can be typed out in its entirety.

For the vast majority of users, all it will do is catch genuine errors. 
For a small minority it will have no effect[0]. And for an infinitesimal 
number it will be unhelpful as `--force` without lease or inclusion is 
genuinely what they were looking for.

I genuinely do not understand what `force-if-includes` does from reading 
the manpage and just learned that it exists from Johannes Schindelin's 
message, it might be an even better default behaviour for `-f`.

Either way I think `-f` should not, ultimately, alias to `--force`.

My idea there was to introduce a setting initially defaulting to `false` 
and a warning about the migration (triggered on `-f` when that setting 
is unset), then a few versions later flip the default to `true`.

[0] and I would expect users of tools which helpfully fetch in the 
background to not be using the CLI, and thus not be impacted by this change.
