From: Kevin Ballard <kevin@sb.org>
Subject: Re: notes.rewriteRef doesn't apply to rebases that skip the commit
Date: Mon, 7 Apr 2014 14:54:29 -0700
Message-ID: <047C96E4-80B6-431C-906C-D9DFFDBFE9FF@sb.org>
References: <99F95780-059D-4F62-A851-C43729BB9893@sb.org> <xmqqzjjwlt9p.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Content-Type: text/plain; charset=iso-2022-jp
Content-Transfer-Encoding: 8BIT
Cc: gitList list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 07 23:54:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WXHUz-0006ue-Mq
	for gcvg-git-2@plane.gmane.org; Mon, 07 Apr 2014 23:54:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755959AbaDGVyd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Apr 2014 17:54:33 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:54348 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755956AbaDGVyc convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 7 Apr 2014 17:54:32 -0400
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 558A621052
	for <git@vger.kernel.org>; Mon,  7 Apr 2014 17:54:31 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute4.internal (MEProxy); Mon, 07 Apr 2014 17:54:31 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=content-type:mime-version:subject:from
	:in-reply-to:date:cc:content-transfer-encoding:message-id
	:references:to; s=smtpout; bh=fh4mBrVVTltSSynny6Uhg4O/7ic=; b=NE
	bjl3y65xm9r/nZUQCGei6fws3iPH00a+vS4DRZByukjXE76/eBZNasMkfwdW7/ZU
	DHIuBUIvx/DQg+njSAuZx5oBf1Z5NqT7bF2kTIomquNE8hDxijSLQkTOxNnzJ1k7
	PPFJgvJtosZibw9udMMjL2asRKKBr8NY3Puyugqe0=
X-Sasl-enc: Am7XLBi3CzJTYy/b2LklxqN8CBDkwNo0PGA61BnsmmHw 1396907671
Received: from [10.1.30.11] (unknown [199.27.109.101])
	by mail.messagingengine.com (Postfix) with ESMTPA id 9069EC007AA;
	Mon,  7 Apr 2014 17:54:30 -0400 (EDT)
In-Reply-To: <xmqqzjjwlt9p.fsf@gitster.dls.corp.google.com>
X-Mailer: Apple Mail (2.1874)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245908>

On Apr 7, 2014, at 2:33 PM, Junio C Hamano <gitster@pobox.com> wrote:

> Kevin Ballard <kevin@sb.org> writes:
> 
>> I’ve started using notes recently, and I have notes.rewriteRef set so that
>> when I rebase, my notes will be kept. Unfortunately, it turns out that if a
>> rebase deletes my local commit because it already exists in upstream, it
>> doesn’t copy the note to the upstream commit. It seems perfectly reasonable to
>> me to expect the note to be copied to the upstream commit, as it represents
>> the same change.
> 
> That would cut both ways, depending on the use case.  I suspect that
> those who use notes as remainder of what are still to be sent out
> would appreciate the current behavior.

It depends on how things are sent out. I know Git operates by sending all
patches to the ML, which are then reapplied, so they end up with a different
commit hash. But in most of the projects I've worked in, the main workflow
ends up with commits getting merged into master without getting rewritten. The
reason why I'm requesting this behavior is that committing without rewriting
isn't necessarily a strict rule.

For example, in the project that I'm using notes for, every commit needs to go
through Gerrit for code review. Normally it gets reviewed and merged into
origin/master without a rewrite, and my note is preserved. But sometimes
someone else will sneak a commit in first and I'll need to rebase. If I rebase
locally, that works, but Gerrit also offers to rebase my commit for me. And if
I let Gerrit do it, I still want my note to be preserved. In the end, there
should be no practical difference between me rebasing and Gerrit rebasing.

In general, Git doesn't know what the user is using notes for. If the user has
requested that notes persist through rewrite operations, it seems reasonable
that Git should recognize rewrites that happened remotely too, not just
locally.

As for your particular example of tracking what still needs to be sent out,
I'm not sure I understand that example. If I `git push` or use format-patch
and send an email, isn't that sending it out? Therefore I need to
update/delete my note explicitly. And if I want to track what hasn't made it
into origin/master yet, well, the origin/master ref already does that for me.

>> Another potential issues is if the commit exists upstream, but the surrounding
>> context has changed enough that it contains a different patch-id. In this
>> case, I would want Git to take the extra effort to correlate the upstream
>> commit with my local one (it has the same message, modulo any Signed-Off-By
>> lines, the same authorship info, and all the - and + lines in the diff are
>> identical).
> 
> That would be an orthogonal improvement, I would think.  Such a
> smarter "patch-id may mistake it, but it is a moral equivalent"
> detection would not only be useful for copying notes, but also for
> skipping the commit from getting replayed in the first place, no?

Perhaps, but replaying an empty commit already does nothing. Although I
suppose `git rebase` does have the `--keep-empty` flag, so it might be useful
there.

>> On a semi-related note, I don't see why Git should be warning about
>> notes.displayRef evaluating to a reference that doesn't exist. It doesn't
>> exist because I haven't created any notes for that ref in this repository yet.
>> But that doesn't mean I won't be creating them eventually, and when I do I
>> want them to be displayed.
> 
> That also cuts both ways. I think a warning is primarily to let
> those who mistyped the refname take notice.

I get that, but I don't think that's particularly important. There's no
practical difference between typoing the ref in notes.displayRef and forgtting
to set up notes.displayRef in the first place. Git certainly can't warn about
the latter. And the warning about the former is quite annoying if I did not
in fact typo, but rather just haven’t created any notes in that ref yet.

-Kevin Ballard