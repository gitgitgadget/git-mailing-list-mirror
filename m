From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] config doc: rewrite push.default section
Date: Tue, 18 Jun 2013 13:09:51 +0530
Message-ID: <CALkWK0ng+NOLNFJ8soccx-bLQtiV8c_zaLp4kJUh7NEBWAKFvg@mail.gmail.com>
References: <1371377188-18938-1-git-send-email-artagnon@gmail.com> <7vli69iff2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 18 09:40:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UoqWr-0007Cy-Tx
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 09:40:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751588Ab3FRHkd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jun 2013 03:40:33 -0400
Received: from mail-ie0-f179.google.com ([209.85.223.179]:50695 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750788Ab3FRHkd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 03:40:33 -0400
Received: by mail-ie0-f179.google.com with SMTP id c10so9234848ieb.10
        for <git@vger.kernel.org>; Tue, 18 Jun 2013 00:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=ocZ1Hld9Nr9lwD8DMfeo1cpM4oizLSzXjtyg9PA3gl4=;
        b=cAxKKZMrEj6YpJg5LP2WTrw0I3aZO6IxrstWiUc7OiP/awM6vkOfu3PEBd9eOLlIwX
         fZLKXl4utwrJBhxSbeU2C+do7ojCyH1bfBlO05/bBCwLX75b+piftDr8AO0STWdlVoRL
         BnMDsPYq2UGJYmvSL0ZfuCCNTnSGHt6tw2bhIXIyF959JE3p0HT3WtZtBejXp5N9RlUH
         b+wx6h8O+YY5tYZurT39Foj3cX1HdWOxWq1aZxQoU+FUviyPz1QWcYP7nU1SGiaAhfUQ
         H6C1AlOaJ/Q7F2MnhQTz3tFPFdBDA0mtRymeLZ54TLxPZtEWpNZwMRMrXx8gZF+Y+u4/
         3gjA==
X-Received: by 10.50.80.9 with SMTP id n9mr7006941igx.42.1371541232870; Tue,
 18 Jun 2013 00:40:32 -0700 (PDT)
Received: by 10.64.129.97 with HTTP; Tue, 18 Jun 2013 00:39:51 -0700 (PDT)
In-Reply-To: <7vli69iff2.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228168>

Junio C Hamano wrote:
> I do no think the remainder (snipped) belongs to the log message.

Oh, it was never intended to be a proper commit message.  I'll write a
proper one when I send it in with the implementation.

>  - To understand "if central, works as upstream, otherwise works as
>    current", the readers need to know if their workflow is 'central'
>    or not, so we need to say how that is decided upfront (probably
>    immediately before "Possible values are:" in the introductory
>    paragraph for push.default;

Good idea.

>  - For each of these choices, what it means is more important to the
>    readers than how the implementation achieves that semantics
>    (e.g. "current uses refs/heads/foo:refs/heads/foo when you are on
>    foo branch"). I think the ideal is a description of the meaning
>    that is clear enough not to require any implementation detail.

I'd definitely like to include the push refspec, to educate users on
how to achieve a one-off matching-push even when push.default is set
to current, for example.

> As this is an attempt to _define_ the semantics of what should
> happen in triangular workflow, I think it would be healthy to wait
> for a week or so in order for others (not just two of us) can see if
> we have defined a sane semantics we would want to go forward with.

Agreed.

> I am reasonably sure 'current' would be the best default for
> triangular (and that is why I suggested 'simple' to fall back to
> it), but I do not think others had a chance to see what design our
> discussion settled, think if that makes sense, and think of a better
> alternative.

You didn't realize one thing, because my wording was terrible:
`simple` is just a "safe" version of `current` :)

* `simple` - behaves exactly like `current`, with one safety feature:
in central workflows, it errors out if branch.$branch.merge is set and
is not equal to $branch (to make sure that the `push` and `pull`
aren't asymmetrical).

In other words, it's `current` with the safety feature of `upstream`.
There's no point in erroring out if no upstream is set, or mentioning
its relationship with `upstream`.

>> +* `nothing` - error out unless a refspec is explicitly given.
>
> I do not think 'error out' is the primary effect of this mode.
> Wouldn't "do not push anything" be much better?

"Do not push anything" is misleading because it implies an exit status
of zero; what is really does is "error out", no?

>> +* `current` - push the refspec "$HEAD".  HEAD is resolved early to a
>> +  branch name (referred to as $HEAD).  In other words, push the
>> +  current branch to update a branch with the same name on the pushing
>> +  side.
>
> As already pointed out, dropping everything before and including "In
> other words, " would be better.

I'd like to put it in the end, like Matthieu suggested.

> Also "push the current branch" is
> talking about the branch on the pushing side (you, the one who is
> running "git push"), and the side that is getting updated is at the
> receiving end, not "pushing side".

"receiving end" is better, yes.

> I think listing 'simple' at the end would be easier to read.  The
> above already swaps the order to make sure current and upstream are
> described before it, which is good.

As I pointed out, `simple` is just a composition of `current` and
`upstream`.  That's why it comes after them.  Also, I thought
`nothing`, `current`, `upstream` were fundamental: which is why they
come first.

> But I do not see a reason to move 'matching' which was next to
> 'nothing' here.

It's probably a personal bias, but I don't like matching at all :P

>> +* `matching` - push the refspec ":".  In other words, push all
>> +  branches having the same name in both ends, even if it means
>> +  non-fast-forward updates.  This is for those who prepare all the
>> +  branches into a publishable shape and then push them out with a
>> +  single command.  Dangerous, and inappropriate unless you are the
>> +  only person updating your push destination.
>
> It was already pointed out that unnecessary negativity needs to be
> fixed, but more importantly the above "Dangerous" is not even
> correct.

Okay, I'll explain my bias:

I have _never_ lost data with git: the reflog is my close companion.
There is one recent instance where I *lost* data, and I was very
unhappy about it.  I work on multiple machines, and not all local
branches are always synced with the upstream branches: when I switch
to a local branch to work on the topic, I notice my prompt and get it
to '=' before starting work.  In this one instance, I was developing
@{push} and toying around with various push.default settings.  I'd
forgotten that I'd set push.default to matching and issued my usual
push to update my branch.  This resulted in a huge number of my
branches getting rewound, and I could do nothing about it!

We've mentioned that pull --rebase is _dangerous_ (with the underline
for effect) in our documentation, when it's trivial to recover from
it: git reset --hard @{1}.  Yet, when I mention matching being
dangerous, I'm accused of being unnecessarily negative :\

In my opinion, `matching` is a bad and unpredictable setting, and
deserves last place on the list.  `nothing` deserves first place,
because it is the most predictable and least surprising.  Do not
mistake my stance for "matching is not useful"; ofcourse it is useful,
and I sometimes use it myself using ":" explicitly.

>> -+
>> -The `simple`, `current` and `upstream` modes are for those who want to
>> -push out a single branch after finishing work, even when the other
>> -branches are not yet ready to be pushed out. If you are working with
>> -other people to push into the same shared repository, you would want
>> -to use one of these.
>
> And I do not see a reason to drop this part, especially the first
> sentence.

I thought we should make it clear in the `matching` section; after
all, it's just `matching` versus everything else.
