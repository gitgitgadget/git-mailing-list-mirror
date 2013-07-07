From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] name-rev: strip trailing ^0 in when --name-only
Date: Sun, 07 Jul 2013 11:16:49 -0700
Message-ID: <7vd2qu44mm.fsf@alter.siamese.dyndns.org>
References: <1373200996-9753-1-git-send-email-artagnon@gmail.com>
	<1373200996-9753-3-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 07 20:16:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UvtW4-00063h-Dg
	for gcvg-git-2@plane.gmane.org; Sun, 07 Jul 2013 20:16:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752911Ab3GGSQw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jul 2013 14:16:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34987 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752358Ab3GGSQv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jul 2013 14:16:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7D4D72EE5E;
	Sun,  7 Jul 2013 18:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rTj7h1SXlOba8sSO6Fmzien0btU=; b=SHNULB
	9jVg4rJNZtSH3OhisuYFywBfu9WyKhI8gXixIQW3NFFIfIwmZ4WKe/u0vEFKHqbQ
	lhoEnpoPpTwkZfWH0qzEedNPKAmRtKse6dsLMt6KQJ4tyGr+NwqUQlDkVFNNxsSC
	wX+a1bbZzMmcBB8yaW15lEyfSTjllNkDCUUKs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AieKCr1D+OQ6rWceMa9CO0S/5kQAWmyK
	7gG2T3y5saYyFmT8xb0rJEzjBGbVUTxFloBBqlJZQclgT4e9ABjd2hBsZ7fxB9bD
	a3KiiEdsylbNOG1b6+s8kgTqA6yMawF3hTtWsn6rb+EbVUB1DcaiAc+sNB+ZUtPs
	fQdoyaSLGv8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 747552EE5D;
	Sun,  7 Jul 2013 18:16:51 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D74C72EE5C;
	Sun,  7 Jul 2013 18:16:50 +0000 (UTC)
In-Reply-To: <1373200996-9753-3-git-send-email-artagnon@gmail.com> (Ramkumar
	Ramachandra's message of "Sun, 7 Jul 2013 18:13:15 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6506BEA6-E731-11E2-AE66-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229792>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> 236157 (Teach git-describe how to run name-rev, 2007-05-21) introduced
> `git name-rev --name-only`, with the intent of using it to implement
> `git describe --contains`.  According to the message, one of the primary
> objectives of --name-only was to make the output of name-rev match that
> of describe.
>
>   $ git describe --contains --all master
>   master
>
>   $ git describe --contains --all master~1
>   master~1
>
>   $ git describe --contains --all v1.8.3~1
>   v1.8.3~1
>
>   $ git describe --contains --all v1.8.3
>   v1.8.3^0

WRT "describe --contains", I do agree that both of these

    $ git describe $(git rev-parse v1.8.3^0)
    $ git describe --contains $(git rev-parse v1.8.3^0)
        
should just say "v1.8.3" without ~0/^0/~0~0~0 etc. and the last
example you showed will be improved by dropping ^0 at the end.

However.

I was a bit bothered by the description talking _only_ about
describe, but the actual change is to modify what name-rev gives its
direct users as well.  And that made me realize that the patch
itself has an undesirable side effect.

"describe" is _only_ about commit history graph, so in its context
v1.8.3 means the same thing as v1.8.3^0 (we never want to get a tag;
we always want a commit).  But I do not think "name-rev" is limited
to commits, in the sense that you would see this:

    $ git rev-parse v1.8.3 v1.8.3^0 | git name-rev --stdin
    8af06057d0c31a24e8737ae846ac2e116e8bafb9
    edca4152560522a431a51fc0a06147fc680b5b18 (tags/v1.8.3^0)

The second object is _not_ v1.8.3 but is v1.8.3^0 in the context of
name-rev, whose purpose is to give you a string you can feed
"rev-parse" and get the object name back.  "rev-parse v1.8.3" will
not give you the commit object name, so you need to keep "^0".
