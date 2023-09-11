Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8BB0EE7FF4
	for <git@archiver.kernel.org>; Mon, 11 Sep 2023 04:23:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232432AbjIKERr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Sep 2023 00:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbjIKERo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Sep 2023 00:17:44 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A43D6FE
        for <git@vger.kernel.org>; Sun, 10 Sep 2023 21:17:35 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id 5614622812f47-3ab7fb1172cso797404b6e.3
        for <git@vger.kernel.org>; Sun, 10 Sep 2023 21:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694405854; x=1695010654; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FbeHlgyGeM5Echgl0CAc0AGHzG9GLTnLmWyDWGAeG+E=;
        b=Dtz00Tt9QJ8DyQxgBm8X2UNDVJqPYP7DWpXq4le56tds24wY5KUqE+cdCAr3UdwgN9
         vue/okrTRGHC+okPC5fth1QrQP0TsgbpaJTt9S/oLtwxa9A6J5yrvLlKKqdoNnFWT2wk
         bmxLc1kaE7rJb28Bbk7Yo1lAdX8lYqcD4YCszsGG8jRk1Uihl4uN1KJF2Q4lBtkwVYrx
         kWuOvDATN9lXZnPNxR/PljleF1ejNqKN2hRFZ71XE4rcUytXLIXWYXQNmKpJlKE7cMw9
         xZZmRZ2OF+IL6dmaN6TP7+GfsVqDIL6fpaF78dy42KmvfCMYozCJCwudaIWzFs0PM5lZ
         HkXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694405854; x=1695010654;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FbeHlgyGeM5Echgl0CAc0AGHzG9GLTnLmWyDWGAeG+E=;
        b=Wa704TlZcEoz1uPkf6KNQr9zzhprwFljqT0wM1e0azJj++yRtfbF+n2hJKGNdsy2Nx
         bwzW1J5D7f5/nH+ZXF9d91SIHMz25/tOqLiMqCCjNdMgyvUp3DFq3uOiQ8zQqelgeIFo
         /G/hXboXiL/8Uikf9VWtNzW6uqgDVHXikuSwZnbl1VxEMP8W39j04V21yW1RsRkTYNsv
         YkBJmk5dGHDOK5/e/cGmP0er1H5TnWV3UrOzKe13iwpGCmL7gQ3pfyC7HaVLfDj05J8b
         c7msVf75OxD930UqAxM8F5cWlwa4nosbVo617F4tcLINhRW13lF2TGlurFTfpUCXrGYP
         KslA==
X-Gm-Message-State: AOJu0YwJx55bpNabsRmR5atsUUSXvkmsbjCF1Q2WijtV0H+oyF2EkT2L
        2makmdMNwHMX/zvYd+oHSnE2wFBWDy1x32fz+TpEcQc89g==
X-Google-Smtp-Source: AGHT+IFIElMryrjXt1wTtD64tQCh3/POJVN8Vdb3iPXONHbt3fcSv8S/cRhj69VBKaFW3Df+oUNFTWPN6HtJtW6C0b4=
X-Received: by 2002:a05:6808:1795:b0:3a7:550c:635d with SMTP id
 bg21-20020a056808179500b003a7550c635dmr10312974oib.56.1694405853906; Sun, 10
 Sep 2023 21:17:33 -0700 (PDT)
MIME-Version: 1.0
From:   Yawar Amin <yawar.amin@gmail.com>
Date:   Mon, 11 Sep 2023 00:17:21 -0400
Message-ID: <CAJbYVJJUVUPNPpGAMGZKVWxYu2PiOf_16kzts009qpeLwoim+g@mail.gmail.com>
Subject: Idea: indirect authorship info
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I have an idea about enabling management of authorship info in a git repo, to
make it easier to manage and potentially remove author/committer/tagger PII (in
the context of GDPR), without having to change any commit history/SHAs.
Apologies if this has been brought up before, but I failed to find anything
relevant from some quick searches:

- https://lore.kernel.org/git/?q=indirect+authors
- https://lore.kernel.org/git/?q=authors+file
- https://lore.kernel.org/git/?q=people+file

Potential use cases:

- Someone requests that their names and email addresses be removed from a public
  repo's history under GDPR Right to be Forgotten (although, based on [1], it's
  not clear if projects could be forced to do honour RTBF or not)
- Someone requests that their legal name change be reflected in a public repo

I am interested in hearing your thoughts on this basic idea:

- On committing/tagging/creating a note, the identity of the author is not saved
  in the commit etc. object itself but in a separate file e.g. `.git/people`:
  `d0efaf97-e18a-4197-b2c0-61c05efec75e <-> Yawar Amin <yawar.amin@gmail.com>`
- Instead of the real identity of the author, a pointer to the `people` file
  entry is stored e.g. `Author: d0efaf97-e18a-4197-b2c0-61c05efec75e`
- If an entry for the person already exists in the `people` file, it is reused
- When syncing with a remote repo, new entries in the `people` file are synced
  along with other objects (in an append-only manner, not editing existing
  entries)
- Git uses the `people` file to cross-reference and fill in authorship
  info when it renders commit etc. objects like in `git log`, `git show` etc.
- If git can't find the authorship info in the `people` file it renders some
  appropriate default e.g. `(Unknown)`

Project owners (with write access to the hosted repo) are able to edit and push
changes to the `people` file. In this way they can fulfill change requests like
the ones I mentioned above.

Regards,

Yawar

[1] https://www.dataprotection.ie/en/individuals/know-your-rights/right-erasure-articles-17-19-gdpr
