Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAF57C3DA7D
	for <git@archiver.kernel.org>; Tue,  3 Jan 2023 03:22:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231634AbjACDWl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Jan 2023 22:22:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbjACDWk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Jan 2023 22:22:40 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87449BC24
        for <git@vger.kernel.org>; Mon,  2 Jan 2023 19:22:38 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id c9so14181933qko.6
        for <git@vger.kernel.org>; Mon, 02 Jan 2023 19:22:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WFBw5+Myha/Dp8J6G1v5Zrsxx8UzuFzTCMMOShxSAiA=;
        b=TIAc+Pt+h84of/ycwp4n8aWbSDu4Cr2j94BgO7Vdw0nh25/ahwbp1GoJP3VznLmKEP
         0hj+T+Sk8cfHtkp3Uc5g65zP6rzjzw/i3pgT02dozncXkeKwm/GDrfBVX42wRjE/gPkJ
         tCPn9tG9FgXnl9bwaHks5kD+ZwoCoDCqA84SH53mM9+gKtQu30RLa0I6sXIZcH1lz/V2
         ci8+WoYH6YhSzvpqCialRcbmjFmnvmLHSAJsGPxoghWoc7em8XGW9RlE1+cd/q/h3QzO
         Y9pJruq1NdVyopg7wuUdjx+2nW9DO3JWjPWQwB5jNdHksO98DwDRsxPHN2bSAlaEqvTC
         syVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WFBw5+Myha/Dp8J6G1v5Zrsxx8UzuFzTCMMOShxSAiA=;
        b=pAz2qXEXActDN7KXr/3SekGJ7kQtQRMyAVCOqSjYLFxF7SDQqzLKxm+tAhqNu6S2Fy
         AwVdQwRsm+mlUlz6jo5ccr6kTMyxcw/FV4lkx/c6OP5C/VxuDjjoPAa6FBuLI2iTKrwA
         7dzrLZczD5+Vg8kQFVstMhjrpAsuCTqfJyRDp+hsmcxJwQj8iIdT2odVqtZfH5Bj+onj
         jj0+bSfn+hwEfJfWxyP0rS2vc41mkqitvq6yCopUrQkJtw+u4cfy0y4Zgb1443J7mahq
         U7m4lh3OAvgrnVToch0t7f6osVlE3GDSDv1NnAJ4I6w7k4AZDnEyvD95JUVMKdXOgtJw
         4qkg==
X-Gm-Message-State: AFqh2kpm6mwjWjpzy9FKeazGN9RsS/g8XXQ41lUJWzA1h1uEPkcI44vW
        ico4nMhl/nr2You37UAne4nYiakvoctYkOaaFo1+UEfZ5330pgjbcbc=
X-Google-Smtp-Source: AMrXdXvLZP7cVHeGPOiZmdyI+A5xpumWk7xiEIEUKV3SCxWI3cG7PElrvudYD9xOb6d28Y9cfMkz+XDKWyKVDB9A6zM=
X-Received: by 2002:ae9:ebd1:0:b0:6fe:c166:d030 with SMTP id
 b200-20020ae9ebd1000000b006fec166d030mr1834803qkg.712.1672716157385; Mon, 02
 Jan 2023 19:22:37 -0800 (PST)
MIME-Version: 1.0
From:   Andrew Hlynskyi <ahlincq@gmail.com>
Date:   Tue, 3 Jan 2023 05:22:01 +0200
Message-ID: <CAAYtLELp4v=id-UUdGT+BoCxLuTV05Z0fFMQmPfd3Mt-yXJ9Tw@mail.gmail.com>
Subject: [BUG] `git gc` or `git pack-refs` wipes all notes for `git notes` command
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Steps to reproduce:
1. Create some notes with the `git notes add` command.
2. Run `git notes` to list stored notes.
3. Run any of `git gc  --prune=now` or `git pack-refs --all` commands.
4. Run `git notes` again and see that there are no more seen notes.

The reason is that all commands like `git notes` or `git log --notes`
expect to find notes head as unpacked ref in .git/refs/notes/commits.
But the gc or the pack-refs command packs .git/refs/notes/commits ref
into .git/packed-refs file.

It's possible to restore the notes ref with a shell script like:
```
fix-notes-unpack-commits-ref(){
    local hash path
    grep refs/notes/commits .git/packed-refs |\
    while read hash path; do
        path=".git/$path"
        mkdir -p "$(dirname "$path")"
        echo -n "$hash" > "$path"
    done
}
```
Or, fortunately, from another backup place: .git/logs/refs/notes/commits.

The expected behavior is that `git notes` and `git log` should work
also with notes ref stored in the .git/packed-refs file and also
respect that the `git notes` command can store notes with a custom ref
by using the `--ref` option.

Yours sincerely,
Andrew
