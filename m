From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] t1300: put git invocations inside test function
Date: Wed, 19 Oct 2011 00:04:04 -0700
Message-ID: <7vzkgxcviz.fsf@alter.siamese.dyndns.org>
References: <20111012182742.GA14543@sigill.intra.peff.net>
 <20111012182920.GA18948@sigill.intra.peff.net> <4E9E7115.60303@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>,
	Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Oct 19 09:04:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RGQCC-0003aX-KE
	for gcvg-git-2@lo.gmane.org; Wed, 19 Oct 2011 09:04:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755109Ab1JSHEI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Oct 2011 03:04:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65364 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752187Ab1JSHEG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Oct 2011 03:04:06 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0947535F4;
	Wed, 19 Oct 2011 03:04:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ewMXUtWGl1Dreh/YOZ5hELq+hBA=; b=ttxohK
	O9cDGmEsX1XhLD+VKNDfXKmQh7XRL2xsz6k+RYUgOiOKpsqw0K1001xd+TbngbI8
	/VpxDn/g9pK38IavDngkAzPM6bHoqcG56kRGCXDXcoD5NzcOl+GPH7Odx5KH0sHs
	Yqbqq71FLZtWfc0mRlAtYIza8KF7Eak/PHv0Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mXrHtNyHwsD+D5jYGay63Iw7fK0y3XrI
	qGZti8LcGVn/9/+ty7agQ+4mD/H2FMQBeEOEFPLLyqnpuUf2MXBb4QdHp2CGfUY/
	cfDNSxwRlcJWSvvlcO+qiCzD7pRDNlL8ftVI9L4Tz6XV5l/L8IM3mBWndZTbFZbA
	kntRHTAJ/28=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0053B35F3;
	Wed, 19 Oct 2011 03:04:06 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 851A435F2; Wed, 19 Oct 2011
 03:04:05 -0400 (EDT)
In-Reply-To: <4E9E7115.60303@viscovery.net> (Johannes Sixt's message of "Wed,
 19 Oct 2011 08:41:25 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 88689EC8-FA20-11E0-A8DD-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183924>

Johannes Sixt <j.sixt@viscovery.net> writes:

> This innocently looking hunk fails on Windows, because the preceding tests
> are skipped, and .git/config does not exist. I was tempted to just change
> this to 'rm -f'. But there are a few other instances of 'rm .git/config'
> in this file that were *not* moved inside the test function.
>
> How would you like this solved?
>
> - Move this one out again
> - Add -f to just this one
> - Add -f everywhere
> - a combination of the above?

Probably "rm -f .git/config" to all tests would be the most appropriate,
as the desire to start from an empty config file is a sign that each test
wants to be as independent as possible from previous tests.

An alternative approach to achieve the independence would be to make each
test responsible for cleaning up after itself, with test_when_finished,
but that won't work for the first one, as the test framework would give
you the original one. Besides, that's trying to be cooperative when each
test can fail in an unexpected way (after all the purpose of tests is to
fail when things go wrong). In order to achieve isolation, each test
protecting themselves from others, as long as it can be easily and
reasonably done (e.g. a single "rm -f"), is probably far more preferrable
than each test trying to clean after itself, risking possible failure to
do so.
