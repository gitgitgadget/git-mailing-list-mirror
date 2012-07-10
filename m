From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] branch: suggest how to undo a --set-upstream when
 given one branch
Date: Tue, 10 Jul 2012 15:43:12 -0700
Message-ID: <7vliirgrun.fsf@alter.siamese.dyndns.org>
References: <1341939181-8962-1-git-send-email-cmn@elego.de>
 <1341939181-8962-3-git-send-email-cmn@elego.de>
 <20120710192408.GF8439@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 11 00:43:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Soj9M-0003Lj-SY
	for gcvg-git-2@plane.gmane.org; Wed, 11 Jul 2012 00:43:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754580Ab2GJWnP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jul 2012 18:43:15 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33448 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753857Ab2GJWnP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jul 2012 18:43:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4F1A493C4;
	Tue, 10 Jul 2012 18:43:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=spN0gI/P4JXy4n0Rg1GFMS8A9bA=; b=hqO0ae
	f2N37WNzrXL5PWMOKdPqLqIKGR8ZTWw3Kv1qlb4CzrRxWzC9JTSM58+j1T1cgxBB
	rIX5obJ3Jro/q/ns6PTsQ7jVYdXxM7donQxGWcd1ej0hopFgG+A/mVIQwKqmSrVA
	5qXnCPie1gXwy084gcFDAde+qxLmtesaEwu4M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yAc6lri6Mi4h9V+jTzyJ6dwgTCI9qGHq
	MEwzjldgCUNRjgx3WhiP2GQCIMLSIIFpnrueFaaxV4kpFIQBsHi+GEEp1IF6fI4U
	pYaz1aKF1d2RsqhEcvkXp3+3zWCkbHclqDyHP+DB109UaYLMDVcR65y74hSDdXQs
	s+CzrDLQvDY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 46D1993C3;
	Tue, 10 Jul 2012 18:43:14 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CA36193C1; Tue, 10 Jul 2012
 18:43:13 -0400 (EDT)
In-Reply-To: <20120710192408.GF8439@burratino> (Jonathan Nieder's message of
 "Tue, 10 Jul 2012 14:24:08 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A211DC18-CAE0-11E1-971B-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201281>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Message should go on stderr and be guarded with an advice option (see
> advice.c).
>
> Like this:
>
> 	const char *arg;
>
> 	...
> 	if (argc != 1 || !advice_old_fashioned_set_upstream)
> 		return 0; /* ok. */
>
> 	arg = argv[0];
> 	advise("If you wanted to make '%s' track '%s', do this:",
> 							head, arg);
> 	if (branch_existed)
> 		advise(" $ git branch --set-upstream-to='%s' '%s'",
> 			old_upstream, arg);
> 	else
> 		advise(" $ git branch -d '%s'", arg);
> 	advise(" $ git branch --set-upstream-to='%s'", arg);
>
> If an argument contains single-quotes, the quoting will be wrong, but
> that's probably not worth worrying about.

In principle, I would agree that this is a kind of thing that falls
into the "advice" categiry, but with the fact that we plan to
deprecate "--set-upstream", combined with the fact that [PATCH 1/3]
introduced the new option --set-upstream-to together with a short
and sweet -u synonym already at this point in the series, I think it
is better to leave them emitted unconditionally to the standard
error stream, in order to train users away from using the old option
that has its arguments wrong (the option does not take an argument
it should, and makes the command line to look as if it takes two
branch arguments in the wrong order).

Actually, we should probably add the deprecation warning in this
commit.
