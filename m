From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/7] Fix some bugs in abspath.c
Date: Tue, 04 Sep 2012 12:03:51 -0700
Message-ID: <7vehmha9uw.fsf@alter.siamese.dyndns.org>
References: <1346746470-23127-1-git-send-email-mhagger@alum.mit.edu>
 <7va9x5bqz4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
To: mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Tue Sep 04 21:04:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T8yPq-0007Uf-My
	for gcvg-git-2@plane.gmane.org; Tue, 04 Sep 2012 21:04:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757576Ab2IDTDz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Sep 2012 15:03:55 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45565 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757530Ab2IDTDy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2012 15:03:54 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 896039D06;
	Tue,  4 Sep 2012 15:03:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gWXi0Bc9gJY08QPqcIFY9SNL3rw=; b=QxeoYA
	5+f3AYgHKlSAztOrD+nydSXfnc1pD9Px2iQRz4GQ14cU3cM4l40THo0hzJjQQDhO
	b7FLtgRCHPCkESxDogaGImR6LsEIqXvPJnI5jRxHczm4lLbaMcDKK84HZL5T9mLU
	9lBg1rQEJvvRMlxXX0waSCk8NBAMf/Xo0OOH8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NjpROVACqKe0Xz9+/qcbISjoNjLBVJEG
	x+zelb6A3D3vQw1KM914jX1u/WNpqpC3vWDn82bD4wAcVTKlWjX/CcEdU9PnmjT0
	ocTpAK4sp8K4tjvJ2OJAI7caGus+rgxGSAHZcWPOuOHZ2yKOun5lvM5zguARkB++
	ad49s2YPVgg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 768399D05;
	Tue,  4 Sep 2012 15:03:53 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C54379D03; Tue,  4 Sep 2012
 15:03:52 -0400 (EDT)
In-Reply-To: <7va9x5bqz4.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue, 04 Sep 2012 11:08:47 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 449F23A6-F6C3-11E1-8D86-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204765>

Junio C Hamano <gitster@pobox.com> writes:

> mhagger@alum.mit.edu writes:
>
>> Please note that both absolute_path("") and real_path("") used to
>> return the current directory followed by a slash.  I believe that this
>> was a bug, and that it is more appropriate for both functions to
>> reject the empty string.  The evidence is as follows:
>>
>> * If this were intended behavior, presumably the return value would
>>   *not* have a trailing slash.
>
> That is weak.  The only thing you can infer from that observation is
> that the presense or absense of trailing '/' would not make any
> difference to the caller who wanted a path to the cwd (and is more
> convenient if the call is made so that a path relative to the cwd is
> tucked after it).

I still wonder why you want to reject "" as an input, as it could be
argued that it is a valid way to say the current directory.

What does realpath(3) do?

    ... goes and looks ...

The realpath(3) wants an existing path, and "" naturally gives NOENT,
so we cannot really draw parallel from it.

Ok, let's do this again.

    $ ./test-path-utils absolute_path ""
    /srv/git/git.git/
    $ ./test-path-utils absolute_path "foo"
    /srv/git/git.git/foo

so a caller has to be prepared to see the returned path sometimes
terminated with slash and sometimes without, to form an absolute
path to the file "bar" in the directory it gives to these functions
(i.e. "/srv/git/git.git/bar" vs "/srv/git/git.git/foo/bar").

That is a reasonably good sign that either nobody calls these
functions with "" or existing callers are buggy and would not handle
that case well and need to be fixed anyway.

So I am fine with die() in your patch.

Thanks.

>> * I couldn't find any callers that appeared to depend on the old
>>   behavior.
>
> That is a very good argument (especially if the audit were
> thorough).
>
> I would be tempted to say that we should die() on "" for now, cook
> the result outside "master" for a few weeks while auditing the
> callchains, and see if any of them complains.
