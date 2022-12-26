Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD105C3DA79
	for <git@archiver.kernel.org>; Mon, 26 Dec 2022 17:21:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbiLZRVm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Dec 2022 12:21:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiLZRVk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Dec 2022 12:21:40 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93B93DB6
        for <git@vger.kernel.org>; Mon, 26 Dec 2022 09:21:38 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id d123so5880704iof.6
        for <git@vger.kernel.org>; Mon, 26 Dec 2022 09:21:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zjSTqEFcwyx2boblX7zKMSkf5bwNbsJM0tC4BINKKAc=;
        b=dF8WEwlOfqvBbcMdEUGnqB7p4dbyDku7q1mvqDIDRitrOO3hsnqq5UddHnG+MlmtvB
         GWw5JQOzg2qw3b6QLSK99C0+kZUk7OzPqGprME4sjwTDFWMmCRr7r5xAUOZFcmlRvQed
         7Dv1sZ/2whZRCsRV83HJjCXhvQ2FMSBsF1Q8DBSZZnNku2knTsUKO0W6251aqyJA+L8P
         QpFgfZ3tSZf9IHJvvOgQwhHD+Et9DeaLDSGVeAY/ac3N2CQdD/P2bMJ6qywo2bE8M2sN
         IPkZbCcbQ49g+5CvWYeVR+zSFZN5iHDpCq6KylNY34a+mbgdgcmHdw89krot8Ha3nbBP
         O6Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zjSTqEFcwyx2boblX7zKMSkf5bwNbsJM0tC4BINKKAc=;
        b=n7UNjvDA9ZdX3rR2wkyYmkJLvGqc9A68PdI1qLbEhKxeB2HkLa2UEPkr/kk8ZNxcsH
         VKmdzdb8iLbLJOL/wtaz4FBPMn+wXHv03whni2e0K3sTCY28WRHSfQhnPvcHbly4ZR1Z
         KHnL1N68uQtjrxNmBm7Y6PNZBaTGHEjqKY247toccPr0U4orvD1+wWNJ1D1QCCTVBdsi
         9g32yVFDvY38I+axVqhA57gsVN+hZpOTyop0JTIQ1yL8ukJ6nI/Ut2XJ0fp4tcG+uG1r
         JXwzHde2iC0dv3MCD530fOtbd5FrmSNx1CoiSk+23Wp/f1uWQsQOWw+rw+yuVz4Byud5
         zJPw==
X-Gm-Message-State: AFqh2kqYaW4P7kj/uYBMSE/QrxFfBbzBWx18DZJgJk1p6ZV3L/4ppow8
        cvIndHdx1peG9YrylyRq0PfBPZJCaCz7u6aw2qlEw8Z60UwmM5E=
X-Google-Smtp-Source: AMrXdXvNXQoc46UQdKqZexpHJj9CnOWTG7XQGlf/Nh7g7jDU+SHAJobaqqUSghowlXE/j5hE/5uEWiPtzJkSmB0+NFQ=
X-Received: by 2002:a02:b908:0:b0:38a:7675:fd26 with SMTP id
 v8-20020a02b908000000b0038a7675fd26mr1632304jan.300.1672075297561; Mon, 26
 Dec 2022 09:21:37 -0800 (PST)
MIME-Version: 1.0
From:   Tim Hockin <thockin@google.com>
Date:   Mon, 26 Dec 2022 09:21:26 -0800
Message-ID: <CAO_RewZeUBVvqT+UgXL5V5EeTOt14zZ-5vJYA4YvNr-jNyupXg@mail.gmail.com>
Subject: git fetch --dry-run changes the local repo and transfers data
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm trying to test if a remote repo has a given SHA. `ls-remote` does
not work for this unless it is a tag or a HEAD (which is not
guaranteed for this case).

`git fetch --dry-run $remote $rev` SEEMS to fit the bill, except it
changes local state. For example:

```
$ git cat-file -t f80f1b23b4cab2a295a091c623bb4746d188bd4a
fatal: git cat-file: could not get object info

$ git rev-parse FETCH_HEAD
42d21cf12aab73ac8bc6245cc74ac9850bdf6989

$ git fetch --dry-run file:///tmp/e2e.2527526915/repo
f80f1b23b4cab2a295a091c623bb4746d188bd4a
remote: Enumerating objects: 20, done.
remote: Counting objects: 100% (20/20), done.
remote: Compressing objects: 100% (9/9), done.
remote: Total 18 (delta 6), reused 0 (delta 0), pack-reused 0
Unpacking objects: 100% (18/18), 415.91 KiB | 84.00 KiB/s, done.
From file:///tmp/e2e.2527526915/repo
 * branch            f80f1b23b4cab2a295a091c623bb4746d188bd4a -> FETCH_HEAD

$ git cat-file -t f80f1b23b4cab2a295a091c623bb4746d188bd4a
commit

$ git rev-parse FETCH_HEAD
42d21cf12aab73ac8bc6245cc74ac9850bdf6989
```

FETCH_HEAD was not updated (good) but the rev in question is now
present locally (bad), further tested by making a very large commit
and watching the fetch be very slow.  Also the same on non file://
repo (I tried https)

Am I using --dry-run wrong (or misunderstanding its purpose)?

Tim
