From: Phil Hord <phil.hord@gmail.com>
Subject: Re: Ambiguous reference weirdness
Date: Wed, 22 Feb 2012 09:48:23 -0500
Message-ID: <CABURp0r+3gOQ3rq_ubv=uEoU=XmtYs=etfT4W2Lb9M0LBrikWg@mail.gmail.com>
References: <CABURp0oAw7cvU7cwCZOtvqZ_oa0hDPsE_0Lm3kR1ctdNuxU3hg@mail.gmail.com>
 <20120222070034.GA17015@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 22 15:48:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0DUw-0008UM-Q2
	for gcvg-git-2@plane.gmane.org; Wed, 22 Feb 2012 15:48:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752028Ab2BVOsp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 22 Feb 2012 09:48:45 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:48981 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751869Ab2BVOsp convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Feb 2012 09:48:45 -0500
Received: by lagu2 with SMTP id u2so121369lag.19
        for <git@vger.kernel.org>; Wed, 22 Feb 2012 06:48:43 -0800 (PST)
Received-SPF: pass (google.com: domain of phil.hord@gmail.com designates 10.152.148.2 as permitted sender) client-ip=10.152.148.2;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of phil.hord@gmail.com designates 10.152.148.2 as permitted sender) smtp.mail=phil.hord@gmail.com; dkim=pass header.i=phil.hord@gmail.com
Received: from mr.google.com ([10.152.148.2])
        by 10.152.148.2 with SMTP id to2mr5325025lab.39.1329922123391 (num_hops = 1);
        Wed, 22 Feb 2012 06:48:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=UOMxAbA2JvVJBrRP5o7UeWMqlkuiZlcuTYb/RzoW2zo=;
        b=oaTOJcFd8ofdTPwaey+JU7LLYkWJZu+AaKZ6pVHPmINVUGXOtGQjD12L8X6YsnDx4a
         0zVviHYHMHxqaHJpYxYoVDGsbvfju/ZmTsNjVVolL4lO1doy8jEf1n6IW6ZPbhZFBkZ3
         HXArmOPHt5dOqWafX3ij8ndeTY1xNQF3f8+JI=
Received: by 10.152.148.2 with SMTP id to2mr4502568lab.39.1329922123267; Wed,
 22 Feb 2012 06:48:43 -0800 (PST)
Received: by 10.112.4.101 with HTTP; Wed, 22 Feb 2012 06:48:23 -0800 (PST)
In-Reply-To: <20120222070034.GA17015@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191258>

On Wed, Feb 22, 2012 at 2:00 AM, Jeff King <peff@peff.net> wrote:
> On Tue, Feb 21, 2012 at 08:46:24PM -0500, Phil Hord wrote:
>
>> I accidentally ran into this today:
>> =A0 =A0 $ git cherry-pick 1147
>> =A0 =A0 fatal: BUG: expected exactly one commit from walk
>>
>> git log shows no output:
>> =A0 =A0 $ git log 1147
>
> What is 1147? Is it supposed to be a partial sha1, or is it a ref you
> have?

1147 was a typo.  It was a Gerritt changeset ID I forgot to expand.
When I type "git cherry-pick 1147<TAB>", autocompletion expands this
for me to "git cherry-pick origin/changes/47/1147/1".  Except in this
case I misfired the TAB and got the weird "BUG:" report.  But I didn't
see the same problem with other invalid refs, so I went searching for
the variants and to see what caused it.

> Have you looked at the object that it resolves to? I suspect it is th=
e
> partial sha1 of a non-commit object. E.g.:

All of these examples were run in current git.git, so you can try them
yourself if needed.  But I did figure out that 1147 resolves to a
blob, and that's apparently the difference between these three:

$ git cherry-pick 1147
fatal: BUG: expected exactly one commit from walk

$ git cherry-pick 1146
error: short SHA1 1146 is ambiguous.
error: short SHA1 1146 is ambiguous.
fatal: ambiguous argument '1146': unknown revision or path not in the
working tree.
Use '--' to separate paths from revisions

$ git cherry-pick 114333
fatal: ambiguous argument '114333': unknown revision or path not in
the working tree.
Use '--' to separate paths from revisions

I consider the first two responses to be UI bugs.   The second one is
minor (the twice-reported error message), and the first one is pretty
rude.   I would expect all three to report the same conclusion,
"fatal: ambiguous argument 'XXXXX': unknown revision or path not in
the working tree."  But the first one doesn't.



> =A0$ git cat-file -t HEAD^{tree}
> =A0tree
> =A0$ git cherry-pick HEAD^{tree}
> =A0fatal: BUG: expected exactly one commit from walk
> =A0$ git log HEAD^{tree} | wc -l
> =A00

