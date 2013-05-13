From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/7] rebase.autostash completed
Date: Sun, 12 May 2013 21:57:37 -0700
Message-ID: <7vy5bjqxxa.fsf@alter.siamese.dyndns.org>
References: <1368359801-28121-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 13 06:57:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UbkpU-0005F1-QA
	for gcvg-git-2@plane.gmane.org; Mon, 13 May 2013 06:57:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752277Ab3EME5l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 May 2013 00:57:41 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52134 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752060Ab3EME5k (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 May 2013 00:57:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2A0AE198F2;
	Mon, 13 May 2013 04:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=ItBBHEAYdDsbuo3FzeeOy9veYNw=; b=C+xp7SpuXsFlyfjU2jQb
	je5wIloPw1COXp5wFXWkcM/ywf2foneX2ZICu5zA0/v8Q265SThsLfCKrkKt2C6w
	pB0S858SjBPdVAoI9Zsgx0hiCuGyPPW5ZjaRs7bgF68ZULh5TeAIFSONpqs6kfOh
	eMSi6yEb9H/Et1ww1TqfCxk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=kdnXyQngFmtcLuJZesIwr83UsEKbCiZNBbH3QuFF+wVuEw
	IL1RMKZ1sllCRR8uE5gtna49Y/YcJ4f0jsh+AhY0dXz6jRjR4gQZgibnafyLUaM/
	/zv7rVoKASTZskdv77ipj8IBkllAj8jutcaMktsjBd2c5dIY9um8teTX8F228=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1D59D198F1;
	Mon, 13 May 2013 04:57:40 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5894B198F0;
	Mon, 13 May 2013 04:57:39 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A2F983A2-BB89-11E2-A483-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224086>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Minor changes since v2 in response to reviews by Junio and Eric
> Sunshine.
>
> Should be ready to merge soon.

That, and the "completed" on the Subject line are not for you to
decide, I would have to say ;-)

Overall the patches look cleanly done, but I did not carefully look
into the implementation.  Especially I did not check if there are
still undesirable data loss behaviour in corner cases that people
were worried about in the discussion.  It would have been nice to CC
people who voiced concerns during the previous reviews.

A few comments on possible follow-up work, not meant as a suggestion
to include in this series:

 * The series shows that it is necessary to first prepare a stash
   entry with "stash create", then later decide to queue it to the
   stash (or decide not to do so) in some applications.

   In the longer term, it is unmaintainable to make such users (like
   this new code) of the stash mechanism manually do so, and we may
   want to add a "git stash __store" subcommand, not meant for the
   interactive use of end users.  The implementation of the stash
   can later be changed without affecting such users by doing so.

 * The primary reason why you wanted this autostash was because
   "rebase" is implemented in a lazy and stupid way, compared to
   "merge" that detects possible conflicts with local changes and
   refrains from touching the working tree at all, and any local
   change that do not interfere with the merge are permitted.

   Perhaps "rebase" can be taught to be more careful when checking
   if local changes may overlap with the changes being replayed.
   When replaying a range A..B on top of the onto commit O, perhaps
   "rebase" can at least do these:

    - If the index is dirty with respect to HEAD, stop just like
      "merge" does.

    - Take a union of paths different between O and the working
      tree, and untracked new paths in the working tree.  These are
      the possible "local changes".  If there is no way the replay
      of A..B touches any of these paths, we do not even have to
      worry about stashing.

    - Take output from "diff-tree -m --name-only" for each commit in
      the replayed range (note that I am not adding -M to take
      maximal coverage).  Check if any of the paths overlap with the
      "local changes", and if so, stop.

   to be par with "merge". 

When the latter is done, there is _no_ justification for autostash
to be an option specific fo "rebase.  At that point, "rebase" and
"merge" would refuse to start in the same situation, i.e. the local
changes you have are known to interfere with the integration with
the branch, diminishing the need to "autostash" greatly.

When autostash is still needed to proceed after such change to
"rebase", I suspect that the user may be better off saving such
work-in-progress in a temporary commit (possibly after making it
into a better shape before even starting to "rebase" or "merge")
than using a transient mechanism like stash to save such a work,
because it is likely that such local changes have a real conflict
with the work being integrated.

Those who still want to use stash would benefit from having an
autostash, but at that point, there is no reason to single out
"rebase" for the autostash feature.  Those who want to stash
immediately before a "merge" that is known to conflict can use the
same autostash and may want to do so for exactly the same reason
they may want to use it for "rebase".
