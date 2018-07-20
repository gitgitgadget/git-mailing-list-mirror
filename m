Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 489101F597
	for <e@80x24.org>; Fri, 20 Jul 2018 18:09:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388203AbeGTS7E (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Jul 2018 14:59:04 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:41178 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731556AbeGTS7E (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jul 2018 14:59:04 -0400
Received: by mail-yb0-f195.google.com with SMTP id s8-v6so4956892ybe.8
        for <git@vger.kernel.org>; Fri, 20 Jul 2018 11:09:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DYFDVy47NIFe7CsfvqeSseVPJowGrxQUVcpS9iSOkoA=;
        b=Z9uLWO3Dc+s2KZ5YXQ0hvkG4DvFVCVvy+W+pVrVNDczbefvT/Clt7e7br2knAd0BXf
         NC+h+EeRZzXsMkU2nq7M7eYcnB5CVBcvKhMPw18VjXzM7E9cOjw8HqjrjXfh8tCKgsTH
         qn7nLLuXprNVnfJfEdfBtrucJ6scs3EKwxiA7XOhqmYAntDlGIt0ya4/GohnJlPd1g0V
         ToKYMTeoFJ9JhH0G3REsQRghoG2DV8BZg619mEBqvZgiOzftdmOqmeIN+EKmzzFUddcF
         QKCJoPHa2vagWmmx63RnxC28R9PQ/p5jaEvWmDmuezZgzaXCAdBgsGUuJup9lioLiJP7
         WybA==
X-Gm-Message-State: AOUpUlHGjHYyHCNZVbVG44YQm2QZlM3ZqCRLLeCWclGo8TtlCVVLjXLX
        f0wkOjOcvJdHXhA6CGBxrm29iY4WQjR7EaQCQrQ=
X-Google-Smtp-Source: AAOMgpdnqIUgnkPaWZ57023NCz2YWjvsdr3mYuczMRCX+FFqa5YyhZj9gyMv/QQB81jiPnMoNq0xIgd4fJMQPxD+DU4=
X-Received: by 2002:a25:9d81:: with SMTP id v1-v6mr1655505ybp.76.1532110178827;
 Fri, 20 Jul 2018 11:09:38 -0700 (PDT)
MIME-Version: 1.0
References: <20180720163227.105950-1-dstolee@microsoft.com> <20180720171836.106091-1-dstolee@microsoft.com>
In-Reply-To: <20180720171836.106091-1-dstolee@microsoft.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 20 Jul 2018 14:09:27 -0400
Message-ID: <CAPig+cRRa9gcvfu9jKy-+DK+Jjj6maCabuOyprVQMeGx4uJrRg@mail.gmail.com>
Subject: Re: [PATCH v2 00/18] Consolidate reachability logic
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     Git List <git@vger.kernel.org>, Derrick Stolee <stolee@gmail.com>,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 20, 2018 at 1:20 PM Derrick Stolee <dstolee@microsoft.com> wrote:
> Here is the diff between v1 and v2.
>
> diff --git a/t/t6600-test-reach.sh b/t/t6600-test-reach.sh
> @@ -67,142 +67,176 @@ test_three_modes () {
>  test_expect_success 'get_merge_bases_many' '
>         cat >input <<-\EOF &&
> +       A:commit-5-7
> +       X:commit-4-8
> +       X:commit-6-6
> +       X:commit-8-3
>         EOF
>         {
> -               printf "get_merge_bases_many(A,X):\n" &&
> -               git rev-parse commit-5-6 &&
> -               git rev-parse commit-4-7
> +               echo "get_merge_bases_many(A,X):" &&
> +               git rev-parse commit-5-6 \
> +                             commit-4-7 | sort

Pipes lose the exit code of the all upstream commands. When a Git
command is upstream, we'd usually recommend to dump its output to a
file, then use the file as input to the rest of the pipe so as not to
lose the Git command's exit code:

    {
        ...
        git rev-parse ... >oids &&
        sort <oids
    } >expect &&

One could argue, in this case, that if git-rev-parse crashes, then it
won't have the expected output and the test will fail anyhow despite
not seeing its failed exit code. However, git-rev-parse might crash
_after_ emitting all the normal, expected output, and that crash would
be missed altogether, so avoiding git-rev-parse as a pipe upstream is
a good idea.

However, one could argue that argument by saying that it isn't the job
of this particular test script to check git-rev-parse's behavior, so
crashy git-rev-parse ought to be caught elsewhere by some other test
script. Nevertheless, you'll likely encounter reviewers who don't want
to see git-rev-parse upstream, even with that argument.

Anyhow, why is that 'sort' even there? It wasn't needed in the
original. Is git-rev-parse outputting the OID's in random order?

>         } >expect &&
>         test_three_modes get_merge_bases_many
>  '
>
>  test_expect_success 'reduce_heads' '
>         [...]
> +               git rev-parse commit-5-1 \
> +                             commit-4-4 \
> +                             commit-3-6 \
> +                             commit-2-8 \
> +                             commit-1-10 | sort

Ditto.

>         } >expect &&
>         test_three_modes reduce_heads
>  '
