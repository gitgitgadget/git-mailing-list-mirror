Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 49B7A1F403
	for <e@80x24.org>; Tue,  5 Jun 2018 08:47:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751520AbeFEIrj (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Jun 2018 04:47:39 -0400
Received: from mail-yb0-f173.google.com ([209.85.213.173]:34176 "EHLO
        mail-yb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751442AbeFEIri (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jun 2018 04:47:38 -0400
Received: by mail-yb0-f173.google.com with SMTP id i1-v6so510032ybe.1
        for <git@vger.kernel.org>; Tue, 05 Jun 2018 01:47:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lxFXJIfLAvusnQK12hZ7hJSd8nmX3ACVRJ8RLHnvtf8=;
        b=TGkLflhdTyDIZDmQaP8BaR0jaEVn3c53BOXHGN5meLOW271p8bobeJ9CMH4TiHmckv
         U8982hlE0bBOVQxMPQdYdJdJv9G5fj6bSLXToxWLQ2sOn5YXvDC+OWoXrSFw2cyEYXt5
         B5QETJccdki3ENn5d3enN2OJWshZveo2+DTwRlEwwZhDmrZndfN+pAMDdaWCFFI/hmNN
         AbBzXxN54KeHweTulECYWpXnni8r6JqUYi3vD8ijJHXTwEdvM4odQXgR9j+uQpfmGvFX
         zda/PisaqWDEGKideYIMocyPzyDcB+YGIkaRD2FRBf2dDaGOTVMApZ8oRSeX9UPjL+T1
         El6w==
X-Gm-Message-State: APt69E34ouMO8socmUw4nnHhQixnMx5KFS6c5fEnHE1GDKMJwErFMGQr
        jeaNKE9qZoF37JNwJXnb9CvtDKLKpG4ZoZ7keFw=
X-Google-Smtp-Source: ADUXVKKIBoBAwM+rPZiM4gsgVYswywsluALJstxR9Hx2Af2A+bP+wzjEAO+p0323NOzXB+dS4Z2VY+46L7nKVhSxiTk=
X-Received: by 2002:a25:8741:: with SMTP id e1-v6mr454038ybn.194.1528188457782;
 Tue, 05 Jun 2018 01:47:37 -0700 (PDT)
MIME-Version: 1.0
References: <20180605082854.17090-1-luke@diamand.org> <20180605082854.17090-3-luke@diamand.org>
In-Reply-To: <20180605082854.17090-3-luke@diamand.org>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 5 Jun 2018 04:47:26 -0400
Message-ID: <CAPig+cQH1n+c2sNijPBKTG2tGDYEWjBz_PUoWREQh8y9tG4a-Q@mail.gmail.com>
Subject: Re: [PATCHv1 2/2] git-p4: add option to disable syncing of p4/master
 with p4
To:     Luke Diamand <luke@diamand.org>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        merlorom@yahoo.fr, Miguel Torroja <miguel.torroja@gmail.com>,
        viniciusalexandre@gmail.com,
        Lars Schneider <larsxschneider@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 5, 2018 at 4:29 AM Luke Diamand <luke@diamand.org> wrote:
> Add an option to the git-p4 submit command to disable syncing
> with Perforce.
>
> This is useful for the case where a git-p4 mirror has been setup
> on a server somewhere, running from (e.g.) cron, and developers
> then clone from this. Having the local cloned copy also sync
> from Perforce just isn't useful.
>
> Signed-off-by: Luke Diamand <luke@diamand.org>
> ---
> diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
> @@ -369,6 +369,11 @@ These options can be used to modify 'git p4 submit' behavior.
> +--disable-p4sync::
> +    Disable the automatic sync of p4/master from Perforce after commit have

s/commit/commits/

> +    been submitted. Implies --disable-rebase. Can also be set with
> +    git-p4.disableP4Sync. Sync with origin/master still goes ahead if possible.
> diff --git a/git-p4.py b/git-p4.py
> @@ -1368,7 +1368,9 @@ def __init__(self):
> +                optparse.make_option("--disable-p4sync", dest="disable_p4sync", action="store_true",
> +                                     help="Skip perforce sync of p4/master after submit or shelve"),

s/perforce/Perforce/
