From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH 1/2] notes: don't expand qualified refs in expand_notes_ref
Date: Tue, 22 Sep 2015 11:48:21 -0700
Message-ID: <CA+P7+xqDs4OokEeNhsvYeP8dDRhC1jRh2hLMBqc1v8D+ABCnmg@mail.gmail.com>
References: <1442441194-5506-1-git-send-email-jacob.e.keller@intel.com>
 <1442441194-5506-2-git-send-email-jacob.e.keller@intel.com>
 <xmqqzj0mkn7r.fsf@gitster.mtv.corp.google.com> <CA+P7+xpv_0Sf94FqMKJa0v0pSSEWXPRD2KQ0kmNBKC=2hrunhw@mail.gmail.com>
 <xmqqsi665yjm.fsf@gitster.mtv.corp.google.com> <CA+P7+xrwM44tMHMW+dEJx_tMtcMVEQELNq=J=rqs1uQ+feuZqQ@mail.gmail.com>
 <xmqqa8se47wa.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	Git List <git@vger.kernel.org>, Mike Hommey <mh@glandium.org>,
	Johan Herland <johan@herland.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 22 20:48:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZeScY-0006lb-O2
	for gcvg-git-2@plane.gmane.org; Tue, 22 Sep 2015 20:48:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934258AbbIVSsv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Sep 2015 14:48:51 -0400
Received: from mail-io0-f182.google.com ([209.85.223.182]:35320 "EHLO
	mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934334AbbIVSsl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Sep 2015 14:48:41 -0400
Received: by ioiz6 with SMTP id z6so23577616ioi.2
        for <git@vger.kernel.org>; Tue, 22 Sep 2015 11:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=WuudT/NGGxggFt81T6w7dhWAUQRrGMJGLdStmrhZRL4=;
        b=0XKdNOr2wJIKQpzN/kZe67bd1XsxNCX2wRqj/DcIkh2S56VkFfSJq/F9uYVHitPQ3C
         cyaprWuJtQ7gi/Na24skelkBN0xsAo2N+PW90AxT/6+6WaXqhUQG78RddXyOjSt1L8aq
         n1aSztTMLfFFTC/Y3lkMW1WsUJfquAkVdwMN75aUMjf+QWLyXrhgx3gap6ehwMd6yalY
         fjhO9Z5Js+r8XUZhJe2IzJaajuvnpnPfgu+QnV0GI0E4Zes6BelGWnRwYQEqGkvY1hUe
         mAV8RNnWG8OWm5f55sY3/tb9VBml46thWU5jwz2C7WA29MnYDkXmHjR6eWbFM7NbMuP2
         diRQ==
X-Received: by 10.107.166.201 with SMTP id p192mr39737783ioe.0.1442947720762;
 Tue, 22 Sep 2015 11:48:40 -0700 (PDT)
Received: by 10.107.132.155 with HTTP; Tue, 22 Sep 2015 11:48:21 -0700 (PDT)
In-Reply-To: <xmqqa8se47wa.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278416>

On Tue, Sep 22, 2015 at 11:37 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Jacob Keller <jacob.keller@gmail.com> writes:
>
>> The other issue here is that expand_notes_ref is called on the --ref
>> argument waaay before the current code even decides if the operation
>> is "read" or "write". Thus we'd have to break this out and handle
>> things very differently.
>
> I think you hit the right nail here.  The handling of --ref argument
> is what you need to adjust to the new world order.
>
> And "safety" is a red herring.  Those who are used to run
>
>         git log --notes=refs/heads/master
>
> and relies on it to refer to refs/notes/refs/heads/master must
> continue to be able to do so.  Changing expand_notes_ref() the
> way the proposed patch does will break them, won't it?  "safety"
> is not the only (or even the primary) requirement, but the
> correctness must also be kept.

I think that's more confusing than helpful, but we really shouldn't
change behavior here. I think we need to update documentation to
clearly indicate the current behavior, as it was not obvious at least
to me. I can submit a patch for this at least.


>
>> It seems like a lot more heavy lifting to change the entire flow of
>> how we decide when to expand "--ref" for "read" operations vs "write"
>> operations.
>>
>> That is, git notes list.
>>
>> It's easy to change behavior of git notes merge as it handles its
>> argument for where to merge from separately, but it's not so easy to
>> change git notes show...
>
> Yes, exactly.
>
> I am _more than_ OK to see that read-only accesses to the notes tree
> allowed anything under refs/ (like the proposed patch did) and also
> a raw 40-hex object name in the endgame, but I really would not want
> to see "we meant well and attempted to enhance 'notes merge' but we
> ended up regressing the behaviour of unrelated operations all of a
> sudden".
>
> If you cannot do your change without breaking the existing users,
> then you at least need a sound transition plan.  But I am not sure
> yet if you have to break the world (yet).  Let me think aloud a bit
> more.
>
> There aren't all that many callers of expand_notes_ref().
>
> My preference is to leave that function as-is, especially keep the
> behaviour of the caller in revision.c that handles --show-notes=
> (and --notes= that is its synonym) the same as before.
>

Ok.

> All the other callers are only reachable from the codepath that
> originates from cmd_notes(), if I am reading the code correctly, and
> that can be enhanced without breaking the existing users.  One
> obvious way to do so would be to make "--ref" to keep the call to
> expand_notes_ref(), and add another "--notes-rawref" or whatever
> option that does not restrict it to "refs/notes", but there may be
> other ways.
>

I think the easiest way would be to have --ref check ahead of time
which commands are read or write, and perform the init_notes_check
code there instead of inside each command. I'll look at this again
when I have time in the next few days.

Regards,
Jake
