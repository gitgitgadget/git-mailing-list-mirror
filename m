From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 7/7] sequencer: Remove sequencer state after final commit
Date: Fri, 19 Aug 2011 00:21:24 +0530
Message-ID: <CALkWK0noHBnW-7zZLw=jJdDVFxXmsm2vHHYnUJc9miLLuDRnAg@mail.gmail.com>
References: <1313310789-10216-1-git-send-email-artagnon@gmail.com>
 <1313310789-10216-8-git-send-email-artagnon@gmail.com> <20110814160440.GK18466@elie.gateway.2wire.net>
 <7vei0nn1cn.fsf@alter.siamese.dyndns.org> <20110814213200.GA6555@elie.gateway.2wire.net>
 <7vippzlj7a.fsf@alter.siamese.dyndns.org> <7v7h6eld2c.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 18 20:52:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qu7h8-0004BP-02
	for gcvg-git-2@lo.gmane.org; Thu, 18 Aug 2011 20:51:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752479Ab1HRSvq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Aug 2011 14:51:46 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:59129 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752430Ab1HRSvp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Aug 2011 14:51:45 -0400
Received: by wyg24 with SMTP id 24so1619078wyg.19
        for <git@vger.kernel.org>; Thu, 18 Aug 2011 11:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=u5hH20SBmcpIDEw3R84s7ShjcuoJKT4P0LdQnr0ouIU=;
        b=vD02nU5b0ZNv1KS44MFlQR1WgCedSBM/2yoMA7G5Ld9AmxWrIZRzKwGjm4x/PwRoEk
         MicnJ19fQNjpa6YkAneWGKvOUiSbmp0PTKXgtop1ayhwCWjTZerNp9CQ8r6b0uvspuRe
         ZZ/lOX8QPiv26c402Mq9iVAMhUjT8u7kllHNI=
Received: by 10.216.46.208 with SMTP id r58mr5462842web.78.1313693504106; Thu,
 18 Aug 2011 11:51:44 -0700 (PDT)
Received: by 10.216.172.132 with HTTP; Thu, 18 Aug 2011 11:51:24 -0700 (PDT)
In-Reply-To: <7v7h6eld2c.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179612>

Hi Junio,

Junio C Hamano writes:
> [...]

Here are some comments from my end after extensive thought.  Instead
of responding to your comments directly, I've sprinkled bits of it
here and there, reordering it as I see fit.  Thanks for detailing out
your thoughts so well :)

0. Before getting into historical mistakes and evaluating existing
workflows, let's first try to detail the problem the sequencer is
trying to solve: pick/ revert aren't the only operations we want to
support.  Let's imagine some hypothetical "foo" operation that does
something incredibly complex in the instruction sheet:

pick b38bcc
foo
pick 49ab7c

Now, let's imagine that the "foo" command failed.  What is the
strategy we will employ to handle his?  I think the question boils
down to: should we teach '--continue' the prerequisite for executing a
"pick" command (clean worktree etc), or how to finish a "foo" command?
 What will this answer depend upon?

1. Now, let's discuss the motivation for d3f4628e.  I didn't want to
create a separate workflow for pick-one-commit versus
pick-many-commits.  It would have to go something like:

  parse_arguments(whatever tree'ishes specified on argc)
  setup_revision_walker
  n =3D count_revisions
  if (n =3D=3D 1)
    do foo; // Don't create sequencer state
  else
    create sequencer state; do foo; cleanup sequencer state;

Ugly.  Wouldn't you agree?  So, what choice did I have?  I can't
conditionally create sequencer state.  So, an idea struck me: if I
clean it up before someone notices, I'm safe.  So, I decided to remove
it before the last commit -- when there's only one commit, it'll be
removed immediately.  So far so good: no regressions introduced.

2.  Okay, now let's try to touch upon the issue of marking something as=
 "done":

> =C2=A0- The case to resume an unexpected stop (i.e. "pick" that cause=
s conflict
> =C2=A0 or "rebase" without "-i") also feels right. The user fixes up =
and marks
> =C2=A0 things as "done" with "add/rm", and tell the stopped command t=
hat it can
> =C2=A0 now continue with "rebase --continue". The same comment applie=
s for
> =C2=A0 "am".

I could argue that "add/rm" need not be the only way to specify "done"
in the general case.  We needn't be consistent about that- we can
print hints about what "done" would mean, and not invent a new
"--mark-as-done" command.  What varies here is the definition of
"done": does it mean that the user has "done" what the instruction
sheet operation was supposed to do (including the committing), or has
simply done a part of the job and passed on the baton?

3. How tight do we want the sequencer to be?  Should we allow
executing other commands during the operation of the sequencer, or
should we simply expect the user to "--continue" the operation first
and take care of everything else later?

> =C2=A0- The sequencing flow the current "rebase -i" implements when r=
esuming a
> =C2=A0 controlled stop (i.e. "edit" or "reword"), even as the last st=
ep of the
> =C2=A0 insn sheet, feels like the right thing. The actual tweaking of=
 the
> =C2=A0 commit done by "commit --amend" is oblivious to the sequencing=
 state,
> =C2=A0 and resuming is controlled by "rebase --continue".

I often "git commit -m temp" in the middle of a "rebase -i", and I'm
strongly in favor of allowing this somehow.

> There is a (complicated) workflow to split an commit during
> "rebase -i" that does _not_ want an auto-resume by a commit.

Exactly! :)
Auto-resuming after a "commit" is fundamentally wrong.

> Also not
> all conflicted/stopped state can be concluded with "commit" (think:
> "rebase/am --skip").

A good point on consistency.

4.  Let's correct the historical mistakes and get our act together.
The final pending question is: how many historical mistakes are we
willing to stomp now?

> I personally am leaning towards teaching "--continue" to "merge" and
> "cherry-pick", while keeping only existing awareness of these two com=
mands
> in "commit" as historical mistakes (look for 'unlink(git_path("[A-Z_]=
*"))'
> in builtin/commit.c). That would mean that in the long run, new users=
 need
> to learn only one thing: when "git Foo" stops because it needs help f=
rom
> you resolving conflicts, after you help it by editing the files in yo=
ur
> working tree and making that with add/rm, you say "git Foo --continue=
" to
> signal that you are done helping it.

Okay, stomp nothing.  Under this constraint, the best we can do is:
1. Introduce a 'merge --continue' to invoke 'git commit'.  MERGE_HEAD
helps 'git commit' finish.  Modify tests to use '--continue' instead
of the earlier commit-to-finish workflow, and advertise this feature
everywhere.
2. Make 'cherry-pick --continue' invoke 'git commit' as well.
CHERRY_PICK_HEAD helps 'git commit' finish.  If the commit finishes
successfully: (if there is one commit left, remove the sequencer
state; otherwise, drop the first insn on top of the list and execute
the next insn).  Modify tests to use '--continue' instead of the
earlier commit-to-finish workflow, and advertise this feature
everywhere.  Unfortunately, if the user executes 'git commit' instead
of the newer '--continue', we're screwed: a stray sequencer state will
be left behind.

Does the above seem sensible, or should we do something about the
historical mistakes?

Thanks.

-- Ram
