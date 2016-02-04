From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-completion.bash: always swallow error output of for-each-ref
Date: Thu, 04 Feb 2016 11:06:58 -0800
Message-ID: <xmqqwpqki9bh.fsf@gitster.mtv.corp.google.com>
References: <56B32953.2010908@gmail.com>
	<20160204111307.GA30495@sigill.intra.peff.net>
	<alpine.DEB.2.20.1602041216240.2964@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	git@vger.kernel.org, szeder@ira.uka.de, tr@thomasrast.ch
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Feb 04 20:07:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRPFF-0005rf-TA
	for gcvg-git-2@plane.gmane.org; Thu, 04 Feb 2016 20:07:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965623AbcBDTHE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Feb 2016 14:07:04 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:55703 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S965225AbcBDTHD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2016 14:07:03 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BFE773FAE1;
	Thu,  4 Feb 2016 14:07:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gRwU7zz14NF5/4EPFIewuudwdgw=; b=xWfW6U
	iR5+9K5sAzviD3zylIjQdCnC+DmANymwflbHcSHaFcswq3WDllEzLo3HDUymT5RW
	yCS5NjNj0s5/qQEqweWUQHWZhfbDqUjgJoZcmAul2HbNAF9KM/0j2USxR80LynTD
	D6XCFL3Ed0fI9ITBBuBtNo/JbszTJDdmp906I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ia2u/h+SrHzgWAwc+1d42HvhkczxSxdN
	JQouiSCQ54010t6pHaJYvtkMBldkr3lL4NnV2m072aJdHD5ARwwkVKI+MUow++LW
	ajWb8ALIqdtvHtTLFHSAwCEXG92g45s/lMoc9Vse4ot0SsyR4pM2w2Ike+uKHLT5
	xsysjPVFuCM=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3FD553FAE0;
	Thu,  4 Feb 2016 14:07:01 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 33EC53FADD;
	Thu,  4 Feb 2016 14:07:00 -0500 (EST)
In-Reply-To: <alpine.DEB.2.20.1602041216240.2964@virtualbox> (Johannes
	Schindelin's message of "Thu, 4 Feb 2016 12:26:19 +0100 (CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 77E54740-CB72-11E5-AA2C-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285478>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> $ time git for-each-ref --format='%(refname:short)' refs/tags >/dev/null
>> 
>> real    0m0.009s
>> user    0m0.004s
>> sys     0m0.004s
>
> And the timings in the ticket I mentioned above are not pretty small:
> 0.055s vs 1.341s
>
>> The upcoming refname:strip does much better:
>> 
>> $ time git for-each-ref --format='%(refname:strip=2)' refs/tags >/dev/null
>> 
>> real    0m0.004s
>> user    0m0.000s
>> sys     0m0.004s
>
> This is funny: after reading the commit message at
> https://github.com/git/git/commit/0571979b it eludes me why strip=2 should
> be so much faster than short...

"short" tries to ensure that the result is not ambiguous within the
repository, so when asked to shorten refs/heads/foo, it needs to
check if refs/tags/foo exists.  "strip=2" textually strips two
levels from the top without worrying about ambiguity across
different hierarchies.
