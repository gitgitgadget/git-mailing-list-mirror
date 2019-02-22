Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9762D202AA
	for <e@80x24.org>; Fri, 22 Feb 2019 13:18:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbfBVNSS (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Feb 2019 08:18:18 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:39457 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726352AbfBVNSS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Feb 2019 08:18:18 -0500
Received: by mail-qt1-f196.google.com with SMTP id o6so2372183qtk.6
        for <git@vger.kernel.org>; Fri, 22 Feb 2019 05:18:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DMNrU3/B9xxorLgT2Bdmsoy94hyKO5s2nYkINKeBgBA=;
        b=UJYnE8TwcsQlN/Mc3b7L7/JoEjfNW7++VRaHWiHm1uBr/zHwxpO84gXfjen53Luh4l
         e6pl7Ud78tntW3D7kv8t//IWR0NdUXKJwlqsGdIDi6JeYYIeqnf9vdglUgSvSqYCMVUx
         jUvL2a4OYFWwNedmSGfkt7YvCjJXCt9D2LdcGR9E+m6+6krdrWAjzP0XmB+dSyn459+I
         QmNR6nkQLD42ruVpmxArd3BtPHY/+S/6VXZ61wA4/N/Gpu7Qi9vhnpkDZ/8FFEc+zk0w
         L9hKXOGHOuy9LtZ+thMvPuln5xlewtXHjiNXvxLJ/rWBzvHl2mZu3wJqu76qxrzQkKtz
         xhBQ==
X-Gm-Message-State: AHQUAuY4JOKOn23dO64nOliOB/JekMdgqXqbt08Qb/m9h592nN+ev58k
        DY3sS0cMk17W/Halp49ke6/wZCfFuFzlp/PG/PA=
X-Google-Smtp-Source: AHgI3IYaCWosiBTJ/RfwKKbQURiC4HJONm4Gpkm9n8rKDNfL7DaIBdZtR/qCu3GnWrVhiCpqNFmAqN4Ew7QGXSSkrzI=
X-Received: by 2002:aed:3fd9:: with SMTP id w25mr3003310qth.352.1550841496984;
 Fri, 22 Feb 2019 05:18:16 -0800 (PST)
MIME-Version: 1.0
References: <cover.1550170980.git.jonathantanmy@google.com>
 <cover.1550780213.git.jonathantanmy@google.com> <b0ff17d324d46822da9db898d187dcc5fb0467ca.1550780213.git.jonathantanmy@google.com>
In-Reply-To: <b0ff17d324d46822da9db898d187dcc5fb0467ca.1550780213.git.jonathantanmy@google.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 22 Feb 2019 08:18:06 -0500
Message-ID: <CAPig+cQNg26zHm=ns3PsmPHEsNo4M7hTSG8=oO_uKqEa4wf3Vw@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] remote-curl: use post_rpc() for protocol v2 also
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 21, 2019 at 3:25 PM Jonathan Tan <jonathantanmy@google.com> wrote:
> diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
> @@ -542,7 +542,38 @@ test_expect_success 'clone with http:// using protocol v2' '
> +test_expect_success 'clone big repository with http:// using protocol v2' '
> +       test_when_finished "rm -f log" &&
> +
> +       git init "$HTTPD_DOCUMENT_ROOT_PATH/big" &&
> +       # Ensure that the list of wants is greater than http.postbuffer below
> +       for i in $(test_seq 1 1500)
> +       do
> +               # do not use here-doc, because it requires a process
> +               # per loop iteration
> +               echo "commit refs/heads/too-many-refs-$i" &&
> +               echo "committer git <git@example.com> $i +0000" &&
> +               echo "data 0" &&
> +               echo "M 644 inline bla.txt" &&
> +               echo "data 4" &&
> +               echo "bla"
> +       done | git -C "$HTTPD_DOCUMENT_ROOT_PATH/big" fast-import &&

Although not outright wrong, maintaining an &&-chain in the loop body
is a bit misleading here for a couple reasons. First, without "|| exit
1" at the end of the body, neither the loop nor the test itself will
abort early if some command within the body fails. Second, the exit
status of the loop is lost anyhow due to being upstream of a pipe.

By the way, I see that this same script already contains a couple
tests with loops neglecting the trailing "|| exit 1", hence they too
fail to abort early if something goes wrong inside the body (which, in
both cases, contains a test_commit() invocation). Fixing those might
be fodder as a follow-up patch for someone.
