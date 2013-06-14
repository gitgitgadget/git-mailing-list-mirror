From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 5/6] status: do not depend on flaky reflog messages
Date: Fri, 14 Jun 2013 11:57:14 +0530
Message-ID: <CALkWK0=NAiGDVWbwHXMmEffPF9wKXd23BdwOntfdvNCpVe8fiA@mail.gmail.com>
References: <1371130349-30651-1-git-send-email-artagnon@gmail.com>
 <1371130349-30651-6-git-send-email-artagnon@gmail.com> <7vvc5hubox.fsf@alter.siamese.dyndns.org>
 <CALkWK0kjxKFkrLArL1mLZYCMN1=sgnDSa3vaoJm6eSUp2E4Pyw@mail.gmail.com> <7vd2rpu3kf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 14 08:28:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnNUY-0005a0-7T
	for gcvg-git-2@plane.gmane.org; Fri, 14 Jun 2013 08:28:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751401Ab3FNG15 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Jun 2013 02:27:57 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:44519 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751344Ab3FNG14 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jun 2013 02:27:56 -0400
Received: by mail-bk0-f46.google.com with SMTP id na10so72279bkb.19
        for <git@vger.kernel.org>; Thu, 13 Jun 2013 23:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=2u7YUM/ARxabKCIIJA7GvuytZBlr0QMbPB8fqk8y9MY=;
        b=hG5T7Z7Q3l4tlLdCw9C8N8/AFTDd60hK3xvj5/XvZydy3uptPDqz2z9PnIEDqzJ+Wg
         FjVL2Su2AR1vdufzpUYqmOnOJuyoOjhoHK+lRQoR+r5fmgPYJqsa0lxL75qtdpx2/9jr
         D/SeEClHTbfMUeHCZEuqobRLkRXeMrbqyI7E8i+2x310Ih1Ybh9ZJeoEjg+lm51ycAZA
         q5a1lhgFr+05xTKF18gvrzYxd1zlpEkjms5yJPNDTtl6SWr7+4ED8ytMwVbtT+jt0h0/
         E2Nqoo0nWsVX53eDXVQNhv35V+fKrdh1twjWEwmnooW/8wJeKrfctho/pnkjzsutIeTR
         HjBQ==
X-Received: by 10.204.69.12 with SMTP id x12mr96007bki.14.1371191274797; Thu,
 13 Jun 2013 23:27:54 -0700 (PDT)
Received: by 10.204.186.77 with HTTP; Thu, 13 Jun 2013 23:27:14 -0700 (PDT)
In-Reply-To: <7vd2rpu3kf.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227789>

Junio C Hamano wrote:
>> What is wrong with git describe?  Is this cheaper, or am I missing something?
>
> I think what you are missing is that the "detached from" is not
> about your current HEAD after you flipped it around with many resets
> and commits.  It is about what tag or what specific commit you
> detached your HEAD at originally.

No, it is about what tag of specific commit you detached your HEAD
from, *without using checkout*.  If you used checkout, you'd get the
"detached at" message, and I haven't changed that.

> "You can ask the same to describe" is wrong and is not a valid
> argument.  Once you replace the HEAD^ with a distant commit
> (e.g. HEAD~400) in the third step in the example, "describe" will
> not talk about v1.8.2 at all.

You're missing the point: how do I, as the end-user, detach my HEAD
*without using checkout*?  The hypothetical example you have given is:

  $ git checkout HEAD^
  $ git update-ref HEAD $(git rev-parse HEAD~400)

Which end-user executes that?

> Your argument can be that it is not a useful piece of information,
> and as you can probably guess from my "I wouldn't be surprised"
> above, I am not sure how useful it would be and in what situation
> [*1*].

Precisely.  It is a poorly thought-out feature that locks things up
too tightly, and makes life hell for contributors.  It must therefore
be removed.

> But the original commit thought it was necessary and that was done
> for a reason; we need to be careful here.  With a good justification
> why it is not necessary (or misleading to the user), I do not think
> we cannot change it.

We cannot reverse-engineer intents.  All we can do is look at the
evidence in front of us.  Read the commit message, and look at the
newly added test.  There is absolutely no indication about why this
"detached from" is useful, and where.

>         $ git rebase master
>         ... replays some but stops
>         $ git status
>
> currently uses that "HEAD detached from" codepath, but I think that
> is a mistake.  We could not just tell the HEAD is detached, but the
> reason _why_ the HEAD is detached (i.e. we are in the middle of a
> rebase).  The prompt script can do it, "status" should be able to do
> the same, and do a lot more sensible thing than unconditionally
> showing that "HEAD detached from" and then say "You are currently
> rebasing" on a separate line.  Most likely we do not want to even
> say "Not currently on any branch" but just say "You are currently
> rebasing branch X on top of Y" (and perhaps "N commits remaining to
> be replayed").

That information is available in .git/{rebase-apply,rebase-merge}, and
your suggestion pertains to improving show_rebase_in_progress().  The
first line is about the state of HEAD, and is completely orthogonal to
the issue at hand.

  artagnon|rebase-rev-failure|REBASE-i 2/3:~/src/git$ git status
  # HEAD detached from a7e9fd4
  # You are currently editing a commit while rebasing branch
'rebase-rev-failure' on '9926f66'.
  #
  nothing to commit, working directory clean

That first line about "HEAD detached from ..." is completely useless.
And yes, my prompt is more useful.  No prizes for guessing how often I
use the long form of git status.

> *1* One thing I could think of is to start sightseeing or (more
>     realistically) manually bisecting at a given release point,
>     reset the detached HEAD around several times, and then want to
>     be reminded where the session started from.  I do not think it
>     is particularly a very good example, though.

The example you have given now is:

  $ git checkout @^
  # or whatever bisect command to detach HEAD
  $ git reset @~3
  ...
  $ git reset @^
  ...
  $ git reset @~5
  ....
  # when was HEAD originally detached?

Yes, it is a contrived example where this feature arguably has some
utility.  Is it worth putting the information in the status for such
an esoteric example?  If one really wants this information, they can
open up the reflog and grep for "checkout: ".
