Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AEEDF202F2
	for <e@80x24.org>; Tue, 21 Nov 2017 00:02:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751735AbdKUAC3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Nov 2017 19:02:29 -0500
Received: from mail-io0-f181.google.com ([209.85.223.181]:36649 "EHLO
        mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751198AbdKUAC2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Nov 2017 19:02:28 -0500
Received: by mail-io0-f181.google.com with SMTP id 79so10007763ioi.3
        for <git@vger.kernel.org>; Mon, 20 Nov 2017 16:02:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=khanacademy.org; s=google;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=BrtxbjprQBdGnOhnZNBQrDVFNy72s3ekRWtBgWCxmG4=;
        b=CR2OgVyPCIKoxnOM3OHkoQO4M+oCiTPxnuWk8OW0Fu+J3/kqPGk62RmQUhgGica51P
         GN8R8ifeoUtlgfINs3aRpvnhMT60gi29W6tbT0Yqq7VlmoPzJUDfDrHo2i7TETZfKKYW
         Zj/0KzuDS6NX8vebtYmwuSjT0kWGqjCAL8gZk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=BrtxbjprQBdGnOhnZNBQrDVFNy72s3ekRWtBgWCxmG4=;
        b=JSL2JE/w1qZLb2USn5snMay1kWlyUeDybxw4lw4qPd+SUommHOhnmaXhIi0kGZSpAh
         Lj0wQpQunZmiKX4f4N1UplG37VRvt4rr91YpSWUnD2ZMERm4ysfWfzAwIQIMnSNTlCWL
         y+OWLGNJA2RB9uGoCejEdcmL1gxuxR7LEc8EvmoCl9DbBv550UJq6pNs59BgUdQ7Vef2
         muQK2TRj0YR++jj0fkhZ3ouWka0fShcR93RbT+OnX7DJOp+5eV2j6sLzwYJSYCl3KD00
         B8DZTtQudt37i/4zo5+KFbfMbqxU+/ft7+CaKGXZUHgflaIZc6fI5oVARQSd+I5XAufa
         MHRw==
X-Gm-Message-State: AJaThX6/MnPtpcHEqUYtHE+qd7ydAJfyYFgEQ8y3XxWaB3xGXnTt11IY
        +3DVIAahzv4sIMGubwW74L0KSey5nSqZH8XnIFUSU49q
X-Google-Smtp-Source: AGs4zMapalKShkjPrsm60oMdHJaBqH1mGvX8KOn6t/62biiZabsT7G8K83OOll+Fi5qsFgZeyef0dabt6gOFzmKZW2U=
X-Received: by 10.107.201.16 with SMTP id z16mr127728iof.62.1511222546320;
 Mon, 20 Nov 2017 16:02:26 -0800 (PST)
MIME-Version: 1.0
Received: by 10.2.85.201 with HTTP; Mon, 20 Nov 2017 16:02:25 -0800 (PST)
Reply-To: csilvers@khanacademy.org
From:   Craig Silverstein <csilvers@khanacademy.org>
Date:   Mon, 20 Nov 2017 16:02:25 -0800
Message-ID: <CAGXKyzEbDxBkHeeiZAreGJDmoGR2quPi26R_COWnno_3-EcnmA@mail.gmail.com>
Subject: Bad interaction between git clean, gitignore, and deleted submodules
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We have the following situation:
1) A .gitignore file that contains '*.pyc'
2) A repo with a submodule named jinja2

In normal use, clients of our repo have it checked out and run things
in it, creating files like jinja2/run.pyc.

I deleted the jinja2 submodule (by running `git rm jinja2` and
pushing).  Clients did a `git pull; git submodule update` and saw that
the jinja2 directory was still around, albeit untracked. So they ran
`git clean -ffd`.

The problem is that git clean refuses to delete the directory due to
the (ignored and thus uncleanable) file jinja2/run.pyc.  And when it
refuses to delete the directory, it also leaves around jinja2/.git.

Later, someone ran `git add .` and jinja2/.git got added back in as an
"orphaned submodule" (I forget the exact terminology).  I know there's
a very loud warning when this happens but somehow they didn't see it,
and it caused all sorts of trouble when they pushed their change.

My question: is it possible for a client to *really* get rid of the
jinja2 submodule?  We can't run `git clean -ffdx` because there are
other .gitignore'd files we want to keep around.

The behavior I'd like to see is for `git clean -ffd` to delete .git
files if they don't correspond to a currently registered submodule.
Then `git clean -ffd` would delete jinja2/.git even though it leaves
around jinja2/run.pyc.  But I don't know if that would break anything
else.

Or maybe we should just add `.git` to our `.gitignore`, so people who
run `git add .` can't create these orphaned submodules...

craig
