From: Johan Herland <johan@herland.net>
Subject: Re: [RFD] Making "git push [--force/--delete]" safer?
Date: Wed, 3 Jul 2013 12:00:01 +0200
Message-ID: <CALKQrge_REZKfds0T-owJOn2BvfLmHpk7yQeSog=yvofE_zKJQ@mail.gmail.com>
References: <7vfvvwk7ce.fsf@alter.siamese.dyndns.org>
	<CALKQrgenpqKUxOZ+p79NsaQD9M2-q4h93ZqN0oencVo-QZF=zg@mail.gmail.com>
	<CALKQrgdovWTd50LVDnNR+BhurWgSCKkhr88wCo01VZF3sd5PNg@mail.gmail.com>
	<7vli5ogh8r.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 03 12:00:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UuJrD-0000xz-Vr
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jul 2013 12:00:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932595Ab3GCKAJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jul 2013 06:00:09 -0400
Received: from mail10.copyleft.no ([188.94.218.231]:49554 "EHLO
	mail10.copyleft.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932445Ab3GCKAH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jul 2013 06:00:07 -0400
Received: from locusts.copyleft.no ([188.94.218.116] helo=mail.mailgateway.no)
	by mail10.copyleft.no with esmtp (Exim 4.66 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1UuJr3-0006JD-SE
	for git@vger.kernel.org; Wed, 03 Jul 2013 12:00:05 +0200
Received: from mail-oa0-f46.google.com ([209.85.219.46])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1UuIaV-0004Bf-LJ
	for git@vger.kernel.org; Wed, 03 Jul 2013 10:38:55 +0200
Received: by mail-oa0-f46.google.com with SMTP id h1so7745240oag.5
        for <git@vger.kernel.org>; Wed, 03 Jul 2013 03:00:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=XRH23HtnhUQKBCYnpHB3tYm2BAswepSoGncvFCZBtvg=;
        b=MX/HpFUVNO+eJKbbLedEcWbw+nsgIM6FK33mcK53D7KRDgJK2+DDItddgg2PxWMu0d
         pREjaMTowi5YIyiVhA6FoM7uYdFS27oX++cIDrkxF8k0g5i9/w8SYe5MyJiXa9nl20gp
         dBHLVisLY/FoYXwdtsbTr4lwbfyEKYEx3TfNZjhD7I9y+FS3zGNcovLMLc6vORegLVKi
         MbW24JuHjCuJM6iP2WkGNHbtfERhWJY+/OAp3UqHGk/wDvlL4U1+EQ6ltDvwP7VTm1kj
         y2pLs9FAddVyDOl8NPBOFWIvNrcLTnmu8eoNE7gyx6QorwHAJa3r9H/yqA11SAzSZ0KH
         FnuQ==
X-Received: by 10.60.97.1 with SMTP id dw1mr149078oeb.1.1372845601431; Wed, 03
 Jul 2013 03:00:01 -0700 (PDT)
Received: by 10.182.102.5 with HTTP; Wed, 3 Jul 2013 03:00:01 -0700 (PDT)
In-Reply-To: <7vli5ogh8r.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229479>

On Wed, Jul 3, 2013 at 10:49 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Johan Herland <johan@herland.net> writes:
>> Overnight, it occured to me that --force-if-expected could be
>> simplified by leveraging the existing --force option; for the above
>> two examples, respectively:
>>
>>   $ git push --force --expect
>>   # validate foo @ origin == @{upstream} before pushing
>>
>> and
>>
>>   $ git push --force --expect=refs/original/foo my_remote HEAD:foo
>>   # validate foo @ my_remote == refs/original/foo before pushing
>
> First, on the name.
>
> I do not think either "--validate" or "--expect" is particularly a
> good one.  The former lets this feature squat on a good name that
> covers a much broader spectrum, forbidding people from adding other
> kinds of validation later.  "--expect" is slightly less bad in that
> sense; saying "we expect this" does imply "otherwise it is an
> unexpected situation and we would fail", but the name still does not
> feel ideal.
>
> What is the essense of compare-and-swap?  Perhaps we can find a good
> word by thinking that question through.
>
> To me, it is a way to implement a "lock" on the remote ref without
> actually taking a lock (which would leave us open for a stale lock),
> and this "lock"-ness is what we want in order to guarantee safety.
>
> So we could perhaps call it "--lockref"?
>
> I'll leave the name open but tentatively use this name in the
> following, primarily to see how well it sits on the command line
> examples.

I agree that neither --expect nor --validate are very good. I also
don't like --lockref, mostly because there is no locking involved, and
I think most users will jump to an incorrect conclusion about what
this option does, unless they read the documentation.

Some other suggestions:

a) --update-if. I think this reads quite nicely in the fully specified
variant: --update-if=theirRefName:expectedValue, but it becomes more
cryptic when defaults are assumed (i.e. --update-if without any
arguments).

b) --precond. This makes it clear that we're specifying a precondition
on the push. Again, I think the fully specified version reads nicely,
but it might seem a little cryptic when no arguments are given.

