From: Phil Hord <phil.hord@gmail.com>
Subject: Re: [Bug] git stash generates a different diff then other commands
 (diff, add, etc) resulting in merge conflicts!
Date: Thu, 8 Aug 2013 16:54:59 -0400
Message-ID: <CABURp0oATJ58POmgYLjSmy-y84LTjkP0PTh4=3M-vc04_AoMdg@mail.gmail.com>
References: <CAP+CFTZWzoAg=ni6t1aif-85y6W4-2JUT4wooapTvD0oGH+HRw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Luke San Antonio <lukesanantonio@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 08 22:55:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7XF1-0001t2-9r
	for gcvg-git-2@plane.gmane.org; Thu, 08 Aug 2013 22:55:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966555Ab3HHUzW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Aug 2013 16:55:22 -0400
Received: from mail-vb0-f49.google.com ([209.85.212.49]:60191 "EHLO
	mail-vb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966547Ab3HHUzU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Aug 2013 16:55:20 -0400
Received: by mail-vb0-f49.google.com with SMTP id w16so3545974vbb.22
        for <git@vger.kernel.org>; Thu, 08 Aug 2013 13:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=0D/Ccw02quaUG8FQrsUaS6KG2aGLlMQPcZkwioRFCyg=;
        b=CNr6szAvhVXm5vWnrUOP3+1IFl7qM//pb78NuvNR8USzK+YOC1J962osNcQt0gfEFl
         tkUqiQCgBb3b29oyerEAU4RR+XuzfQA2rmbugP8VLbpMGKL1ztKYaMgSHwvc2yOjm0wT
         mJxUGICGSPFL2OVZt3eL5M8FJ5ia2RJmIH7YApAKUH5fXaaLMLO9PbxTwQzrFX2hHaae
         15V8+hXOBCQ6LYWvBw/+jh7oY4k4QkkY0XCREwXKnOPWCLRD+S4A1x8VrSuVNDKMUU/w
         Y6KnnEYr3ZNqiWB64ghesF85I8ztNAKbaQlvuLmZOAKNfyDVM3LWsK3uM33zPeXZLvRY
         mO4A==
X-Received: by 10.220.82.9 with SMTP id z9mr5155218vck.0.1375995319555; Thu,
 08 Aug 2013 13:55:19 -0700 (PDT)
Received: by 10.58.220.72 with HTTP; Thu, 8 Aug 2013 13:54:59 -0700 (PDT)
In-Reply-To: <CAP+CFTZWzoAg=ni6t1aif-85y6W4-2JUT4wooapTvD0oGH+HRw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231929>

On Thu, Aug 8, 2013 at 3:07 AM, Luke San Antonio
<lukesanantonio@gmail.com> wrote:
>
> Hi, my name's Luke!
>
> Today, I had a problem merging a stash after immediately creating it.
> This is exactly what I did!
>
> git stash save --keep-index
> git stash pop
>
> And BAM! Merge conflict! This was especially weird because my file had
> this in it (taken directly from my code!)
>

Luke,

I think the issue is that your working directory receives your cached
file when you say 'git stash --keep-index'.  When you restore the
stash, your previous working directory now conflicts with your new
working directory, but neither is the same as HEAD.

Here's a test script to demonstrate the issue, I think.  Did I get
this right, Luke?

 # cd /tmp && rm -rf foo
 git init foo && cd foo
 echo "foo" > bar &&  git add bar && git commit -mfoo
 echo "bar" > bar &&  git add bar
 echo "baz" > bar
 echo "Before stash  bar: $(cat bar)"
 git stash --keep-index
 echo "After stash  bar: $(cat bar)"
 git stash apply


The output looks like this:

$  git init foo && cd foo
Initialized empty Git repository in /tmp/foo/.git/
$ git commit --allow-empty -mInitialCommit
[master (root-commit) b5ecc7e] InitialCommit
$ echo "Bar" > bar &&  git add bar && git commit -mBar
[master 16d708b] Bar
 1 file changed, 1 insertion(+)
 create mode 100644 bar
$ echo "bar" > bar &&  git add bar
$  echo "baz" > bar
$  echo "Before stash  bar: $(cat bar)"
Before stash  bar: baz
$  git stash --keep-index
Saved working directory and index state WIP on master: 16d708b Bar
HEAD is now at 16d708b Bar
$  echo "After stash  bar: $(cat bar)"
After stash  bar: bar
$  git stash apply
Auto-merging bar
CONFLICT (content): Merge conflict in bar
Recorded preimage for 'bar'
$ cat bar
<<<<<<< Updated upstream
bar
=======
baz
>>>>>>> Stashed changes



Phil
