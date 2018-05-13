Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA5071F42D
	for <e@80x24.org>; Sun, 13 May 2018 08:59:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751013AbeEMI71 convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Sun, 13 May 2018 04:59:27 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:44231 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750850AbeEMI70 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 May 2018 04:59:26 -0400
Received: by mail-qt0-f195.google.com with SMTP id d3-v6so12507116qtp.11
        for <git@vger.kernel.org>; Sun, 13 May 2018 01:59:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UTndzjBYsqPO9pZeohds+v/u+TJxHRHj1livms+y87Y=;
        b=Q5p1H262tC91Pr98klZsc7eohpF/HDBFOv+K/Znf3GCJ04UzOw3Yt2cxDZrlDfTG3Y
         Bse5YSLfm9vewMWANVxwHfoGnhdNL61CmYune0hq1rrsjUF7ACJrNNfcVr2z0R7lZMjR
         GuJ1wM5BYxEt/0xLO0erIO68cGgEnInlEJ4xNsOMkwf8Wm/lQEI0V4jgxUO5RPWK1sAO
         Vgy6na43nQsXyf7lwm0OfrhySCZ9qQVoT89qqCKX3t1lwiAF2WY3yZH888jS8OvOQ/xS
         qMVZcXqNPzbGz+jn9fdJE+a3us7a3k6EwIYR6+k9sQMVB3LdvtUZmN3sJTlxHmdQDOgD
         MRNw==
X-Gm-Message-State: ALKqPwetuHvnQ7iWld2HkpXil2KFF9OkPVfjsHrpv2wm9BtgzcKQ7RZZ
        Ul2NUXAXBY9FZXDvCVQUqRuQR43kRYETEHemAqQ=
X-Google-Smtp-Source: AB8JxZoII3s5EkG+xC183Ll1jDPewgApwkg4mK1cgnUzfoP7vEhBEwR1HASx24yCh7oStCpstG+csNzWHTWiGU+v3hs=
X-Received: by 2002:ac8:42b:: with SMTP id v43-v6mr4595593qtg.69.1526201965247;
 Sun, 13 May 2018 01:59:25 -0700 (PDT)
MIME-Version: 1.0
References: <20180513082303.19582-1-martin.agren@gmail.com>
In-Reply-To: <20180513082303.19582-1-martin.agren@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 13 May 2018 04:59:13 -0400
Message-ID: <CAPig+cThT3VVw75VF0wuF-yR-xbnfNOxhviYGZLAksF8HFuOGw@mail.gmail.com>
Subject: Re: [PATCH] config: free resources of `struct config_store_data`
To:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, May 13, 2018 at 4:23 AM Martin Ågren <martin.agren@gmail.com> wrote:
> Commit fee8572c6d (config: avoid using the global variable `store`,
> 2018-04-09) dropped the staticness of a certain struct, instead letting
> the users create an instance on the stack and pass around a pointer.

> We do not free the memory that the struct tracks. When the struct was
> static, the memory would always be reachable. Now that we keep the
> struct on the stack, though, as soon as we return, it goes out of scope
> and we leak the memory it points to.

> Introduce and use a small helper function `config_store_data_clear()` to
> plug these leaks. This should be safe. The memory tracked here is config
> parser events. Once the users (`git_config_set_multivar_in_file_gently()`
> and `git_config_copy_or_rename_section_in_file()` at the moment) are
> done, no-one should be holding on to a pointer into this memory.

> Signed-off-by: Martin Ågren <martin.agren@gmail.com>
> ---
> diff --git a/config.c b/config.c
> @@ -2333,6 +2333,13 @@ struct config_store_data {
> +void config_store_data_clear(struct config_store_data *store)
> +{
> +       free(store->parsed);
> +       free(store->seen);
> +       memset(store, 0, sizeof(*store));
> +}

A newcomer to this code (such as myself) might legitimately wonder why
store->key and store->value_regex are not also being cleaned up by this
function. An examination of the relevant code reveals that those structure
members are manually (and perhaps tediously) freed already by
git_config_set_multivar_in_file_gently(), however, if
config_store_data_clear() was responsible for freeing them, then
git_config_set_multivar_in_file_gently() could be made a bit less noisy.

On the other hand, if there's actually a good reason for
  config_store_data_clear() not freeing those members, then perhaps it
deserves an in-code comment explaining why they are exempt.
