Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E7CB21FD99
	for <e@80x24.org>; Sat, 20 Aug 2016 19:07:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753099AbcHTTHD (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 Aug 2016 15:07:03 -0400
Received: from mail-io0-f176.google.com ([209.85.223.176]:33283 "EHLO
        mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752801AbcHTTHC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Aug 2016 15:07:02 -0400
Received: by mail-io0-f176.google.com with SMTP id 38so77117270iol.0
        for <git@vger.kernel.org>; Sat, 20 Aug 2016 12:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to;
        bh=9wTLJkdaL31EZZP7i4HJhEiyZCSIdV7WarEA4Oo86ec=;
        b=gti3wTTyb6tMY7VSSUTibpRA8RoBCL4mAy80TUSNaA2T8HttE/dPsUHQgar4RMzU5r
         kFp7aXkQM1K+m6FUFxO6le7w//xqu702HmrFtX3lcXFo4UIqaKJdF6F00Q1Y1pIo+ZXc
         S+6wrx5+H8fnPBd74IRd4n5bLLLzLtenNDNHK0ARdakeQ4rfwAjqeXyX2LpBWh1GQXJ6
         lna/aRxpJ6eYnxzTohAmQWpVwHQUE+vV4Zs5tOq8Du+mVIH+9QZg9SE8zB4uWkzXLyUR
         y6XZAtH12v7SsgXS9fMOGdTp7I39v97qYlEUoZTAqhbOZOYxFDMPEpKl+5VY7ITmPjlH
         CnhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=9wTLJkdaL31EZZP7i4HJhEiyZCSIdV7WarEA4Oo86ec=;
        b=HD6lo/txXwLqfnGjAFFCWHL45Dd6OhdmwkvMpzwUuWXjSkhpV3B6EOukTasOONPyA1
         IqYSU68pco6FGLbfdudKH0OVZOji3lzFvFk7WfRH0+B2NlBi88NMQwRmTC6GiZMs6tQU
         yH0YBP0TeOuK6IKEdoaGhvC4Dz2TZ2vex812raH49mx/r7IJQGPB4ZiM4MdTPlXvADkP
         3phc7m5gI2NvksMjq3PEV9+60+cFjj0+7nkziXN9XeJtnI/mcaSDXUYmlw8RuZlkn64T
         JGdv4zBHhU+6TKi5zuVXY1VDrXUvfOQV0+ah/iwzg0B60zz9a5lw5tjpzOOMp0qqOAXH
         k8Eg==
X-Gm-Message-State: AEkoouuDWRM1bQ3MNVWPVj5Z597hOSWnG+GyToX4DKsTfQBQJyrhhyW6Wjab/KbViCqeuheCNG6Lcvm09nTDGw==
X-Received: by 10.107.48.76 with SMTP id w73mr17882024iow.172.1471720021211;
 Sat, 20 Aug 2016 12:07:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.83.5 with HTTP; Sat, 20 Aug 2016 12:07:00 -0700 (PDT)
From:   Richard <richard.maw@gmail.com>
Date:   Sat, 20 Aug 2016 20:07:00 +0100
Message-ID: <CAB2VqoZh6zZV3Lk2B7dBPVE5h6H1LCwyxWrUo4yJFhqB=hAjig@mail.gmail.com>
Subject: Adding more namespace support to git
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I work on a git server called gitano.
We've been using and recommending cgit for the web UI.

I've been working on adding git namespace support to both,
so that we can separate administrative branches from code branches.

Because git is not namespace aware for anything but git-upload-pack
and git-receive-pack,
I've had to implement namespace parsing in cgit
for listing branches, showing logs, displaying notes and commit decorations.
It might be more useful if this support was added to git itself,
so other git servers could make use of it so there's less duplicated code.

I think the way to do this would be to make the low-level ref reading functions,
read_raw_ref, for_each_reflog_ent*, reflog_exists etc.,
interpret the ref they are passed as being relative to the current git
namespace.

Since when upload-pack and receive-pack run hooks they leave GIT_NAMESPACE set
there are hook scripts that expect that the current namespace is ignored,
so commands that now want to be namespace aware would have to opt-in.

I tried adding a flag to the functions
with the intention of changing everything to conditionally set the flag
and adding wrapper functions to provide the old ABIs,
but quickly abandoned that after seeing how much change would be required.

Is anyone more familiar with the codebase able to recommend how I
might make it work,
and would there any interest in accepting such patches if I got it to work?

Please reply-all in response, I am not subscribed to the mailing list.
