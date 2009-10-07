From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] New date format: local_original
Date: Wed, 07 Oct 2009 13:01:05 -0700
Message-ID: <7vocojrn26.fsf@alter.siamese.dyndns.org>
References: <200910062209.47606.tuomas.suutari@gmail.com>
 <20091007125427.GA20067@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tuomas Suutari <tuomas.suutari@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Oct 07 22:09:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MvcpH-0005vB-Bz
	for gcvg-git-2@lo.gmane.org; Wed, 07 Oct 2009 22:09:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759968AbZJGUB7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Oct 2009 16:01:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759941AbZJGUB7
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Oct 2009 16:01:59 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:44043 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759229AbZJGUB6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Oct 2009 16:01:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id CEE936E913;
	Wed,  7 Oct 2009 16:01:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=jlvdYvyWug/DqqOBUMZ00AGMPgc=; b=u8A92w8iPWLWLHwLKzJaEsM
	J6azLWLwZo0DNwlzHwuNBkWrbMkz9cdurLkf441GMEvgNbXN7iy/sO+tBvWJKaEV
	R0NYHfHd6KAPoRKMnNcMTiB9hZpKP98XOysmdEYK5dPyXgdcHwZ0oWWqb4OJPQWH
	SMGUH6WgR7KxZbmmYYcg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=ceLoUvlAF+HcRWwju7kP/c1t7YAwB20OCArWIgwHv/c0Zk7KQ
	ymVBthT/No5CVuQpE3Y+SuVSLO3LJmMh0ScEf3+rxXuQhxGLY0N1F/N0J1mTNCJZ
	DPBgA/BhbR72IwvFST7saTT4cZqG2+kq/L/B8Ip4yONUqM9fJmeZIpb/gs=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A1CAB6E90F;
	Wed,  7 Oct 2009 16:01:12 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id ABA676E90E; Wed,  7 Oct 2009
 16:01:06 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 29C98EE6-B37C-11DE-BEC8-1000076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129656>

Jeff King <peff@peff.net> writes:

> If the former, then should the options be orthogonal? That is, should it
> be a new format combining the two, or should it be an option to show, in
> your preferred format, the time in both local and original time zones?
> E.g., something like:
>
>   $ git log --date=iso --local-dates-too
>   commit bf01a69ed40e1afcf56aff143f7523da2ce263ed
>   Author: Johannes Schindelin <Johannes.Schindelin@gmx.de>
>   Date:   2009-10-04 00:41:55 +0200
>   Local:  2009-10-03 17:41:55 -0500
>
> And then you can use it with "normal" dates, iso dates, rfc2822 dates,
> etc.

Thanks for comments.

I think "--date=iso --local-dates-too" is still not orthogonal enough, let
alone "local_original" which invites "Why is this combination supported
and not this, that, and 47 others?" questions.

I however do not think it is so bad an idea to allow something like:

	git log --date='custom:%Y-%m-%d ...'
	git log --date=custom	;# looks at "date.custom" config

You (not Peff, but figuratively whoever wants to implement it) can add a
mechanism to specify in which timezone (original or local) you would want
the timestring to be given, and make what Tuomas's RFC patch does a mere
special case.  For example, we could reuse 'date "+format"' string with
our own extension %{magic}, with two magic tokens initially defined:

    %{local}	interpret timestamp in local zone from now on
    %{original}	interpret timestamp in the original zone from now on

With such a mechanism Tuomas can define:

	[date]
            custom=%{local}%a %Y-%m-%d %H:%M:%S %{original}(%a %H:%M:%S %z)

and ask "git log --date=custom" to get what his patch does.
