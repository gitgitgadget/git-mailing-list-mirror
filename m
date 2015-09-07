From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Bug: git-upload-pack will return successfully even when it can't read
 all references
Date: Mon, 7 Sep 2015 14:11:15 +0200
Message-ID: <CACBZZX6ZYDEPrQorg=pVh734ua+x55SYoKKvSZ_h0GQaR=m+8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?RHV5IE5ndXnhu4Vu?= <pclouds@gmail.com>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Sep 07 14:11:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZYvGu-0007iK-9W
	for gcvg-git-2@plane.gmane.org; Mon, 07 Sep 2015 14:11:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751236AbbIGMLh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Sep 2015 08:11:37 -0400
Received: from mail-qg0-f49.google.com ([209.85.192.49]:35210 "EHLO
	mail-qg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750885AbbIGMLf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Sep 2015 08:11:35 -0400
Received: by qgt47 with SMTP id 47so60825146qgt.2
        for <git@vger.kernel.org>; Mon, 07 Sep 2015 05:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:cc:content-type;
        bh=GOLUeBIadJL0wGBqAIrgmlZUYHNvRhLsDxdVPBM4PK4=;
        b=YgsZcDWqtuIym+x2UwIWTbMkdV4rOFmoP4lfybvyhlFd+vGVQAvTszEfyhwRrcywlb
         WOSxpOkgNfBgFeDXw/f/vtsXCAVwuNHwxl0Sg/+XoLuBT1HrNMUAY18NRXh9fhlXjs5L
         D4D3nah6kiQNHG8JrU+kh7b16LTG1mErOB7MiIjrUAb72FwFavQYTh36f/ggdqdfr9Gd
         pv9lMHFntGF8KpfkH24doUDYCp9O2XYylkd+KhMU9sXIWfAYySJHBnoVe2lHya8C6mBE
         pDLlr+fm/Y2O1+opSJaI48+hzci7Rpu6usK86UAPKndWoGiKDsnbhl6dfE9z/A/39y05
         D9pQ==
X-Received: by 10.140.41.5 with SMTP id y5mr25513251qgy.61.1441627894793; Mon,
 07 Sep 2015 05:11:34 -0700 (PDT)
Received: by 10.55.24.209 with HTTP; Mon, 7 Sep 2015 05:11:15 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277449>

We have a process to back up our Git repositories at work, this
started alerting because it wasn't getting the same refs as the
remote.

This turned out to be a pretty trivial filesystem error.
refs/heads/master wasn't readable by the backup process, but some
other stuff in refs/heads and objects/* was.

But I think it's a bug that if we ssh to the remote end, and
git-upload-pack can't read certain refs in refs/heads/ that we don't
return an error.

This simple shellscript reproduces the issue:

    rm -rf /tmp/repo /tmp/repo-checkout
    git init /tmp/repo
    cd /tmp/repo
    touch foo
    git add foo
    git commit -m"foo"
    git checkout -b branch
    git checkout master
    git show-ref
    chmod 000 .git/refs/heads/master
    git show-ref
    cd /tmp
    git clone repo repo-checkout
    echo "Status code of clone: $?"
    cd repo-checkout
    git show-ref

After running this you get:

    $ (cd /tmp/repo-checkout && echo -n | strace
/tmp/avar/bin/git-upload-pack /tmp/repo 2>&1 | grep -e EACCES)
    open("refs/heads/master", O_RDONLY)     = -1 EACCES (Permission denied)
    open("refs/heads/master", O_RDONLY)     = -1 EACCES (Permission denied)
    open("refs/heads/master", O_RDONLY)     = -1 EACCES (Permission denied)

And "git fetch" will return 0.

We fail to call get refs/heads/master in head_ref_namespaced() called
by upload_pack(). I was going to see if I could patch it to return an
error, but that code seems very far removed from any error checking.

This isn't only an issue with git-upload-pack, e.g. show-ref itself
has the same issue:

    $ chmod 600 .git/refs/heads/master
    $ git show-ref; echo $?
    e7255c8fcabc6e15f57cd984f9f117870052c1a0 refs/heads/branch
    e7255c8fcabc6e15f57cd984f9f117870052c1a0 refs/heads/master
    0
    $ chmod 000 .git/refs/heads/master
    $ git show-ref; echo $?
    e7255c8fcabc6e15f57cd984f9f117870052c1a0 refs/heads/branch
    0

I wanted to check if this was a regression and got as far back as
v1.4.3 with the same behavior before the commands wouldn't work
anymore due to changes in the git config parsing code.
