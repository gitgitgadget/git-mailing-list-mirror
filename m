From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] learn to pick/revert into unborn branch
Date: Sat, 22 Dec 2012 19:24:58 -0800
Message-ID: <7vr4mhpi0l.fsf@alter.siamese.dyndns.org>
References: <1356117013-20613-1-git-send-email-martinvonz@gmail.com>
 <1356117013-20613-2-git-send-email-martinvonz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Martin von Zweigbergk <martinvonz@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 23 04:25:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TmcBt-00025d-6t
	for gcvg-git-2@plane.gmane.org; Sun, 23 Dec 2012 04:25:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752473Ab2LWDZE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Dec 2012 22:25:04 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35576 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752369Ab2LWDZB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Dec 2012 22:25:01 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 69856A94C;
	Sat, 22 Dec 2012 22:25:00 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1/ebfmuj4DIuHdZ2qyxkc5RhZ34=; b=fJzcZ9
	IOCQckr+Tie092VL6hbnhph5GGmvqWNG6PeNfGJGKRCVB4VZ3pEqPQgQOlGYsDaA
	yMLbXKMw0l8m0mWoBF7TlHDGB4fxZ31c06Ps8axFymAGT3pP7cNy9Qm2z6xeLcfW
	5AGouYsgs72o5MzRISTRo7Y/3jN9KJmTADyXA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iJZRaZ5/hxUu5UKU1inNkPN8zgA2OUG7
	FXBUeV0SztUL3TK/tS3rQ8RXQ5QpqAgXuRs7XVLrE1ACl5p0aHSvwC21H3nBUpi3
	QiyS3UxzWaNHC/M1O2gB1qXmziZWko1vQwT8P0V8Dx+8lXtq198xwQBQK39F1xyv
	97pMUE94dgU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 56486A94B;
	Sat, 22 Dec 2012 22:25:00 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A76D6A948; Sat, 22 Dec 2012
 22:24:59 -0500 (EST)
In-Reply-To: <1356117013-20613-2-git-send-email-martinvonz@gmail.com> (Martin
 von Zweigbergk's message of "Fri, 21 Dec 2012 11:10:11 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 54E73562-4CB0-11E2-ABAB-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212078>

Martin von Zweigbergk <martinvonz@gmail.com> writes:

>>From the user's point of view, it seems natural to think that
> cherry-picking into an unborn branch should work, so make it work,
> with or without --ff.

I actually am having a hard time imagining how that could ever be
natural.

When you are on an unborn branch, you may have some files in your
working tree, and some of them may even be registered to the index,
but the index is merely for your convenience to create your first
commit, and as far as the history is concered, it does not matter.

By definition you do not have any history in such a state.  What
does it even mean to "cherry-pick" another commit, especially
without the --no-commit option?  The resulting commit will carry the
message taken from the original commit, but does what it says match
what you have done?

I can understand that it may sometimes make sense to do

  $ git show --diff-filter=A $that_commit | git apply

as a way to further update the uncommitted state you have in the
working tree, so I can sort of buy that --no-commit case might make
some sense (but if you make a commit after "cherry-pick --no-commit",
you still get the log message from that commit, which does not
explain the other things you have in your working tree) in a limited
situation.

It seems to me that the only case that may make sense is to grab the
contents from an existing tree, which might be better served with

  $ git checkout $that_commit -- $these_paths_I_am_interested_in

> Cherry-picking anything other than a commit that only adds files, will
> naturally result in conflicts. Similarly, revert also works, but will
> result in conflicts unless the specified revision only deletes files.

You may be able to make it "work" for some definition of "work", but
I am not sure how useful it is.

Puzzled...
