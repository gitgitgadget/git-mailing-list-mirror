From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] status: display the SHA1 of the commit being currently processed
Date: Mon, 17 Jun 2013 11:37:41 -0700
Message-ID: <7vy5a8d1my.fsf@alter.siamese.dyndns.org>
References: <1371471004-9069-1-git-send-email-Mathieu.Lienard--Mayor@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Jorge Juan Garcia Garcia 
	<Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Mathieu Lienard--Mayor <Mathieu.Lienard--Mayor@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Mon Jun 17 20:38:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UoeJe-0007Iv-Qa
	for gcvg-git-2@plane.gmane.org; Mon, 17 Jun 2013 20:38:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752165Ab3FQSh4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Jun 2013 14:37:56 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52728 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752123Ab3FQShy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Jun 2013 14:37:54 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AA70B28EB6;
	Mon, 17 Jun 2013 18:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=w7AHCF+pSyvYpiR6kBa8T7apmSA=; b=yaxZVu
	HxceLNKSbRViXOVOFU/g/hMo6f9u3+tZNJ4RmslfhE9uouS2fS6x+ZquK0mZw/mq
	Hx5vVDUKi+vjEF/B2YUh525l4H+Tz5iFa+o5gSJqC4pguB5/lJuC8su9qx3hvmh6
	qQTuYHcg1uG8S1qIW78ZVP+Ne9bBZGwB+4P4E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fxXcf+zkbvdsqoMTJDeotgZ4ZkLIsZYW
	6sdZAO+sbr4s86Bwc+gzt5DLaTydzEAha/JUACAhzqwQZMYhXpc3tJs6A+7yU5yo
	V0vSTqOEafyfygXysSX8FdSL66kIUIFjhuMo5WuHbkvEU37gMiIbi+WiRILR+ScN
	9gFJ/phMB0Q=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5D6EE28EB0;
	Mon, 17 Jun 2013 18:37:44 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7E38C28EAA;
	Mon, 17 Jun 2013 18:37:43 +0000 (UTC)
In-Reply-To: <1371471004-9069-1-git-send-email-Mathieu.Lienard--Mayor@ensimag.imag.fr>
	(Mathieu Lienard--Mayor's message of "Mon, 17 Jun 2013 14:10:04
	+0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FF652380-D77C-11E2-B821-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228097>

Mathieu Lienard--Mayor <Mathieu.Lienard--Mayor@ensimag.imag.fr>
writes:

> When in the middle of a rebase, it can be annoying to go in .git
> in order to find the SHA1 of the commit where the rebase stopped.
>
> git-status now includes this information in its default output.
> With this new information, the message is now shorter, to avoid
> too long lines.
>
> The new message looks like:
> $ git status
>  HEAD detached from 33e516f
>  Editing c346c87 while rebasing branch 'rebase_i_edit' on 'f90e540'.

Hmph.  It only looks into rebase-merge and not rebase-apply; is this
patch complete, or just to show a Work-In-Progress?

I do not think you need to introduce a new stopped-sha file (if you
need it, call that with "sha-1").  "git rebase [-i/-m]" knows where
it stopped and what the next step is without having to have such an
extra file.  Why should you need one?

It seems that wt_status_get_state() tries to read in-progress state
for various operations, and I think the logic to _detect_ what to
show (i.e. what is the next commit to be replayed?  how many more
remains to be replayed?, etc.) would mix well with that function.
Extend wt_status_state structure to hold the necessary info, query
the state from the filesystem in that function, and display the info
(but not collect info) in show_rebase_in_progress(), to keep the
clean division of labor between these two places.

Also, please pay closer attention to topics that are under
discussion in other threads.  I think Ram's "Fix 'checkout -' after
'rebase' finishes" topic cf.

  http://thread.gmane.org/gmane.comp.version-control.git/227994/focus=228092

makes the output reasonably better and consistent (please check what
I'll be pushing out on 'pu' later today after fixing some of them
up).  I suspect that this patch will conflict with it, so either you
would need to wait, or work together with that branch (i.e. rebase
on top of it as necessary), or something.

In the longer term to address issues discussed in this thread cf.

  http://thread.gmane.org/gmane.comp.version-control.git/227432/focus=227471

I think the right direction is *NOT* to keep the first "HEAD
detached at" line and to add more cruft to the status output as
additional lines, when various sequencer-like operations that
tentatively take you to detached HEAD state to give control back to
you in the middle.  "git status" knows what operation is in
progress, and I think we should start our output _without_ that
"HEAD detached at" line.

Thanks.
