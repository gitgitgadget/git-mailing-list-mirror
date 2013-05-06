From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 10/9] revision.c: treat A...B merge bases as if manually specified
Date: Mon, 06 May 2013 14:24:11 -0700
Message-ID: <7vli7rpzt0.fsf@alter.siamese.dyndns.org>
References: <1367767977-14513-1-git-send-email-kevin@bracey.fi>
	<1367859096-25909-1-git-send-email-kevin@bracey.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
To: Kevin Bracey <kevin@bracey.fi>
X-From: git-owner@vger.kernel.org Mon May 06 23:24:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZStQ-0004Ut-4C
	for gcvg-git-2@plane.gmane.org; Mon, 06 May 2013 23:24:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758032Ab3EFVYP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 May 2013 17:24:15 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35103 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756915Ab3EFVYO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 May 2013 17:24:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E684C1C90D;
	Mon,  6 May 2013 21:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=irL2MYXlJxBD4Mv3x2MLJhF0f5s=; b=MclIrT
	J4elL8652omL+DcJWtkrwbRGKXfFJH5OIkUkngSyGJGNeJN1lUK1NY4nvuOrTYI2
	xcX0XPpe5tgLfGkRrT1fV4ChgWULRw28lOrVEYgSu8fCtDgbXaFx5shDbzW+LeJy
	QOHCfhpvzkfc7lvYbDnsFQat2xdpcl4nzj6a0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OmCo/ZaVEvFWLnBs4eaTEzk365FWJvBK
	FHXJzMozX1rDH14gRQ7xHSHcusDz3mfQHjKTHcwe+eCEfESTQ38YYbwUFYejQKhr
	3/2ZAhZ4Cuyw4akM1BSzvMQA7UoaWj26lOWjHmaQ9xKlWbnY4RbhWvK82EEm9mKG
	w2lMU+e40IQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DD0751C90A;
	Mon,  6 May 2013 21:24:13 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 56BC31C909;
	Mon,  6 May 2013 21:24:13 +0000 (UTC)
In-Reply-To: <1367859096-25909-1-git-send-email-kevin@bracey.fi> (Kevin
	Bracey's message of "Mon, 6 May 2013 19:51:36 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4C742938-B693-11E2-9D25-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223508>

Kevin Bracey <kevin@bracey.fi> writes:

> The documentation assures users that "A...B" is defined as 'r1 r2 --not
> $(git merge-base --all r1 r2)'. This isn't in fact quite true, because
> the calculated merge bases are not sent to add_rev_cmdline().

We want the commands to be able to tell which ones in revs->pending
and revs->commits were specified by the end user and how.  While I
think it makes sense to mark these negative merge bases with "These
came from the command line with A...B syntax", I am not sure if it
is the best way to do so in add_pending_commit_list().

By the way, why does this have anything to do with the history
traversal series in the first place?

When there is anythning marked UNINTERESTING on the rev->pending
before calling prepare_revision_walk(), you have a history with some
bottom boundaries, and when there isn't, your bottom boundaries are
root commits.  If you want to behave differently depending on how
the user gave us the revision range from the command line, e.g.
acting differently between "A ^B" and "B..A", cmdline is a good
place to learn the exact form, but at the history traversal level, I
do not think you should even care.  Why does the code even look at
the cmdline, and not rev->pending?
