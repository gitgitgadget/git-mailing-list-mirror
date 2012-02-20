From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] pre-rebase: Refuse to rewrite commits that are reachable
 from upstream
Date: Mon, 20 Feb 2012 14:43:15 -0800
Message-ID: <7vobstjfcs.fsf@alter.siamese.dyndns.org>
References: <201202111445.33260.jnareb@gmail.com>
 <1329772071-11301-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, jnareb@gmail.com, philipoakley@iee.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Mon Feb 20 23:43:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rzbx5-00007w-Nw
	for gcvg-git-2@plane.gmane.org; Mon, 20 Feb 2012 23:43:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754697Ab2BTWnT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Feb 2012 17:43:19 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62314 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754593Ab2BTWnS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Feb 2012 17:43:18 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4425C6119;
	Mon, 20 Feb 2012 17:43:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=y6A63+zDIim2B/LF4x4PZe+qhGc=; b=ES/thJ
	otG1W4jxSCcgy6uYc6ZY3ztofsPc8ThXgz0S9j7J6CIX9YsYmGp1rY0N/z53fFf2
	dvAgug3czHi5+6qwwnmldEifZzjqdOhV5MJ9jPOI+vLJFQ3rER1xEcaOrCSfhh/j
	srP+fjR+iydfiWyK+/n36luZord4krWNMFwu8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GcEMPFOXtW4c8PgQUg+Q/FDcz0ZBU2q0
	Ka68ybI7mjHZM7KOyTL2fFFxOYnk9APqvgFs4sSSe+Wftf5Dt6p9XU2icT5IPPpX
	+KxwBY7tZyi5KhP8en3J/KHKiGZ12D5FVlWX6TJoPK0ow9HSjdeUrYCm+cpWABtx
	q+uAy2xqA/w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 39DC36118;
	Mon, 20 Feb 2012 17:43:17 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8EB0A6117; Mon, 20 Feb 2012
 17:43:16 -0500 (EST)
In-Reply-To: <1329772071-11301-1-git-send-email-johan@herland.net> (Johan
 Herland's message of "Mon, 20 Feb 2012 22:07:51 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4777E8BE-5C14-11E1-99CC-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191123>

Johan Herland <johan@herland.net> writes:

> Teach the pre-rebase sample hook to refuse rewriting commits on a branch
> that are present in that branch's @{upstream}. This is to prevent users
> from rewriting commits that have already been published.

If the user has configured an option to always create @{u} when creating a
branch from somewhere else, transplanting $n good commits from his master
that is forked from the shared master onto his maint would be done like
this:

	$ git checkout -b copy master
        $ git rebase -i --onto maint HEAD~$n

If these good commits have been published to 'master', because the
upstream of 'copy' is set to the local 'master', would the new mechanism
hinder this attempt to backport good fixes?  Perhaps it is safer to
trigger only when @{u} exists and it is not local?

But because you wanted to discuss more about the issues than the
implementation, let me think aloud a bit, reviewing what I usually do.

I keep things simpler by sticking to a very simple rule. I allow myself to
rebase only what is not yet in 'next', so the logic becomes a simple "am I
creating a new commit based on what is already in 'next'?"

During the course of integration testing with 'next', however, I often
find a topic or two that I have merged to it is less than ideal, and of
course, the whole point of doing integration testing with 'next' is to
find such problematic topics before pushing 'next' out.  I rewind 'next',
rebuild the problematic topics, and then rebuild 'next', and all of these
happen before 'next' is pushed out.  The step that rewinds 'next' that
acquired problematic versions of the topics makes the topics eligible for
rebase.

That would mean that a configuration variable "rebase.bottomLimit = next"
is sufficient to implement such a check for me.  No per-branch bottom is
needed, because everything is merged to 'next' and tested to see if they
do not need further rebases for fixing them up before they are published.

Perhaps "I mistakenly rebased something that I have already published" is
a mere symptom a bigger problem.  The issue may not be that we do not give
them a good tool to help them to be more careful with less effort on their
part before they rebase.  It may instead be that it is too easy to publish
branches that are not ready to be pushed out, and that is the real cause
of the "I realized I need to fix the topic and I fixed it, but I did not
realize that it was too late and I shouldn't have rebased" problem.

I wonder if it would be a more direct solution to the issue you are
raising to give them a good tool to help them to be more careful with less
effort on their part before they publish (not before they rebase).
