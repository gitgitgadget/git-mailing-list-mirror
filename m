Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8FD351F45B
	for <e@80x24.org>; Fri, 28 Dec 2018 19:37:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387863AbeL1ThF (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Dec 2018 14:37:05 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:46178 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732082AbeL1ThF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Dec 2018 14:37:05 -0500
Received: by mail-qt1-f196.google.com with SMTP id y20so24280138qtm.13
        for <git@vger.kernel.org>; Fri, 28 Dec 2018 11:37:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5DxjV4sPRKAD8xmLKlksZ4QWMunTiso1Sw7+1b9goOA=;
        b=tfKDh1WZxr6vM3GoElGJFZM5FozFAa36AP3YXbFGX5q/Kg4ntVBn9OLPKpac7raUyP
         nxgvRZteEwI3PRQ0PfGBvr96EVwSQcoSl6znXiF0GjGWF1G84dUgPoZjzBeXg2zuUmz4
         dmKVVeimYYVjy/fR4UKoCVSdT7My154UbWIyIfwHT5ZuAxUmIEua/FItxkDg23+bcPeN
         ClGxGHzT9/ni6M6qmEDX7XaPism9fwY0gDrnihSTsvzWWB09PcF86H+8ldc/ExngN7SJ
         3c19aTjqO1pLJ0dTfCX1UPJRZ5OuJlXaDXVF8itGjDjaJDbrFM/yKWheW7ETJp8b9N+A
         +HNw==
X-Gm-Message-State: AJcUukf/a/MkPTsDcnyA4w8+ckyM4R3EMyOqeJoTZewFXxCbR+wekbXU
        eOHxKXeOCbt/IH7MbDawhNNv+pWypVwT5e7d+xyFbDgI3/E=
X-Google-Smtp-Source: ALg8bN5z0Gz4ylUZ1+CDpynw+epr8LJ06+Z4VLpZnAs9Lnh9JiUzoiXezg3jat93qR2j5g9TwSNp4QSCV4VHofMEeXs=
X-Received: by 2002:ac8:36ba:: with SMTP id a55mr26637340qtc.236.1546025824381;
 Fri, 28 Dec 2018 11:37:04 -0800 (PST)
MIME-Version: 1.0
References: <20181228014720.206443-1-masayasuzuki@google.com> <20181228014720.206443-2-masayasuzuki@google.com>
In-Reply-To: <20181228014720.206443-2-masayasuzuki@google.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 28 Dec 2018 14:36:52 -0500
Message-ID: <CAPig+cQc6oF3b03XS2jmNdtUDOX_08tv=AMUpdd7D1eDto33=A@mail.gmail.com>
Subject: Re: [PATCH 2/2] Unset CURLOPT_FAILONERROR
To:     Masaya Suzuki <masayasuzuki@google.com>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 27, 2018 at 8:47 PM Masaya Suzuki <masayasuzuki@google.com> wrote:
> When GIT_CURL_VERBOSE is set, libcurl produces request/response headers
> to stderr. However, if the response is an error response and
> CURLOPT_FAILONERROR is set, libcurl stops parsing the response, and it
> won't ump the headers. Showing HTTP response headers is useful for

s/ump/dump/

> debugging, especially for non-OK responses.
>
> This is substantially same as setting http_options.keep_error to all
> requests. Hence, removing this option.

s/removing/remove/

> Signed-off-by: Masaya Suzuki <masayasuzuki@google.com>
> ---
> diff --git a/t/t5581-http-curl-verbose.sh b/t/t5581-http-curl-verbose.sh
> @@ -0,0 +1,32 @@
> +test_expect_success 'setup repository' '
> +       ...
> +'
> +
> +test_expect_success 'create http-accessible bare repository' '

Not a big deal, but this seems like more setup, so it could be folded
into the "setup" test above it.

> +       mkdir "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
> +       (cd "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
> +        git --bare init
> +       ) &&

Since this is a new test script, it makes sense to format the subshell
in the modern style:

    (
        cd ... &&
        git ...
    ) &&

Alternately, use -C and drop the subshell altogether:

    git -C $BLAH/repo.git --bare init &&

> +       git remote add public "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
> +       git push public master:master
> +'
> +
> +test_expect_success 'failure in git-upload-pack is shown' '
> +       (GIT_CURL_VERBOSE=1 git clone --bare "$HTTPD_URL/error_git_upload_pack/smart/repo.git" 2>curl_log ||
> +        true) &&

Using test_might_fail() would allow you to drop the subshell and the "|| true":

    test_might_fail env GIT_CURL_VERBOSE=1  git clone ... &&

> +       cat curl_log | grep "< HTTP/1.1 500 Intentional Breakage"
> +'
