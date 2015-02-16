From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] request-pull: do something if $3 is passed
Date: Mon, 16 Feb 2015 11:47:55 -0800
Message-ID: <xmqqiof163kk.fsf@gitster.dls.corp.google.com>
References: <1424110568-29479-1-git-send-email-bonzini@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Mon Feb 16 20:48:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YNReE-0008OW-9D
	for gcvg-git-2@plane.gmane.org; Mon, 16 Feb 2015 20:48:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751667AbbBPTr6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2015 14:47:58 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:61382 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751439AbbBPTr5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2015 14:47:57 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DB30D37197;
	Mon, 16 Feb 2015 14:47:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=H4uJiWRJVurdhj6DaNNYL4j9UHQ=; b=pVJaad
	cZZ66gOozFiSlF/edMIh3pVR0wAbPZcoWCdTrEndnRJG+SVDYRj4eUO91IFJCi7r
	D6qTGUF0wasFV9esURV2NY9Ammt/DyTG/OCriB8YaFCrclVKdoYUQ4x+8WxzQUcs
	jVtC7xpB9MOD9ihIIoqAecUnkMr3wWgHHISd0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RYuD3VbYAROt7vH74bwujJjDeqY9Fjox
	r1mE3OD4718lqBVw1MUeRJZaGkR7fn9KdSphsrS5JHCFPGAXhJsUedufiqvwpD2D
	FsEteuIAMWqCM/9HFWt6Rul23Q8L26kUkOZfVRngMryWlPVzqTL9Knf25yUu68cF
	QTnaJ+uuVmo=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D036037196;
	Mon, 16 Feb 2015 14:47:56 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5674D37193;
	Mon, 16 Feb 2015 14:47:56 -0500 (EST)
In-Reply-To: <1424110568-29479-1-git-send-email-bonzini@gnu.org> (Paolo
	Bonzini's message of "Mon, 16 Feb 2015 19:16:05 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B402C6E0-B614-11E4-BA12-A4119F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263915>

Paolo Bonzini <bonzini@gnu.org> writes:

> From: Paolo Bonzini <pbonzini@redhat.com>
>
> After updating to git 2.3.0, "git request-pull" is stubbornly complaining
> that I lack a matching tag on the remote side unless I pass the third
> argument.  But I did prepare and push a signed tag.

A few questions.

 - what old version did you update from?  I think the "correct
   over-eager dwimming" change was from v2.0 days.

 - what exactly do you mean by "stubbornly complain"?  I think we
   say something about HEAD not matching the HEAD over there, which
   I think is bogus (we should instead say things about the branch
   you are on and the branch over there with the same name) and is
   worth fixing.

> This looks like a bug to me; when $3 is not passed git will try to use
> "HEAD" as the default but it cannot be resolved to a tag, neither locally
> (patch 2) nor remotely (patch 3).

An earlier 024d34cb (request-pull: more strictly match local/remote
branches, 2014-01-22) deliberately disabled over-eager DWIMming when
the $3-rd argument _is_ given.  It didn't say much about what should
happen when it is missing.

I am torn about your changes.

One part of me feel that not giving the $3-rd argument should behave
the same way as if you gave the name of the current branch as the
$3-rd argument.  DWIMming from local HEAD to a local branch name
(e.g. 'master') may be OK and necessary (I already said it is worth
fixing above).  But we should not be resurrecting the over-eager
DWIMming from that point---not from a local branch name to a tag
that points at it, which was what 024d34cb wanted to forbid.

On the other hand, I can also understand (not necessarily agree
with) a view that not giving the $3-rd argument is an explicit
user's wish to us to DWIM as much as we want.  But again, that
directly contradicts with the desire of 024d34cb.

So,... I dunno.

I'd be more comfortable if 2/3 and 3/3 were replaced with something
like "do not ask HEAD to be pulled, but always require a specific
ref to be pulled", by dereferencing HEAD locally to a branch name,
and behave as if that name was given to $3 from the command line,
without doing any other changes (like turning that branch name that
was implicitly given into a tag that happens to point at it).

Thanks.

>
> Patch 1 is a simple testcase fix.
>
> Paolo
>
> Paolo Bonzini (3):
>   request-pull: fix expected format in tests
>   request-pull: use "git tag --points-at" to detect local tags
>   request-pull: find matching tag or branch name on remote side
>
>  git-request-pull.sh     | 15 +++++++++++----
>  t/t5150-request-pull.sh |  5 ++---
>  2 files changed, 13 insertions(+), 7 deletions(-)
