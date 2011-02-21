From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/3] t/gitweb-lib.sh: print to stderr when gitweb_run
 has errors
Date: Sun, 20 Feb 2011 22:40:50 -0800
Message-ID: <7vmxlplwjx.fsf@alter.siamese.dyndns.org>
References: <1298124654-12051-1-git-send-email-avarab@gmail.com>
 <201102191646.02543.jnareb@gmail.com>
 <AANLkTimFyue2F6aRg7KdqOJZw9dOHY+B0XWCiVBYNOeg@mail.gmail.com>
 <201102191916.21164.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 21 07:41:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PrPSR-0006w9-3W
	for gcvg-git-2@lo.gmane.org; Mon, 21 Feb 2011 07:41:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751969Ab1BUGlE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Feb 2011 01:41:04 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:38225 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750778Ab1BUGlC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Feb 2011 01:41:02 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 291974759;
	Mon, 21 Feb 2011 01:42:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fPhL12WlxSnANh1SA5IN6P4OuLQ=; b=uej+ML
	dgGIZLrSzRsfOc1ijxlJ4pcw26jFNoqm1cZQROOkq2IyEr7QqWWfMykwjKRyOpTN
	H5sglpCK7OxIzxrHN3mTjwbuwBBMZG9U9gjMkVHSlJ2BhWGJpTS6LQaTHs+s+8rz
	Diwghs9hAmbEXV51gH3S8d07zTyYhyoJ5cS2I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qNJ2MU77lhRZb92YFmjsd1dFble9EFKH
	fZblysFn9vrwn7dE2HPDWdouDiNR8mcfqPMuCX5GuLTQ0Z6rwF/GHPtsasW3q26V
	3MsXvo4e2I3eSb48FTasUQrMgp7neZUuCGnvuMTqnrUOLIQB9UySIhO5ul6eWUVG
	6uvznIlkV0g=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id EB6DB4758;
	Mon, 21 Feb 2011 01:42:06 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id C457E4757; Mon, 21 Feb 2011
 01:42:02 -0500 (EST)
In-Reply-To: <201102191916.21164.jnareb@gmail.com> (Jakub Narebski's message
 of "Sat\, 19 Feb 2011 19\:16\:19 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B34D4DEE-3D85-11E0-9885-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167442>

Jakub Narebski <jnareb@gmail.com> writes:

> Because '--immediate' stops test suite after first error, therefore in
> this mode
>
>   test_debug 'cat gitweb.log'
>
> was never ran, thus in effect negating effect of '--debug' option.
> This made finidng the cause of errors in gitweb test sute difficult.

I think the patch itself makes sense, but I actually don't agree with the
above reasoning.

The point of --immediate is not just it stops where we find a failure, but
also it leaves the trash directory intact, so that _you_ who started the
test with --immediate can run the "cat gitweb.log" yourself.

In other words, I think test_debug is overused.  In the current setting, I
think a sane way to debug the test script itself would probably be

	sh -x tXXXX-xxxx.sh -i -v -d

so that:

 (1) with -x I can see what commands are being run;
 (2) with -i I can stop the test immediately upon the first failure;
 (3) with -v I can see the output from the commands that we usually do not
     show; and
 (4) with -d I can be sure that trash directory does not go away.

Notice that I do not count "I can see test_debug executed" as a benefit
from (4) above?

My preference, although I do not care too deeply, would be to gradually
remove test_debug calls that were casually sprinkled and left in the test
scripts while they were initially developed, and have the regular test
sequence run them just like your patch does.  Another change I would
welcome would be to make the "-d" option automatically trigger shell
tracing, to make it unnecessary to say "sh -x".
