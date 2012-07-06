From: Phil Hord <phil.hord@gmail.com>
Subject: Re: [RFC/PATCH] stash: Delete MERGE_RR before stash apply
Date: Fri, 6 Jul 2012 19:18:30 -0400
Message-ID: <CABURp0oXhZ5ysm4b3Z=7o+2TB+3wFdMjj4oEwxafApjD4c7ozA@mail.gmail.com>
References: <CABURp0pNsRQgbf7_iYc-xVaySa9-gGiA++Lw4-WgSCQ4QGCXsA@mail.gmail.com>
 <7v7guiruxo.fsf@alter.siamese.dyndns.org> <CABURp0rOfr=c-TcF7O6Ms=2iRA3SC9ckt_ukeozBS5vGqaKZaQ@mail.gmail.com>
 <7v7gugodzh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: David Aguilar <davvid@gmail.com>, git@vger.kernel.org,
	martin.von.zweigbergk@gmail.com, tytso@mit.edu
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 07 01:19:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SnHnd-0003OY-9Y
	for gcvg-git-2@plane.gmane.org; Sat, 07 Jul 2012 01:18:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933481Ab2GFXSw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jul 2012 19:18:52 -0400
Received: from mail-gh0-f174.google.com ([209.85.160.174]:35206 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932579Ab2GFXSu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jul 2012 19:18:50 -0400
Received: by ghrr11 with SMTP id r11so9123436ghr.19
        for <git@vger.kernel.org>; Fri, 06 Jul 2012 16:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=GMnIHoX5iE+VcHf1+PcD1SO4iHTOgMt/ULwlgKiV+l0=;
        b=wCk/bMym2vIxjB2nDTI26r2xXsCcpeeZc9AqSb0ordMNBycKSGa+sT6m6lAPvMA5F9
         NpKwQWpHZ8IbAESfPnve1zm+P4mf805EjdQXc+8JGH/2P0oyjDqccpwSBdF2AtF240j5
         ZU7/oMWGpZJz/Ew+0hIWjDsCWWkyFOnrGheoIQB+Jd3jYgdgtfINiR7K0eTBRsuHmYl7
         RQi1J3oon+1N87FFlqc7BMeCFCpuahfCuiytnf0mg9SvCDHbj1qJKqsrA+6/a0SSwbUA
         UL8YoEcN5+5huoVUOLz3m7k6WOiVkUvdsZpX9OktdQEvoYqgv1dseT/b3CCa9ufNjfpX
         q0nQ==
Received: by 10.236.183.168 with SMTP id q28mr26270161yhm.45.1341616730386;
 Fri, 06 Jul 2012 16:18:50 -0700 (PDT)
Received: by 10.146.150.18 with HTTP; Fri, 6 Jul 2012 16:18:30 -0700 (PDT)
In-Reply-To: <7v7gugodzh.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201154>

On Fri, Jul 6, 2012 at 4:01 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Phil Hord <phil.hord@gmail.com> writes:
>
>>> Would an obvious alternative of running "git rerere" ourselves after
>>> running "git merge-recursive" in this script work?
>>>
>>>  git-stash.sh | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/git-stash.sh b/git-stash.sh
>>> index 4e2c7f8..bbefdf6 100755
>>> --- a/git-stash.sh
>>> +++ b/git-stash.sh
>>> @@ -469,6 +469,7 @@ apply_stash () {
>>>         else
>>>                 # Merge conflict; keep the exit status from merge-recursive
>>>                 status=$?
>>> +               git rerere
>>>                 if test -n "$INDEX_OPTION"
>>>                 then
>>>                         gettextln "Index was not unstashed." >&2
>>
>> Yes, except it needs "git rerere clear".  "git rerere" is not enough
>> to cause the clean-up to occur.
>
> Intuitively, it feels wrong to run "rerere clear" after an operation
> that potentially can create conflicts in the index and in the
> working tree.
>
> The point in the codepath where the above "git rerere" appears is
> immediately after we run merge-recursive backend.  Because the
> backend does not invoke rerere itself (which by the way probably is
> the correct thing not to; I haven't thought things through, though),
> we invoke it ourselves there, so that the user can ask rerere to
> replay an earlier conflict resolution.  Why can it be a good thing
> to discard potentially useful information with "git rerere clear"?
>
> I just tried this sequence (manually without any patch).
>
>     $ git init empty && cd empty
>     $ for i in a b c d e; do echo $i; done >file
>     $ git add file && git commit -m initial
>     $ for i in a b C d e; do echo $i; done >file ;# c to C
>     $ git stash
>
>     $ for i in a B c d e; do echo $i; done >file ;# b to B
>     $ git commit -a -m second
>
>     $ mkdir .git/rr-cache ;# enable rerere
>     $ git stash apply ;# conflicts
>     $ git rerere ;# records preimage
>
>     $ for i in a B C d e; do echo $i; done >file ;# c to C
>     $ git commit -a -m third ;# records resolution
>     $ git reset --hard HEAD^
>
>     $ git stash apply ;# conflicts
>     $ git rerere ;# replays
>
> I think the above "how about this" patch is equivalent to the two
> "git rerere" invocations I made manually with my experiment, and it
> seems to improve the end user experience (please try it yourself).
>
> What am I missing???

I thought the reason rerere was not supported was because of some
limitation in the type of merge being completed.  I didn't think it
was possible to make rerere actually work with this situation.

I understand now.  I'll try again.

Phil
