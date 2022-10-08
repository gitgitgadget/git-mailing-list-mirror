Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CA5BC433F5
	for <git@archiver.kernel.org>; Sat,  8 Oct 2022 04:54:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbiJHEyx convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sat, 8 Oct 2022 00:54:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiJHEyt (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Oct 2022 00:54:49 -0400
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6C1513D77
        for <git@vger.kernel.org>; Fri,  7 Oct 2022 21:54:47 -0700 (PDT)
Received: by mail-io1-f44.google.com with SMTP id o65so5069429iof.4
        for <git@vger.kernel.org>; Fri, 07 Oct 2022 21:54:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AV74GMKouwv9VsT1l0YcxvrKj01b5UCMauRyQqyMaG8=;
        b=1VYByLm1rvD28EDW7Ywx/Dl8jF1k7fAlfMDWarWdioIm4YiGaeBHhPD7rxq5c92LIT
         DMTbdeBNRdGk3QfDWyYifog7EQDw6TJDiAhdkT+4yTly64ebii2F6l8XpWK+YaZjQ1g7
         8O/iWJyA2URa/GnAsr2gt061N9EVjIuIEEwS9qqSF9e0DW4mvtzjmFdFdKOT6Y96u7Op
         JEtMWTdDaw5sEqPPKj/V9aM605APhTUqn5958CoVw2c4JlcMLYY19dR7t/VHiqS8eITb
         CNDNHSdlXi+U7XzvcY5R/QfiGg+Ti2PgNdV9WpvvcBkSbcuSUH3/gYp6ObLbrprlsADF
         bIpw==
X-Gm-Message-State: ACrzQf04fN8H+0MD1W5sOgWCQFxU0lCUaTql0dglF9BdRquuPw8DJSHv
        MWydLFmUmgrBNwFJrXlhCgReNVc/2PKcaP6zpZsepXJP0+/GBg==
X-Google-Smtp-Source: AMsMyM7VVwAOp3YOktcy9fzqGJlY+lm2c/YhFhe4s5TTT3ZoERFeeOqSL+K2pCNofgpj6HqTp30gXdUu4U4Nf3G2yIc=
X-Received: by 2002:a02:715f:0:b0:363:575a:5398 with SMTP id
 n31-20020a02715f000000b00363575a5398mr4059000jaf.285.1665204887097; Fri, 07
 Oct 2022 21:54:47 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqleprcn08.fsf@gitster.g> <xmqqsfjzaq78.fsf@gitster.g>
In-Reply-To: <xmqqsfjzaq78.fsf@gitster.g>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 8 Oct 2022 00:54:36 -0400
Message-ID: <CAPig+cQHw_VjbA2_HaZJj3Q0v8C6uUukr40vXFuizx4M_04XFA@mail.gmail.com>
Subject: Re: [PATCH v2] symbolic-ref: teach "--[no-]recurse" option
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 8, 2022 at 12:34 AM Junio C Hamano <gitster@pobox.com> wrote:
> [...]
> One thing that is slightly irritating, however, is that I do not
> think there is a good way (other than "cat .git/HEAD") to learn that
> you checked out 'maint' to get into that state.  Just like the output
> of "git branch --show-current" shows above, "git symbolic-ref HEAD"
> would report 'refs/heads/maint-2.38', bypassing the intermediate
> symbolic ref at 'refs/heads/maint' that is pointed at by HEAD.
> [...]
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> diff --git a/Documentation/git-symbolic-ref.txt b/Documentation/git-symbolic-ref.txt
> @@ -46,6 +46,15 @@ OPTIONS
> +--recurse::
> +--no-recurse::
> +       When showing the value of <name> as a symbolic ref, if
> +       <name> refers to another symbolic ref, follow such a chain
> +       of symbolic refs until the result no longer points at a
> +       symbolic ref (`--recurse`, which is the default).
> +       `--no-recurse` stops after dereferencing only a single level
> +       of symbolic ref.

With his recent documentation-normalization work, I suspect Ævar would
appreciate an update to the synopsis, as well:

    SYNOPSIS
    --------
    [verse]
    'git symbolic-ref' [-m <reason>] <name> <ref>
   -'git symbolic-ref' [-q] [--short] <name>
   +'git symbolic-ref' [-q] [--short] [--no-recurse] <name>
    'git symbolic-ref' --delete [-q] <name>

or something similar (i.e. plain [--recurse] or composite
[--[no-]-recurse] or [--recurse | --no-recurse]).
