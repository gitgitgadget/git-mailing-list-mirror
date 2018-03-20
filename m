Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2BBCF1F404
	for <e@80x24.org>; Tue, 20 Mar 2018 01:49:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751889AbeCTBtb (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Mar 2018 21:49:31 -0400
Received: from mail-ot0-f172.google.com ([74.125.82.172]:44537 "EHLO
        mail-ot0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751718AbeCTBta (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Mar 2018 21:49:30 -0400
Received: by mail-ot0-f172.google.com with SMTP id 79-v6so40349oth.11
        for <git@vger.kernel.org>; Mon, 19 Mar 2018 18:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dakotahawkins.com; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=Q7+UcjKLyIYwc18y1p9/C/w7ePJv+01jD0GjVMK4R0o=;
        b=IGiFHMPS6vWWalARSOWFRUOkrhyhGCya1EIkL2D1AMyFM5AkJNBz9KINZuJeJ/WUs3
         Bxxfj1AToNbh/eyJeyZLhdEVNFI2WNzEd0U7y8HCu6UHAnuNFNp2O9hKy9g2rUPEeA2u
         u2kpVtbl/7PUFiKJXH9VFqsJRc9lo1bvIG4Xg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Q7+UcjKLyIYwc18y1p9/C/w7ePJv+01jD0GjVMK4R0o=;
        b=SlfG6tSbekcWRD+t2QEBASd3X/SU4YzW7QbuZwVEJLHPTYHx69jREdr09Ewjn2RyUu
         w0tEHW8UJVoCIDeHnD2lk4wa1QCzfiK2xAKkz8lcPvTVGZinlv8AHCn2K8yGyI6Tv9g+
         7oSFHiQlmp9O/LhQ7s7dLjK9jtj4N4t65x/isaUcRkqb8EcZCvc/3vmbzJokklDQxfD5
         C8dJsZZCBym73UwAesXUayx3D/HScb9NqyecC/NG8VSK+YtWF2rdES/pzQiVcaNUammG
         O+iwFjpkTRSisjL80Zq6Djx8XFh0FjMRyG4OTXZ3ctymo053rGoxq0UM1ML55XiRTI+w
         +aQQ==
X-Gm-Message-State: AElRT7Hx8YZJnyLuskXu1DfOlpJRjKp1VNxmOxoBHNdC1rQDykFQqcGu
        W324SJUc/5SoSsSbkw3gFl8hf8KqY4zSw2xlowWgNGzSjy4=
X-Google-Smtp-Source: AG47ELuylhW3LP9tuv4z2DKs2QN616BftkdUmYpWraQWPzmxmhOaxEa5nEjDhVgzU66mUKjBqJBXI3lawv7XyYyDPA0=
X-Received: by 2002:a9d:213c:: with SMTP id i57-v6mr7428465otb.85.1521510569179;
 Mon, 19 Mar 2018 18:49:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:4a69:0:0:0:0:0 with HTTP; Mon, 19 Mar 2018 18:49:28
 -0700 (PDT)
From:   Dakota Hawkins <dakota@dakotahawkins.com>
Date:   Mon, 19 Mar 2018 21:49:28 -0400
Message-ID: <CAHnyXxRX4+sMJCNG6f9xtsDO6bdqRS-U6TAYO47OKQjH8bGzbg@mail.gmail.com>
Subject: .gitattributes override behavior (possible bug, or documentation bug)
To:     Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

According to the gitattributes docs:

"When more than one pattern matches the path, a later line overrides
an earlier line. This overriding is done per attribute."

I had a need to do this recently, and while the attributes are git-lfs
specific, I think the issue may be generic.

Summary: Trying to apply attributes to file extensions everywhere
except in one directory.

.gitattributes:

    *.[Pp][Nn][Gg] filter=lfs diff=lfs merge=lfs -text
    /.readme-docs/ -filter=lfs -diff=lfs -merge=lfs

Make some data:

    echo "asldkjfa;sldkjf;alsdjf" > ./.readme-docs/test.png
    git add -A

Result:

    "git check-attr -a --cached -- ./readme-docs/test.png" still shows
"filter=lfs diff=lfs merge=lfs" attributes.

Full details: https://github.com/git-lfs/git-lfs/issues/2120#issuecomment-374432354

Is this me misunderstanding something in the documentation? I would
expect "./.readme-docs/" to match "./.readme-docs/test.png" and
override the earlier "*.[Pp][Nn][Gg]" attributes.

I have found the following overrides to work in lieu of the directory match:

    /.readme-docs/* -filter=lfs -diff=lfs -merge=lfs
    /.readme-docs/**/* -filter=lfs -diff=lfs -merge=lfs

...but I don't see a justification in the documentation for this
working and the original directory filter not working.

Thanks for any clarification or help you can provide,

- Dakota