Thanks.  I'm not familiar with the {tree} syntax -- in fact I'd like
to find a dictionary for all the reference spelling variants -- but
this is elucidating.

> In the cherry-pick case, the code is checking the right thing, but th=
e
> message is horrible. It is not a bug, but merely unexpected input, an=
d
> it should provide a usage message.

Bug is too strong a word in one sense, but from the user perspective I
consider this "horrible message" a bug.

> In the log case, we totally ignore any pending non-revision arguments=
=2E
> So it is correct to produce no output (there is nothing to show, whic=
h
> is not unusual in itself; many queries end up producing empty output)=
=2E
> But we should probably notice that there are pending objects left ove=
r
> and produce some kind of diagnostic.

I think you're right about this.  I tried log as an afterthought and
was surprised by the varying results.

> I've reordered some of your example commands below to fit the flow of=
 my
> explanation better.
>
>> $git log 114
>> fatal: ambiguous argument '114': unknown revision or path not in the
>> working tree.
>> Use '--' to separate paths from revisions
>
> Right. I think we require at least 4 characters in a partial sha1, so=
 we
> don't treat that as a possibility. So we are left guessing whether yo=
u
> mean to do:
>
> =A0git log 114 --
>
> or
>
> =A0git log HEAD -- 114
>
> since it exists as neither a revision nor a path, and the error messa=
ge
> reflects that (the first one is an error, as there is no such revisio=
n.
> The second is a correct query, though one that does not produce any
> results).
>
>> $ git checkout 114
>> error: pathspec '114' did not match any file(s) known to git.
>
> I think checkout has the same "is this a path or a revision" ambiguit=
y
> to resolve. But rather than be explicit that you might have meant "11=
4"
> as a tree, the error message assumes you meant a path. That might be
> worth improving, similar to the above example.
>
> Again, you can disambiguate with:
>
> =A0$ git checkout -- 1147
> =A0error: pathspec '1147' did not match any file(s) known to git.
>
> =A0$ git checkout 1147 --
> =A0fatal: reference is not a tree: 1147
>
>> $ git checkout 1147
>> fatal: reference is not a tree: 1147

Yes, I understand this.  This was a typo and it was ambiguous.  But
shouldn't we tell the user the same thing when encountering the same
failure?

> In this case the name does resolve to an object, so we try to use it =
as
> such (even though we later find that it is useless for the operation)=
=2E
> We _could_ realize that it is not a tree and disambiguate to:
>
> =A0$ git checkout -- 1147
>
> but the current rule is at least consistent and simple.
>
>> $ git checkout 1146
>> error: short SHA1 1146 is ambiguous.
>> error: pathspec '1146' did not match any file(s) known to git.
>
> The sha1 is ambiguous, and therefore it does not resolve to anything.=
 So
> you get the same case as "git checkout 1147", but with the extra
> ambiguity warning.

This one I like.  I only included it to demonstrate the different
error messages git produces.

>> $ git merge 114
>> fatal: '114' does not point to a commit
>
> It might be nice for this error message to be split into two cases:
>
> =A01. the name does not resolve _at all_ (i.e., you made a typo)
>
> =A02. the name does resolve to something, but it is not a commit
>
> In the latter case, we actually do get an extra error message from
> elsewhere in the code:
>
>> $ git merge 1147
>> error: 1147: expected commit type, but the object dereferences to bl=
ob type
>> fatal: '1147' does not point to a commit
>
> But in case 1, it's not clear which is which (maybe even rewording it=
 as
> "114 cannot be resolved as a commit" would be less confusing).
>
>> $ git cherry-pick 114
>> fatal: ambiguous argument '114': unknown revision or path not in the
>> working tree.
>> Use '--' to separate paths from revisions
>> [...]
>> $ git cherry-pick 1147
>> fatal: BUG: expected exactly one commit from walk
>
> This is the "does not resolve" versus "is not actually a commit". In =
the
> first case, though, I wonder if the error message is accurate. I'm no=
t
> sure if you can do "git cherry-pick <rev> -- <paths>", so the error
> message is misleading

Good point.  I missed that one completely.


> (if anything, I would expect it to limit the
> revision walk, but trying "git cherry-pick HEAD -- 114" seems to stil=
l
> complain about the absence of 114).
>
>> [more examples]
>
> These are all variants that hopefully make sense in light of the
> explanations above.
>
>> I can understand some of the inconsistent error reporting (checkout
>> may expect filenames, but cherry-pick and merge do not). =A0But this
>> seems too varied to me.
>>
>> And the first two look like bugs.
>>
>> Any comments or suggestions?
>
> I think the outcomes are all working as intended, but the error messa=
ges
> could stand to be improved.

Yes, I agree.  I only meant to complain about the error messages, not
the results.  Thanks for the discussion.  I'll try to look for where
these come from and see if they can be improved within reason.

Phil
