From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] commit: make it work with status.short
Date: Mon, 24 Jun 2013 08:17:42 -0700
Message-ID: <7v38s7czc9.fsf@alter.siamese.dyndns.org>
References: <1372077912-18625-1-git-send-email-artagnon@gmail.com>
	<1372077912-18625-3-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 24 17:17:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ur8Wc-0003JM-MB
	for gcvg-git-2@plane.gmane.org; Mon, 24 Jun 2013 17:17:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751479Ab3FXPRq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Jun 2013 11:17:46 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43092 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750872Ab3FXPRp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jun 2013 11:17:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DCB472A06D;
	Mon, 24 Jun 2013 15:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yhCr/rbEj6E4RvUhDy8vERWO69M=; b=C59K8o
	P9E8esrcudjkV81qs+4VxqhEcr0SGX9R1GpdOUzSYDYL/NWJ0zL8uxMvkfokAUhB
	+64KBS1AffkgTtn7kZX/f0F3K+zbRDmhfcIQvaUE8iC+JaY97YJ5PgvxJAWMlaXI
	rF8NGhR0dU9DEjc7Aeczqmkgh5PPvqLbQwaj0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=T9Y04PiUf7rfkQh10Bn5BJW0/RTIoICP
	A/VDikrpdOetVXnJSuNZ7PCEhF/tajJCy/oZB5JUFXbqI/72rZKbh/pVn0GTrLtM
	dei6LDZAEVCfsSaZ1tyf/Xpm4/HgyyzOHCeFzEOy50cgGXzY2x4OMTeGhHWBVgTy
	E6Zg97IAgx4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D3FF02A06C;
	Mon, 24 Jun 2013 15:17:44 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 459C72A06B;
	Mon, 24 Jun 2013 15:17:44 +0000 (UTC)
In-Reply-To: <1372077912-18625-3-git-send-email-artagnon@gmail.com> (Ramkumar
	Ramachandra's message of "Mon, 24 Jun 2013 18:15:12 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 382F7652-DCE1-11E2-8E8D-9B86C9BC06FA-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228821>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> 50e4f75 (status: introduce status.short to enable --short by default,
> 2013-06-11) introduced a regression in git commit; it is now impossible
> to commit with status.short set.
>
> This happens because commit internally runs run_status() to set
> s->commitable and determine whether or not there is something to
> commit.  The problem arises from the fact that only STATUS_FORMAT_NONE
> (or STATUS_FORMAT_LONG) is equipped to set s->commitable.
> 7c9f7038 (commit: support alternate status formats, 2009-09-05) clearly
> states that --short and --porcelain imply --dry-run and are therefore
> only intended for display purposes.
>
> The bigger problem is that it is impossible to differentiate between a
> status_format set by the command-line option parser versus that set by
> the config parser.  So these two are exactly equivalent:
>
>   $ git -c status.short=true commit
>   $ git commit --short

Thanks for a report.  I think the analysis above is correct, and if
we want to ignore status.short but still want to honor --short from
the command line, your patch is a way to go.

As I said in the other message, I'll revert the merge of the topic
branch from 'master' for now, and queue this on top of the topic so
that we will have the preventive fix when the topic is in a better
shape for the other possible breakage on the "--branch" thing.

Having said that, even before the merge of that status.short
(e.g. v1.8.3), "git commit --short" did not work and that was
deliberate only because "git commit --dry-run" has long been an
equivalent for "git status", "--short/-z/--porcelain" were options
for "status", and therefore these options were made to imply
"--dry-run".

I have to wonder if that is a sane thing in the first place, now
that it has been quite a while since "git status" has become
different from "git commit --dry-run".

That is, "git commit --short/--porcelain/-z" has these three
possibilities:

 - work (ignoring these options);

 - work (showing the template in some kind of "short" format); or

 - error out (clearly indicating that we did *not* make a commit).

and what we currently do is closest to the last (but we do not say
we did not create a commit).  In the longer term for Git 2.0, we may
want to change it to do one of the former two.
