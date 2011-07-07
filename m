From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 12/14] revert: Introduce --reset to cleanup sequencer data
Date: Thu, 7 Jul 2011 08:33:54 +0530
Message-ID: <CALkWK0nfakukih6m=r86RA8xvNt2BxJaUUNw9XRJ4Z6n3e=sJg@mail.gmail.com>
References: <1309938868-2028-1-git-send-email-artagnon@gmail.com>
 <1309938868-2028-13-git-send-email-artagnon@gmail.com> <CALkWK0nhH=_3+Gj=O4Ov2zOGBoVquzD--+RW_QYYnb8YMAHniA@mail.gmail.com>
 <20110706192141.GA23516@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 07 05:04:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qeet4-00032Z-IF
	for gcvg-git-2@lo.gmane.org; Thu, 07 Jul 2011 05:04:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753568Ab1GGDEQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Jul 2011 23:04:16 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:36797 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752916Ab1GGDEP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Jul 2011 23:04:15 -0400
Received: by wwe5 with SMTP id 5so506029wwe.1
        for <git@vger.kernel.org>; Wed, 06 Jul 2011 20:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=TUY9esS8SmvMNYCprKJb75tBc6M8hpG9Aln1vowxrPw=;
        b=Lv8WyK7zXl5ID9POlgYBA7PuvMI2uQTRp+S1h1p+P5FyWceaJLrFb9odCSGqqr9fWu
         B/KSmH44a2VqwMXNWOpnZl40071PFqGbnj0Ndhho63LVCze4++Yhqg5kfvxQwuRmu5i6
         wtcTPqKRri28foQg+ML5Zl/6qRqLDZt5yz81c=
Received: by 10.216.187.65 with SMTP id x43mr218068wem.62.1310007854100; Wed,
 06 Jul 2011 20:04:14 -0700 (PDT)
Received: by 10.216.175.198 with HTTP; Wed, 6 Jul 2011 20:03:54 -0700 (PDT)
In-Reply-To: <20110706192141.GA23516@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176739>

Hi again,

Jonathan Nieder writes:
> Ramkumar Ramachandra wrote:
>
>>> --- a/t/t3507-cherry-pick-conflict.sh
>>> +++ b/t/t3507-cherry-pick-conflict.sh
> [...]
>> As you can see, there is no "reset --hard" in these
>
> In this one, there's "git checkout -f && git read-tree -u --reset HEA=
D
> && git clean -fdx", which is almost the same thing.

Ofcourse, but it's a combination of three commands -- are you
suggesting that I replace this sequence of commands with "git reset
--hard"?.

>>> --- a/t/t3505-cherry-pick-empty.sh
>>> +++ b/t/t3505-cherry-pick-empty.sh
>
> This one is not a typical script, I think --- if you knew the
> cherry-pick was going to be empty, why did you try it in the first
> place? =C2=A0I think it would make sense to make it "git reset --hard=
" at
> the beginning of each test as a separate, preparatory patch with
> explanation.
>
> [...]
>> There is however, one other thing I can do: if there is
>> nothing left to cherry-pick after a successful conflict resolution +
>> git commit, I can modify commit.c to blow away the sequencer state
>> after checking appropriately. =C2=A0This will also have a nice end-u=
ser
>> experience side-effect:
>> $ git cherry-pick moo
>> fatal: Conflict in foo!
>> $ echo "Resolved" > foo
>> $ git add moo
>> $ git commit
>> $ git cherry-pick --continue # This no-op will be unnecessary
>
> Though it's not obvious to me how this would affect the scripts above=
,
> it sounds like a nice enhancement to me independently, fwiw.

Oh, it fixes everything :)
Just see my GitHub fork.

>> Then again, teaching commit about the sequencer is inelegant,
>
> It's possible to add some hook-like thing to do this, or to structure
> the code as if a hook was used.
>
>> and it's
>> possible to achieve this effect in another way: when a conflict is
>> encountered in the sequencer && length(todo_file) =3D=3D 1, throw aw=
ay the
>> sequencer state.
>
> Yep, that seems like basically the same effect. =C2=A0Are there downs=
ides?
> (Maybe years from now when a "git cherry-pick --rewind" is introduced
> we would regret this? =C2=A0But that can be figured out years from no=
w.)

> Doh, I'm not thinking straight. =C2=A0Would this break "git cherry-pi=
ck
> --abort", or is there some hack layered on top to avoid that? =C2=A0M=
aking
> "git commit" remove the .git/sequencer for the last commit of the
> sequence seems a little saner.

We could always inject a hack to avoid this.  I'm not yet convinced
that we should teach commit about the sequencer, especially since the
patch to do it from the sequencer end is so simple.  Please have a
look at the patch [1], and let me know what you think.  I could submit
it as an RFC patch to the list for convenience, but I'm afraid it'll
be missing context.

[1]: https://github.com/artagnon/git/commit/0653bcccfa8d69687ed939f07f5=
b32dd14d302d3

-- Ram
