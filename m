From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] revision.c: fix possible null pointer access
Date: Fri, 04 Dec 2015 07:39:10 -0800
Message-ID: <xmqq610ete8x.fsf@gitster.mtv.corp.google.com>
References: <1449171136-31566-1-git-send-email-stefan.naewe@gmail.com>
	<xmqqlh9bthyb.fsf@gitster.mtv.corp.google.com>
	<46311B14CC814F54AC34764F2520947A@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "Stefan Naewe" <stefan.naewe@gmail.com>, <git@vger.kernel.org>,
	"Stefan Beller" <stefanbeller@googlemail.com>
To: "Philip Oakley" <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Fri Dec 04 16:39:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a4sS6-00044C-Kq
	for gcvg-git-2@plane.gmane.org; Fri, 04 Dec 2015 16:39:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754116AbbLDPjO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Dec 2015 10:39:14 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:54996 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753412AbbLDPjN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Dec 2015 10:39:13 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 90E342F5F0;
	Fri,  4 Dec 2015 10:39:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ypA+g7TBhghhdYkVp3RTSGC10iQ=; b=pj/M2J
	Pz70mwhpoCdnqgK3PTh0EfJ0IGuTsGi7KhKLTM+G5NahX/Rb9jERp+3pnpFVRoC6
	8UdwRXZaggckSROWpRAOl3mBKEwabgNW3lseKwu6gPR8iYXmjSvxG67pqmxnqiW3
	rJyDxrca5w1JYDG5izc6/2DKf5ev0W/uocFKI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wVlXJTV1DpNr6iHE7l2nGGi9BQec1m1l
	R7khMaLJrfFjjAG1bNw0GnZ37+Sv083Nn2oqbHH+E3l9467+op27T4mOdvBDjN+7
	jRjO4ROTC1V3PmLl/5+DjmyOzOieEhoEsUOCr7y1EnzLNy/nCY/QnOn/SjRaGu8Z
	LB67vRFm8YU=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 884B22F5EF;
	Fri,  4 Dec 2015 10:39:12 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 0651C2F5EE;
	Fri,  4 Dec 2015 10:39:11 -0500 (EST)
In-Reply-To: <46311B14CC814F54AC34764F2520947A@PhilipOakley> (Philip Oakley's
	message of "Thu, 3 Dec 2015 21:34:32 -0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 2AA13E68-9A9D-11E5-B54B-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281985>

"Philip Oakley" <philipoakley@iee.org> writes:

> From: "Junio C Hamano" <gitster@pobox.com>
>> Stefan Naewe <stefan.naewe@gmail.com> writes:
>>
>>> Two functions dereference a tree pointer before checking
>>
>> Reading them a bit carefully, a reader would notice that they
>> actually do not dereference the pointer at all.  It just computes
>> another pointer and that is done by adding the offset of object
>> member in the tree struct.
>
> But you can't do that computation (in the error case under
> consideration). Null can't be added to anything (as far as the
> implications of the standards go). These are horrid gotchas because
> they go against the grain of all that binary arithmetic and
> simplifications we learnt long ago.

Yeah, but in that hunk that does check !tree, because the function
can be fed a NULL, the computed result assigned to object, which is
undefined, is never used ;-)

Of course, there used to be exotic platforms that are still standard
compliant that triggered a trap when such a pointer computation was
made (rather, such a bogus pointer was assigned to a pointer
variable).  I do not think anybody attempted to port Git to such a
platform, but I agree that it is better to "fix" such a codepath, if
only to stop wasting time dealing with them discussing with language
lawyers ;-)

So as I said in my review, the first hunk is a reject, the second
one is OK.

Thanks.
