Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6871A1F991
	for <e@80x24.org>; Mon, 31 Jul 2017 17:01:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751655AbdGaRBu (ORCPT <rfc822;e@80x24.org>);
        Mon, 31 Jul 2017 13:01:50 -0400
Received: from mail-pg0-f51.google.com ([74.125.83.51]:32860 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751243AbdGaRBt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jul 2017 13:01:49 -0400
Received: by mail-pg0-f51.google.com with SMTP id c14so48139160pgn.0
        for <git@vger.kernel.org>; Mon, 31 Jul 2017 10:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:from:date:message-id:subject:to;
        bh=5MhUlaVXsD24ygcTO+10x0OpNzGGnXAfijYLWdY7JjU=;
        b=lgwhmu53JjA2xO/usUhJcT4mwuCtwwkoIevHNW7gyKNGhzWPhlDOlZllEXoVwCZ1ne
         /m49IFwy2NKl8/w1JQ+ybCWiZyzJNiDgXqtpX0AeJw5O9Q4yFj18p6RXIzq/ut2CS7W0
         N2SHJ4CCxy4A+Cn0P09XHwXWlSopxtirVdF8ONQY4V7fLTqFdpaoNbKHA515br5uGG8i
         tVn4me9HRKYbgT5iNzBDQSTm4WOqbK3LdQ56Kdj+gu7a3/o9OaH8SeR9yUuc1GSlpJ5r
         me/PGizEf+mghz702C/wuBKktBIkjlaJkKYxBNus3gaRZcwBv+17aUk90zQu8u5kHwUm
         dRQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=5MhUlaVXsD24ygcTO+10x0OpNzGGnXAfijYLWdY7JjU=;
        b=X1TbDWqxgyYSToZdW2Gey3qgZOqmT39k7pHW+nuxXo+I7+VgXJnEB+/HB0NbLLa2dC
         saoAG47amnl1wRmSgysR8OHsnIqWDhYaTuIHjXlqz0X02YXcOjyxtNageM3wEbXqHjHs
         vYWq9ZAMFwckUP2f+QSnMxIYJAUrTCdsS3KQDfAJQvuA0hML0rUSUCrUTAQTBhLXKd+Q
         6DYsYdUXX8olawYZ2yVXLX18+kDXgptw0cXW0uFCHTxlc43ve17h19gECTTJQ4VxqcjA
         G1UzePVLR5qNlQZW2ySyXLuzX0+gpXINgBUaOPay6DkIrwkuWt1wPlG733Q/9XixNIox
         nK1Q==
X-Gm-Message-State: AIVw111Fts3UrwQeg8aBFMZEUJVxva3qFFb6AzCmbZSqJf/6gzIkhC1Z
        CeFnHivMtMtbjCaWxeGEAvUn4imqfGB0qJY=
X-Received: by 10.99.125.68 with SMTP id m4mr16026293pgn.259.1501520508323;
 Mon, 31 Jul 2017 10:01:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.132.193 with HTTP; Mon, 31 Jul 2017 10:01:47 -0700 (PDT)
From:   Anthony Sottile <asottile@umich.edu>
Date:   Mon, 31 Jul 2017 10:01:47 -0700
Message-ID: <CA+dzEB=aC9RMOMyTGuMiboZ4OrreKQQwoOL0PXckodSfS=Xoog@mail.gmail.com>
Subject: git checkout-index --all --force does not restore all files when
 `core.autocrlf` is set to `input`
To:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm not sure if this is a bug or the intended behaviour.

Here's my minimal reproduction (using python3 to write files so I can
control line endings)

```
#!/bin/bash
set -ex

rm -rf repo
git init repo
cd repo

git config --local core.autocrlf input

python3 -c 'open("foo", "wb").write(b"1\r\n2\r\n")'
git add foo
python3 -c 'open("foo", "wb").write(b"3\r\n4\r\n")'

git checkout-index --all --force
echo 'I expect this `git status` to have no modifications'
git status
```

Here's the output:

```
+ rm -rf repo
+ git init repo
Initialized empty Git repository in /tmp/foo/repo/.git/
+ cd repo
+ git config --local core.autocrlf input
+ python3 -c 'open("foo", "wb").write(b"1\r\n2\r\n")'
+ git add foo
warning: CRLF will be replaced by LF in foo.
The file will have its original line endings in your working directory.
+ python3 -c 'open("foo", "wb").write(b"3\r\n4\r\n")'
+ git checkout-index --all --force
+ echo 'I expect this `git status` to have no modifications'
I expect this `git status` to have no modifications
+ git status
On branch master

Initial commit

Changes to be committed:
  (use "git rm --cached <file>..." to unstage)

    new file:   foo

Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git checkout -- <file>..." to discard changes in working directory)

    modified:   foo

```

In this state, `git diff` and `git diff-index` disagree as well:

```
$ git diff-index --exit-code $(git write-tree) --patch; echo $?
1
$ git diff --exit-code; echo $?
0
```

I expect the plumbing command `checkout-index -af` to exactly restore
the disk state to the index such that `git status`, and `git
diff-index` both indicate there are no changes.

Interestingly, `git checkout -- .` does exactly this, but it is a
porcelain command and not suitable for scripting.  Alternatively, I'm
looking for an equivalent to `git checkout -- .` which uses only
plumbing commands.

Thanks,

Anthony
