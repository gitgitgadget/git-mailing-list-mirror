From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] test-lib: '--run' to run only specific tests
Date: Tue, 06 May 2014 14:02:31 -0700
Message-ID: <xmqqfvkmei3c.fsf@gitster.dls.corp.google.com>
References: <1398154767-1276-1-git-send-email-ilya.bobyr@gmail.com>
	<1398851444-2492-1-git-send-email-ilya.bobyr@gmail.com>
	<1398851444-2492-4-git-send-email-ilya.bobyr@gmail.com>
	<xmqqk39yeiic.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Thomas Rast <trast@inf.ethz.ch>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Ilya Bobyr <ilya.bobyr@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 06 23:10:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WhmVd-0005ps-Re
	for gcvg-git-2@plane.gmane.org; Tue, 06 May 2014 23:02:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755361AbaEFVCi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 May 2014 17:02:38 -0400
Received: from smtp.pobox.com ([208.72.237.35]:52311 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751924AbaEFVCh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 May 2014 17:02:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CBBFC155A4;
	Tue,  6 May 2014 17:02:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=v+WD9AxcqYjFyLfoXJ53SjCEgB0=; b=g4JR6n
	/RYuAdCVWlcrSy+efST1H6KZfI5tQ//S1X+BH+BEYkjhC4JR1Ht2vh5EE/EuNWRA
	HMSX7SU+tbt1JIcu/pjQ5e2WI4YVIdRTF7Ojj0LjXS1VSkkjfAdM3m37ZbeiLilR
	n99T0hAl0lfLTB8aXOBAwHTJ6x2PYNwU/gvng=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QzZpzA7bWH0QAa+VgbfTz5HJUfC7jHfA
	rCoOOs8/FI++Mq4TNZXVUgVcYC4b74jGDkiIFKO9L9Rs1anVN7iJy4+O0OOcgEDo
	Uaf+xlXVqlorls93gFIQr1qCvYONbMh3LnYdBo6vKcM+FFRepiTNBzDc31RPkdZN
	msSguVch6SE=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C1ABC155A3;
	Tue,  6 May 2014 17:02:36 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 0006C1559F;
	Tue,  6 May 2014 17:02:33 -0400 (EDT)
In-Reply-To: <xmqqk39yeiic.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Tue, 06 May 2014 13:53:31 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: BEC14366-D561-11E3-8B58-9CEB01674E00-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248252>

Junio C Hamano <gitster@pobox.com> writes:

> The need to explain better with longer description will reduce the
> likelyhood that the feature is understood and correctly used.  When
> you can write "1-2,4-", why accept "1-4 !3" and force yourself to
> explain to people why that is different from "!3 1-4"?

By the way, having said all that, I would understand if the result
is made not depend on the order of selectors given to the option.

That is:

 - Find all the positive ones and form the "positive" set; if there is
   no positive ones, then make the "positive" set include everything.

 - Find all the negative ones and form a "negative" set.  The
   "negative" set can be an empty set if there is no negative
   selector.

 - Subtract the "negative" set from the "positive" set, and run only
   the tests in the resulting set.

Then "1-4 !3" and "!3 1-4" would mean the same thing.  Explanation
of the semantics would be far simpler than "we do it from left to
right".

One reason why the orders shouldn't matter is, unlike the "print
dialog" case, we won't run tests out of order when given "1 4 3 2".
We will still run "1-4".  So it would be natural for the readers to
expect that the orders they give selectors would not matter.
