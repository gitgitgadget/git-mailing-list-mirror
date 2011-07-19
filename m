From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [GSoC update] Sequencer for inclusion v2
Date: Tue, 19 Jul 2011 22:47:38 +0530
Message-ID: <1311095876-3098-1-git-send-email-artagnon@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 19 19:18:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QjDwR-0002nC-6F
	for gcvg-git-2@lo.gmane.org; Tue, 19 Jul 2011 19:18:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751747Ab1GSRSi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jul 2011 13:18:38 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:36451 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751001Ab1GSRSh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jul 2011 13:18:37 -0400
Received: by pvg12 with SMTP id 12so4030753pvg.19
        for <git@vger.kernel.org>; Tue, 19 Jul 2011 10:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=3N1eHnZ0RZUWL5V8D+N0+U5nws1gYu0Ir7JVW1hWWDQ=;
        b=u0UHABwZU3g3Tos5hI5VVJE4MzECmJDWt+onpRxWk34gh51qpYTV00qsWfRKYUlEoh
         8UCsEJXuECKUbxKdF6Htn+28swsHtb3P0f7BtJULp0vai3oltBu6p74yx4YQMa2ouSAg
         EAQU+08RIuJuHMoodHJido6mLRDHq0G+v+lLY=
Received: by 10.142.75.9 with SMTP id x9mr3904931wfa.129.1311095916610;
        Tue, 19 Jul 2011 10:18:36 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id r12sm4276415wfe.1.2011.07.19.10.18.31
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 19 Jul 2011 10:18:35 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.rc1.7.g2cf08.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177465>

Hi,

Mid-term is over, and I'm disappointed that I'm behind schedule -- I
haven't been able to get the Sequencer merged yet.  The reviews have
been incessant as ever, and I spend most of my time chipping
everything to prefection.  On a positive note, the series looks like a
beautiful work of art now; I never imagined that it could be this
beautiful :)

So, I've worked harder on this iteration to fix all the issues with
the last one.  Many of the commit messages are new, I've thrown away
my custom parser in favor of the gitconfig one.  There is however, one
pending issue: how "revert: Remove sequencer state when no commits are
pending" will be compatible with a future "--abort" feature.  I've
done nothing about it; here's an elaborate justification:

In article <7vvcv8bjmf.fsf@alter.siamese.dyndns.org>, Junio C Hamano wrote:
> Ramkumar Ramachandra <artagnon@gmail.com> writes:
>> diff --git a/builtin/revert.c b/builtin/revert.c
>> index f9f5e3a..3936516 100644
>> --- a/builtin/revert.c
>> +++ b/builtin/revert.c
>> @@ -990,8 +990,18 @@ static int pick_commits(struct commit_list *todo_list, struct replay_opts *opts)
>>       for (cur = todo_list; cur; cur = cur->next) {
>>               save_todo(cur, opts);
>>               res = do_pick_commit(cur->item, opts);
>> -             if (res)
>> +             if (res) {
>> +                     if (!cur->next)
>> +                             /*
>> +                              * An error was encountered while
>> +                              * picking the last commit; the
>> +                              * sequencer state is useless now --
>> +                              * the user simply needs to resolve
>> +                              * the conflict and commit
>> +                              */
>> +                             remove_sequencer_state();
>>                       return res;
>> +             }
>>       }
>
> It may be useless for --continue, but wouldn't --abort need some clue on
> what you were doing?

In article <20110706195610.GA23984@elie>, Jonathan Nieder wrote:
> Doh, I'm not thinking straight.  Would this break "git cherry-pick
> --abort", or is there some hack layered on top to avoid that?  Making
> "git commit" remove the .git/sequencer for the last commit of the
> sequence seems a little saner.

Okay, allow me to revisit this discussion with some new arguments -- I
spent some more time thinking about this.

First, on the issue of making "git commit" remove the sequencer state
- why I don't like this. Okay, let's say I "touch
.git/remove-sequencer-state-after-commit" instead of this hunk.  What
does this mean? "git commit must remove the sequencer state before it
exits", right? Well, not exactly -- we can restrict it to say that
"git commit must remove the sequencer state before it exits, provided
that it's committing a conflict resolution (using information in
CHERRY_PICK_HEAD)". Now, the problem:
having.git/remove-sequencer-state-after-commit around is very
dangerous.  It is only cleaned up after the next git commit commits a
conflict resolution and exits cleanly.  Consider what would happen if
it were lying around, even by mistake:

