From: Christian Halstrick <christian.halstrick@gmail.com>
Subject: is ORIG_HEAD allowed to point to a non-existing object?
Date: Tue, 10 May 2016 14:15:31 +0200
Message-ID: <CAENte7jNxM7J9bWUnrOkLQJZ=8JEtYzw9-uxVkq-CpvGyk9UUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 10 14:16:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b06a0-0007wx-44
	for gcvg-git-2@plane.gmane.org; Tue, 10 May 2016 14:16:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751730AbcEJMPy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2016 08:15:54 -0400
Received: from mail-wm0-f50.google.com ([74.125.82.50]:36089 "EHLO
	mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751692AbcEJMPw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2016 08:15:52 -0400
Received: by mail-wm0-f50.google.com with SMTP id n129so175888725wmn.1
        for <git@vger.kernel.org>; Tue, 10 May 2016 05:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to;
        bh=+JAMlJkT9Hv2q20CwUu13lPryEEmRRbkwu7yBvnMXRY=;
        b=pW91/dkfwr5Z6x6gkL+Bl3rP8Prfe0B5O17zRf2w9KJqn1xCj/flUICTVesAdOdim2
         ty74k2zqimzJjY+fA8HTFnNc/5EImYsJnQ1LPpSfHEqg1I7+9d+eLh9uyW1HqSrtQB1U
         5OScvChula1mjbUQNbToB/JgPxX4PmluM/Pwgt/4Rx3nR1UYie84iI4F4z05WorRgBcP
         CPtB9WeeTbbILSf8zYZEKA1DcLZgRIXnosrI9ygfvNXU24kL2AvUJ4BhCMMg2NBBX56I
         +7gtoorg9FyZu+8tjwTDd0K9Uu/P+clVNj27es88LP8CZ6SHXYfrNx9LFi8ufcTDPxB9
         F1Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=+JAMlJkT9Hv2q20CwUu13lPryEEmRRbkwu7yBvnMXRY=;
        b=HhqGEJvqtoLJuuJdFQqkBc1qXAZl9m+LU4o+M38blXNSjWze/pxLm6UiczWvV2us/c
         QAf18t6B0udE0coEJ/DVQCfWg5of8HjCKhtUI4xlHahtwy+xJcTsrHbgEoyrP1wO5UBM
         X+aSiiu++deaZQo6yhfco7+82eyw9+sqGmVgj1s9wIHSqL5wX1Sx6fSFSmz/TzWzoTFO
         JYn8atZhXgH1imik26fG3eSUgDkATB6ZHICuASXGIJavYeyUEqiNTJVVNVevldhusrsi
         qdsX54ywuZgg2bxBK9MOcCNUQvJnp83JhP+O37MG5MYsWOjvirS6wJ34e9e1Iu26qXRh
         y4lg==
X-Gm-Message-State: AOPr4FV545AW6iOxSOAHERVG1tKRz90pbaSf0AW5EehSBBcrSNssvDnfAPGWayDHa4tjiuIRqt1snpUhTIlIdQ==
X-Received: by 10.28.54.224 with SMTP id y93mr16922434wmh.82.1462882551295;
 Tue, 10 May 2016 05:15:51 -0700 (PDT)
Received: by 10.28.31.17 with HTTP; Tue, 10 May 2016 05:15:31 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294126>

If I do a "git-rebase -i ..." followed by "git reflog expire ..." and
"git gc ..." then I can end up with a repo which has a ref ORIG_HEAD
which points to a non-existing object.

- Is this intended?
- What's the reason to keep a ref which points to a non-existing object?
- Are there any other refs which are allowed to point to non-existing objects?

Here is how I reproduced the problem:

> git init
Initialized empty Git repository in /tmp/yy/.git/
> touch a
> git add a
> git commit -m addA
[master (root-commit) ff82f68] addA
 1 file changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 a
> echo 2 >a
> git commit -a -m modA
[master f9ae5a7] modA
 1 file changed, 1 insertion(+)
> echo 3 >a
> git commit -a -m 'fixup! modA'
[master 271012b] fixup! modA
 1 file changed, 1 insertion(+), 1 deletion(-)
> git rebase -i --autosquash HEAD~~
[detached HEAD 3eb17d4] modA
 1 file changed, 1 insertion(+)
Successfully rebased and updated refs/heads/master.
> git rev-parse --short ORIG_HEAD
271012b
> git reflog expire --expire=now --all
> git rev-parse 271012b
271012be467fcbd62a875b7187c0e9871f62ac0d
> git gc --prune=now
Counting objects: 6, done.
Delta compression using up to 2 threads.
Compressing objects: 100% (2/2), done.
Writing objects: 100% (6/6), done.
Total 6 (delta 1), reused 0 (delta 0)
> git rev-parse 271012b
271012b
fatal: ambiguous argument '271012b': unknown revision or path not in
the working tree.
Use '--' to separate paths from revisions, like this:
'git <command> [<revision>...] -- [<file>...]'
> git rev-parse --short ORIG_HEAD
271012b

Ciao
  Chris
