Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7853320248
	for <e@80x24.org>; Mon,  8 Apr 2019 00:42:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbfDHAmi convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Sun, 7 Apr 2019 20:42:38 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36186 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726352AbfDHAmh (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Apr 2019 20:42:37 -0400
Received: by mail-wr1-f66.google.com with SMTP id y13so14263763wrd.3
        for <git@vger.kernel.org>; Sun, 07 Apr 2019 17:42:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=f6SsX+TSYlM01yiH8vTXrd56eK285E3Tk3QWeb9Tt/U=;
        b=a5eq/lqWNwG3saTx/ZDZZDvMm30NLkRLiV1CqqbNw3jauSbXuXMAthO4hoKSplsJs+
         0c/dIQxkonFGg0jRcn0wk2fbHHKlKTi0EahQ5fbKSrO3t+dRJT8shLiofUMpxkiJnLrM
         8xiNImz7o5GmEkeY4jdJlkkymXS7ORpvq6uHARWoIh4YOr/T5di71BkRTK39asYoPM25
         9Opz1SSe2STyYo81yWAjLb+x4gF9hOWJp15iUvTQSYglTfFU73cyk+D4eSyGDmPn52Eo
         B2HmGQPe2pXRReiAF68g9lEkZd1iDlHQnbWhyHGgcHf8KrZH5sREBQPndvX5+BGKWwPC
         YHtg==
X-Gm-Message-State: APjAAAXOUh7FJmYGtyGx9JuZ3mOSh+karbaVlIquttITobYPOxYu80gc
        pWEFEEE1LfZhpX7fjZFlDg9AsM04lQ/jeFk3h+0=
X-Google-Smtp-Source: APXvYqynkJwdHn6JHYuMe7tRVxYX5joUCelTAcqNWNx7DXNOLbtsQ28gwn9R9ny3nn9KtjEeQxDcOhMOq45tnuLFlJ4=
X-Received: by 2002:adf:f050:: with SMTP id t16mr12514180wro.198.1554684156009;
 Sun, 07 Apr 2019 17:42:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190407234327.25617-1-szeder.dev@gmail.com>
In-Reply-To: <20190407234327.25617-1-szeder.dev@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 7 Apr 2019 20:42:24 -0400
Message-ID: <CAPig+cQJUEEZ1=bG2WFLCXHpO6D2h36Bhz0c=zTsyjB5Oc4piQ@mail.gmail.com>
Subject: Re: [PATCH] blame: default to HEAD in a bare repo when no start
 commit is given
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Apr 7, 2019 at 7:43 PM SZEDER Gábor <szeder.dev@gmail.com> wrote:
> [...]
> We could improve the error message, of course, but let's just default
> to HEAD in a bare repository instead, as most likely that is what the
> user wanted anyway (if they wanted to start from an other commit, then
> they would have specified that in the first place).
> [...]
> Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
> ---
> diff --git a/builtin/blame.c b/builtin/blame.c
> @@ -993,6 +994,18 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
> +       if (!revs.pending.nr && is_bare_repository()) {
> +               struct commit *head_commit;
> +               struct object_id head_oid;
> +
> +               if (!resolve_ref_unsafe("HEAD", RESOLVE_REF_READING,
> +                                       &head_oid, NULL) ||
> +                   !(head_commit = lookup_commit_reference_gently(revs.repo,
> +                                                            &head_oid, 1)))
> +                       die("no such ref: HEAD");

This source file is already mostly internationalized, so perhaps:

    die(_("no such ref: %s"), "HEAD");

> +               add_pending_object(&revs, &head_commit->object, "HEAD");
> +       }
