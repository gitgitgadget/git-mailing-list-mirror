From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH] Move git-dir for submodules
Date: Thu, 21 Jul 2011 16:37:52 -0700
Message-ID: <7vr55jyzlb.fsf@alter.siamese.dyndns.org>
References: <1311267139-14658-1-git-send-email-iveqy@iveqy.com>
 <7vhb6f1ipp.fsf@alter.siamese.dyndns.org> <4E289CDA.20209@cisco.com>
 <4E289F42.4040708@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Fredrik Gustafsson <iveqy@iveqy.com>, git@vger.kernel.org,
	jens.lehmann@web.de, hvoigt@hvoigt.net
To: Phil Hord <hordp@cisco.com>
X-From: git-owner@vger.kernel.org Fri Jul 22 01:38:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qk2of-0002jc-3Z
	for gcvg-git-2@lo.gmane.org; Fri, 22 Jul 2011 01:38:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752966Ab1GUXh7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jul 2011 19:37:59 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36268 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751941Ab1GUXh6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jul 2011 19:37:58 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6423C485E;
	Thu, 21 Jul 2011 19:37:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zGJcOvovZBkYr0lt+kmfTKBT5IY=; b=o1NHTY
	6VtL2xs9P+IvWWBkcG71j7T0XvU+7d0Z+rDx/XpEPLY6oCu0qkLjJSN545uwDSP6
	WVMlQLABTkG7b5XfZ5JikqPZf7P4p3pRQnlpQaZ9jUFqyQ+Mg5xWfIY5pTGvRM9E
	ijqOyE3p2veezrocvd0auu1rZSebcbkuHaQ9Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WaGhsXTs8Io5seEivh9xCoKtIUl6rwWZ
	vucJGE2YRT/n8eD4qc6ddJvCuIJ4tZ0PQozaMbmB4QIDRu11qb0SDzwQS8k5LLMS
	4wWLwweL8HWyjQyM8AoVZwOzXFnrslf6q1ms+ExaKXvQ4uJlVx+fIEvZWKT1Y7VO
	nCIAe+FpU4o=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5BE9B485D;
	Thu, 21 Jul 2011 19:37:55 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BA5AF485C; Thu, 21 Jul 2011
 19:37:54 -0400 (EDT)
In-Reply-To: <4E289F42.4040708@cisco.com> (Phil Hord's message of "Thu, 21
 Jul 2011 17:50:58 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 75081B20-B3F2-11E0-9D26-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177631>

Phil Hord <hordp@cisco.com> writes:

> Now that you mention it, what happens if the submodule name changes in
> the history?  What happens if the submodule URL (and possibly the entire
> submodule contents) changes in the history?

The original idea (dating back before "git submodule" was written, but
only when "gitlink" was added to the index and the tree objects) was to
identify the submodule by name and refer to the same logical entity with
the same name, so that no matter where in the superproject's working tree
hierarchy you change your mind to bind a particular submodule (say, "the
Linux kernel upstream source") at (i.e. "path"), or from which mirror of
the kernel repository you recommend your downstream to clone it from
(i.e. "url" in .gitmodules).

So "What happens if the submodule name changes" is a nonsense question.

But you remind me an ancient design discussion regarding the submodule URL
(you should dig the list archive if you are interested in reviving the
discussion of this issue), that hasn't been implemented.

It was envisioned that we sh/could record (in superproject's .git/config
somewhere) all the values of submodule.$name.url the user has ever seen
(via checkouts and branch switching), the value of submodule.$name.url
that was recorded in .gitmodules, along with what URL the user has
actually chosen to use given the set of these values. 

Imagine that the original version of the superproject recommended A as the
URL for the submodule S, and then later versions of the superproject
recommend B as its URL because the project it borrows its submodule has
migrated to a new home.

A possible user experience under this scenario may go like this:

    $ git clone superproject && cd superproject
    $ git submodule init S

        The user hasn't seen any submodule.S.url yet, as this is
        immediately after cloning. .gitmodules records A and this
        command would ask "Do you want to clone from A [Y/n]?" or use A
        without asking.

        It also records that when given A, the user chose A (or something
        else, such as its known mirror A').

    Time passes.  The superproject changes the url for submodule S.

    $ git pull

        Now .gitmodules has B in submodule.S.url, which is different from
        anything the user has seen (recorded in .git/config of
        superproject). Any "git submodule" subcommand that would try to
        update submodule S from its upstream _should_ offer the user a
        chance to notice this, and update the actual URL in S/.git/config
	to fetch from.  It may ask "Do you want to update from B [Y/n]? "
        and some other choices (e.g. keep using A' may be an option).

	It also records that after seeing A and B, and to update the
	version of superproject that records B as the URL for S, the user
	chose to use what exact URL to update S (it may be A, B, or A', or
	it may be something entirely different).

    $ git checkout -b side master~400 ;# or whatever old version

	After switching to an ancient version, .gitmodules has A. Perhaps
	the module needs to be updated from A, or the module needs to be
	updated from B (because A is defunct and no longer working, but B
	records exactly the same history as A used to). But the record in
	the superproject does not show what URL the user wants to use,
	when A and B are the choices the user has seen, and A is recorded 
	in .gitmodules, so we ask again, and record the choice.

    After this, we know that given the knowledge of presence of A and B,
    what URL the user wants to use when .gitmodules records A (or B) as
    the URL for the submodule, so switching to _any_ version in the
    history will not have to ask the user what URL should be used to
    interact with the upstream of submodule S.

Note that the above scenario can be loosened by assuming that B is always
a superset of A and newer recommendation is always preferred. Then the
mapping from the situation to the actual URL can be simplified to "Given
these URLs the user has seen, the user wants to use this URL", not "Given
these URLs the user has seen and this URL recorded in .gitmodules for the
particular version, the user wants to use this URL" as the above scenario
outlined.
