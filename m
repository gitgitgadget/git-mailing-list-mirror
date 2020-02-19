Return-Path: <SRS0=H/u6=4H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15A7CC34056
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 19:49:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D10C8208E4
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 19:49:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbgBSTtn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Feb 2020 14:49:43 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41816 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbgBSTtn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Feb 2020 14:49:43 -0500
Received: by mail-wr1-f68.google.com with SMTP id c9so1964552wrw.8
        for <git@vger.kernel.org>; Wed, 19 Feb 2020 11:49:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H2SXii331JKVSrmD2YCx082g5AoepbWGaBkJriRiRuo=;
        b=UmecNgy+f18nM6P4VywRAFpqgAcxm2S31Pa/YEoZYdnJzJVJ9hLGKSdmLEFsappoXK
         vNIfrTQJf7ZO6q/wlp/HEgicOmanEp97DU0j0q4mj+X+blQp1JqNJqD90fobmWeKg20N
         ylusSIiyrstUOHEDmqbOe9ZGcXjs27aRIRDuIy+dW/601kpYys3E/xDm+PeqGNZ/xnlt
         5aDWqA5g9FLxR0zT7t/me8Ju6qw+93stPetroJptDC3LfOTRhHEo5dPXM/7x6ZLqK9Bn
         +56lSVtaZ0i77Gt5v/LnVdpew56JxCEhueumyxrXQJVTJ6BXfuonAviyuYQN4azGpsQr
         tQyA==
X-Gm-Message-State: APjAAAXKqQy5lsx4svOF/VIVz1g3MQMmfzsM9+9dIU+P1Ci+KCiLifTn
        omFG7QFfzsP+DZa6H9xI1wb+yz4326VFUy3rkqokSFPu
X-Google-Smtp-Source: APXvYqzl0Cf+sG+aTTk/2Gmm1rCFv0TPJy1GDnNDqYEeN/t2J/Caj2PcUBkyWFsHi8JiIEH417Dq/RP63BHQuKLs4Fs=
X-Received: by 2002:a5d:4a0f:: with SMTP id m15mr37804075wrq.415.1582141781690;
 Wed, 19 Feb 2020 11:49:41 -0800 (PST)
MIME-Version: 1.0
References: <20200219161352.13562-1-pbonzini@redhat.com> <20200219161352.13562-5-pbonzini@redhat.com>
In-Reply-To: <20200219161352.13562-5-pbonzini@redhat.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 19 Feb 2020 14:49:30 -0500
Message-ID: <CAPig+cR2VLDYc_UpbWySFSF49Uo0twVyGRXgVx3Z6w1R04aavg@mail.gmail.com>
Subject: Re: [PATCH 4/4] am: support --show-current-patch=diff to retrieve .git/rebase-apply/patch
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Git List <git@vger.kernel.org>, bfields@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 19, 2020 at 11:15 AM <pbonzini@redhat.com> wrote:
> When "git am --show-current-patch" was added in commit 984913a210 ("am:
> add --show-current-patch", 2018-02-12), "git am" started recommending it
> as a replacement for .git/rebase-merge/patch.  Unfortunately the suggestion
> is misguided, for example the output "git am --show-current-patch" cannot
> be passed to "git apply" if it is encoded as quoted-printable or base64.
> Add a new mode to "git am --show-current-patch" in order to straighten
> the suggestion.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
> diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
> @@ -16,7 +16,7 @@ SYNOPSIS
> -'git am' (--continue | --skip | --abort | --quit | --show-current-patch[=raw])
> +'git am' (--continue | --skip | --abort | --quit | --show-current-patch[=raw|diff])

Missing parentheses. To be consistent with other documentation, this
should be written as:

    --show-current-patch[=(raw|diff)]

> @@ -176,9 +176,11 @@ default.   You can use `--no-utf8` to override this.
> ---show-current-patch[=raw]::
> -       Show the entire e-mail message "git am" has stopped at, because
> -       of conflicts.
> +--show-current-patch[=raw|diff]::

Ditto: --show-current-patch[=(raw|diff)]::

> +       Show the message "git am" has stopped at, because of conflicts.

The weirdly-placed comma is still weird.

> +       If the argument is absent or "raw", show the raw contents of
> +       the e-mail message.  If the argument is "diff", show the diff
> +       portion only.

I think the usual term is "omitted" rather than "absent".

Suggested rewrite:

    Show the message at which `git am` has stopped due to conflicts.
    If `raw` is specified, show the raw contents of the e-mail
    message; if `diff`, show the diff portion only. Defaults to `raw`.

This also simplifies the change if the default ever flips from "raw" to "diff".
