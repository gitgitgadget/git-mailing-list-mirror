Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3C19C77B73
	for <git@archiver.kernel.org>; Sun, 23 Apr 2023 09:39:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbjDWJjb convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sun, 23 Apr 2023 05:39:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjDWJja (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Apr 2023 05:39:30 -0400
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BC6BE7B
        for <git@vger.kernel.org>; Sun, 23 Apr 2023 02:39:29 -0700 (PDT)
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-74dd7f52f18so967582485a.0
        for <git@vger.kernel.org>; Sun, 23 Apr 2023 02:39:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682242768; x=1684834768;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zUU+D80zJ91wQVx160qQG3zxA4KDD3RTVz7Cr0El8r8=;
        b=goxZCwDv3NqBgFp6ebe7m1rL/IdhMSLUxw2ug9yTtYOQqq4nRcRzrijTLOf+X2Lb+/
         KglWp8AS1kqdMPPdY+yQUcQ13e45ZEDqDhTKQJEWtKtTcqifKT9o6n5i0tsii7eZV5yu
         zE+paopu0ilJYm38ui4yUTb3oK9tMuz3SisYPLUOS1JhIKJSIi2lK2h2/S40cjWAeLqX
         p4FVypFpHr9+2sq0GqSAIRkRJNAJThhI98RrDavWTKKjxLKuehgq+KjJIWioI54wnhJU
         yOppIpbedUwLypxfgixYHf5hVKTTYowmZga7LmxCCcb8IsTHnGej2DS980/l6+v/FKzy
         kOcQ==
X-Gm-Message-State: AAQBX9eqfVII1YieBkNNmUYd1wPyquZ0q6ZZM0oG0CfgDA/gkxJOjJuo
        hX6FSshWmEZLH7kiLDWu0nJR1QZzkr7zsMoKd9IGWhpBVug=
X-Google-Smtp-Source: AKy350Zv9NjZiNyQRTzL6vtfsfDZ2m43YF2PXoA4Er9+QVVgxWgi+ssLJ2xEbLGWqynfL2X7Yn0zrFS/j5ZTuJrS6Xo=
X-Received: by 2002:a05:622a:653:b0:3ef:34e1:d37d with SMTP id
 a19-20020a05622a065300b003ef34e1d37dmr16386647qtb.25.1682242767930; Sun, 23
 Apr 2023 02:39:27 -0700 (PDT)
MIME-Version: 1.0
References: <8fe188a9-c01f-9fb5-5877-8ff508094b22@game-point.net>
 <01cd01d9754b$f12326b0$d3697410$@nexbridge.com> <fbe77ad2-ce65-e6a6-254e-01bf6446d582@game-point.net>
 <01ce01d97553$4361f990$ca25ecb0$@nexbridge.com> <3ac19159-7314-c299-5112-b0f7aa2cc409@game-point.net>
 <01d301d97567$0e9bc0b0$2bd34210$@nexbridge.com>
In-Reply-To: <01d301d97567$0e9bc0b0$2bd34210$@nexbridge.com>
From:   Erik Cervin Edin <erik@cervined.in>
Date:   Sun, 23 Apr 2023 11:38:52 +0200
Message-ID: <CA+JQ7M8avZiZuBHUtkQu2WqtR4zozU3C2ayCjBxRsQcKjAr16g@mail.gmail.com>
Subject: Re: Proposal: tell git a file has been renamed
To:     rsbecker@nexbridge.com
Cc:     Jeremy Morton <admin@game-point.net>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 22, 2023 at 9:57 PM Jeremy Morton <admin@game-point.net> wrote:
>
> https://stackoverflow.com/a/1094392/178757
>
> says:
>
> git mv oldname newname
>
> is just shorthand for:
>
> mv oldname newname
> git add newname
> git rm oldname

That's what I though but it's more like:
  git show :0:oldname > newname
  git add newname
  git rm --cached oldname
  mv oldname newname

Basically, a move but also preserving staged/unstaged contents. But
yes. How git handles renames can sometimes be a bit of a PITA.

On Sun, Apr 23, 2023, 12:16 AM <rsbecker@nexbridge.com> wrote:
>
> $ git add file1
> $ commit -m "Commit 1"
> $ git mv file1 file2
> $ git status
> On branch master
> Changes to be committed:
>   (use "git restore --staged <file>..." to unstage)
>         renamed:    file1 -> file2

I think your point is better illustrated
  git add file1
  commit -m "Commit 1"
  echo 'Changed' > file1
  git mv file1 file2
  git status
Which yields:
Changes to be committed:
  (use "git restore --staged <file>..." to unstage)
        renamed:    file1 -> file2

Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
        modified:   file2

Or perhaps even:
  echo Initial > file1
  seq 1 10 >> file1 # We need a larger file to detect rename with change
  git add file1
  git commit -m 'Commit 1'
  seq -i 's/Initial/Changed/' file1
  git add file1 # Stage changes
  seq 11 20 >> file1 # Add some unstaged changes
  git mv file1 file2

This will result in a staged rename, as well as the staged change
'Initial'  -> 'Changed' with a bunch of additional unstaged lines of
numbers 11 to 20.
NB that this doesn't play nice unless the contents of file1 in HEAD
and index are similar enough (at least 50%?)
