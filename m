From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFD] Making "git push [--force/--delete]" safer?
Date: Wed, 03 Jul 2013 13:18:08 -0700
Message-ID: <7vbo6je6tb.fsf@alter.siamese.dyndns.org>
References: <7vfvvwk7ce.fsf@alter.siamese.dyndns.org>
	<CALKQrgenpqKUxOZ+p79NsaQD9M2-q4h93ZqN0oencVo-QZF=zg@mail.gmail.com>
	<CALKQrgdovWTd50LVDnNR+BhurWgSCKkhr88wCo01VZF3sd5PNg@mail.gmail.com>
	<7vli5ogh8r.fsf@alter.siamese.dyndns.org>
	<CALKQrge_REZKfds0T-owJOn2BvfLmHpk7yQeSog=yvofE_zKJQ@mail.gmail.com>
	<CAF5DW8++sc2VYmdJEjbD_ue_wtDFj21vcyFzNWU0M+rAm2X0sQ@mail.gmail.com>
	<7vr4ffe83n.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org
To: Jonathan del Strother <maillist@steelskies.com>
X-From: git-owner@vger.kernel.org Wed Jul 03 22:18:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UuTVJ-0006aa-K7
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jul 2013 22:18:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933216Ab3GCUSM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jul 2013 16:18:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34665 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932355Ab3GCUSL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jul 2013 16:18:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 714892DCF7;
	Wed,  3 Jul 2013 20:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tovAOa9TlQrNhowrDwhlWdaxCpY=; b=uhT8fm
	wUfAhLbUYARj84UHy2204wkOxR9/hdSfaRCONYLFeMsGxGMqH5gV5/HrWLGLn8y7
	e/RFFtnfY9Y7zw8peBtBgE988MZ8fTGFg3pKynWwYVIQzsQolbq0rCZcXHjgXRPF
	gts+nR4V6UBk+iIOfXAMpgApiPVDleGZRO5U0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vPUfyugbTzf4CgjYCctZPPqoBMlZGYpG
	upVeids4R0FehzctGlSk5L1g7fZB8Qym67RPW8k3b1FrHxN0/7MYydpLpQ4VXlHS
	zsvxLrKSQ/Q1aAWIuOebFbr+uVZWojCZU9Z7r+zDpfWLSLoWixCt5hgOUrRjIo7Y
	tL7StGGxi70=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 648C32DCF6;
	Wed,  3 Jul 2013 20:18:10 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C42382DCEF;
	Wed,  3 Jul 2013 20:18:09 +0000 (UTC)
In-Reply-To: <7vr4ffe83n.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Wed, 03 Jul 2013 12:50:20 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: ADF35DCA-E41D-11E2-9EFE-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229521>

Junio C Hamano <gitster@pobox.com> writes:

> Jonathan del Strother <maillist@steelskies.com> writes:
>
>> I'm struggling to think of instances where I wouldn't want this
>> CAS-like behaviour.  Wouldn't it be better to make it the default when
>> pushing, and allowing the current behaviour with "git push
>> --blind-force" or something?
>
> Not until we run this in the wild for a while and the mechanism
> proves to be useful without being too cumbersome to some population.
>
> Then at a major version bump, we can start talking about enabling it
> by default, allowing people to selectively disable it.

If we enable this by default, we would need to be a lot more careful
designing what should happen when there is no remote-tracking branch
the corresponds to what we are updating/deleting.

The proposed behaviour so far is to fail, and that is justifiable
because "the user asked us to check, but did not say what to check
against, and we tried to check with a remote-tracking branch and
found none.  We cannot satisfy the user's request to check, hence we
fail".

Enabling the check by default will change the picture somewhat; that
justification no longer holds.

If you are pushing to more than one publishing branches of your own,
there is no reason to have remote-tracking branches for the
secondary locations, because you always push to all your publishing
repositories at the same time, and you only need to keep remote
tracking for one of them to remember what you pushed out.  Making a
push to secondaries fail in such a case is bad, and forcing the user
to disable the feature for each secondary remotes is unnice, too.
