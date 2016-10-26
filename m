Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 882E62022A
	for <e@80x24.org>; Wed, 26 Oct 2016 13:53:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755072AbcJZNxO (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Oct 2016 09:53:14 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:34188 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932323AbcJZNxN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Oct 2016 09:53:13 -0400
Received: by mail-it0-f66.google.com with SMTP id u194so254863itu.1
        for <git@vger.kernel.org>; Wed, 26 Oct 2016 06:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=lSqQcuuYojEcjmh74I5CX3dcfZuYWTjqXzqyrnaC07I=;
        b=MPddxj9uq9mxpEPtrRbNu1CuVVbEK45XRp6ArVoh7gOsfapAG+3YlRnl7EjRGIS1k3
         AyIGMXDsoREgdci5aj5nSctR0UqqZqCThO7TAyHAw/dzXPihBOnuce1ozx1Dbn1A9kmb
         yyLb7QfoRhrycFY5Stoce3vxKR9hTkuEb/aLRqRNgCQy23/n++el5J+XcXwoTGi/I8HP
         KmlsuxeMbuQ1Y/uNnXo152HMmpsgHT1aNYJjDYYFMzr3YBZseVFt7UJDWvwnzdqShEuv
         EtQFntM/YDviYd/5Y8oiZX2NY2cQI30SaGoEkZ6knjdms/yNB8u3wQMWIHzumE7tjb4r
         dWTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=lSqQcuuYojEcjmh74I5CX3dcfZuYWTjqXzqyrnaC07I=;
        b=Rn3kpdc//4jSmWoUdZJOzlyn/vbwIBOZGFJ+ZlLcxmS5grlIkncHIlAJ9n08iWDe/6
         12kE9Naid1sd7vOsRDwWdbJS7HxsUTUbZ6KNA1nUEZm/n5/n3YdUo3+f6Y4y7AENnjlA
         GRxqCCioCcNFIGyWhmgMwSt8h7kjiSboc69pe9oQ1f44VYFp++eU5whawyZyPnyzPdi+
         dPHcopgVIGV949hnUo/voyobqgl+yLLUa/7LD0h4HloFMSDucxVLeyu5LlbWatmFJgWX
         MjigMk9uIw9sySRLOcAysW953ne5XHlowSDtCr6MiAs8RkO3rqHreKuj6G7eej5vcjix
         15DA==
X-Gm-Message-State: ABUngvfthOnC3KWgfzthg1UvZR7XxbDixrrKH2AYdYLnU439Lum8hBMNBn8zyAtBf8lQ89FxDEbht20bnkE0Qw==
X-Received: by 10.107.59.6 with SMTP id i6mr2726124ioa.176.1477489992116; Wed,
 26 Oct 2016 06:53:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.164.102 with HTTP; Wed, 26 Oct 2016 06:52:41 -0700 (PDT)
In-Reply-To: <20161022233225.8883-28-sbeller@google.com>
References: <20161022233225.8883-1-sbeller@google.com> <20161022233225.8883-28-sbeller@google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 26 Oct 2016 20:52:41 +0700
Message-ID: <CACsJy8AB-24dDEs6Pa_6pB16T2ZAgw2faOQDEtZ2vU2uuAepHg@mail.gmail.com>
Subject: Re: [PATCH 27/36] attr: convert to new threadsafe API
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>, bmwill@google.com
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 23, 2016 at 6:32 AM, Stefan Beller <sbeller@google.com> wrote:
> This revamps the API of the attr subsystem to be thread safe.
> Before we had the question and its results in one struct type.
> The typical usage of the API was
>
>     static struct git_attr_check *check;
>
>     if (!check)
>         check = git_attr_check_initl("text", NULL);


Two cents. I read the .txt first and my first thought was "is _initl a
typo, shouldn't it be jsut _init"? I know we have this 'l' variant at
least in argv-array, but there we have many ways of adding arguments.
And here it's just "initl", not "init" nor other "initX" variants,
which looks odd. I wonder if the name git_attr_check_init() would do
the job fine, since we don't have different init variants and the
naming convention is not strong enough to tell me "it's multiple
arguments ended with a NULL one" right away. If you're worried about
people forgetting NULL at the end, how about passing an array of
strings, terminated by NULL, instead?

Just thinking out loud. Maybe _initl _is_ a better name.
-- 
Duy
