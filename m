Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A6A91F461
	for <e@80x24.org>; Thu, 27 Jun 2019 05:26:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbfF0F0c (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Jun 2019 01:26:32 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39437 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbfF0F0c (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jun 2019 01:26:32 -0400
Received: by mail-wm1-f67.google.com with SMTP id z23so4263963wma.4
        for <git@vger.kernel.org>; Wed, 26 Jun 2019 22:26:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Iw3kO5QkHjoHfKAG/iLx05+yECHh5yi51GVmsYX/E6o=;
        b=ZP6TJtN0l3H/1wTVDaX1j5srUuPAJPo7Fbt6FgIW++3QLlgTovyOKG2MY0QijoSCv2
         ZXprNLp7OOY/h0EagzYK8Szei3VT0+kKY+sWhYBwJ7Im4gvCGZqNq5UK3fsAsBZ9wz3B
         xvPxV0+7hyX8WmEIs0OYWwCpI6Flv3TSKok8MdYwsFaqpoPTicg7rmDkB2PH8zOuzLys
         eEWgHMs2/EPCm+ejsIG4xiRGtVd0wqsxByRQFkDbS662pYMiuce/VissngqxEV6HiLKS
         cDZi9vOrn39KNa9wyAutO+DCXZdY5/wdYiVBFhznp6r7Mt6IiGXvxUp/hSBk/9gRrBbk
         aqYA==
X-Gm-Message-State: APjAAAVKJC3rOOdf0NgmSAX85aHPZSRte/Emmdh8aYHWd7Cgl8XYlbn4
        4SCN2msOM1LXAoBCboZ/5PJxp1Tf0YoCIlNf8k4=
X-Google-Smtp-Source: APXvYqwmdH2VnZ7RDpog4Fvs9jRy0lTGwtXlmS8GWpIQs2ra6VUU/Y2D0GSfp5t/SX3PJ8Kg8EisT7kcieHvsd+tHfk=
X-Received: by 2002:a1c:720e:: with SMTP id n14mr1643723wmc.53.1561613189989;
 Wed, 26 Jun 2019 22:26:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190626235032.177551-1-emilyshaffer@google.com> <20190626235032.177551-10-emilyshaffer@google.com>
In-Reply-To: <20190626235032.177551-10-emilyshaffer@google.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 27 Jun 2019 01:26:19 -0400
Message-ID: <CAPig+cQh2rEW271KziUyYGZyPXrFV8z_OV6UzY=-e4pOrF_zsw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 09/13] walken: demonstrate reversing a revision
 walk list
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 26, 2019 at 7:51 PM Emily Shaffer <emilyshaffer@google.com> wrote:
> The final installment in the tutorial about sorting revision walk
> outputs. This commit reverses the commit list, so that we see newer
> commits last (handy since we aren't using a pager).
>
> It's important to note that rev->reverse needs to be set after
> add_head_to_pending() or before setup_revisions(). (This is mentioned in
> the accompanying tutorial.)

This leaves the reader wondering "why that requirement?". Is it
because those functions may change the value or otherwise depend upon
the value?

Also, something this important probably deserves an in-code comment
(and need not be mentioned in the commit message if the in-code
comment explains it well.)

> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> ---
> diff --git a/builtin/walken.c b/builtin/walken.c
> @@ -69,6 +69,9 @@ static void final_rev_info_setup(int argc, const char **argv, const char *prefix
>         /* add the HEAD to pending so we can start */
>         add_head_to_pending(rev);
> +
> +       /* Reverse the order */
> +       rev->reverse = 1;
