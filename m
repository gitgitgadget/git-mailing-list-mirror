Return-Path: <SRS0=S9iH=BU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5B6AC433E0
	for <git@archiver.kernel.org>; Mon, 10 Aug 2020 00:50:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB5582068F
	for <git@archiver.kernel.org>; Mon, 10 Aug 2020 00:50:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbgHJAuN (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 9 Aug 2020 20:50:13 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43677 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726323AbgHJAuM (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Aug 2020 20:50:12 -0400
Received: by mail-wr1-f66.google.com with SMTP id a15so6576382wrh.10
        for <git@vger.kernel.org>; Sun, 09 Aug 2020 17:50:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U9TGDlOB0BodyedPZkeWfUg5k7iy3htQKmFihv7rToc=;
        b=pwZrxOAAU6QPqISoZtIsuBeSQa7c7Vin2NaCE5ycqiDAoDfLq5Z7530AnFxwj4E0zu
         jN9SuDFs3LeGcRhWxbmAtl7sIw1GOXohRD5LBVcdEZ0sDcEntc7piXwMFoDlAlnIppsX
         MwfbzmKawrz9FIzYHmgEx4trzFEB5XGFD1N9JZdYk70d1z2eNnWE2DMq2rAumBXgBtJ6
         ZAhLOGjEY0VZO4epb4/086uYbAJPzcQ6XJ8FD4MHpEyZ1pcSYALKLdthtbI4kUsqSrRI
         M+q3jvfUEm0qKkM1k9GdzErxnGUezjvBi36bAtwoJlV8aat+aE+owEHy8J1dJMKSUP6k
         Dqxw==
X-Gm-Message-State: AOAM532TAkwr9kUykd409mkxhRy2WYwCDGEvg+ojoztlsRh95gVxjI/e
        gRc6c6chQeiyrxo5wyqSMEDkAosvN1y1sUSgyV1/UMEa
X-Google-Smtp-Source: ABdhPJy4+/oh5dwFh9VDcfHYSGvbT3fNq9/zG+Xhu6XtPhPr2YHCgVA8Ov78KMuHpyxiKC+o5quv8HdLyZMv+orLBKQ=
X-Received: by 2002:adf:b352:: with SMTP id k18mr23021499wrd.386.1597020610560;
 Sun, 09 Aug 2020 17:50:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200808213457.13116-1-me@pluvano.com> <20200809230436.2152-1-me@pluvano.com>
In-Reply-To: <20200809230436.2152-1-me@pluvano.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 9 Aug 2020 20:49:59 -0400
Message-ID: <CAPig+cT3aMUQapU7i0C3jZaLd2XJwP9SbxFEm_tG_1wj8w1PKw@mail.gmail.com>
Subject: Re: [PATCH v2] gitweb: map names/emails with mailmap
To:     Emma Brooks <me@pluvano.com>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 9, 2020 at 7:06 PM Emma Brooks <me@pluvano.com> wrote:
> Add an option to map names and emails to their canonical forms via a
> .mailmap file. This is enabled by default, consistent with the behavior
> of Git itself.
>
> Signed-off-by: Emma Brooks <me@pluvano.com>
> ---
> diff --git a/Documentation/gitweb.conf.txt b/Documentation/gitweb.conf.txt
> @@ -751,6 +751,11 @@ default font sizes or lineheights are changed (e.g. via adding extra
> +mailmap::
> +       Use mailmap to find the canonical name/email for
> +       committers/authors (see linkgit:git-shortlog[1]). Enabled by
> +       default.

Is this setting global or per-repository? (I ask because documentation
for other options in this section document whether they can be set
per-repository.)

Should there be any sort of support for functionality similar to the
"mailmap.file" and "mailmap.blob" configuration options in Git itself?
(Genuine question, not a demand for you to implement such support.)

> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> +# Contents of mailmap stored as a referance to a hash with keys in the format

s/referance/reference/

> +# of "name <email>" or "<email>", and values that are hashes containing a
> +# replacement "name" and/or "email". If set (even if empty) the mailmap has
> +# already been read.
> +my $mailmap;
> +
> +sub read_mailmap {
> +       my %mailmap = ();
> +       open my $fd, '-|', quote_command(
> +               git_cmd(), 'cat-file', 'blob', 'HEAD:.mailmap') . ' 2> /dev/null'
> +               or die_error(500, 'Failed to read mailmap');

Am I reading this correctly that this will die if the project does not
have a .mailmap file? If so, that seems like harsh behavior since
there are many projects in the wild lacking a .mailmap file.

> +       return \%mailmap if eof $fd;
> +       foreach (split '\n', <$fd>) {

If the .mailmap has no content, then the 'foreach' loop won't be
entered, which means the early 'return' above it is unneeded, correct?
(Not necessarily asking for the early 'return' to be removed, but more
a case of checking that I'm understanding the logic.)

> +               next if (/^#/);
> +               if (/(.*)\s+ <([^<>]+)>\s+ ((?:.*\s+)? <[^<>]+>) (?:\s+\#)/x ||
> +                   /(.*)\s+ <([^<>]+)>\s+ ((?:.*\s+)? <[^<>]+>)/x) {
> +                       # New Name <new@email> <old@email>
> +                       # New Name <new@email> Old Name <old@email>

The first regex is intended to handle a trailing "# comment", whereas
the second regex is for lines lacking a comment, correct? However,
because neither of these expressions are anchored, the second regex
will match both types of lines, thus the first regex is redundant. I'm
guessing, therefore, that your intent was actually to anchor the
expressions, perhaps like this:

    if (/^\s* (.*)\s+ <([^<>]+)>\s+ ((?:.*\s+)? <[^<>]+>) (?:\s+\#)/x ||
        /^\s* (.*)\s+ <([^<>]+)>\s+ ((?:.*\s+)? <[^<>]+>) \s*$/x) {

Also, if you're matching lines of the form:

    name1 <email1> [optional-name] <email2>

in which you expect to see "name1", then is the loose "(.*)\s+"
desirable? Shouldn't it be tighter "(.+)\s+"? For instance:

    if (/^\s* (.+)\s+ <([^<>]+)>\s+ ((?:.*\s+)? <[^<>]+>) (?:\s+\#)/x ||
        /^\s* (.+)\s+ <([^<>]+)>\s+ ((?:.*\s+)? <[^<>]+>) \s*$/x) {

> +                       $mailmap{$3} = ();

I wonder if you should be doing some sort of whitespace normalization
on $3 before using it as a hash key. For instance, if someone has a
.mailmap that looks like this (where I've used "." to represent
space):

    name1.<email1>.name2...<email2>

then $3 will have three spaces between 'name2' and '<email2>' when
used as a key, and that won't match later when you construct a "name
<email>" key later in map_author() with a single space.

> +                       ($mailmap{$3}{name} = $1) =~ s/^\s+|\s+$//g;
> +                       $mailmap{$3}{email} = $2;
> +               } elsif (/(?: <([^<>]+)>\s+ | (.+)\s+ ) (<[^<>]+>) (?:\s+\#)/x ||
> +                        /(?: <([^<>]+)>\s+ | (.+)\s+ ) (<[^<>]+>)/x) {

Same comment as above about anchoring these patterns...

> +                       # New Name <old@email>
> +                       # <new@email> <old@email>
> +                       $mailmap{$3} = ();
> +                       if ($1) {
> +                               $mailmap{$3}{email} = $1;
> +                       } else {
> +                               ($mailmap{$3}{name} = $2) =~ s/^\s+|\s+$//g;
> +                       }
> +               }
> +       }
> +       return \%mailmap;
> +}
