Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2861720A1E
	for <e@80x24.org>; Sat,  8 Dec 2018 02:12:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726081AbeLHCMh (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Dec 2018 21:12:37 -0500
Received: from mail-it1-f171.google.com ([209.85.166.171]:54571 "EHLO
        mail-it1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbeLHCMh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Dec 2018 21:12:37 -0500
Received: by mail-it1-f171.google.com with SMTP id i145so9825609ita.4
        for <git@vger.kernel.org>; Fri, 07 Dec 2018 18:12:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=okcupid.com; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=7yi2BTAC6WE3MhnCCCcAt+5p5VBB+g+6SntXcUkAojw=;
        b=QxUdNBA5uYRL8gdVW5lFQUWZtecGz08fUhuxSOHy2J04IHuZ9HNcTy7kPdn3EsPYXd
         X+utPORBB/R2EtW/4+SzrewBWedI6XHINmyZodaxKS1+82SPbHVn1TfrN/5BfklC3btb
         VmV6mOckAW+o7J72r6xJPNcjgDKjcoyO6GEWU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=7yi2BTAC6WE3MhnCCCcAt+5p5VBB+g+6SntXcUkAojw=;
        b=a4Brb1aF6uPkscCvp2JIlvEY2fFU6TWI4XE6sOEUYRpOQ9MjIW/APF2Y1YuKFtZOmR
         em4TKKXjFLhS31umPc/zJqEHj9MBM45Ltv3n9WqDD8SonPBfolUS4Zc2KnvJnIwO/PFP
         RHqAbGZKvBEik1KlNfw2z2SryG4E/FBrWCDdtSl7d9Cy1KEPuXtV7lEmcTetqqDoJYsn
         1JZNndGUIeCc2STTAjdNCc+TlE+ttfWVVpoJ7XVAYD22GBJv5xqEUlDq0YeCpCBq1Rj0
         j6MSy8Wgz0gG+iEIBxNYFdi1ZpCKYlGogxlBLFto8szM9Xv3/Nws/3wthm944YQ2s65L
         NoBA==
X-Gm-Message-State: AA+aEWYps9YJ+41ARPT0rRGr3SBRGSpsLZoCCZKN/k5zrh51e39G/2Hf
        D4+vj8E0shswXCyq4pjMMHkwz/kKw6iWFLBBlCPdhqTIeMk=
X-Google-Smtp-Source: AFSGD/UmaTfOYDMy8PNcCsji/r3MNMf8xk5ZjhxOIAgZSW5jQGKZ6lRcFNQ+96m4yiCeHaU3vPZPtpwsoSP6fFWNrCk=
X-Received: by 2002:a05:660c:a45:: with SMTP id j5mr4102085itl.83.1544235155875;
 Fri, 07 Dec 2018 18:12:35 -0800 (PST)
MIME-Version: 1.0
From:   Josh Wolfe <josh@okcupid.com>
Date:   Fri, 7 Dec 2018 21:12:24 -0500
Message-ID: <CAKQQkGppdO5pwOpG+sJ0uc2uPW867TZzWzc0ZntPd6MkqsozFQ@mail.gmail.com>
Subject: bug: git fetch reports too many unreachable loose objects
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git version 2.19.1
steps to reproduce:

# start in a brand new repo
git init

# create lots of unreachable loose objects
for i in {1..10000}; do git commit-tree -m "$(head -c 12 /dev/urandom
| base64)" "$(git mktree <&-)" <&-; done
# this prints a lot of output and takes a minute or so to run

# trigger git gc to run in the background
git fetch
# Auto packing the repository in background for optimum performance.
# See "git help gc" for manual housekeeping.

# trigger it again
git fetch
# Auto packing the repository in background for optimum performance.
# See "git help gc" for manual housekeeping.
# error: The last gc run reported the following. Please correct the root cause
# and remove .git/gc.log.
# Automatic cleanup will not be performed until the file is removed.
#
# warning: There are too many unreachable loose objects; run 'git
prune' to remove them.

# to manually fix this, run git prune:
git prune

# note that `git gc` does not fix the problem, and appears to do
nothing in this situation:
git gc


According to the `git fetch` output, the `git help gc` docs, and the
`git help prune` docs, I don't think I shouldn't ever have to run `git
prune` manually, so this behavior seems like a bug to me. Please
correct me if this is expected behavior.

In case anyone's wondering why I'm creating unreachable loose objects,
here's the usecase: https://stackoverflow.com/a/50403179/367916 . I
would love a first-class solution to obviate that workaround, but that
is probably a separate issue.

Josh
