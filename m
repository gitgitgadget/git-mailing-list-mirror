From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] compat: Fix read() of 2GB and more on Mac OS X
Date: Mon, 26 Aug 2013 21:59:14 -0700
Message-ID: <xmqq4nabhgpp.fsf@gitster.dls.corp.google.com>
References: <1376900499-662-1-git-send-email-prohaska@zib.de>
	<1376926879-30846-1-git-send-email-prohaska@zib.de>
	<CA+55aFzQhJqE4QDwJDKtkTtJpMNbz3_Aw5_Q3yTk5DnhLJyjCQ@mail.gmail.com>
	<xmqqeh9p8ut3.fsf@gitster.dls.corp.google.com>
	<7E527329-230E-4954-9942-8BB0935ACE4D@gmail.com>
	<CA+55aFzAQjxB7HkDqR6_3wdex1t1Tbrf5CeUVyiVm=DRyDVhhQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Kyle J. McKay" <mackyle@gmail.com>,
	Steffen Prohaska <prohaska@zib.de>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Sixt <j6t@kdbg.org>,
	John Keeping <john@keeping.me.uk>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Aug 27 06:59:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VEBNC-0003XD-KJ
	for gcvg-git-2@plane.gmane.org; Tue, 27 Aug 2013 06:59:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752931Ab3H0E7T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Aug 2013 00:59:19 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54462 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752538Ab3H0E7S (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Aug 2013 00:59:18 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9769939D63;
	Tue, 27 Aug 2013 04:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=suVGJstmdMSp43xKHQmk8n6/0Wo=; b=XL0uCp
	8ZNIbxn76q0vUpcz5wBqrNLyRsf77w2u4IH2MQQIs8D1jIIC3rFuVlPKGeGTfhJn
	jrRy8K8PS4bW88C0RzVIBfDA0nrLHzgqUN2/V+4epuH/7P410WonFPVxYRjM0376
	GbRpSGn3QYI+RUH9twKVtFbDJk+YtO+j9N0bk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uqTHJnPdyZHkA5F85Qo1AoJqgC1+OKgx
	tBARKTirEOzTl/gcsB2kEu/Yh4aAdcrJzM19HCZwVf5eDp5VnB01iy7GZlyYafh8
	Jq7a++T9imy0WbDgw22ZV9SBGtZSHiIq2KWh3VLNTP599i0RBRoM1zjP90uojyAO
	mRdga36BQj8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 891DB39D62;
	Tue, 27 Aug 2013 04:59:17 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D7A1F39D60;
	Tue, 27 Aug 2013 04:59:16 +0000 (UTC)
In-Reply-To: <CA+55aFzAQjxB7HkDqR6_3wdex1t1Tbrf5CeUVyiVm=DRyDVhhQ@mail.gmail.com>
	(Linus Torvalds's message of "Mon, 19 Aug 2013 15:51:41 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 6CF18972-0ED5-11E3-BC4B-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233074>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> So it would probably be a great idea to make the filtering code able
> to do things in smaller chunks, but I suspect that the patch to chunk
> up xread/xwrite is the right thing to do anyway.

Yes and yes, but the first yes is a bit tricky for writing things
out, as the recipient of the filter knows the size of the input but
not of the output, and both loose and packed objects needs to record
the length of the object at the very beginning.

Even though our streaming API allows to write new objects directly
to a packfile, for user-specified filters, CRLF, and ident can make
the size of the output unknown before processing all the data, so
the best we could do for these would be to stream to a temporary
file and then copy it again with the length header (undeltified
packed object deflates only the payload, so this "copy" can
literally be a byte-for-byte copy, after writing the in-pack header
out).

As reading from the object store and writing it out to the
filesystem (i.e. entry.c::write_entry() codepath) does not need to
know the output size, convert.c::get_stream_filter() might want to
be told in which direction a filter is asked for and return a
streaming filter back even when those filters that are problematic
for the opposite, writing-to-object-store direction.
