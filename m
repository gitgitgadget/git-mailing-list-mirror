From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] blame: introduce -u/--unique option
Date: Thu, 10 Mar 2011 01:43:55 -0800
Message-ID: <7vhbbb5mzo.fsf@alter.siamese.dyndns.org>
References: <1299581951-4670-1-git-send-email-namhyung@gmail.com>
 <1299581951-4670-2-git-send-email-namhyung@gmail.com>
 <7vy64o9ixz.fsf@alter.siamese.dyndns.org> <1299737621.1496.55.camel@leonhard>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Namhyung Kim <namhyung@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 10 10:44:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PxcPk-0001Gi-0P
	for gcvg-git-2@lo.gmane.org; Thu, 10 Mar 2011 10:44:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752014Ab1CJJoG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Mar 2011 04:44:06 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:40415 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751858Ab1CJJoE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Mar 2011 04:44:04 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D79A03364;
	Thu, 10 Mar 2011 04:45:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UtfZz3ogXqR+OrKi1n5Wwq1Pg10=; b=WIeLvS
	Mg5I5hXM0KqWkh76eoA80rVWniyXU/HpEz9hwOM+LY7QQSGoFZpgo8RhjUZtNcmv
	jEwHmDhXalYCeOGyCvOZRxHBLxC5hPMcSF3kzw/fMuNVCCQFMA/A1RSJz3v5lXAk
	ZOKjh5fHkrqG0irpuPlg+dBWWKb4KLdpr1au8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MrOw9G+ryus+H2tKTWRq2JClYJqjIrhM
	dpmMj/qH4kZqatHX/CXvmmWygxe+9X60mVplbOgkptPk01XAEcxdj5FpThXbicdU
	Dm1Is34rAMCZiusilfruFRkdtLs/aOJWc8aB+oPQFufRpjxRk5t/PJw4BfzJXkee
	pDPX+xmQbqg=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id AC8EA3363;
	Thu, 10 Mar 2011 04:45:29 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id A90A93362; Thu, 10 Mar 2011
 04:45:26 -0500 (EST)
In-Reply-To: <1299737621.1496.55.camel@leonhard> (Namhyung Kim's message of
 "Thu, 10 Mar 2011 15:13:41 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2271E7A2-4AFB-11E0-B759-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168802>

Namhyung Kim <namhyung@gmail.com> writes:

> Hmm... I thought about that too. But you mean that you only want
> --abbrev instead of -u, right?

Yeah, if it can be shown that ensuring the uniqueness in addition to
uniform length with negligible cost, I don't think there is any reason to
have this as an option.  So perhaps the minimum change would be to keep
the current "8" as a hardwired constant to feed find-unique-abbrev with to
find the longest unique prefix as your patch did and use that length when
showing the output.  Making "8" configurable would become a separate
topic.

> My original intention was if user specified --abbrev explicitly, it
> should be honored regardless of the uniqueness. The guard will not be
> used in this situation because the user gave the exact length [s]he
> wants to see.

Hmm, like giving a ridiculously short --abbrev and forcing the output to
be ambiguous yet hopefully they can be differenciated by other clues like
author and date?

The reason I originally suggested to make the uniqueness an optional
feature was primarily output performance, but that is linear with the
number of lines in the file and is dwarfed by the history traversal cost,
so it is a non-issue, so I then suggested that it doesn't need to be an
option.  But I think you may have a point--an option to decline uniqueness
would also make sense, especially when you want a very short prefix that
you know won't be unique and when you don't care about uniqueness.

As all the normal commands that use --abbrev would call f-u-a to ensure
uniqueness, the current "cut at fixed length" behaviour is an oddball.  It
should become an optional behaviour.

The current behaviour, when we eventually have both options, would be:

	$ git blame --abbrev=8 --no-uniq $rev -- $path

and should be the default when neither --abbrev=$n nor --no-uniq is given
for backward compatibility.  Porcelains are _not_ supposed to be reading
from blame output without giving it --porcelain option, but we know we
cannot expect sanity from people who script around git.

When you want to give a very short width that wouldn't guarantee
uniqueness, and you want to force that width, you would say:

	$ git blame --abbrev=4 --no-uniq $rev -- $path

Without --no-uniq, 

	$ git blame --abbrev=4 $rev -- $path

the command may use more hexdigits than 4 to ensure uniqueness, but all
commit names are shown with the same width to ensure alignment as well.

I kind of like that.  While I don't think "--no-uniq" is the best name for
that option, I think --abbrev everywhere else implies uniqueness so it is
not a good idea to require "-u" option for unique output and give
ambiguous output without one.  It would hurt consistency in the UI.
