From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 10/10] git-submodule.sh: don't use the -a or -b option with the test command
Date: Fri, 16 May 2014 12:09:29 -0700
Message-ID: <xmqq7g5la6c6.fsf@gitster.dls.corp.google.com>
References: <1400163457-28285-1-git-send-email-gitter.spiros@gmail.com>
	<1400163457-28285-10-git-send-email-gitter.spiros@gmail.com>
	<20140515155821.GA27279@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Elia Pinto <gitter.spiros@gmail.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 16 21:09:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlNVj-0008Fb-EC
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 21:09:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992466AbaEPTJf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2014 15:09:35 -0400
Received: from smtp.pobox.com ([208.72.237.35]:53448 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2992446AbaEPTJe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2014 15:09:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5B0DC13A5B;
	Fri, 16 May 2014 15:09:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+3ZQhnivgpRInpS95Cw60z7+OLg=; b=yBjyjF
	KLFX1zmanBH/xsVSLHJ8C96xSMmIv1pm0c4t4v9EhHj+QICGWmFEMNMIlM6Y83Dt
	zP6kKdfmDrtSb4FjJe/WJn/Q4bsUfmyX6DJ/r/1ZO5p3JsMjXIoN7F1EqrKCF9wv
	6tx5NLe/lUy5E2KgTq3ZFMeoS2BCBQRRBFl+E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nZlmyVUsFZDNFR1Zh66wmpAIoXQb695h
	2B/RL2ynGyAgnY8OjQJ9aWlszu2bQLABnbgPc1zJw6gSmHtJTfvudJ5z0ff8GwB+
	+KhdQWctpEZUHtK+mSNtrFtE2Y58WnjgphfKd7Ehj7ON87t/F4IoUrE3REbEhqLh
	m1jjTz82c+Y=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4F02B13A5A;
	Fri, 16 May 2014 15:09:34 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 8C13513A58;
	Fri, 16 May 2014 15:09:31 -0400 (EDT)
In-Reply-To: <20140515155821.GA27279@google.com> (Jonathan Nieder's message of
	"Thu, 15 May 2014 08:58:22 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 9C3E1F98-DD2D-11E3-B212-B784E8FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249414>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Perhaps something like the following would work?
>
> 	tree-wide: convert test -a/-o to && and ||
>
> 	The interaction with unary operators and operator precedence
> 	for && and || are better known than -a and -o, and for that
> 	reason we prefer them.  Replace all existing instances in git
> 	of -a and -o to save readers from the burden of thinking
> 	about such things.
>
> 	Add a check-non-portable-shell.pl to avoid more instances of
> 	test -a and -o arising in the future.

Yeah, the title is certainly better than "-a or -b option" I see
above ;-) and a single tree-wide fix may be OK while the tree is
quiescent.

I however do think "better known" is much less of an issue than that
"-a/-o" is more error prone e.g. 'test -n "$x" -a a = b' is buggy
because it does not consider that $x could be "=".



> [...]
>> -			test $status = D -o $status = T && echo "$sm_path" && continue
>> +			 ( test $status = D || test $status = T ) && echo "$sm_path" && continue
>
> There's no need for a subshell for this.  Better to use a block:
>
> 			{
> 				test "$status" = D ||
> 				test "$status" = T
> 			} &&
> 			echo "$sm_path" &&
> 			continue

Yes.
