From: Sergey Organov <sorganov@gmail.com>
Subject: Re: [PATCH] Documentation/git-rebase.txt: fix -f description to match actual git behavior.
Date: Mon, 18 Aug 2014 17:27:34 +0400
Message-ID: <87a972rkqh.fsf@osv.gnss.ru>
References: <87bnrq22uf.fsf@osv.gnss.ru>
	<xmqq4mxh5w34.fsf@gitster.dls.corp.google.com>
	<xmqqzjf94f5n.fsf@gitster.dls.corp.google.com>
	<87mwb8ahtb.fsf@osv.gnss.ru>
	<xmqqha1g49q5.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 18 15:27:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJMyM-0007rV-Mc
	for gcvg-git-2@plane.gmane.org; Mon, 18 Aug 2014 15:27:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751505AbaHRN1h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Aug 2014 09:27:37 -0400
Received: from mail.javad.com ([54.86.164.124]:43711 "EHLO mail.javad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751372AbaHRN1h (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Aug 2014 09:27:37 -0400
Received: from osv.gnss.ru (unknown [89.175.180.246])
	by mail.javad.com (Postfix) with ESMTPSA id C281E60BF3;
	Mon, 18 Aug 2014 13:27:35 +0000 (UTC)
Received: from osv by osv.gnss.ru with local (Exim 4.72)
	(envelope-from <sorganov@gmail.com>)
	id 1XJMyE-0000sM-40; Mon, 18 Aug 2014 17:27:34 +0400
In-Reply-To: <xmqqha1g49q5.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 13 Aug 2014 09:48:02 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255388>

Junio C Hamano <gitster@pobox.com> writes:

> Sergey Organov <sorganov@gmail.com> writes:
>
>> ... I.e., git must not rebase anything
>> when "Current branch is a descendant of the commit you are rebasing
>> onto", unless -f is given. Simple, reasonable, straightforward.
>
> It may be simple and straightforward, but breaks the use case the
> plain vanilla rebase is used for, doesn't it?

I hope it does not. I don't think plain vanilla rebase's "flattening"
feature is usually used, as those who care about flat history mostly
don't merge. Either not at all, or do merges temporarily and undo them
later. At least that's the impression I've got from recent conversations
about the issue.

Moreover, I'm afraid rare person would correctly predict the result of
history flattening he will get from git rebase of even remotely complex
graph.

That said, I'm still to hear from somebody who would actually suffer. I
mean I see some use-case(s), but they: 1) are unlikely to be used in
practice. 2) are better handled by other means. 3) abuse bug/feature
that contradicts documentation. 4) won't be broken that hard anyway.

> You seem to ignore, or perhaps you don't realize the existence of, the
> need of those who want to flatten the history on top of the tip from
> the other side;

No, I do realize and I don't ignore the possibility. Please recall that
I didn't suggest to get rid of any functionality that is already there.

I didn't want to get into lengthy discussion about it, but here we are.

In fact there are 2 issues here (please notice that I don't cut any
existing functionality):

1. Better design of interface to "git rebase" features.

2. How far we are currently from those "better", is it worth the trouble
   to move in the direction of "better" at all, and how far and how fast
   we are going to move, considering backward compatibility issues.

If we don't agree on (1), i.e., where is point B, there is no reason to
discuss (2), i.e., the way from point A to point B. I'm trying to
discuss (1), and you are mostly objecting by pointing me to the fact
that changes could break some workflow, i.e., by discussing (2).

What about those better design? Here is my bet:

1. "git rebase" with no options takes a set of commits and rebases them
   on top of another commit, preserving precious history as much as
   possible.

   Reason: most common operation: "rebase my work on top of different
   commit". Nothing more, nothing less. That's what --preserve mode does
   right now. I.e., the result should be as close as possible to the
   case where I had started to do all the work on top of the new base
   commit from the beginning.

2. "git rebase" onto the same base should be no-op, unless --force
   option is given.

   Reason: if command changes base, it's natural to do nothing when base
   is not changed. Alternatively, rebase would have to be performed
   always, and commit dates etc. would be changed as a result. This
   would be just annoying most of times.

3. "git rebase" may have an option to flatten the history instead of
   preserving its shape (--flatten or some such). This mode may imply
   some relaxing of (2) by always performing the rebase when there are
   merge commits among those to be rebased.

   Reason: somebody somewhere could probably find a real use for such a
   feature. BTW, there could be different modes of flattening, so this
   option may take corresponding values (e.g., squash every merged set
   of commits to a single commit). Please also notice that function of
   (3) could be achieved by other means, so it's not a requirement,
   rather a convenience (that's why I said "may have an option").

We can discuss this if somebody interested. If not, let's just fix
documentation to match current historical design, please.

> your statements in the "pull --rebase[=preserve]" thread may be
> coming from the same place, I suspect.

Yes, it's the same place. It's all started from a big trouble I ran into
by simply following current git documentation for "git pull" and "git
rebase" and from assumption that defaults are usually safe (and sane,
yes, in my understanding of "sane" ;-) ).

And yes, they share the same reasoning. That is, by default a command
must perform its primary job, and only it. Everything else should be an
option. For "git pull" it'd mean to fetch the changes from upstream, and
then either merge or rebase to integrate with them. For "git pull", my
plan would be to introduce new "pull.rebase=flatten" value and deprecate
"pull.rebase=true". Bare "pull --rebase" should be deprecated as well
in favor of explicit "pull --rebase=flatten", then later "pull
--rebase" could be given saner and safer meaning of "pull
--rebase=preserve", or rather removed.

> For the "flatten the history on top of that commit" use case, two
> conditions must be satisfied before the command can say "the history
> is already in the desired shape and nothing needs to be done" to
> allow it to make a short-cut.  It is not sufficient for the current
> tip to be merely descendant of the tip from the other side (which is
> the documentation bug we are fixing here).  The history between the
> two commits need also to be linear, or it would not be flattening.
>
> Punting when when only one of the two conditions is met and
> requiring "--force" to perform what the user wanted to ask the
> command to do does not fall into the "reasonable" category.

Current behavior you described above would be "reasonable" for "git
flatten" command. If it were reasonable for "git rebase", why is it
that difficult to correctly document it? Good design is usually easily
documentable.

> If your workflow does not involve the flattening plain vanilla
> "rebase", not using it is perfectly fine.  But please do not break
> it for other people only because you do not use it yourself.

I only aim at making "git rebase" better. Backward compatibility
shouldn't be forgotten, but you seem to disagree that my suggestion(s)
do make it better in the first place, so no need to discuss any breakage
at this point.

Anyway, those imaginary people, if any, who would suffer from the change
that would require --force to rebase *on the same commit* currently
silently rely on the feature that contradicted documentation, and that
sometimes needs to be punished ;-)

-- 
Sergey.
