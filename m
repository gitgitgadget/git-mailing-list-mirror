From: Junio C Hamano <gitster@pobox.com>
Subject: Re: How to handle terminal detection in a daemon calling git?
Date: Wed, 30 May 2012 23:22:58 -0700
Message-ID: <7vaa0o98e5.fsf@alter.siamese.dyndns.org>
References: <1338412607.9452.140661082904349.02F677C3@webmail.messagingengine.com>
 <20120531012908.GD5488@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Travis P <git@castle.fastmail.fm>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 31 08:23:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SZymp-0003Zz-CN
	for gcvg-git-2@plane.gmane.org; Thu, 31 May 2012 08:23:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753551Ab2EaGXD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 May 2012 02:23:03 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49711 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753275Ab2EaGXB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 May 2012 02:23:01 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 520245D7D;
	Thu, 31 May 2012 02:23:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=o1fEMwBPS5sN7NulJNL7loA8fng=; b=mkoDUf
	gG+wpnxuyIqjFV0EMAHNwQiFF30Bq31sai3NFYWSJ+cs9nyyg3KtrOt3Q56QGI6/
	8JbUhH5AaxFo6Vtt0bnz0R/CKeNgnZVV7QO0/eajq5GrffX7fXZmajl8Mmsh9grh
	sLTBxHOlbrJN3H6oeTEXUTS4Hxp6kXwMR2u78=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ba5gwBYU9abXYaYjoL2oD2AnHcC/vU26
	kno2asvJvfCqeTGEp/SL/vWujRUwS29YBFhq5G5shHOFoLaYIl2ZEn+Vnwu/qGVA
	XTH3i3uTOvKr6rhEIpTIjrZGWMAnLkRjFNkmavHtcVIFlZCCW7/1cYDLlP6HnJ7d
	668KBXqWVA4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 491875D7C;
	Thu, 31 May 2012 02:23:00 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D402A5D78; Thu, 31 May 2012
 02:22:59 -0400 (EDT)
In-Reply-To: <20120531012908.GD5488@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 30 May 2012 21:29:09 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 11B1CDC0-AAE9-11E1-B172-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198860>

Jeff King <peff@peff.net> writes:

> On Wed, May 30, 2012 at 04:16:47PM -0500, Travis P wrote:
>
>> I've got a script that runs in the background without a terminal.
>> It actually does have STDOUT and STDERR set to a rotating log file.
>> 
>> When it runs:
>>   /bin/sh -c 'cd /to/my/wc; git pull --ff-only'
>> the git command fails (rc 32768).
>> 
>> When it runs
>>  /bin/sh -c 'cd /to/my/wc; git pull --ff-only > /to/a/file 2>&1'
>> 
>> or even
>>  /bin/sh -c 'cd /to/my/wc; git pull --ff-only | cat'
>> 
>> then all is well.  The command succeeds (rc 0, and I see the expected
>> results).
>
> If your stdout and stderr are not a terminal in the first place (you say
> they go to a rotating log file), then that should not be making a
> difference. Are they connected by a pty or something odd?

A more likely failure case is when fd 0, 1 and 2 are _closed_.

I vaguely recall we once saw a failure report for that particular
case, and then audited the code several years ago, but I do not
offhand know if we have regressed over time.
