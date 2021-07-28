Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEAE6C4338F
	for <git@archiver.kernel.org>; Wed, 28 Jul 2021 15:17:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8E236023F
	for <git@archiver.kernel.org>; Wed, 28 Jul 2021 15:17:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237056AbhG1PRq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Jul 2021 11:17:46 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:17756 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236901AbhG1PRh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jul 2021 11:17:37 -0400
Received: from host-84-13-154-214.opaltelecom.net ([84.13.154.214] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1m8lJN-000BJl-CB; Wed, 28 Jul 2021 16:17:34 +0100
Subject: Re: [PATCH v7 3/3] bundle doc: elaborate on rev<->ref restriction
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <cover-0.3-00000000000-20210702T112254Z-avarab@gmail.com>
 <cover-0.3-0000000000-20210727T002001Z-avarab@gmail.com>
 <patch-3.3-88e7ad1cf4-20210727T002001Z-avarab@gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <42d4fb18-f9ee-006d-b20a-af8708096fd8@iee.email>
Date:   Wed, 28 Jul 2021 16:17:33 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <patch-3.3-88e7ad1cf4-20210727T002001Z-avarab@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 27/07/2021 01:24, Ævar Arnfjörð Bjarmason wrote:
> Elaborate on the restriction that you cannot provide a revision that
> doesn't resolve to a reference in the "SPECIFYING REFERENCES" section
> with examples.
>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  Documentation/git-bundle.txt | 47 ++++++++++++++++++++++++++++++------
>  1 file changed, 39 insertions(+), 8 deletions(-)
>
> diff --git a/Documentation/git-bundle.txt b/Documentation/git-bundle.txt
> index f1f84ce2c4..0f28c41409 100644
> --- a/Documentation/git-bundle.txt
> +++ b/Documentation/git-bundle.txt
> @@ -144,14 +144,45 @@ unbundle <file>::
>  SPECIFYING REFERENCES
>  ---------------------
>  
> -'git bundle' will only package references that are shown by
> -'git show-ref': this includes heads, tags, and remote heads.  References
> -such as `master~1` cannot be packaged, but are perfectly suitable for
> -defining the basis.  More than one reference may be packaged, and more
> -than one basis can be specified.  The objects packaged are those not
> -contained in the union of the given bases.  Each basis can be
> -specified explicitly (e.g. `^master~10`), or implicitly (e.g.
> -`master~10..master`, `--since=10.days.ago master`).
> +Revisions must accompanied by reference names to be packaged in a
> +bundle, since the header of the bundle is in a format similar to 'git
> +show-ref'.
> +
> +More than one reference may be packaged, and more than one basis can
> +be specified.  The objects packaged are those not contained in the
> +union of the given bases.
> +
> +The 'git bundle create' command resolves the reference names for you
> +using the same rules as `git rev-parse --abbrev-ref=loose`. Each
> +basis can be specified explicitly (e.g. `^master~10`), or implicitly
> +(e.g. `master~10..master`, `--since=10.days.ago master`).
> +
> +All of these simple cases are OK (assuming we have a "master" and
> +"next" branch):
> +
> +----------------
> +$ git bundle create master.bundle master
> +$ echo master | git bundle create master.bundle --stdin
> +$ git bundle create master-and-next.bundle master next
> +$ (echo master; echo next) | git bundle create master-and-next.bundle --stdin
> +----------------
> +
> +And so are these (and the same but omitted `--stdin` examples):
> +
> +----------------
> +$ git bundle create recent-master.bundle master~10..master
> +$ git bundle create recent-updates.bundle master~10..master next~5..next
> +----------------
> +
> +A revision name or a range whose right-hand-side cannot be resolved to
> +a reference is not accepted:
> +
> +----------------
> +$ git bundle create HEAD.bundle $(git rev-parse HEAD)
> +fatal: Refusing to create empty bundle.
> +$ git bundle create master-yesterday.bundle master~10..master~5
> +fatal: Refusing to create empty bundle.

I like this example showing the need for a reference name to be part of
the basis, clarifying that part of the description.

Philip

> +----------------
>  
>  OBJECT PREREQUISITES
>  --------------------

