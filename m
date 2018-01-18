Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D03D1F406
	for <e@80x24.org>; Thu, 18 Jan 2018 00:34:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753879AbeARAel (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Jan 2018 19:34:41 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:41659 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753023AbeARAek (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Jan 2018 19:34:40 -0500
Received: by mail-pg0-f66.google.com with SMTP id 136so11939565pgd.8
        for <git@vger.kernel.org>; Wed, 17 Jan 2018 16:34:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=GbjQ7CWl1DroyLYYMU7/a536bcsKEQsKmUg6n1DqWvQ=;
        b=JdF4r6OY/mqNJG7SMUY31gqQYsTp9US+gi0Yt5noI0hAWU8kqroXb+4hdisDcToC4i
         RTHDkpDf+iTpZ+s0epPcWoZJRaU7OoHsZu+FupgVsSAr76lznp5jJfpFy0XpzsEhwhS+
         5H6LJEEIxGaTwae4pUidiv3Ufm1reTBRRVT1F6AKygX9UlOF9B0FhzsLg/2RJpjlMGjb
         JiqW6k3v1MnSDf3hZsX8aP1r/XijEPksrII0apuIgm0ajOS+w4ur0lDBivj4YfUy5jwa
         QJsEPyIYi+ceXhJUmvM/+5EJ8f1Iy5qVm4NyqOLjo1DCK+TMMA+4UJU8Y5tLL/IeJ7IO
         /N7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=GbjQ7CWl1DroyLYYMU7/a536bcsKEQsKmUg6n1DqWvQ=;
        b=B9OWTVqAUcdOXfC8pKYFP6yLhX3wI/0yondLjsixBRCKeGaVXMja6uG1XVZblzoe0A
         lvln0kJPf8L5ggwT4mf9MtPcUOCmlQ31k7wCBDVnIg/honzu/QuYO0Bq3EgQqzA9zEuO
         7P0d0SKo37Y1h0XFFiPdZdWNjX0iYXGyUFG9zVfyrm3T8McVmomY9pHgXYvcLilecchc
         1tB0zAzDIXqlOP8VH/+IXS6wFI0J0Wfx7AiiM+Wurewti2vAfwLPUxAuxfZR81T9ZkhW
         S71DZnN/y89BUxDYa8WGYH3NiwfjZpOz8+cbsXfGGYqyd7RasIYg1djhPhcKFNJPYvfy
         LocA==
X-Gm-Message-State: AKwxytdF5zB+TJEiLX2VQn5q+BhnBU28vqX9yb7qyxTlw93tfeYZrlPA
        Z9ockizxKgHf7ZF/ZQe46RCJYIkCHTY=
X-Google-Smtp-Source: ACJfBovRAnmHIpt5clPPMRvbFWTcIzcVjzu9YXq6f0SLA9jnL9opmQA6MLKWMDyqTqe8brOOhNL2Eg==
X-Received: by 10.159.252.75 with SMTP id t11mr4967111plz.324.1516235679883;
        Wed, 17 Jan 2018 16:34:39 -0800 (PST)
Received: from twelve3.mtv.corp.google.com ([100.96.218.44])
        by smtp.gmail.com with ESMTPSA id d5sm11233484pfk.2.2018.01.17.16.34.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 17 Jan 2018 16:34:38 -0800 (PST)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: [RFC PATCH 0/2] Cookie redaction during GIT_TRACE_CURL
Date:   Wed, 17 Jan 2018 16:34:29 -0800
Message-Id: <cover.1516235197.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.16.0.rc2.38.g114ad43e1.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sometimes authentication information is sent over HTTP through cookies,
but when using GIT_TRACE_CURL, that information appears in logs. There
are some HTTP headers already redacted ("Authorization:" and
"Proxy-Authorization:") - the first patch extends such redaction to a
user-specified list.

I've also included another patch to allow omission of data transmission
information from being logged when using GIT_TRACE_CURL. This reduces
the information logged to that similar to GIT_CURL_VERBOSE.
(As for why not use GIT_CURL_VERBOSE instead - that is because
GIT_CURL_VERBOSE does not perform any redaction, merely using Curl's
default logging mechanism.)

The patches are ready for merging, but I marked this as "RFC" just in
case there is a better way to accomplish this.

Jonathan Tan (2):
  http: support cookie redaction when tracing
  http: support omitting data from traces

 http.c                      | 82 ++++++++++++++++++++++++++++++++++++++++-----
 t/t5551-http-fetch-smart.sh | 24 +++++++++++++
 2 files changed, 98 insertions(+), 8 deletions(-)

-- 
2.16.0.rc1.238.g530d649a79-goog

