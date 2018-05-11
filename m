Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 70ECE1F406
	for <e@80x24.org>; Fri, 11 May 2018 22:23:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751028AbeEKWXk convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Fri, 11 May 2018 18:23:40 -0400
Received: from mail-qk0-f171.google.com ([209.85.220.171]:40841 "EHLO
        mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750876AbeEKWXj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 May 2018 18:23:39 -0400
Received: by mail-qk0-f171.google.com with SMTP id s83-v6so492601qke.7
        for <git@vger.kernel.org>; Fri, 11 May 2018 15:23:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sg1arYuhFMct9Ld29m3FGZqb/eldM/jdymOa4MqJV7g=;
        b=CDnZiNH79wRT9PC8SjzADmFJnaARNPiDw6MxOmQt/56dC8vGAEXemYx1OAEMZPlhXJ
         DYBEIUlTHhRyOJkw2RRta/jjzwFucr1lbE96rVmxUViRORwUAuvQHFPdcseldYqdcETQ
         aE2e3KQkPmrQ4PbbwfByNTqj8sSqNStnYMSPVfJS0tTAp5teA2HMipZ+fJpYDQxZhnVm
         mz4MVtIJRBk/x/9Lo5+6+UVbU1TkXTzEEVhsFBc4fviiBWD2sTlDk1e0KxsK+nyvQAQn
         UIOYMkqUeFxr08gvorIxRt4t1aP20wWJXDOilVmWFjj1lTUXLibEpcDdO3otNqiJ51Ne
         ZtPg==
X-Gm-Message-State: ALKqPwdr7tDs631YXDOOsHghjSUSLgjP41+Gj0BiOrB0FUtyg+KGOhJE
        15HaBf8oKVw/CCSrFYfk88MXM9mg/v4gCOekYeo=
X-Google-Smtp-Source: AB8JxZoFM4FKAjrr5icoiRE3vgE3m99nXuTJXjegThZQkYn+eFiGcjNMz+z2Yec51ej1b+oC/fqf7kTM41cqVo+p3Wk=
X-Received: by 2002:a37:be86:: with SMTP id o128-v6mr6540652qkf.141.1526077419030;
 Fri, 11 May 2018 15:23:39 -0700 (PDT)
MIME-Version: 1.0
References: <20180510141927.23590-1-pclouds@gmail.com> <20180510141927.23590-4-pclouds@gmail.com>
In-Reply-To: <20180510141927.23590-4-pclouds@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 11 May 2018 18:23:27 -0400
Message-ID: <CAPig+cQYaabk+XibOMUGa5b4y2D8AhjNBjujgNE7ctLCdFpdCQ@mail.gmail.com>
Subject: Re: [PATCH 3/9] fsck: factor out msg_id_info[] lazy initialization code
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 10, 2018 at 10:19 AM Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
wrote:
> This array will be used by some other function than parse_msg_id() in
> the following commit. Factor out this prep code so it could be called
> from that one.

> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
> diff --git a/fsck.c b/fsck.c
> @@ -84,26 +84,32 @@ static struct {
> -static int parse_msg_id(const char *text)
> +static void prepare_msg_ids(void)
>   {
> -       if (!msg_id_info[0].downcased) {
> -               /* convert id_string to lower case, without underscores.
*/
> -               for (i = 0; i < FSCK_MSG_MAX; i++) {
> -                       [...]
> -               }
> +       /* convert id_string to lower case, without underscores. */
> +       for (i = 0; i < FSCK_MSG_MAX; i++) {
> +               [...]
>          }
> +}
> +
> +static int parse_msg_id(const char *text)
> +{
> +       if (!msg_id_info[0].downcased)
> +               prepare_msg_ids();

If you move the "if (!msg_id_info...)" conditional into the new
parpare_msg_ids() function, then it becomes self-contained; it takes care
of avoiding double-initialization so callers don't have to worry or know
about it. (Doing so would also make the diff less noisy.)

Not at all worth a re-roll.
