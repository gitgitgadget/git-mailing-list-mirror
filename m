From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 28/51] refs.c: rename ref_array -> ref_dir
Date: Mon, 12 Dec 2011 22:37:02 -0800
Message-ID: <7vk461vuy9.fsf@alter.siamese.dyndns.org>
References: <1323668338-1764-1-git-send-email-mhagger@alum.mit.edu>
 <1323668338-1764-29-git-send-email-mhagger@alum.mit.edu>
 <7v7h21xps9.fsf@alter.siamese.dyndns.org> <4EE6E61F.8080405@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Dec 13 07:37:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RaLzD-0003VC-11
	for gcvg-git-2@lo.gmane.org; Tue, 13 Dec 2011 07:37:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752093Ab1LMGhH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Dec 2011 01:37:07 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63266 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751372Ab1LMGhF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Dec 2011 01:37:05 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0F724382F;
	Tue, 13 Dec 2011 01:37:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cosr6TX0xi8zbJkFQCaQHn+8qhc=; b=V48exo
	pdD9Kw8f3a0ve350MJzC7KXU1Y1iuT5QbhtlO9hVUyqg/oW2jFkYgEjFj+qoNT+a
	ouczoD9aSqcokAVA/WkgHwLXGIIfQyYfAWaw5kPc90wZOAIJsJ/nO4sFL7lSmC90
	LQ8KNiEvQbARuOT6y7ltyAsqcywWwNUAN5A7M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=m+Pgp6bpYG90eOr73hfRY3Pjyml6/yZt
	ZoRFNCB7n/owHT1eKcVUu4Dxp5R3q8mdQ8aQgZeiQNVzlwlYh4yRNqcjxz6KxaKv
	y+Q2OlYgUtfNpWX7jw54RxuQOQ2lpsOmatoaDRddNKMa5EiwV5Ll3cXpKbru0Nwm
	Bt9ZtagIwlI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 064C7382E;
	Tue, 13 Dec 2011 01:37:04 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 85848382D; Tue, 13 Dec 2011
 01:37:03 -0500 (EST)
In-Reply-To: <4EE6E61F.8080405@alum.mit.edu> (Michael Haggerty's message of
 "Tue, 13 Dec 2011 06:43:59 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DE5BCB66-2554-11E1-B32F-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187007>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> Apropos testing, it is unsettling that our test suite doesn't show any
> failures after my changes.  The dir entries in extra_refs are now always
> sorted and de-duped when do_for_each_ref() is called.  Could it be that
> duplicate ".have" references never come up in the test suite?  It sounds
> like an important code path is not being tested.  In particular, I won't
> be able to test whether my fix works :-/

I doubt anybody thought of using more than one --reference while cloning
or having more than one entry in $GIT_DIR/objects/info/alternates in a
repository that is being pushed into, even though we might have tests for
simpler single --reference and single alternate cases.

As to the order of the changes, my gut feeling is that it would make it
harder to debug your series to delay the removal of "extra_ref" hackery,
as it would be a corner case that your "hierarchical" structure never has
to worry about in the end result.

Another possibility is to keep the extra_ref interface in refs.c, without
any of your changes (i.e. keep it just as a flat list, with the original
interface to append to it without any dedup and other fancy features) and
also keep the special casing of it in for_each_ref(). AFAIK, that is the
only iterator that should care about the extra refs. Thinking about it a
bit more, removal of add_extra_ref() API may be unnecessarily complex with
no real gain. For example, extra refs added in builtin/clone.c is used by
builtin/fetch-pack.c, meaning that the codepath that discovers and
remembers these extra history anchor points and the codepath that uses
them while walking the history are not localized and we would need some
sort of "extra ref API" anyway. I am leaning towards this option.
