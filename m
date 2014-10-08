From: Tanay Abhra <tanayabh@gmail.com>
Subject: Re: [bug] [UX] `stash save --untracked` produces a stash that *looks*
 empty
Date: Wed, 08 Oct 2014 14:50:14 +0530
Message-ID: <543501CE.5040705@gmail.com>
References: <CACsY31pSeijqGC4Rw=q+qAGHJQ+bNibindVReYoZZACvYL7O+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 08 11:20:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XbnPz-0004pb-VK
	for gcvg-git-2@plane.gmane.org; Wed, 08 Oct 2014 11:20:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754796AbaJHJUU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Oct 2014 05:20:20 -0400
Received: from mail-pd0-f172.google.com ([209.85.192.172]:61658 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754434AbaJHJUS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Oct 2014 05:20:18 -0400
Received: by mail-pd0-f172.google.com with SMTP id ft15so6602700pdb.31
        for <git@vger.kernel.org>; Wed, 08 Oct 2014 02:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=7yuOZAX9jhKCVW9jGvEco7c0gakWckInZu7gUlS/lEU=;
        b=ywYGv2FWylh5oWNxVv9NiBueuep23ealmT2/z5Lj9Or40Sq48yeipC/fE+jk7ahTWX
         UAPBHIA+mm8utc3ODrbyvNlsydjqcSWMzhC0QWRQp7Qh4wPjxHeWoNaDUSH6nHwgY6jJ
         iC0m/FhclNZf4xW9si/FF5F0MbFkZPgfYJN5fHA6hRQjjEenrU6AwhLtWCiEtkEZhSKI
         jnCtkqKJLA58gl/5mQ/T4L2wzAa/SXKQ3lVyIOGNJVQOauXIxT6Uj9yeFxXu5CaeFUJf
         I1ilWZYMjlUmCUhYBHELURv861PuAzZNCcKNcVd2teS9Qm7pcgke0shVOTR7TtR+46FQ
         ypDg==
X-Received: by 10.70.34.197 with SMTP id b5mr9240429pdj.83.1412760018145;
        Wed, 08 Oct 2014 02:20:18 -0700 (PDT)
Received: from [127.0.0.1] ([223.225.25.45])
        by mx.google.com with ESMTPSA id uu17sm18377768pab.43.2014.10.08.02.20.16
        for <git@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 08 Oct 2014 02:20:17 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <CACsY31pSeijqGC4Rw=q+qAGHJQ+bNibindVReYoZZACvYL7O+A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/5/2014 10:58 PM, Alberto Scotto wrote:
> Hi all,
> 
> I've just found that:
> - given you have an empty staging area
> - and you have only untracked files in your working dir
> - when you do `git stash --untracked`
> - then `git stash show` gives you an empty output => stash looks empty
> 
> My first thought was "oh god, my files are lost!"
> Second thought: "Jeez I found a bug in git! cool!"
> Then I found that actually `git stash apply` restores the apparently lost
> files
> So I think it's a UX issue.
> It cost me a few lost files already, as I thought "an empty stash? uhm..
> can't remember what/when I stashed.. whatever.. let's just delete it and
> clean up a little bit this mess of stashes".
> 
> 
> Here are the reproducible steps:
> 
>    1. create new fresh git repo in $REPO_DIR
>    2. create a couple of files/dirs and commit
>    3. edit src/MyClass.java and commit
>    4. create dir src/new-dir with one file inside
>    5. edit file.txt and stage it
>    6. stash => stashes staged changes; only untracked files are left
>    7. stash -u => stashes untracked changes => working dir is clean
>    8. stash list
>    9. git stash show -p => empty output
>    10. git stash apply (restore stashed untracked files)

Hi,

I think problem lies with  show_stash() which just shows the
diff between working tree and the base tree, it ignores the
untracked files. A quick and dirty fix can be to just show
the diff between the untracked files and a NULL commit.
Here's the patch, it works all right but can be implemented
much better. I will try to find a better approach tomorrow.

diff --git a/git-stash.sh b/git-stash.sh
index d4cf818..7088584 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -304,6 +304,8 @@ show_stash () {
        assert_stash_like "$@"

        git diff ${FLAGS:---stat} $b_commit $w_commit
+       empty_tree=$(git hash-object -t tree /dev/null)
+       git diff ${FLAGS:---stat} ${empty_tree} $u_commit
 }

 #

Cheers,
Tanay
