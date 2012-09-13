From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add MALLOC_CHECK_ and MALLOC_PERTURB_ libc env to the
 test suite for detecting heap corruption
Date: Thu, 13 Sep 2012 10:46:46 -0700
Message-ID: <7vvcfh95o9.fsf@alter.siamese.dyndns.org>
References: <1347452248-12222-1-git-send-email-gitter.spiros@gmail.com>
 <7vy5kfceod.fsf@alter.siamese.dyndns.org>
 <CA+EOSBmjwUA_Sogo5ZixnAE5_6C97wjEOzO6PnDgjw_BYzVz-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Elia Pinto <gitter.spiros@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 13 19:46:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCDVB-00072G-W9
	for gcvg-git-2@plane.gmane.org; Thu, 13 Sep 2012 19:46:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754292Ab2IMRqu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Sep 2012 13:46:50 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56707 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752124Ab2IMRqt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Sep 2012 13:46:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BAD5083A1;
	Thu, 13 Sep 2012 13:46:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=99XGCVVoHj5Dpqq3et8MTrdJd6E=; b=GUuC7g
	up8b5VJCsz4hNuTbif2xTpirZ8GEOTcdO42d7Td1t/nwasKduAXn2nt3gDlFiojB
	SUMXttvpWZLdXqSKa9xzSQO4MD4N2pgkTS+Jg6cbwkrxy3i7kR197CI7Ccw43RLq
	z6q1c6OmK/caPrGq2jJOTGrUO7gKNKc5XgEW8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tKhYkcgg3diUsp9lWs5DKF6AdQdGckx7
	of1YEgAUkRTlrT3n1TFHQpAojPzuDntkggSs8hQ+MvrONeIlI9pyXvKn1jZD3kT9
	VxK4hto16XatGB8WoLR32mnxunDgdZOdfVTz2fKySeAs/t+oUBgTSg+k2jeIM8A7
	D6wJ0DrDMZo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A791983A0;
	Thu, 13 Sep 2012 13:46:48 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0A31C839F; Thu, 13 Sep 2012
 13:46:47 -0400 (EDT)
In-Reply-To: <CA+EOSBmjwUA_Sogo5ZixnAE5_6C97wjEOzO6PnDgjw_BYzVz-w@mail.gmail.com> (Elia
 Pinto's message of "Thu, 13 Sep 2012 18:36:53 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FDC370EA-FDCA-11E1-A10A-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205397>

Elia Pinto <gitter.spiros@gmail.com> writes:

> 2012/9/12 Junio C Hamano <gitster@pobox.com>:
>>
>> Interesting, but it bothers me to make it enabled unconditionally.
>> At least, this shouldn't be enabled under GIT_TEST_OPTS=--valgrind, no?
> Sorry for the late response and thanks.
>
> No, setting MALLOC_CHECK don't require
> valgrind ...

You never said anything like that, and I didn't question it.

> and it considered a best QA to have the test suite with it
> defined always. If the test suite fail with MALLOC_CHECK, well, there
> is some problem, no ?

I never said using MALLOC_CHECK_ is a bad idea.

Let me ask the same question in a different way, as I seem to have
failed in the previous message.

If you are using valgrind to run tests, is it sane to also enable
MALLOC_CHECK?  If you were testing "cat", would it make sense to do:

	$ MALLOC_CHECK_=3 valgrind cat README

Because we are not interested in testing how valgrind (not cat)
uses malloc, we may be better off running

	$ valgrind cat README

without MALLOC_CHECK_; it will reduce the risk of MALLOC_CHECK_
potentially disturbing what we really want to check (i.e. cat) by
triggering for something whose problems we are not trying to see
(i.e. valgrind), no?

That was my question.
