From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Don't search files with an unset "grep" attribute
Date: Wed, 01 Feb 2012 08:28:46 -0800
Message-ID: <7vd39y4iwx.fsf@alter.siamese.dyndns.org>
References: <7vy5sy8e0y.fsf@alter.siamese.dyndns.org>
 <1327359555-29457-1-git-send-email-conrad.irwin@gmail.com>
 <7vaa5d4mce.fsf@alter.siamese.dyndns.org>
 <20120125214625.GA4666@sigill.intra.peff.net>
 <7vhazb3rtm.fsf@alter.siamese.dyndns.org>
 <20120201082005.GA32348@sigill.intra.peff.net>
 <20120201091009.GA20984@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Conrad Irwin <conrad.irwin@gmail.com>, git@vger.kernel.org,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Dov Grobgeld <dov.grobgeld@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 01 17:28:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rsd3H-0005Jc-Ij
	for gcvg-git-2@plane.gmane.org; Wed, 01 Feb 2012 17:28:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756498Ab2BAQ2u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Feb 2012 11:28:50 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40774 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753797Ab2BAQ2t (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Feb 2012 11:28:49 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F2A817B78;
	Wed,  1 Feb 2012 11:28:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cwLHbJhPW/qSYG8lgBJAarf1xFE=; b=eRFNTs
	8CzyxSLYjFRlfWJrjpG+V3dbKHTL+6xKC0b+jaiF/TnoqaXb56NdfZ/+rUdr6CbM
	fSaeENqyY/VXLEmQZZxreK2YgSQj9UVMXiWwuPsXUY2U1zPUfM3XfrDsGoOOKx6j
	aB7TydQGEx452yYZ1U2yOkds8bY+oxisuA9Zc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aL09i6w6sUXmlr+UJwi2hFwAS9xnqDQD
	dH53TZzMeS5FLd+fPY1UT4elkXHKf1wLVyNsubdcYu2FgP7tT5rbDAhop2t0V2Y2
	GPQdjYdmzRBuyfBdNyHiavFQxDbjEjDrnoRX4GWgZknqXQ8ZaCXzjBPbpyvv7y7B
	aIPSSeLGZKA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E98B97B77;
	Wed,  1 Feb 2012 11:28:48 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 598D37B74; Wed,  1 Feb 2012
 11:28:48 -0500 (EST)
In-Reply-To: <20120201091009.GA20984@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 1 Feb 2012 04:10:09 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D184D18E-4CF1-11E1-A9D6-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189521>

Jeff King <peff@peff.net> writes:

> Part of the problem, I suspect, is that the attribute lookup code is
> optimized for locality. We only unwind as much of the stack as we need,
> so looking at "foo/bar/baz.c" after "foo/bar/bleep.c" is much cheaper
> than looking at "some/other/directory.c". But with threaded grep, that
> locality is likely lost, as we are mixing up attribute requests from
> different threads.
>
> Given that binary lookup means we need every file's gitattribute, it
> might be better to look them up serially at the beginning of the
> program, and then pass the resulting userdiff driver to grep_buffer
> along with each path.

Yeah, that was my impression when the performance of threaded grep was
discussed, which was before this "let's honor binary attribute".