c) --pre-verify, --pre-check are merely variations on (b), other
variations include --pre-verify-ref or --pre-check-ref, making things
more explicit at the cost of option name length.

> Then on the semantics/substance.
>
> I had quite a similar thought as you had while reading your initial
> response.  In the most generic form, we would want to be able to
> pass necessary information fully via the option, i.e.
>
>         --lockref=theirRefName:expectedValue
>
> but when the option is spelled without details, we could fill in the
> default values by making a reasonable guess of what the user could
> have meant.  If we only have --lockref without refname nor value,
> then we will enable the safety for _all_ refs that we are going to
> update during this push.  If we have --lockref=theirRefName without
> the expected value for that ref, we will enable the safety only for
> the ref (you can give more than one --lockref=theirRefName), and
> guess what value we should expect.  If we have a fully specified
> option, we do not have to guess the value.
>
> And for the expected value, when we have a tracking branch for the
> branch at the remote we are trying to update, its value is a very
> good guess of what the user meant.
>
> Note, however, that this is very different from @{upstream}.
>
> You could be pushing a branch "frotz", that is configured to
> integrate with "master" taken from "origin", but
>
>  (1) to a branch different from "master" of "origin", e.g.
>
>         $ git push --lockref origin frotz:nitfol
>         $ git push --lockref origin :nitfol     ;# deleting
>
>  (2) even to a branch of a remote that is different from "origin",
>      e.g.
>
>         $ git push --lockref xyzzy frotz:nitfol
>         $ git push --lockref xyzzy :nitfol      ;# deleting
>
> Even in these case, if you have a remote tracking branch for the
> destination (i.e. you have refs/remotes/origin/nitfol in case (1) or
> refs/remotes/xyzzy/nitfol in case (2) to be updated by fetching from
> origin or xyzzy), we can and should use that value as the default.
>
> There is no room for frotz@{upstream} (or @{upstream} of the current
> branch) to get in the picture.
>
> Except when you happen to be pushing with "push.default = upstream",
> that is.  But that is a natural consequence of the more generic
> check with "our remote tracking branch of the branch we are updating
> at the remote" rule.

Fully agree with all of the above. I've been living under the
"push.default = upstream" rock for too long... ;)

So, how do we deal with the various corner cases?

If we don't have a tracking branch for the branch at the remote we are
trying to update (and an expected value is not specified on the
command line) we should obviously fail the push as we were asked to
verify, but don't know what to verify against. AFAICS, there is no
alternative fallbacks for the expected value of the remote ref, and
even if there were, I'm wary of adding too many fallbacks as it makes
the behaviour less transparent.

Similarly, if we're expecting a certain value for a ref, and that ref
does not (yet) exist at the remote, we should also fail (even if the
same push without --force (and --lockref) would succeed), as we
clearly expected the ref to already exist, and its non-existence might
point to a typo somewhere in our command.

For the case where we're pushing multiple refs, and have expected
values for more than one of them, we need to determine if a failing
expectation should cause the entire push to fail, or merely stop that
one ref from being pushed (letting the others go through). I'd feel
safer if the _whole_ push failed, but I'm not a "push.default =
matching" user, so my opinion is of limited value. AFAICS, the current
behaviour of "matching" is that one failing (e.g. non-ff) ref does not
abort the entire push, which I find somewhat unsafe...

...Johan

--
Johan Herland, <johan@herland.net>
www.herland.net
