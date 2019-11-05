Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 82FEE1F454
	for <e@80x24.org>; Tue,  5 Nov 2019 20:06:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728909AbfKEUG1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Nov 2019 15:06:27 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39705 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbfKEUG1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Nov 2019 15:06:27 -0500
Received: by mail-wr1-f66.google.com with SMTP id a11so22964066wra.6
        for <git@vger.kernel.org>; Tue, 05 Nov 2019 12:06:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+8r7KQeWappmCqKIzY48BS1dz4FgIh/YtSN0IwkJOGc=;
        b=itW35Zvd5a1cs18SqFZF7gv80+JWv3ujEGY/Jw/J181Qm4gqECSrHHv5KVJP9EZnZj
         DeNMy+rqswEB5ygN+3MLEw1Nf8uyiBlg44hIe2UUnv0ymfXzysxYOoad2L3KAU/eLhAw
         AXisXJbO2F04QvdkWxhRwEzZ0uNGSR5DuEy39tkj9gJJS0704l+IStxHSV+4c6SxJuKE
         8lMogKxXUJIBr0djnVKIqJ6OdGddN4CQ9rSEcbyUhc80vUZEMh/QNgraQKN1839A+LDd
         mdCDreDmPdhm6bcPlS/is73I5bEmZ2jUwvYk9j0lqWAac51PE1/JIPoU57x75kzEpFV7
         8wmQ==
X-Gm-Message-State: APjAAAX/qB6COQjB+1YOer9Q8LWivMQx8otkAsi4O4HHnwcwgWFolWcT
        MoVWbj+/dEw6WA5zk73C8XTur1KPewB/TqXZR1o=
X-Google-Smtp-Source: APXvYqxPFI0y53VoxpAHBag9AxuA+sh5SyWM0jdx0db5BpscJmp9tdAaK9bL4E9ZV1A1vSFp8qgxPj3RSXKCzJzQGEE=
X-Received: by 2002:adf:ea07:: with SMTP id q7mr30080792wrm.78.1572984384895;
 Tue, 05 Nov 2019 12:06:24 -0800 (PST)
MIME-Version: 1.0
References: <20191101203830.231676-1-jonathantanmy@google.com> <20191105185619.207173-1-jonathantanmy@google.com>
In-Reply-To: <20191105185619.207173-1-jonathantanmy@google.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 5 Nov 2019 15:06:13 -0500
Message-ID: <CAPig+cQ6iyJacniLDF_kuc1FhPMXYmL3V1DzdOPa6bX0h2FHFA@mail.gmail.com>
Subject: Re: [PATCH v2] fetch: remove fetch_if_missing=0
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Git List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 5, 2019 at 1:56 PM Jonathan Tan <jonathantanmy@google.com> wrote:
> diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
> @@ -296,6 +296,76 @@ test_expect_success 'partial clone with unresolvable sparse filter fails cleanly
> +setup_triangle () {
> +       rm -rf big-blob.txt server client promisor-remote &&
> +
> +       printf "line %d\n" $(test_seq 1 100) >big-blob.txt

Broken &&-chain.

> +       # Create a server with 2 commits: a commit with a big blob and a child
> +       # commit with an incremental change. Also, create a partial clone
> +       # client that only contains the first commit.
> +       git init server &&
> +       git -C server config --local uploadpack.allowfilter 1 &&
> +       cp big-blob.txt server &&
> +       git -C server add big-blob.txt &&
> +       git -C server commit -m "initial" &&
> +       git clone --bare --filter=tree:0 "file://$(pwd)/server" client &&
> +       echo another line >>server/big-blob.txt &&
> +       git -C server commit -am "append line to big blob" &&
> +
> +       # Create a promisor remote that only contains the blob from the first
> +       # commit, and set it as the promisor remote of client. Thus, whenever
> +       # the client lazy fetches, the lazy fetch will succeed only if it is
> +       # for this blob.
> +       git init promisor-remote &&
> +       test_commit -C promisor-remote one && # so that ref advertisement is not empty
> +       git -C promisor-remote config --local uploadpack.allowanysha1inwant 1 &&
> +       git -C promisor-remote hash-object -w --stdin <big-blob.txt &&
> +       git -C client remote set-url origin "file://$(pwd)/promisor-remote"
> +}
