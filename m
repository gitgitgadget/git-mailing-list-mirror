Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 862DD20281
	for <e@80x24.org>; Thu,  5 Oct 2017 13:22:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751620AbdJENWt (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Oct 2017 09:22:49 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:35703 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751330AbdJENWr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Oct 2017 09:22:47 -0400
Received: by mail-wr0-f193.google.com with SMTP id y44so4535140wry.2
        for <git@vger.kernel.org>; Thu, 05 Oct 2017 06:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:subject:date:message-id;
        bh=vq1QFVr5zYiKM3aRQgCNCtGYVjqmzcJdVMapnTSe48g=;
        b=Ejye44w0ftIiV+ktPBcqLIMdgEQ8fcHm8l6gW1tmind+aQU3UHNvvFvyGM7sVKGuPw
         QzdKtDbIosK7ecUy/xj9OeAjVTCUciBo6UeOY66V03I+p2CWuRulGr0tEccLbRn0mNyd
         Eh+3iWWucjtX5t8T85bNYA2WldAd1EqyGA7NuudBvErDCInmVDF9wRhC3eZVIzJy9dbo
         pdBGSZ01Q3EYaT4pbaUl+EhYWCqo3dk7aobdee5jDrz1Q9hcLUVq6pQJtOcKyxLzqwgw
         /BCWBdkoQqaRP73lmsUnTxH++jeHiKrE2HXl91aihwDBi70BZnq906nHUP2hD8HIjybO
         HfJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:subject:date:message-id;
        bh=vq1QFVr5zYiKM3aRQgCNCtGYVjqmzcJdVMapnTSe48g=;
        b=QG33srDfoK3cMe/mr2j7QqlIfDZGu76Urxl0mcN9Cm9AiwYQMIIdyg+9YeajRg/5uo
         MwpbbADqPJndcvQ6jeNSnj9Tf5+aUfhv4iVROmExvqlZjfU+FLtL5ydVSFmmSu4hP/OO
         4U/Qh/Jx8JfscPvv74gdL2xccco79YF6nuwbn34W4nJvAMjhMIE53JZN6gIiRtysczpY
         r9NvvETnWCAsJPARghOdufit44nqI/lf8rUlB4PZz8RmRnCDLjP+ufmWxWIyEIkDfA/1
         7DcAfq7j7QEh3CdA3SVdHuUIErr5kUXS5RkR87tDA3K2eswQw+XqjfGV/V8e69s/oUZ+
         NCIg==
X-Gm-Message-State: AHPjjUgPWZbsc7kmdoxXD7RcP12RQYQqC6TYchL3N3uTpr7VupswwJQ2
        FU7MlTryLMaanM3HEGVkeiaCfK1E
X-Google-Smtp-Source: AOwi7QCBnQyeKImmPpADQ/9sk1nfJlNprjs2f6h43FOqxoSJFAq8i9KVaV37+AALHWvbpw4h/jknyw==
X-Received: by 10.223.133.147 with SMTP id 19mr22240749wrt.184.1507209765491;
        Thu, 05 Oct 2017 06:22:45 -0700 (PDT)
Received: from donizetti.redhat.com (dynamic-adsl-78-12-246-117.clienti.tiscali.it. [78.12.246.117])
        by smtp.gmail.com with ESMTPSA id r15sm10864439wrc.30.2017.10.05.06.22.44
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 05 Oct 2017 06:22:44 -0700 (PDT)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     git@vger.kernel.org
Subject: [RFC PATCH 0/4] interpret-trailers: introduce "move" action
Date:   Thu,  5 Oct 2017 15:22:39 +0200
Message-Id: <20171005132243.27058-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.14.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The purpose of this action is for scripts to be able to keep the
user's Signed-off-by at the end.  For example say I have a script
that adds a Reviewed-by tag:

    #! /bin/sh
    them=$(git log -i -1 --pretty='format:%an <%ae>' --author="$*")
    trailer="Reviewed-by: $them"
    git log -1 --pretty=format:%B | \
      git interpret-trailers --where end --if-exists doNothing --trailer "$trailer" | \
      git commit --amend -F-

Now, this script will leave my Signed-off-by line in a non-canonical
place, like

   Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
   Reviewed-by: Junio C Hamano <gitster@pobox.com>

This new option enables the following improvement:

    #! /bin/sh
    me=$(git var GIT_COMMITTER_IDENT | sed 's,>.*,>,')
    them=$(git log -i -1 --pretty='format:%an <%ae>' --author="$*")
    trailer="Reviewed-by: $them"
    sob="Signed-off-by: $me"
    git log -1 --pretty=format:%B | \
      git interpret-trailers --where end --if-exists doNothing --trailer "$trailer" \
                             --where end --if-exists move --if-missing doNothing --trailer "$sob" | \
      git commit --amend -F-

which lets me keep the SoB line at the end, as it should be.
Posting as RFC because it's possible that I'm missing a simpler
way to achieve this...

Paolo Bonzini (4):
  trailer: push free_arg_item up
  trailer: simplify check_if_different
  trailer: create a new function to handle adding trailers
  trailer: add "move" configuration for trailer.ifExists

 Documentation/git-interpret-trailers.txt |  13 ++-
 t/t7513-interpret-trailers.sh            |  37 +++++++
 trailer.c                                | 169 ++++++++++++++++++-------------
 trailer.h                                |   1 +
 4 files changed, 149 insertions(+), 71 deletions(-)

-- 
2.14.2

