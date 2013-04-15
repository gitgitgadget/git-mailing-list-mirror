From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 3/3] pull: introduce --[no-]autostash and pull.autostash
Date: Mon, 15 Apr 2013 15:40:51 +0200
Message-ID: <vpqppxvoqsc.fsf@grenoble-inp.fr>
References: <1365887729-9630-1-git-send-email-artagnon@gmail.com>
	<1365887729-9630-4-git-send-email-artagnon@gmail.com>
	<vpq38us2oov.fsf@grenoble-inp.fr>
	<CALkWK0mdC_tK2CGqAa67fr189PQCjSjzAOPujipOHFfoiYW0qA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 15 15:42:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URjfq-0002Kz-EK
	for gcvg-git-2@plane.gmane.org; Mon, 15 Apr 2013 15:42:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751640Ab3DONmS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Apr 2013 09:42:18 -0400
Received: from mx1.imag.fr ([129.88.30.5]:51942 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751038Ab3DONmR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Apr 2013 09:42:17 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r3FDeoUZ001452
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 15 Apr 2013 15:40:50 +0200
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1URjeN-0007fD-LK; Mon, 15 Apr 2013 15:40:51 +0200
In-Reply-To: <CALkWK0mdC_tK2CGqAa67fr189PQCjSjzAOPujipOHFfoiYW0qA@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Mon, 15 Apr 2013 18:45:58 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 15 Apr 2013 15:40:51 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r3FDeoUZ001452
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1366638054.16716@M5BvpDxwhPs3mJOGoiGGcg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221229>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> In the pull-merge case, maybe: if your worktree isn't clean, you lose
> a lot of goodies like merge --abort anyway, and I hate that.

AFAICT, "git merge --abort" is an alias for "git reset --merge" which
was precisely designed to reset only modifications comming from a merge,
and not the local changes that were present before the merge was
started. The man pages are relatively obscure on the subject, but I'd
call that a documentation bug.

> Overall, I don't see how an extra stash/ stash pop where not
> absolutely necessary hurts.

It does. stashing means the user will have to "stash pop" later. One
extra step, one extra opportunity to forget something important.

A minor annoyance is that it will touch files that have no reason to be
touched, hence may trigger extra rebuilds with "make", disturbing text
editors that have the file open, etc.

The fact that "git pull" just works on dirty trees with non-overlapping
changes is an important feature of Git.

>> Shouldn't this belong to "git merge" instead (i.e. implement "git merge
>> --autosquash" and call it from "git pull")? Users doing "git fetch &&
>> git merge" by hand should be able to use --autosquash, I think.
>
> --autosquash reminds me of rebase.autosquash, and that is completely
> unrelated to the issue at hand.

A typo seems to have propagated in this thread. I meant auto*stash*, not
auto*squash*, sorry. I guess it's the same typo in Junio's message.

>> Something should be done for "git rebase" and "git pull --rebase" too.
>> In this case, the UI can be much smoother, since the user would have to
>> run "git rebase --continue" anyway, so you can do the auto-stash-pop for
>> him by adding something like "exec git stash pop" at the end of the todo-list.
>
> No.  I'm against executing a special codepath for a pull-rebase that
> has no equivalent in the pull-merge world.

I think you're taking it the wrong way. You seem to insist that
autostash should be a pull feature. I think it should be a feature of
merge and rebase, and the convenience script "git pull" should expose
them to the user.

I see no reason to prevent users running fetch and then merge or rebase
to use the autostash feature.

>> Ideally, "git rebase --abort" should auto-stash-pop too, although this
>> is much less trivial to implement.
>
> As I already pointed out in my message to Junio, "fixing" rebase is
> not the topic of discussion at all.

It's not about fixing the existing rebase. It's about implementing
autostash the right way.

As a user, when I run "git rebase --continue" and it tells me it's done,
I expect the work to actually be done. This is the case today. This
won't be the case after autostash is introduced if the user has to
remember to run "stash pop" afterwards.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
