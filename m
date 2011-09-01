From: Tzu-Jung Lee <roylee17@gmail.com>
Subject: Re: git-checkout silently throws away the dirty status of index
 without a warning?
Date: Fri, 2 Sep 2011 01:50:53 +0800
Message-ID: <CAEvN+1hH+9XUcuqrT8DaRYu+BW10HJrVk=H96M+ZsdrMy4d8ug@mail.gmail.com>
References: <CAEvN+1h+mY+f3dzK7LFOwkqokOZSS-LosCzBqtYGbyjz=Dg7Zw@mail.gmail.com>
	<20110901165638.GE15018@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Sep 01 19:51:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QzBPp-0007Sy-UC
	for gcvg-git-2@lo.gmane.org; Thu, 01 Sep 2011 19:51:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756614Ab1IARu4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 1 Sep 2011 13:50:56 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:33248 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755592Ab1IARuz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Sep 2011 13:50:55 -0400
Received: by bke11 with SMTP id 11so1954663bke.19
        for <git@vger.kernel.org>; Thu, 01 Sep 2011 10:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=ZJpSTSNzXEF3dMiDHyzrzywJVMfzk2jQdyV8kNatFzA=;
        b=sHUyIDzStEBP+/tkuNWnEDEj79jT/CG+jVnvrQVjYdfAvKCwYcOsL6doqL3IOjlLEW
         sew6M73ewANjVmnxZ+36o8a1SSBiomX0Mv+Esy6lI4/etcdbXa7gpei5QJgvQoqNvc13
         cM7vEMrMq+ZH4B1n4BM7fV7tFKhAK3inGuNZ4=
Received: by 10.204.6.211 with SMTP id a19mr48918bka.388.1314899454023; Thu,
 01 Sep 2011 10:50:54 -0700 (PDT)
Received: by 10.204.152.81 with HTTP; Thu, 1 Sep 2011 10:50:53 -0700 (PDT)
In-Reply-To: <20110901165638.GE15018@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180556>

On Fri, Sep 2, 2011 at 12:56 AM, Jeff King <peff@peff.net> wrote:
> On Thu, Sep 01, 2011 at 11:47:59PM +0800, Tzu-Jung Lee wrote:
>
>> Correct me if I'm wrong:
>>
>> =A0 =A0 git-checkout saves the changes to index and working-tree, an=
d
>> tries to apply them to the destined commit.
>> =A0 =A0 If the changes are applicable, then git-checkout the destine=
d
>> commit and apply the changes.
>> =A0 =A0 Otherwise, git-checkout fails with warnings and leaves the c=
urrent
>> status untouched.
>
> Not exactly. "git checkout <branch>" will switch your HEAD to <branch=
>,
> and then try to make your index and working tree match the contents o=
f
> <branch>, with two exceptions:
>
> =A01. If you have local changes in a file, but the contents of the fi=
le
> =A0 =A0 in <branch> do not differ from what's in the current HEAD, th=
en the
> =A0 =A0 file will be left alone (i.e., your local changes will be
> =A0 =A0 preserved).
>
> =A02. If you have local changes in a file, and the contents of the fi=
le
> =A0 =A0 in <branch> differ both from what's in your working tree and =
from
> =A0 =A0 what's in your current HEAD, git will print an error and refu=
se to
> =A0 =A0 overwrite your changes (though you can ask it to merge them w=
ith
> =A0 =A0 "git checkout -m").
>
> So it is not about "do these changes apply", but rather that we will
> give up any time file-level merging is required (unless "-m" is
> specified).
>

Ah!!! I think it was the "file-level merging" that surprised me so much=
=2E
I used to think it's an atomic "commit-level merging" -- cleanly apply
all the changes or touch nothing at all.
Having using git for years, I never notice this difference and neither
did it cause any trouble to me.
Until the corner case came to me today...

Thanks for the quick and precise explanation.

> The other form, "git checkout <branch> [--] <file>", is not about
> switching branches at all, but about putting content from <branch> in=
to
> the current index and working tree, overwriting what's there.
>
>> If the above correct. Please help me clarify if the following corner
>> case an intended or unexpected behavior.
>> [...]
>> =A0 =A0 $ git checkout -b br1
>> =A0 =A0 $ git reset HEAD^
>> =A0 =A0 Unstaged changes after reset:
>> =A0 =A0 M =A0 =A0 =A0 aaa.txt
>> =A0 =A0 M =A0 =A0 =A0 bbb.txt
>
> So you have changes in two commits...
>
>> =A0 =A0 $ git checkout HEAD aaa.txt
>
> And here you explicitly overwrite the changes in aaa.txt.
>
>> =A0 =A0 $ git status --short
>> =A0 =A0 M bbb.txt
>
> ...leaving only the changes in bbb.txt.
>
>> =A0 =A0 $ git add bbb.txt
>> =A0 =A0 $ git status
>>
>> =A0 =A0 # On branch br1
>> =A0 =A0 # Changes to be committed:
>> =A0 =A0 # =A0 (use "git reset HEAD <file>..." to unstage)
>> =A0 =A0 #
>> =A0 =A0 # =A0 =A0 =A0 modified: =A0 bbb.txt
>> =A0 =A0 #
>
> OK, now it's staged.
>
>> =A0 =A0 $ git checkout master
>> =A0 =A0 Switched to branch 'master'
>>
>> git silently switch to master without warning against the index are
>> "RESTORE/RESET" to clean.
>
> Yes, because the changes in your index were identical to what was in =
the
> destination branch. So we didn't drop any changes; they're still in t=
he
> index and in the working tree. It's simply that when compared to your
> new HEAD, they are uninteresting.
>
>> =A0 =A0 $ git checkout br1
>> =A0 =A0 $ git status
>> =A0 =A0 # On branch br1
>> =A0 =A0 nothing to commit (working directory clean)
>
> And now when we switch to br1, you have no changes against master in
> your working tree or index, so there is no dirty state to block
> switching branches.
>
> I think git is working as intended here. =A0I agree it is a somewhat
> surprising corner case, but only because your changes happened to
> exactly match the difference between the two branches you are switchi=
ng
> between. But it makes sense when you think about what "dirty state"
> means: it is differences between HEAD and your index and working tree=
=2E
> So we usually think of creating or removing dirty state by changing t=
he
> working tree. But you could equally well do it by changing the HEAD
> without changing the working tree, which is what you did here.
>
> -Peff
>
