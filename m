From: Junio C Hamano <gitster@pobox.com>
Subject: Re: default behaviour for `gitmerge` (no arguments)
Date: Mon, 11 Jan 2010 11:43:40 -0800
Message-ID: <7v7hrojukz.fsf@alter.siamese.dyndns.org>
References: <loom.20100111T185144-655@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Gareth Adams <gareth.adams@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 11 20:44:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUQB9-0006dR-93
	for gcvg-git-2@lo.gmane.org; Mon, 11 Jan 2010 20:43:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753922Ab0AKTnt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2010 14:43:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753906Ab0AKTnt
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jan 2010 14:43:49 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:62171 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753898Ab0AKTnr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2010 14:43:47 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id F0C8D8FF17;
	Mon, 11 Jan 2010 14:43:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LDhqhNRPw5urTgkG0FPEEiXAPx4=; b=IOu1c2
	PhywpJdX7Hunq5hcQZN4MWqsS0NWXH3TD9d17XjleNKMlJ05J699iWmfh5iZ5zay
	lfi2McV2yY4ArjSbnQrkuzDsVKf1aikWuTfYOfX94rydfSc8i/ci6SG6O+WbUd2d
	h25tOG+wiuQhfczMjwN6IHbWbQwxVi9X4ox/0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iB5tKiz54M8VTdRHxoQfQz+yMn9df8l/
	j4qbEf4nyaDxZLkorpHn1weKYZTX2OGMYMxQnptuFtlPCAw2xtWnAT0krdflfkK9
	QRyog+8tNCeIC6rbsld+3JDBSQJZlL0JM517bzWd67b1gYcwi8MeTGzJpBiwdnpq
	s+CBKOQW50U=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C63E98FF16;
	Mon, 11 Jan 2010 14:43:44 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1C1818FF14; Mon, 11 Jan
 2010 14:43:41 -0500 (EST)
In-Reply-To: <loom.20100111T185144-655@post.gmane.org> (Gareth Adams's
 message of "Mon\, 11 Jan 2010 18\:49\:38 +0000 \(UTC\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A0E37024-FEE9-11DE-8CF4-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136659>

Gareth Adams <gareth.adams@gmail.com> writes:

> Unfortunately my other option is:
>
>     git pull; ...; git checkout otherbranch; git merge myremote/otherbranch
>
> which is annoying extra typing.

Replace 'pull' with 'fetch' and a bit more regular pattern would emerge.

The code indeed knows (as you can see "git pull" can figure it out) what
other ref the current branch is configured to merge with by default.
There is even a plumbing to do this for script writers.

    $ git for-each-ref --format='%(upstream)' $(git symbolic-ref HEAD)

We can teach this short-hand to "git merge", perhaps:

    $ git merge --default

But "no argument" cannot be the short-hand, because...

> 1) At the moment, `git merge` does nothing. Except mock me for not giving it a
> command in a format it recognises. This change wouldn't have any effect that
> would cause anyone a problem

... except for people who uses a script that does

    commits=
    while some condition
    do
    	commit=$(find some other commit that should be merged)
        commits="$commits$commit "
    done
    git merge $commits

and expect the last step will fail without doing any damage when the loop
finds no new developments.  "no argument means --default" will break their
scripts.
