Return-Path: <SRS0=QOHA=BI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77E0EC433E0
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 02:54:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DD922076E
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 02:54:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731144AbgG2CyB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jul 2020 22:54:01 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39384 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731052AbgG2CyA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jul 2020 22:54:00 -0400
Received: by mail-wr1-f67.google.com with SMTP id a5so10155181wrm.6
        for <git@vger.kernel.org>; Tue, 28 Jul 2020 19:53:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ACfB53Z1m2dYWeSHG7weVSOp9lbkrVpUofYrXKxN+SI=;
        b=pQoYT7NtFtZJTpkiIMEpkwicIvIIfr/FpGz85MaWEp1CdSsKW9UGYXk8ufqCDGFZUD
         sBC/QNc4oDjMADTqVKlSNpQSkKMdf4wGXsuLk3PVS+b1tRLOqE0yP0leJ+O0OUQt5h3a
         fLVSabmvX3TucCuEjl3fv+IO9mkY8fV9+l8xgUaswpY50TPYwCUbg829zW4k2jFb4rie
         dRddinWuLGH3AkBsoNMCS52pIwKi5lvsnBYj5RJS/VKCRuAoXS2WYwdYkcQGruAADj+l
         B5vXBN468xP3ecy1NXpwDl/p9TmeATWnJ9LDHhJfJ0tlHTmHmIkhdPIwZT9RJ27PEY9D
         L/iQ==
X-Gm-Message-State: AOAM533dGHxEjkw2R3NbrLQdZXGxxJB6BPJLROcrxzyAN+XvyQbQ2v3o
        A8NofIGG0iD+VW57EbkWKYkwp44VMwo0xrw7HZa3PmYfEVQ=
X-Google-Smtp-Source: ABdhPJzX7NJfuw9ngATZQ5YOpfLoxDMdKtgRm83a7LJ8S/2dBhppDjjlBnHJGZeEstubFRg7iQ/DIDA9AbyqTYGsdu8=
X-Received: by 2002:adf:fc45:: with SMTP id e5mr29385801wrs.226.1595991238598;
 Tue, 28 Jul 2020 19:53:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200728233446.3066485-1-sandals@crustytoothpaste.net> <20200728233446.3066485-32-sandals@crustytoothpaste.net>
In-Reply-To: <20200728233446.3066485-32-sandals@crustytoothpaste.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 28 Jul 2020 22:53:47 -0400
Message-ID: <CAPig+cSJc9P6hdBDrH9QbkvARcqc3EygMMXXB8vbU=W43viLqA@mail.gmail.com>
Subject: Re: [PATCH v5 31/39] bundle: add new version for use with SHA-256
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 28, 2020 at 7:36 PM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> [...]
> Since we cannot extend the v2 format in a backward-compatible way, let's
> add a v3 format, which is identical, except for the addition of
> capabilities, which are prefixed by an at sign.  We add "object-format"
> as the only capability and reject unknown capabilities, since we do not
> have a network connection and therefore cannot negotiate with the other
> side.
> [...]
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
> diff --git a/bundle.c b/bundle.c
> @@ -57,19 +83,19 @@ static int parse_bundle_header(int fd, struct bundle_header *header,
> -               if (*buf.buf == '-') {
> -                       is_prereq = 1;
> -                       strbuf_remove(&buf, 0, 1);
> -               }
>                 strbuf_rtrim(&buf);
>
> -               if (!header->hash_algo) {
> -                       header->hash_algo = detect_hash_algo(&buf);
> -                       if (!header->hash_algo) {
> -                               error(_("unknown hash algorithm length"));
> +               if (header->version == 3 && *buf.buf == '@') {
> +                       if (parse_capability(header, buf.buf + 1)) {
>                                 status = -1;
>                                 break;
>                         }
> +                       continue;
> +               }
> +
> +               if (*buf.buf == '-') {
> +                       is_prereq = 1;
> +                       strbuf_remove(&buf, 0, 1);
>                 }

Moving the strbuf_rtrim() earlier in the loop, as suggested in my
previous review, made the diff a lot noisier, uglier, and more
difficult to read, however, the code itself ends up being easier to
reason about than in the previous round. Good.

By the way (I didn't think of this in my previous review), but
wouldn't it be better for this:

    if (header->version == 3 && *buf.buf == '@') {

to instead be written as:

    if (header->version >= 3 && *buf.buf == '@') {

to future-proof it since versions beyond 3 will also almost certainly
support "@foo" capabilities?

> @@ -449,13 +475,14 @@ static int write_bundle_refs(int bundle_fd, struct rev_info *revs)
> +       int min_version = the_hash_algo == &hash_algos[GIT_HASH_SHA1] ? 2 : 3;
> @@ -464,8 +491,22 @@ int create_bundle(struct repository *r, const char *path,
> +       if (version == -1)
> +               version = min_version;
> +
> +       if (version < 2 || version > 3) {
> +               die(_("unsupported bundle version %d"), version);
> +       } else if (version < min_version) {
> +               die(_("cannot write bundle version %d with algorithm %s"), version, the_hash_algo->name);
> +       } else if (version == 2) {
> +               write_or_die(bundle_fd, v2_bundle_signature, strlen(v2_bundle_signature));

This looks better than the previous attempt; less likely to be fragile
as new bundle versions are introduced. Good.
