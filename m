Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 658E420401
	for <e@80x24.org>; Wed, 21 Jun 2017 14:27:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752601AbdFUO1o (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Jun 2017 10:27:44 -0400
Received: from mail-pg0-f47.google.com ([74.125.83.47]:33353 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752472AbdFUO1n (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2017 10:27:43 -0400
Received: by mail-pg0-f47.google.com with SMTP id f127so1030737pgc.0
        for <git@vger.kernel.org>; Wed, 21 Jun 2017 07:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=w4CTiydNZYEA1VGm1JqWZg6lTupwcvgdg0d/CwRX4cs=;
        b=oEyrmS2Ytt64UttMJv7PAEmw3/0dfJLzaHEYraYFxBZbQ/SzgY6DRhf7y9mEGQ2wz3
         C3TVgR+KUQKgZOy2GhRq7ginlYtZQeZuRSieGEbemUe4EWdXd/Re1pNxEnhp6nRgoGg1
         +0h8SCEIqCl4e7Q6FIEXHm8O4l3bJQW+IMNsoqriNC+KF6rFc1PmEmr5P8lY7nWD9Eci
         Sdv7gHoeQ3abc0p0DnsdIcQWmkIDkrNKN2bDdg36VA1MlSSeiczAo6k5jXs9885Lr7jG
         gazfyTWD7jomH//nehc6jK+xZBs1tFN60g/3u1k9SRrZRtZ7iTvSNTE9iO8YxjYb8m1F
         ICcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=w4CTiydNZYEA1VGm1JqWZg6lTupwcvgdg0d/CwRX4cs=;
        b=s5L2yzsAma4q0t+Gz1NvsdQCwRTvHSHaoqdrx3UkhFDIX520j++P5KOCXFhMXCMb9k
         mnNyJ85E/U99eK5l8N0wzRqZVPj9jVtBuH+9m3AjwpDZxYLT6wDmoA4CsRYDA9WFUJO3
         5qxFw/CsQnVMUnP8q2O/HQr2ER3Bx+8sxGHXlXKMjZXLHM/FOcsTCgNmdJDb4Xuv0Z/V
         Lfz7btCXwSs5WoTNlpCja3a7ehPFY1dcMA+y5VCEsiE9i9GByb3LCwWUpBqU5MWjj1P2
         3IdDJrMNXWS4KGwqfnVUaKgwUaM6CQBtRA4W79jMn6BeYx2zpZPj8be8BcNjNdJG/8wM
         gq9g==
X-Gm-Message-State: AKS2vOzbUfncHN88ZqoFmgonqJLYB7hqVgRajQqpOFWoLeMqgjFTGP0e
        FGOQtyOaIKN64dBp1vw6yWze0YlGs8JOVa0=
X-Received: by 10.98.104.71 with SMTP id d68mr25688558pfc.35.1498055257466;
 Wed, 21 Jun 2017 07:27:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.181.174 with HTTP; Wed, 21 Jun 2017 07:27:17 -0700 (PDT)
From:   Tim Hutt <tdhutt@gmail.com>
Date:   Wed, 21 Jun 2017 15:27:17 +0100
Message-ID: <CAKuVd4Bdhreu6wrwDp1Bia56Db=TXYMQcitsznaRM+QcYVzJnQ@mail.gmail.com>
Subject: Monitoring a repository for changes
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Currently if you want to monitor a repository for changes there are
three options:

* Polling - run a script to check for updates every 60 seconds.
* Server side hooks
* Web hooks (on Github, Bitbucket etc.)

Unfortunately for many (most?) cases server-side hooks and web hooks
are not suitable. They require you to both have admin access to the
repo and have a public server available to push updates to. That is a
huge faff when all I want to do is run some local code when a repo is
updated (e.g. play a sound).

Currently people resort to polling
(https://stackoverflow.com/a/5199111/265521) which is just ugly. I
would like to propose that there should be a forth option that uses a
persistent connection to monitor the repo. It would be used something
like this:

    git watch https://github.com/git/git.git

or

    git watch git@github.com:git/git.git

It would then print simple messages to stdout. The complexity of what
it prints is up for debate, - it could be something as simple as
"PUSH\n", or it could include more information, e.g. JSON-encoded
information about the commits. I'd be happy with just "PUSH\n" though.

In terms of implementation, the HTTP transport could use Server-Sent
Events, and the SSH transport can pretty much do whatever so that
should be easy.

Thoughts?

Tim