$ git cherry-pick moo..foo
... conflict somewhere in the middle ...
$ echo "foo" >problematicfile
$ git add problematicfile
$ git commit # Resolving the conflict
$ git cherry-pick --continue
fatal: No cherry-pick in progress!

My sequencer state was blown away just because of a stray
.git/remove-sequencer-state-after-commit from a previous operation!
This is horrible.  One can then argue: the file should only ever abort
*that* sequencer operation, and now we run into the problem of
assigning a UID for each sequencer operation.  Unnatural and ugly.
Conclusion: Making "git commit" remove the sequencer state is WRONG.

One alternative I've explored: the sequencer should remove the
sequencer state.  But we have to keep the head around somewhere else
so that "--abort" can work.  What about .git/SEQUENCER_HEAD instead of
.git/sequencer/head? The only inelegance I can see is in the cleanup
-- a cleanup routine has to remove two seemingly unrelated paths.
Then again -- I don't like the idea of unconditional "--abort" either
the way "rebase -i" aborts.  I know it looks odd because I was the one
putting "--abort" in my patches in the first place :p Anyway, what is
the problem with the unconditional "--abort"?  I just returned to my
room after a long vacation, and I want everything to be up to date, so
I do:

$ git reset --hard ram/sequencer
$ git ci --amend
... Some other changes ..
$ git rebase -i master
fatal: An existing rebase is already in progress
# Surprise!
$ git rebase --abort # Immediate reaction
$ git log
# Gah! Where did all my work go?

I propose something like: only "reset --hard" when .git/SEQUENCER_HEAD
is reachable from HEAD.  We can put even more safeguards in place
using a ref name like Junio suggested earlier to protect users from
shooting themselves in the face.  Anyway, this is all a little
long-term, and "--reset" was a really good idea for now: I'm glad we
implemented it.  Users can abort by hard-resetting by hand.

Okay, so far so good.  What about this iteration? I haven't changed
anything.  Making the sequencer remove the sequencer state is not
wrong; we just need to do some additional thing to ensure that a
future "--abort" will work.  I'll let some reviews decide whether that
additional thing should be .git/SEQUENCER_HEAD or something else, and
whether we need to think about it now.

Thanks.

-- Ram

Ramkumar Ramachandra (18):
  advice: Introduce error_resolve_conflict
  config: Introduce functions to write non-standard file
  revert: Simplify and inline add_message_to_msg
  revert: Don't check lone argument in get_encoding
  revert: Rename no_replay to record_origin
  revert: Propogate errors upwards from do_pick_commit
  revert: Eliminate global "commit" variable
  revert: Introduce struct to keep command-line options
  revert: Separate cmdline parsing from functional code
  revert: Don't create invalid replay_opts in parse_args
  revert: Save data for continuing after conflict resolution
  revert: Save command-line options for continuing operation
  revert: Make pick_commits functionally act on a commit list
  revert: Introduce --reset to remove sequencer state
  reset: Make reset remove the sequencer state
  revert: Remove sequencer state when no commits are pending
  revert: Don't implictly stomp pending sequencer operation
  revert: Introduce --continue to continue the operation

 Documentation/git-cherry-pick.txt |    6 +
 Documentation/git-revert.txt      |    6 +
 Documentation/sequencer.txt       |    9 +
 Makefile                          |    2 +
 advice.c                          |   31 ++-
 advice.h                          |    3 +-
 branch.c                          |    2 +
 builtin/revert.c                  |  743 +++++++++++++++++++++++++++++--------
 cache.h                           |    2 +
 config.c                          |   25 ++-
 sequencer.c                       |   19 +
 sequencer.h                       |   20 +
 t/7106-reset-sequence.sh          |   43 +++
 t/t3510-cherry-pick-sequence.sh   |  219 +++++++++++
 14 files changed, 964 insertions(+), 166 deletions(-)
 create mode 100644 Documentation/sequencer.txt
 create mode 100644 sequencer.c
 create mode 100644 sequencer.h
 create mode 100755 t/7106-reset-sequence.sh
 create mode 100755 t/t3510-cherry-pick-sequence.sh

-- 
1.7.4.rc1.7.g2cf08.dirty
