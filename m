Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C36291F461
	for <e@80x24.org>; Thu, 27 Jun 2019 05:38:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbfF0FiL (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Jun 2019 01:38:11 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36054 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbfF0FiL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jun 2019 01:38:11 -0400
Received: by mail-wr1-f65.google.com with SMTP id n4so944607wrs.3
        for <git@vger.kernel.org>; Wed, 26 Jun 2019 22:38:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0jfzG4kty89Qz5veMJtMv0YdbDNKSmDRsy57khXsASg=;
        b=K9eSwGJ4A1ZySkYWmXOiXVg1KM0CmU0PN0bx1Lc9zg5nczWIIjF3VgKfYHsGaKrC3V
         QYv/4/sBniMhE8+LxWEc9yVDQR1fDKTzWMl6vnk26OBdnO7bEC+h5J1GjIHFZAuDnjY0
         wHGqiHsLC3AlvSbZ/rfo4gChaRliNO2flPFF85fUtcthzgndlVIZWXuzNrQIQa15mpiT
         WSqileiGqn5o0YJbajzx8vkqvV81wucRJpv5jhzgVcnoqfA/h9CZAMMV2a1BXxmgeD1S
         G0OWAXhhOCQrxVcW/drQrclI87J2+Jh/gvsAjIZg7AJ0DgNZ13Yc22hJb08CmfgFp3sl
         QiYw==
X-Gm-Message-State: APjAAAW8CsBa4R35qZixYrvOwrQsR4sx6XmKH2wpoV34aQIDdT/hV2He
        d7IbKMYydF39yP45aFO+ZO7lwIR/UMwNUGUqLYIgBpP8
X-Google-Smtp-Source: APXvYqzM24fIzQdFNIJemg4UadpC7aO+lQHxgiQwKXseDppkb8i+zh/behOhdM+TJ/3si8NvHkglKls2VBlO4V1iu9Q=
X-Received: by 2002:a5d:4fce:: with SMTP id h14mr1373519wrw.231.1561613888770;
 Wed, 26 Jun 2019 22:38:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190626235032.177551-1-emilyshaffer@google.com> <20190626235032.177551-11-emilyshaffer@google.com>
In-Reply-To: <20190626235032.177551-11-emilyshaffer@google.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 27 Jun 2019 01:37:58 -0400
Message-ID: <CAPig+cR7rHokaTtZcJJg8trJ14xO3hdeWHqLnB4aOnEUak051w@mail.gmail.com>
Subject: Re: [RFC PATCH v2 10/13] walken: add unfiltered object walk from HEAD
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 26, 2019 at 7:51 PM Emily Shaffer <emilyshaffer@google.com> wrote:
> Provide a demonstration of a revision walk which traverses all types of
> object, not just commits. This type of revision walk is used for
> operations such as creating packfiles and performing fetches or clones,
> so it's useful to teach new developers how it works. For starters, only
> demonstrate the unfiltered version, as this will make the tutorial
> easier to follow.
> [...]
> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> ---
> diff --git a/builtin/walken.c b/builtin/walken.c
> @@ -103,6 +109,65 @@ static int git_walken_config(const char *var, const char *value, void *cb)
> +static void walken_show_commit(struct commit *cmt, void *buf)
> +{
> +       commit_count++;
> +}
> +
> +static void walken_show_object(struct object *obj, const char *str, void *buf)
> +{
> +       switch (obj->type) {
> +       [...]
> +       case OBJ_TAG:
> +               tag_count++;
> +               break;
> +       case OBJ_COMMIT:
> +               die(_("unexpectedly encountered a commit in "
> +                     "walken_show_object\n"));
> +               commit_count++;

The "commit_count++" line is not only dead code, but it also confuses
the reader (or makes the reader think that the author of this code
doesn't understand C programming). You should drop this line.

> +               break;
> +       default:
> +               die(_("unexpected object type %s\n"), type_name(obj->type));
> +               break;

Likewise, this "break" (and the one in the OBJ_COMMIT case) are dead
code which should be dropped to avoid confusing the reader.

Don't localize the die() message via _() here or in the preceding
OBJ_COMMIT case.

The two die() messages are unnecessarily dissimilar. Try to unify them
so that they read in the same way.

> +       }
> +}> @@ -113,15 +178,15 @@ static void walken_commit_walk(struct rev_info *rev)
>         /*
> -         * prepare_revision_walk() gets the final steps ready for a revision
> +        * prepare_revision_walk() gets the final steps ready for a revision
>          * walk. We check the return value for errors.
> -         */
> +        */
>         /*
> -         * Now we can start the real commit walk. get_revision grabs the next
> +        * Now we can start the real commit walk. get_revision grabs the next
>          * revision based on the contents of rev.
>          */

I think these are just correcting whitespace/indentation errors I
pointed out in an earlier patch (so they are unnecessary noise in this
patch).
