From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: can I use multiple worktree in same git repo ?
Date: Thu, 21 Jul 2011 10:20:13 +0700
Message-ID: <CACsJy8DswCJS8YfaG=e73g1ZDVRV1H3Z0St7zaAEuuwYxgxgBQ@mail.gmail.com>
References: <20110720182438.3c40cf1d@shiva.selfip.org> <CACsJy8CLRjLag65H6KQ1AUABLwiL09wNQw3VH8Y-JQnw7CqLUw@mail.gmail.com>
 <201107201611.p6KGBvna012304@dcnode-02.unlimitedmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: "J. Bakshi" <j.bakshi@unlimitedmail.org>
X-From: git-owner@vger.kernel.org Thu Jul 21 05:21:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QjjpO-0001t0-0M
	for gcvg-git-2@lo.gmane.org; Thu, 21 Jul 2011 05:21:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751834Ab1GUDUp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jul 2011 23:20:45 -0400
Received: from mail-fx0-f52.google.com ([209.85.161.52]:39252 "EHLO
	mail-fx0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751801Ab1GUDUo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jul 2011 23:20:44 -0400
Received: by fxd18 with SMTP id 18so2741076fxd.11
        for <git@vger.kernel.org>; Wed, 20 Jul 2011 20:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=lYH7kROGwDjrEchzC8RGvO4M5bA6Hgjljs1gEXAy6cM=;
        b=WPrgyseHL/RP8R988T6ZnLltgAO6zkEnxebzTG14X/fxUhyuW/iL8Jq9W1hINy5wFj
         yl79FRmUn+VOnZgkvGyKNrCEMqpzOWfcEy0EgjdFSpiKrrWp2oUZTtm7FvHcok8rNH6I
         rOZ4k63jDfRz/rKg594I26foXK42/AbdX9bro=
Received: by 10.204.32.129 with SMTP id c1mr2730018bkd.291.1311218443609; Wed,
 20 Jul 2011 20:20:43 -0700 (PDT)
Received: by 10.204.123.199 with HTTP; Wed, 20 Jul 2011 20:20:13 -0700 (PDT)
In-Reply-To: <201107201611.p6KGBvna012304@dcnode-02.unlimitedmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 20, 2011 at 11:12 PM, J. Bakshi <j.bakshi@unlimitedmail.org> wrote:
> Thanks for your response. I am afraid that I can't understand the approach clearly but I must say that I am hopeful to see a direction.
> Obviously there will be a central git repo which will have its worktree under htdocs at the same server.

No, the central repository does not need worktree attached (in other
words "bare repository"). You modify in a clone from it and push
to/pull from it.

> That's why the post-receive
> hook will update the website after each push. But the issue is mapping the structure at git which is different than the structure at
> filesystem. And a push should reflect to its correct folder only.
>
> [git]->[mysite]->dir1/trunk/src => physically map => htdocs/demo/dir1
> [git]->[mysite]->dir2/trunk/src => physically map => htdocs/demo/dir2
>
>
> Please tell me with little more clarification, how can I do this ?

OK, let's create a central repository

GIT_DIR=/somewhere/safe/repo.git git init --bare

Then clone it where development happens

git clone /somewhere/safe/repo.git ~/dev
cd ~/dev

Now we create "dir1" and "dir2" branches, correponding to what you
have in the original tree

git checkout -b dir1
# put contents of dir1/trunk/src here, commit
git checkout -b dir2 master
# put contents of dir2/trunk/src here, commit

Then we push everything back to central repo

git push origin +dir1:dir1 +dir2:dir2

Then we clone it to demo sites

cd /var/www
git clone /somewhere/safe/repo.git dir1
git checkout dir1

cd /var/www
git clone /somewhere/safe/repo.git dir2
git checkout dir2

Now you can add a post commit hook to /somewhere/safe/repo.git to move
to /var/www/dir[12] and do a "pull". When you push again from ~/dev,
/var/www/dir[12] should get updated. Is that what you want?
-- 
Duy
