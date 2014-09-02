From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 22/32] checkout: support checking out into a new working directory
Date: Tue, 2 Sep 2014 19:27:41 +0700
Message-ID: <CACsJy8CTLRpjmh+0K6ypLKUgi52gsFEqnNsha2yfOvRVCdhdMQ@mail.gmail.com>
References: <1409387642-24492-1-git-send-email-pclouds@gmail.com>
 <1409387642-24492-23-git-send-email-pclouds@gmail.com> <70985AC885404243A2B95F534083A0E9@PhilipOakley>
 <CACsJy8CpGhLN58GyJa_3-PDqNqYUCshPEGDr8-pKngad+-oAdg@mail.gmail.com>
 <CACsJy8ASW0xO3WzU7f+T4iDhjL=Y=C6K+Cvi-OWOnS16r=m+9Q@mail.gmail.com> <64D6AA311E524C27A8B6EDE7A63489D7@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Philip Oakley <philipoakley@iee.org>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Sep 02 14:28:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XOnC5-0006H5-Lv
	for gcvg-git-2@plane.gmane.org; Tue, 02 Sep 2014 14:28:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751295AbaIBM2N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Sep 2014 08:28:13 -0400
Received: from mail-ig0-f179.google.com ([209.85.213.179]:39887 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750954AbaIBM2M (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Sep 2014 08:28:12 -0400
Received: by mail-ig0-f179.google.com with SMTP id r2so7100178igi.12
        for <git@vger.kernel.org>; Tue, 02 Sep 2014 05:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=CbByICSCdQpm8olbtBLdp8PH3R8cyI2PxMPa9d1sas4=;
        b=C/3N42X556Ri7ZXBwPyoOVOhvgLwwqMrRb1pk6/OhlIlNPNGMCVLyCsIl4IBh7Ps6c
         t8dfgfBH2WnhNF040muiuqhDFNeXyJqV3+T6Bu7WjfgQWzwUF8aPnqg/aXOM8Rr+Ph4v
         WrJ3T2QsKsmOyltcLG+qCfkndoNpBfm2oj48wAyZi8cZRh8rm9W03gKn8A0X8ly/va7d
         pMLQEPiRbSd9G9lbRj5rKfy0n2HLEOamFjVe+EQsXvK169daow9Zs4eqP8labJh0MEhQ
         +le+YTS1pEF3DMr5Z/RNf1h5snw0GCcpjMsA6In4/VhIqG7s6oDd9IGk+rbxIXN/kkKU
         Rp2w==
X-Received: by 10.50.43.233 with SMTP id z9mr27628179igl.41.1409660891799;
 Tue, 02 Sep 2014 05:28:11 -0700 (PDT)
Received: by 10.107.3.152 with HTTP; Tue, 2 Sep 2014 05:27:41 -0700 (PDT)
In-Reply-To: <64D6AA311E524C27A8B6EDE7A63489D7@PhilipOakley>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256319>

After reading this "multiple checkout mode" in git-checkout.txt, I'm
tempted to rewrite it like this. I think the example makes it clearer
what I mean. If nobody has any comments, I'm going to send v2 with
this (and other comments collected so far)

MULTIPLE CHECKOUT MODE
----------------------
Normally a working directory is attached to repository. When "git
checkout --to" is used, a new working directory is attached to the
current repository. This new working directory is called "linked
checkout" as compared to the "main checkout" prepared by "git init" or
"git clone". A repository has one main checkout and zero or more
linked checkouts.

Each linked checkout has a private directory in $GIT_DIR/repos in the
main checkout, usually named after the base name of the new working
directory, optionally with a number added to make it unique. For
example, the command `git checkout --to ../test-next next` running
with $GIT_DIR=/path/main may create the directory
`$GIT_DIR/repos/test-next` (or `$GIT_DIR/repos/test-next1` if
`test-next` is already taken).

Within a linked checkout, $GIT_DIR is set to point to this private
directory (e.g. `/path/main/repos/test-next` in the example) and
$GIT_COMMON_DIR is set to point back to the main checkout's $GIT_DIR
(e.g. `/path/main`). Setting is done via a .git file located at the
top directory of the linked checkout.

Path resolution via `git rev-parse --git-path` would use either
$GIT_DIR or $GIT_COMMON_DIR depending on the path. For example, the
linked checkout's `$GIT_DIR/HEAD` resolve to
`/path/main/repos/test-next/HEAD` (not `/path/main/HEAD` which is the
main checkout's HEAD) while `$GIT_DIR/refs/heads/master` would use
$GIT_COMMON_DIR and resolve to `/path/main/refs/heads/master`,
which is shared across checkouts.

See linkgit:gitrepository-layout[5] for more information. The rule of
thumb is do not make any assumption about whether a path belongs to
$GIT_DIR or $GIT_COMMON_DIR when you need to directly access something
inside $GIT_DIR. Use `git rev-parse --git-path` to get the final path.
--
Duy
