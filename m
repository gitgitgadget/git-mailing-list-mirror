From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] symbolic-ref: check format of given reference
Date: Mon, 18 Jun 2012 10:10:14 -0700
Message-ID: <7vipeo4kcp.fsf@alter.siamese.dyndns.org>
References: <4FDE3D7D.4090502@elegosoft.com>
 <7vaa017j51.fsf@alter.siamese.dyndns.org> <4FDF18E5.7020908@elegosoft.com>
 <7vr4tc4lsc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>, Michael Haggerty <mhagger@alum.mit.edu>
To: Michael Schubert <mschub@elegosoft.com>
X-From: git-owner@vger.kernel.org Mon Jun 18 19:10:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SgfT5-0000tk-Ub
	for gcvg-git-2@plane.gmane.org; Mon, 18 Jun 2012 19:10:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752143Ab2FRRKS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jun 2012 13:10:18 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46558 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750871Ab2FRRKR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jun 2012 13:10:17 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 638867EEB;
	Mon, 18 Jun 2012 13:10:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vqjfjTn2ctL9uVM3qeT026e3QBA=; b=sCjKAG
	OKqys8hSCgEkT5njeNUTF603X8VEsChzuaae64OkU5ixe4SXEYi2nQj6z8Y2nNT2
	x8C89Z0j3r1/WVNon8ApJPF6tCJzGkUtCr6YYnqZAK4Io1oFjkJQLbf21IOF6gn6
	qNGrWMLpWYmXb4vMmw5abUIcY1zlUBvjb62Ps=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TGjOOAhcqTtREnmFE/kE9PqOBEU++t5n
	nGGmiVV/cVT7F5qem52cLIUwa9YNCLZUUJ2ZNTpychGtAX2yQBehDzfTMMm9IhYo
	F9nXE7bM1twTXhc9c8iUQvOHIs6vrpHlJlNFszzA7R+v4arNLHmk4Y/RWoc9ocMk
	9EjTQZ0ouMY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5B14E7EEA;
	Mon, 18 Jun 2012 13:10:16 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E4C277EE9; Mon, 18 Jun 2012
 13:10:15 -0400 (EDT)
In-Reply-To: <7vr4tc4lsc.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 18 Jun 2012 09:39:15 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 793B8E9E-B968-11E1-918A-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200146>

Junio C Hamano <gitster@pobox.com> writes:

> From: Michael Schubert <mschub@elegosoft.com>
> Date: Sun, 17 Jun 2012 22:26:37 +0200
> Subject: [PATCH] symbolic-ref: check format of given reference
>
> Currently, it's possible to update HEAD with a nonsense reference since
> no strict validation is performed. Example:
>
> 	$ git symbolic-ref HEAD 'refs/heads/master
>     >
>     >
>     > '

It would be nice to add a new test or two to t1401.  1401.3 was
already trying to catch a malformed reference with this test:

	test_must_fail git symbolic-ref HEAD foo

and it did trigger thanks to the prefixcmp(argv[1], "refs/") test we
already have.  Probably something like

	git symbolic-ref HEAD "refs/heads/.foo"
	git symbolic-ref HEAD "refs/heads/-foo"

would be a good start.

To make the latter _correctly_ work requires a bit of work, though.
We should make sure all the check_refname_format() callers pass the
full path to a ref, get rid of ALLOW_ONELEVEL, and redo commits like
6348624 (disallow branch names that start with a hyphen, 2010-09-14)
and 4f0accd (tag: disallow '-' as tag name, 2011-05-10).

For that matter, shouldn't symbolic-ref be forbidden to point
outside refs/heads/, not just restricted in refs/ like the current
code does?
