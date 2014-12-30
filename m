From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: Bug report: checkout-index --temp path is not always relative to
 the current directory
Date: Tue, 30 Dec 2014 17:25:02 -0500
Message-ID: <CAPig+cRSfb=tQ4zUnzutZsj_R590juPU-jFCdJ6+E=x51tguRQ@mail.gmail.com>
References: <CAFAcib9tz+EDqWx=nohxEbH3FRbwUweabKHTyBF-dioh6G-KKg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Josh Bleecher Snyder <josharian@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 30 23:25:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y65Dz-0005oa-5d
	for gcvg-git-2@plane.gmane.org; Tue, 30 Dec 2014 23:25:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751871AbaL3WZF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Dec 2014 17:25:05 -0500
Received: from mail-yk0-f169.google.com ([209.85.160.169]:65415 "EHLO
	mail-yk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751749AbaL3WZE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Dec 2014 17:25:04 -0500
Received: by mail-yk0-f169.google.com with SMTP id 79so7458110ykr.14
        for <git@vger.kernel.org>; Tue, 30 Dec 2014 14:25:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=hRdU1z91lBjbsCFIER8O4IPpJA0QBCuhT+xMJLyCELA=;
        b=s0O+QC6FodNZf/qVfCUmsPGUuQ3p9PQc4fyAiMmb1rwuHrNyS5EKRD1poYKqfIsd4C
         3OwwfYffzw7tRkzdIb55ALPg/TETMT8edOPfMJsP5NzSWXhCJiklEtK1vAVVWPUXt+F7
         0SncHd9St9aYW5W8D5IfD2tFElQvexO6rcPwlMA8EVA9MRq/CmP916/15kLLXKhv9+OF
         8UdV+3/b31pA9cqey/BsXIr3CQMw3XSfIpeDSmThJC5wopNFbW7V+WXgl1HGrrC5I5Ls
         8OPfm9KaOjN1mId/w31ahfx4UIZa7VJEDHcbFHXzUVs5usb0JXObWrDEZuQ1EMwHvy4u
         ak3A==
X-Received: by 10.236.105.210 with SMTP id k58mr41714368yhg.52.1419978302778;
 Tue, 30 Dec 2014 14:25:02 -0800 (PST)
Received: by 10.170.73.7 with HTTP; Tue, 30 Dec 2014 14:25:02 -0800 (PST)
In-Reply-To: <CAFAcib9tz+EDqWx=nohxEbH3FRbwUweabKHTyBF-dioh6G-KKg@mail.gmail.com>
X-Google-Sender-Auth: ROEUbZC-lRzThfWSMzVS8Bh0pJs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261951>

On Tue, Dec 30, 2014 at 5:21 PM, Josh Bleecher Snyder
<josharian@gmail.com> wrote:
> In the section on using --temp, 'git help checkout-index' says:
>
> "The path field is always relative to the current directory and the
> temporary file names are always relative to the top level directory."
>
> However, this can be false when an absolute path to the file is provided.

See [1] for a fix.

[1]: http://thread.gmane.org/gmane.comp.version-control.git/261796

> Reproduction:
>
> ~$ git version
> git version 2.2.1
> ~$ mkdir demo
> ~$ cd demo
> ~/demo$ mkdir a
> ~/demo$ echo "a" > a/f
> ~/demo$ mkdir b
> ~/demo$ echo "b" > b/f
> ~/demo$ git init .
> Initialized empty Git repository in ~/demo/.git/
> ~/demo$ git add .
> ~/demo$ git commit -m "init"
> [master (root-commit) 2afa910] init
>  2 files changed, 2 insertions(+)
>  create mode 100644 a/f
>  create mode 100644 b/f
> ~/demo$ echo "b2" > b/f
> ~/demo$ cd a
> ~/demo/a$ git checkout-index --temp -- `git rev-parse --show-toplevel`/b/f
> .merge_file_xm8RTd f
> ~/demo/a$ cat ../.merge_file_xm8RTd
> b
>
> Note that if f in the checkout-index output is interpreted as relative
> to the current directory, it would refer to a/f, whereas in fact is it
> b/f.
>
> This led to https://github.com/golang/go/issues/9476.
>
> Thanks,
> Josh
