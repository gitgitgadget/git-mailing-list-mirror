From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add MALLOC_CHECK_ and MALLOC_PERTURB_ libc env to the
 test suite for detecting heap corruption
Date: Mon, 17 Sep 2012 13:28:04 -0700
Message-ID: <7vzk4otmwb.fsf@alter.siamese.dyndns.org>
References: <1347641662-3596-1-git-send-email-gitter.spiros@gmail.com>
 <7v392k5w7u.fsf@alter.siamese.dyndns.org>
 <7vligc19d1.fsf@alter.siamese.dyndns.org>
 <CA+EOSBk0hN+v+PK8jzCCZgG0Ko7SsHOSB=cM7nnaSsrUOaJ-7Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Elia Pinto <gitter.spiros@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 17 22:28:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDhvV-0006O9-J4
	for gcvg-git-2@plane.gmane.org; Mon, 17 Sep 2012 22:28:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753475Ab2IQU2I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2012 16:28:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52678 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753238Ab2IQU2H (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2012 16:28:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AD2B99F46;
	Mon, 17 Sep 2012 16:28:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7hbvc9SnlGugUCjpy7gH5XVaBgc=; b=eD2QHj
	gK47Jl1OTmTHUuztAsvxDS3BncJeFIjaJVZAusuDJfIRwOtmsPahr+LIe3jCY7gs
	fq4krOyGb3bJJcGKRjMoLpg+0o1VRnhR4SLmfSUr1nKi6UOW7q+glKm9htUffIS/
	M8Mx2rS1qOKp8HYqZFElBJZwSprIypppv9gIE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=seixYPjlyCri7+7CLErt23T7vFdqRhWT
	oAko1CHsjcgJlPzVAwsClNTnCP1WZWDiFh5qEGbo0LemiVASGpUC/yQV75AIl+A0
	tAyP0aG8bdjtvmUI+L0PR36YhqNS6zRFYSeosOSV4Zt1UhAdm/eU6XDD5VbRIEZj
	TV1oibkja8o=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9AD689F45;
	Mon, 17 Sep 2012 16:28:06 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0505C9F42; Mon, 17 Sep 2012
 16:28:05 -0400 (EDT)
In-Reply-To: <CA+EOSBk0hN+v+PK8jzCCZgG0Ko7SsHOSB=cM7nnaSsrUOaJ-7Q@mail.gmail.com> (Elia
 Pinto's message of "Mon, 17 Sep 2012 14:17:15 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2FF1756A-0106-11E2-8AD1-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205739>

Elia Pinto <gitter.spiros@gmail.com> writes:

>>  - That "165" thing I mentioned earlier.
>
> Thank you so much for the comments, that's fine. A single
> consideration for  MALLOC_PERTURB.
>
> You can use any value between 1..255 for MALLOC_PERTURB_
> That chooses the byte that glibc will use to memset all freed buffers.
> In general it is defined as
>
>     export MALLOC_PERTURB_=$(($RANDOM % 255 + 1))
>
> (as drepper pointed out http://udrepper.livejournal.com/11429.html)

Drepper never recommends RANDOM there.

> Using a random value is slightly better than using a fixed one
> in case your fixed value is someday just the right/wrong value to mask
> a problem.

Quite the contrary.  When you use a fixed pattern, it is easy which
other pieces of memory has uninitailized contents.  When you use a
random value, you sometimes get an error and sometimes the test
mysteriously pass, which does not help debugging.

openSUSE folks seem to use a fixed value for this exact reason of
repeatability of tests.

http://jaegerandi.blogspot.com/2012/01/finding-subtile-malloc-bugs.html

> So OK per the original expression?

No.

I am not convinced 165 is the perfect value, but I am fairly certain
any fixed value is better than using a random to deliberately worsen
repeatability of the tests.
