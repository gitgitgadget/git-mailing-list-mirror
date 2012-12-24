From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: Re: [PATCH 2/2] learn to pick/revert into unborn branch
Date: Sun, 23 Dec 2012 23:20:10 -0800
Message-ID: <CANiSa6i5f6wU5R5U43+NpZfOTTX0e_GFzNVxxA412DB4ES4P8w@mail.gmail.com>
References: <1356117013-20613-1-git-send-email-martinvonz@gmail.com>
	<1356117013-20613-2-git-send-email-martinvonz@gmail.com>
	<7vr4mhpi0l.fsf@alter.siamese.dyndns.org>
	<CANiSa6i0-Z=FkPnSJxgT+3ABHTzgOTNNNUb=wHQpm2DKAN_UOw@mail.gmail.com>
	<7v4njcpof8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 24 08:20:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tn2Ks-0005CY-Od
	for gcvg-git-2@plane.gmane.org; Mon, 24 Dec 2012 08:20:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752682Ab2LXHUM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Dec 2012 02:20:12 -0500
Received: from mail-ia0-f181.google.com ([209.85.210.181]:39841 "EHLO
	mail-ia0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751702Ab2LXHUL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Dec 2012 02:20:11 -0500
Received: by mail-ia0-f181.google.com with SMTP id s32so5609278iak.40
        for <git@vger.kernel.org>; Sun, 23 Dec 2012 23:20:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=PGuGCIRwyyRlkHlM99sPyV7cKu+7x36OgcId0SNk7yk=;
        b=EiC98vaDboQESYndeNnsbGGiHOKICMfs+C+iWisSwETPdRRfJksyR3D7PiZrShW5CL
         Rh2nJifkUN3K8SWbJl6YH/I8rvhYuxIpfJBfDBbPn2zJPqKv6PJlcxmYVae/JCOJfVeV
         1D8s8UcMKqVifUprAfKhbyAY8ESnrmUlJqeM9how+WZj56K/mQrI6EjGu6bJFcC9fNW4
         bHWSIbm7YKP/EHK0UIur2epLNn+F31p67PwTv/R2XeTgWBoKRrSw5rPsIU6CpWoI+b32
         NVGJiou3f3+AYhzEsSFi6d/J8Ctir++m3Os6wcu0WqK6eNLWUYsLe+s4rEYpl0vHORU+
         5WzQ==
Received: by 10.50.196.198 with SMTP id io6mr19473120igc.39.1356333610665;
 Sun, 23 Dec 2012 23:20:10 -0800 (PST)
Received: by 10.64.86.68 with HTTP; Sun, 23 Dec 2012 23:20:10 -0800 (PST)
In-Reply-To: <7v4njcpof8.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212103>

On Sun, Dec 23, 2012 at 11:18 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Martin von Zweigbergk <martinvonz@gmail.com> writes:
>> On Sat, Dec 22, 2012 at 7:24 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> I am not opposed to an "internal use" of the cherry-pick machinery to
> implement a corner case of "rebase -i":
>....
>     3. You run "rebase -i --root" to get this insn sheet:
>
>         pick Add Makefile and hello.c for "Hello world"
>         pick Add goodbye.c for "Goodbye world"
>
>        and swap them:
>
>         pick Add goodbye.c for "Goodbye world"
>         pick Add Makefile and hello.c for "Hello world"

Right, and as you point out in your later message, editing the initial
commit is another (and more useful) use case. It could of course be
special cased in "git rebase", but I think doing it "git cherry-pick"
is the right thing to do. Hopefully git-rebase.sh can then just reset
to the void state and git-rebase--interactive.sh can just continue
without knowing or caring whether it got started on an unborn branch.
Hmm... I just realized the "branch" in "unborn branch" really means we
don't have "unborn detached HEAD", do we? So some more tricks are
probably necessary after all. :-(

> [...] It transplants something that used to depend on the entire
> history behind it to be the beginning of the history so its log
> needs to be adjusted, but "rebase -i" can choose to always make it
> conflict and force the user to write a correct log message, so it
> won't expose the fundamental flaw you would add if you allowed the
> end-user facing "cherry-pick" to pick something to create a new root
> commit without interaction.

If I understand you correctly, you are suggesting that "git rebase"
should set the action from "pick" to "edit" for the first commit in
the insn sheet if it is not a root commit. "git rebase -i --root"
doesn't currently do that, but it certainly could.

> I agree that "git reset" without any commit parameter to reset the
> index and optionally the working tree (with "--hard") should reset
> from an empty tree when you do not yet have any commit.

Good to hear.

> But I do not think it has anything to do with "cherry-pick to empty",
> so I do not agree with "In the same way" at all.

See later comment.

>> One use case might be to rewrite history by creating an new unborn
>> branch and picking the initial commit and a subset of other commits.
>
> If you mean, in the above sample history, to "git cherry-pick" the
> commit that starts the "Hello world" and then do something else on
> top of the resulting history, how would that be different from
> forking from that existing root commit?

True, the result would be the same. The user's thought process might
be a little different ("let me start from scratch" vs "let me start
almost from scratch"), but that's a very minor difference that I'm
sure any user would quickly overcome.

>> Anyway, I didn't implement it because I thought it would be very
>> useful, but mostly because I just thought it should work (for
>> completeness).
>
> I would not exactly call X "complete" if X works in one way in most
> cases and it works in quite a different way in one other case, only
> because it would have to barf if it wanted to work in the same way
> as in most cases, and the different behaviour is chosen only because
> "X that does something is better than X that stops in an impossible
> situation and barfs".

I agree, of course, but I don't see the behavior as different. When
thinking about behavior around the root of the history, I imagine that
all root commits actually have a parent, and that they all have the
same parent. I also imagine that on an unborn branch, instead of being
invalid, HEAD points to that same "single root" commit with an empty
tree. Despite this model not matching git's, I find that this helps me
reason about what the behavior of various commands should be.

With this reasoning, cherry-picking into an unborn branch is no
different from cherry-picking into any commit with an empty tree
(which of course would be rare, but not forbidden).
