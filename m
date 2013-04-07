From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] bundle: Accept prerequisites without commit messages
Date: Sun, 07 Apr 2013 10:21:33 -0700
Message-ID: <7va9pa5k9u.fsf@alter.siamese.dyndns.org>
References: <1365335596-19917-1-git-send-email-git@cryptocrack.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Lukas Fleischer <git@cryptocrack.de>
X-From: git-owner@vger.kernel.org Sun Apr 07 19:21:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOtHr-0007lk-9o
	for gcvg-git-2@plane.gmane.org; Sun, 07 Apr 2013 19:21:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934127Ab3DGRVh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Apr 2013 13:21:37 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53501 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934064Ab3DGRVg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Apr 2013 13:21:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C0A5513091;
	Sun,  7 Apr 2013 17:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=yBF6fNtjzSrjA3RpcYaeVi1tfuw=; b=JQ1MHR
	aOHXRvA/SW4kynVu19Z1ipNByZvcwty26BHu9Vxp/nvus8Ib9xhGHgdWJXV1Dk1+
	+GrMmEfiFDl6LYmgmr8NtIESfbPQsOkS4VZGbgf5X+2C1aR93kjNKoL0llt1mWU8
	LGw3eSnUtGKS3Cea6Yo/LQVu1PhxtK/V8l0wk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; q=dns; s=sasl; b=U0jZSXl+RXLl7OzfHZ9wUtl/hlJHZRDF
	IM0fu7bbYDsxymd70pq4uDbrB7SO06EwmZYovo3FdjX0RxNhT1EhcZ5YprAzF1Vr
	qY1OWEun1IPh23+q7nIw4rnt5WMLzFmGdoMIgMPBxCz8B+F7QgeoaipnTyYvdGER
	Mv9k69M0XZE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B870C13090;
	Sun,  7 Apr 2013 17:21:35 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 265F41308B; Sun,  7 Apr
 2013 17:21:35 +0000 (UTC)
In-Reply-To: <1365335596-19917-1-git-send-email-git@cryptocrack.de> (Lukas
 Fleischer's message of "Sun, 7 Apr 2013 13:53:15 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 991C43AE-9FA7-11E2-BB36-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220331>

Lukas Fleischer <git@cryptocrack.de> writes:

> While explicitly stating that the commit message in a prerequisite
> line is optional, 

Good spotting.  What e9ee84cf28b6 (bundle: allowing to read from an
unseekable fd, 2011-10-13) meant to say was the SP was optional but
we want to allow a tip bundled to have a commit without any commit
log message (hence making it "optional"), and the check you are
looking at does try to enforce.  What was buggy was that the
comparison did not take into account that the codepath earlier
called rtrim() on it, stripping "-<object name>SP<eol>" of the
trailing SP it wants to look for.

As to the order of comparison to match the order on the number line,
e.g. write "0 < something" or "negative < 0" to let readers more
easily visualize in what relation on the number line the quantity of
each side of the comparison stands, here is a reference to a long
and amusing thread:

  http://thread.gmane.org/gmane.comp.version-control.git/3903/focus=3912

We never had any official guideline on which to use.  A patch that
changes an existing "b > a" to "a < b" (this directoin only) because
of the above thread is _not_ "a patch to fix coding style", and is
very much unwelcome.

Similarly, a patch that changes an existing "a < b" to "b > a" (or
vice versa) only because the author thinks it is easier to read is
not welcomed.

A switch done as a part of other meaningful rewrite is not a big
enough deal to make a fuss over, though.  Your patch falls into this
category, I think.
