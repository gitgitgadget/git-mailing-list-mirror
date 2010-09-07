From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Several tests: cd inside subshell instead of around
Date: Mon, 06 Sep 2010 22:08:46 -0700
Message-ID: <7vlj7ep2ch.fsf@alter.siamese.dyndns.org>
References: <4C85357A.8090000@web.de>
 <7vhbi2tqd0.fsf@alter.siamese.dyndns.org> <20100907023713.GJ1182@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Git Mailing List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 07 07:09:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OsqQa-0001Ak-2T
	for gcvg-git-2@lo.gmane.org; Tue, 07 Sep 2010 07:09:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751491Ab0IGFI7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Sep 2010 01:08:59 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:43079 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751164Ab0IGFI6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Sep 2010 01:08:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 156D5D3D28;
	Tue,  7 Sep 2010 01:08:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YbIr1FaWgdKIncpLcNZ7E98XOAU=; b=ueePPh
	/GPKrijt19A2tUH6ngnUU7pCDC8B6CkUNtdqHeOG3KRfrWJVwRvXdEUvNVEx7Ni+
	ltZzvAnuo4/z7T/4+kIQgrx7RzmFYUXfXSioxZgzwE2mjW91U8pOJcg2UXYK12w9
	0mbpgMyy9sD74WfpqIM78y7Lgd/r4MtFqkw5o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cTDYIM6i7/qhwZHarsl8ddKOkTEpoN2O
	X42RsadXieyC7flrJCUDRgSbjcfXdXadJqB16/bJuzRgxkNpQH0mjIdcIkFT+/Bi
	vI35jFAFTcyWaDknZpNuElgQ91sT0LLCUdlx00qY7q836//jiCIcq0fFwhpnOwxo
	NgwpgM5bDe0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D8C8FD3D25;
	Tue,  7 Sep 2010 01:08:52 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E9813D3D24; Tue,  7 Sep
 2010 01:08:47 -0400 (EDT)
In-Reply-To: <20100907023713.GJ1182@burratino> (Jonathan Nieder's message of
 "Mon\, 6 Sep 2010 21\:37\:13 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 01FEB4B2-BA3E-11DF-A879-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155674>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Junio C Hamano wrote:
>
>> If we were to insist that no matter how an individual test fail, the test
>> that follows it must start in a known location (namely, $TRASH), then we
>> might want to use something like the attached patch.
>
> I like it.  Affected test scripts:
> ... (many) ...
> and probably some others.

For the record, I _do not_ like it at all.  Is it worth being that
draconian and say each test must start at $TRASH?  What do we gain by it?

We certainly do _not_ want any test to wander around, escape out of the
$TRASH directory and running random "git" command, but as long as N+1th
test knows and expects Nth test might move to a subdirectory of $TRASH and
is prepared to start, I personally do not think it is such a big deal.  It
certainly makes it harder to insert a new test between such a pair of
tests, but like it or not, many of the tests already depend on the state
of the repository that earlier tests left behind.  I think we could just
declare that $cwd is just a small part of that initial state for
individual test that was left behind the earlier test.

After we vet and apply Jens and your "turn 'cd there && do this && cd ..'
into a subshell" series, and the "modernize indentation style" series,
perhaps we should stop and think?  In an ideal world, it would be really
nice if each "test_expect_success/failure" in a single script were
independent from each other (if we did so, GIT_SKIP_TESTS=4321.4 starts to
be more useful), but realistically, I don't think it is worth the effort.

So it may be worth it to check $(pwd) against $TRASH and make sure we
didn't escape $TRASH by mistake at the beginning of each test in test_run_
function, but to me, "must be at $TRASH" feels like a rule for the sake of
it, without really helping us very much.
