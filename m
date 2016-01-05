From: greened@obbligato.org (David A. Greene)
Subject: Re: [PATCH] contrib/subtree: Remove --annotate
Date: Tue, 05 Jan 2016 15:35:23 -0600
Message-ID: <87oaczwvz8.fsf@waller.obbligato.org>
References: <1451963101-4901-1-git-send-email-greened@obbligato.org>
	<1451963101-4901-2-git-send-email-greened@obbligato.org>
	<xmqqsi2cj5hu.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, techlivezheng@gmail.com,
	alex.crezoff@gmail.com, davvid@gmail.com, cbailey32@bloomberg.net,
	danny0838@gmail.com, prohaska@zib.de, th.acker@arcor.de,
	sschuberth@gmail.com, peff@peff.net, gitter.spiros@gmail.com,
	nod.helm@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 05 22:35:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aGZGZ-0005Ji-DN
	for gcvg-git-2@plane.gmane.org; Tue, 05 Jan 2016 22:35:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751959AbcAEVfk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jan 2016 16:35:40 -0500
Received: from li209-253.members.linode.com ([173.255.199.253]:47060 "EHLO
	johnson.obbligato.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751934AbcAEVfi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jan 2016 16:35:38 -0500
Received: from chippewa-nat.cray.com ([136.162.34.1] helo=waller.obbligato.org)
	by johnson.obbligato.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
	(Exim 4.85)
	(envelope-from <greened@obbligato.org>)
	id 1aGZHF-00028t-AX; Tue, 05 Jan 2016 15:36:25 -0600
In-Reply-To: <xmqqsi2cj5hu.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Tue, 05 Jan 2016 09:33:33 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
X-Filter-Spam-Score: ()
X-Filter-Spam-Report: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283406>

Junio C Hamano <gitster@pobox.com> writes:

> David Greene <greened@obbligato.org> writes:
>
>> From: "David A. Greene" <greened@obbligato.org>
>>
>> Remove --annotate.  This obviates the need for an --unannotate
>> command, which is both an obvious addition and difficult to define
>> due to the numerous ways one might want to specify how to edit
>> commit messages.  git has other tools more suited to rewriting
>> commit messages and it's easy enough to use them after a subtree
>> split.  Such tools include filter-branch, rebase -i and
>> commit --amend.
>
> I do not think that "there are other ways to do this" is a good
> justification for removing a feature, unless it can be shown that
> nobody is using it, of course.

I thought you might say that.  :)

I honestly don't know how much it's used.  Obviously someone uses it
because we got a request a couple of years ago for an --unannotate
option and the ensuing discussion made it clear that that's not a
trivial thing.

The original author is not active anymore so I don't even know why it
was added in the first place.  I don't know how to get data about usage.

I'm in the process of getting git-subtree into shape so it can move out
of contrib into the main area.  Is there a policy for interface changes
to things in contrib?

There are a few other things I'm working on that will involve slight
semantic changes.  I was planning to do those similarly to how push
changed with git 2.0.  Make the current behavior default, emit a warning
and switch the default after a few releases.  This is all being done to
make git-subtree faster, take advanted of new git features since it was
opriginally written and generally make it more solid and predictable.  I
could do the deprecate/remote thing with --annotate if that sounds
better to you.

My thinking on this change runs as follows:

- --annotate isn't as powerful/flexible as other git commit message
  rewrite tools.

- Its obvious pair feature --unannotate isn't trivial to do -- people
  didn't even agree on what it *should* do.  It won't be added any
  time soon, if at all, so don't advertise something that naturally
  leads people to request it.

- We really shouldn't lie about the state of this.  --annotate feels
  tacked-on and incomplete.  It would be best to not have it at all if
  we can't do it right.

- Better to make the change now before moving out of contrib.

If you really don't want to get rid of this, I guess that's ok but my
preference as maintainer is to reduce the feature set to those things
people seem to actually regularly use (according to my very unscientific
Google searches) and add features as requested/evaluated.  --annotate
isn't a huge maintenance burdern but some of those other changes I
mentioned do in fact significantly reduce the maintenance burden of
git-subtree.  I hope I will have some leeway with those, even if they
change semantics slightly.

>> @@ -319,7 +315,7 @@ copy_commit()
>>  			GIT_COMMITTER_NAME \
>>  			GIT_COMMITTER_EMAIL \
>>  			GIT_COMMITTER_DATE
>> -		(printf "%s" "$annotate"; cat ) |
>> +		(echo -n ""; cat ) |
>
> I can see that by changing "printf something" with 'echo -n ""', you
> are making it clear that we are stopping to add that something to
> the pipeline, but (1) I think the intended effect of running 'echo
> -n' on an empty string is to do nothing, and (2) 'echo -n' is not
> portable [*1*], so this leaves a puzzling code that makes future
> readers scratch their heads.
>
> I wonder why this cannot be simply the removal of the entire line,
> making the resulting implementation more like this:
>
>                 git log -1 --pretty=format:... "$1" |
>                 (
>                         read ... various variables ...
>                         export ... various variables ...
>         -		(printf "%s" "$annotate"; cat ) |
>                         git commit-tree "$2" $3 # reads the rest of stdin
>                 ) || die "cannot copy"
>
> That is, just feed the remainder of what is coming directly to the
> command?

That makes sense.  Thanks.

                   -David
