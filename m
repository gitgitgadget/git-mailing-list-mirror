From: Jona Christopher Sahnwaldt <jc@sahnwaldt.de>
Subject: Re: "git checkout foo" is getting confused by folder named "foo"
Date: Wed, 25 Sep 2013 18:24:20 +0200
Message-ID: <CAEQewpoD2VRVtpEyG121TqAptoYfEXxt57CCthBX_EfN7LU0fQ@mail.gmail.com>
References: <CAEQewpqLcDJPo2gUWPk-xc3OitdTC4gH2tnyqaURiQ77BApNog@mail.gmail.com>
 <CAJDDKr64ou+gO7WJLFZ4zOSv+VCbkiW7nKuZa9=5_fiSqGUeyQ@mail.gmail.com>
 <CAEQewpqbf-sWSt0GS9eXQNi0yFz5-23NcO2JWKO4OgSFv3SXdA@mail.gmail.com> <vpqzjr1ujyn.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: David Aguilar <davvid@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Sep 25 18:24:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VOrtO-0003kc-Is
	for gcvg-git-2@plane.gmane.org; Wed, 25 Sep 2013 18:24:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750853Ab3IYQYm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Sep 2013 12:24:42 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:34520 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750712Ab3IYQYl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Sep 2013 12:24:41 -0400
Received: by mail-pa0-f52.google.com with SMTP id kl14so55731pab.25
        for <git@vger.kernel.org>; Wed, 25 Sep 2013 09:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=ZIUUukUtoxnT1rNo2loBwR2hFK5z5iPd4MQ0T921n0I=;
        b=t2vtbA+6l85mVl0hgCAzLNAtSOrmASmFaT6cfCOumLVHacgjsxzQ9pS/gUzHUzTDOh
         8OFz/bZBjY05thw6rzIvYQteBuABKfS7BHkwySphQ4GzaxS7QEATgSKiV0nlMsStg/Fv
         TMO2SBTM8g431fDtzM6KHE7XoaV7wc5aRN62JtIJizoK740Q+fCZgeMjdCXpEQacDUpc
         yIduJusLrMn3L6hukjBW5bkM0Wuca981I5CGAkCOy9LEQVmLcKMukjK0HUc3NnVbDlX/
         wSyGnMdHDsSbP76Zqn55Ywq2So6feip7bh3bhjj0OdKzVD7YxLWFHG238WVwV/fbErWL
         fDgA==
X-Received: by 10.68.34.105 with SMTP id y9mr34403890pbi.15.1380126281012;
 Wed, 25 Sep 2013 09:24:41 -0700 (PDT)
Received: by 10.66.229.70 with HTTP; Wed, 25 Sep 2013 09:24:20 -0700 (PDT)
In-Reply-To: <vpqzjr1ujyn.fsf@anie.imag.fr>
X-Google-Sender-Auth: eZnB7r4HPnqHONV6uJnf3UnpSPc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235359>

Hi everyone,

tl;dr: The short form "git checkout foo" is a mess. There's simply too
much "DWIM" magic going on. There are no comprehensible rules how it
decides if "foo" is a pathspec or a refspec.


On 25 September 2013 15:09, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> wrote:
> Jona Christopher Sahnwaldt <jc@sahnwaldt.de> writes:
>
>> On 25 September 2013 04:51, David Aguilar <davvid@gmail.com> wrote:
>>> On Tue, Sep 24, 2013 at 2:07 PM, Jona Christopher Sahnwaldt
>>> <jc@sahnwaldt.de> wrote:
>>>> Hi,
>>>>
>>>> maybe this has already been reported, but I didn't find it in the mail archive.
>>>>
>>>> If I understand correctly, after I clone a repo, I should be able to
>>>> switch to branch foo just by running
>>>>
>>>> git checkout foo
>>>>
>>>> This doesn't seem to work if a folder called "foo" exists in the root
>>>> of the repo.
>>>
>>> git checkout foo --
>>
>> Thanks for the suggestion, but it doesn't work for me. With both
>> 1.7.9.5 and 1.8.3.2, I get this:
>>
>> $ git checkout wiktionary --
>> fatal: invalid reference: wiktionary
>
> OK, what happens is that "git checkout wiktionary" is actually a
> shorthand for "git checkout -b wiktionary --track origin/wiktionary".

