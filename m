From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/6] Fix checkout-dash to work with rebase
Date: Sun, 16 Jun 2013 21:52:26 -0700
Message-ID: <7v1u81ibjp.fsf@alter.siamese.dyndns.org>
References: <1371372316-16059-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 17 06:52:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UoRQf-0001s8-DU
	for gcvg-git-2@plane.gmane.org; Mon, 17 Jun 2013 06:52:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752115Ab3FQEw3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Jun 2013 00:52:29 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48278 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750867Ab3FQEw2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Jun 2013 00:52:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6110322B8F;
	Mon, 17 Jun 2013 04:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=p5FSNeB0pg2K/xNwTmiJwaWCe7A=; b=Sl55z3
	H8n3K8Oy8gl5aQKUoVCIex9ayuZwZ5PEPQYKUKf0Me1cn08t5V71azYuGdgvJTif
	PlGzlfONlTsu9lKarKK5J6z26dmU3jZfoaTJ9EX1vzUTr0SmpWf7cG+G1PMzLnda
	xjMS6WlOP4BLKFHRMdvSX79DuwYeQran6AtL4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tw9YnvS1nk/hhdeAkKXV+YwTa9UnNHub
	1qe5ju3+n3I7MDmOLXfOwmNiBjM8fnGyHambmcEM6Zs7jy5aC1GB3ssuHgihg9Oa
	fVVXJmIYESiwIibPQ36/fZ9AM+IPw0WiXxgdJV4snC0zzlvJj3uZBR44wSz+GMaA
	4IWF+S07Lzk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5768522B8D;
	Mon, 17 Jun 2013 04:52:28 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AF9F022B8C;
	Mon, 17 Jun 2013 04:52:27 +0000 (UTC)
In-Reply-To: <1371372316-16059-1-git-send-email-artagnon@gmail.com> (Ramkumar
	Ramachandra's message of "Sun, 16 Jun 2013 14:15:10 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B5ADD11A-D709-11E2-8CBC-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228042>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> So after extensive discussions with Junio, I have updated [5/6] to
> special-case rebase and rebase -i instead of dropping the "HEAD
> detached from" message altogether.  Also, [1/6] includes two more
> tests, as suggested by Junio.
>
> Junio: The message is now the constant "rebase in progress; onto
> $ONTO".

That message is better than I was anticipating.

I was actually assuming that you would leave them as they are
i.e. "# HEAD detached at xxx", as we agreed that we will see them
improved anyway by the other topic.

I am still puzzled to see that the change to checkout comes at the
very end.  With "do not depend on rebase reflog messages" done
before the "checkout: respect reflog-action", I was hoping that we
can have changes to the actual reflog message made to rebase (patch
2 and 3) can be done at the very end.  Was I missing something else?

In other words, the order I was anticipating to see after the
discussion (this is different from saying "A series that is not
ordered like this is unacceptable") was:

>   wt-status: remove unused field in grab_1st_switch_cbdata

This is an unrelated clean-up, and can be done before anything else.

>   t/checkout-last: checkout - doesn't work after rebase

This spells out what we want to happen at the end and marks the
current breakage.

>   status: do not depend on rebase reflog messages

This compensates for fallouts from the next change.

>   checkout: respect GIT_REFLOG_ACTION

And this is the fix, the most important step.

>   rebase: prepare to write reflog message for checkout
>   rebase -i: prepare to write reflog message for checkout

And these are icing on the cake, but that cannot be done before
status is fixed.
