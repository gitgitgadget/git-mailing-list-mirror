From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 09/11] rebase: support automatic notes copying
Date: Wed, 24 Feb 2010 19:58:45 -0800
Message-ID: <7vd3zurmoa.fsf@alter.siamese.dyndns.org>
References: <cover.1266885599.git.trast@student.ethz.ch>
 <4623296da9ed82447718b46c72e6a22ff0152fc0.1266885599.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>, Johannes Sixt <j6t@kdbg.org>,
	Johan Herland <johan@herland.net>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Feb 25 04:59:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NkUsh-0006sF-76
	for gcvg-git-2@lo.gmane.org; Thu, 25 Feb 2010 04:59:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932145Ab0BYD7A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2010 22:59:00 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:57221 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932111Ab0BYD7A (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2010 22:59:00 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E655C9C500;
	Wed, 24 Feb 2010 22:58:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6p3tkN1uv79AedTagO4/11CYtB8=; b=JDz99b
	k7sufUwnaIoEKTOmWvC4bCk1qKtTS02ETKD3+T0rD3PlpTpJ5NeqPlmGRvkWP2XG
	+MH/1KUY+m92UD6Cs/s82bmYC6qaC459WIASWr5uGCe0m6HhdoX/5o8gNhMpo840
	s9WLzjJOo+ACFYWkZJAHUNEh9Mjvs+2dKivgY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mBP3OmTECQIg6oil9SsqCLlwol5/eCnn
	XGY7eT55A8AyNl1xMmKZC7kEVI48/j7xCJiNhvsv7vzKf7M20CFmqKiDBe29+gnI
	SlCR9usuRLiqp79MMpjK7lFXncS2Y3hmOLueJ+d5QdGBmGSQyUq7pd37l/78DxRx
	22FVMitLtek=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A0B249C4FF;
	Wed, 24 Feb 2010 22:58:53 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 474E29C4FE; Wed, 24 Feb
 2010 22:58:48 -0500 (EST)
In-Reply-To: <4623296da9ed82447718b46c72e6a22ff0152fc0.1266885599.git.trast@student.ethz.ch> (Thomas Rast's message of "Tue\, 23 Feb 2010 01\:42\:27 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 16EAAC42-21C2-11DF-AAA6-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141024>

Thomas Rast <trast@student.ethz.ch> writes:

> Luckily, all the support already happens to be there.
>
> Signed-off-by: Thomas Rast <trast@student.ethz.ch>

I did my first "rebase -i / commit --amend / rebase --continue" cycle with
this series, and it correctly carried notes I keep track of Message-Id of
original patches with.  Good job.

After looking at the output from "git log refs/notes/amlog", I have a few
observations, though.

 - "git notes add" and friends honor GIT_COMMITER_* and GIT_AUTHOR_* as
   usual.  Since I use post-applypatch hook to record the message-id from
   "git am", I ended up getting my notes written by original submitters.

 - The log messages are mostly useless.  The scripted implementation said
   "Annotate 6d8094a8aa32c30ff39c6b8609acb8d057ccb5e5" which was not the
   most informative, but the new one says "Notes added by 'git notes add'".

I haven't thought things through thoroughly, and I am not complaining, but
it may be worth thinking about what the "commit"-ness of generations of
notes tree _should_ mean.

As we are recording the history of how the set of my notes have grown over
time, I think it is natural to expect that the user can record who is
recording this notes tree at what time for what reason, just like a
regular commit does.

 - "added by 'git notes add'" is just as immaterial as "commit log edited
   with vi".  'copied via notes.rebase.rewrite hook' would make much more
   sense.

 - "git notes add" already uses -m option to take the text used as note
   (i.e. payload of the commit); the user may need a way to affect the
   commit log message to record why the note is added (or modified).

 - As to the determination of committer/author identity, I think what the
   code currently does (i.e. honor the environment and user.* config) is
   perfectly sane, but at the same time I think it would be surprising for
   unsuspecting users.  We may want to advise users about this in the
   documentation.

But the above is merely my personal feeling on the "notes history".

The notes implementation (from the scripted one to the one in 'pu') seems
to take quite a different view and is designed as if aspects other than
the topology and the tree each "commit" object records are not useful at
all, and commits are used to implement the notes history only because the
ancestry might help when we later implement merges of notes histories.  I
think that could also be a _valid_ position to take.