No, it isn't. More precisely: if branch "foo" is not yet in
.git/config, but there is a branch "origin/foo" and no file/folder
"foo" in the root of the project, then "git checkout foo" is short for
"git checkout -b foo -t origin/foo" (which in turn can be shortened to
"git checkout -t origin/foo", if I understand correctly).

Below are the rather arcane rules that I found in 1.7.9.5. They apply
if the branch "foo" is not yet configured in .git/config. If branch
"foo" is in .git/config  I guess "git checkout foo" will always check
out branch "foo", no matter if there's a file called "foo" somewhere.

I gave up testing them in 1.8.3.2, but I assume its behavior the same.

Let's consider several scenarios:

1. there is a branch "origin/foo", but also a *tracked* file/folder
"foo" in the *root* folder of the project:

a. when I'm in the root folder, "git checkout foo" silently resets the
working tree file/folder "foo" to its staged / HEAD version (I think)
and prints no response.

b. when I'm in a sub-folder that contains a tracked file/folder called
"foo", "git checkout foo" silently resets the working tree file/folder
"foo" to its staged / HEAD version and prints no response

c. when I'm in a sub-folder that cotains *no* *tracked* file/folder
called "foo", "git checkout foo" does nothing and prints "error:
pathspec 'foo' did not match any file(s) known to git."

2. there is a branch "origin/foo", but also an *untracked* file/folder
"foo" in the *root* folder of the project:

a. when I'm in the root folder, "git checkout foo" does nothing and
prints "error: pathspec 'foo' did not match any file(s) known to git."

b. when I'm in a sub-folder containing a *tracked* file/folder "foo",
"git checkout foo" silently resets the working tree file/folder "foo"
to its staged / HEAD version and prints no response

c. when I'm in a sub-folder that contains *no* *tracked* file/folder
called "foo", "git checkout foo" does nothing and prints "error:
pathspec 'foo' did not match any file(s) known to git."

3. there is a branch "origin/foo", but *no*  file/folder "foo" in the
*root* folder of the project:

a. if I'm in the root folder (no tracked or untracked file/folder
"foo"), "git checkout foo" switches to branch "foo" which tracks
"origin/foo":

b. if I'm in a sub-folder with a (tracked or untracked) file/folder
"foo", "git checkout foo" switches to branch "foo" which tracks
"origin/foo":

4. there is *no* branch "origin/foo"

a. when I'm in root or sub-folder that contains a *tracked*
file/folder called "foo", "git checkout foo" silently resets the
working tree file/folder "foo" to its staged / HEAD version and prints
no response

b. when I'm in root or sub-folder that cotains *no* *tracked*
file/folder called "foo", "git checkout foo" does nothing and prints
"error: pathspec 'foo' did not match any file(s) known to git."


All right, I guess there are more cases, but let's leave it at that...


>
> In other words, it does not only "checkout" the branch, but it creates a
> local branch with the right name, and checks it out.

No, in my case, it doesn't, because there is a folder called "wiktionary".

>
> The -- disables this shorthand. I'd consider this as a bug. I've just
> sent a patch to try to fix this.
>
>> When I try the full branch name:
>>
>> $ git checkout origin/wiktionary --
>> Note: checking out 'origin/wiktionary'.
>> You are in 'detached HEAD' state. You can [...]
>
> This actually checks out the right commit, but does not create a local
> branch. That's not a very desirable solution.
>
> In short, this should do the trick:
>
>   git checkout -b wiktionary --track origin/wiktionary

Yes, I know, as I said in my original mail. By the way, I later found
that I can shorten this to "git checkout -t origin/wiktionary".

JC

>
> --
> Matthieu Moy
> http://www-verimag.imag.fr/~moy/
