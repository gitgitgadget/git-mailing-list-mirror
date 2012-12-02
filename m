From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/8] imap-send: change msg_data from storing (char *,
 len) to storing strbuf
Date: Sat, 01 Dec 2012 17:48:47 -0800
Message-ID: <7v624lns00.fsf@alter.siamese.dyndns.org>
References: <1353841721-16269-1-git-send-email-mhagger@alum.mit.edu>
 <1353841721-16269-7-git-send-email-mhagger@alum.mit.edu>
 <7vboegp04x.fsf@alter.siamese.dyndns.org> <50B8B66F.3090300@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeremy White <jwhite@codeweavers.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sun Dec 02 02:49:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Teyg7-0003YV-9N
	for gcvg-git-2@plane.gmane.org; Sun, 02 Dec 2012 02:49:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751702Ab2LBBsw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Dec 2012 20:48:52 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49317 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751496Ab2LBBsv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Dec 2012 20:48:51 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3FC9AA077;
	Sat,  1 Dec 2012 20:48:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7cEIZDm3bXnHFNtjNdiVAhIOV3E=; b=iham72
	58TTxoIXT+bNRH3h4GLlkpgjiCsGTzTwqt7i/ub+KGy1gC3Cex5760ntlnv/8xr7
	ACrhu55fJfyIUXVfMtF8mk+mndJlD4gfEkisCLaTsxRayKKFLlKkeCYqRWt+ycaA
	GFB3aWObqt3YNCCBQYPo1N6fFP1yXzuW3pGrY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OLFtVqOvzsH9eWY6E1lnWc589rZa73T/
	SV0/qGCexTScNYY5WZc9EBNsBmFqSR9HTIddRvR9NwW3eH5KkS1Eo6F/aWyvnI/q
	MhI0wS5V8XlkqDDfStPtnF4WPpWmYTTAi5zRGrS/XoqQvURznLshNVpWPT934Riz
	v/XKdlwJIro=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2D4CBA076;
	Sat,  1 Dec 2012 20:48:50 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 85690A075; Sat,  1 Dec 2012
 20:48:49 -0500 (EST)
In-Reply-To: <50B8B66F.3090300@alum.mit.edu> (Michael Haggerty's message of
 "Fri, 30 Nov 2012 14:36:47 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6AF54AB8-3C22-11E2-B81D-C2612E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210987>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> On 11/29/2012 10:30 PM, Junio C Hamano wrote:
> 
>>> A side effect of this change is that the memory for each message is
>>> freed after it is used rather than leaked, though that detail is
>>> unimportant given that imap-send is a top-level command.
>>>
>>> --
>> 
>> ?
>
> If by "?" you are wondering where the memory leak was, it was:

No, I was wondering if you meant to say "---" to mark te remainder
of what you wrote does not exactly belong to the log message.

>>> For some reason, there is a bunch of infrastructure in this file for
>>> dealing with IMAP flags, although there is nothing in the code that
>>> actually allows any flags to be set.  If there is no plan to add
>>> support for flags in the future, a bunch of code could be ripped out
>>> and "struct msg_data" could be completely replaced with strbuf.
>> 
>> Yeah, after all these years we have kept the unused flags field
>> there and nobody needed anything out of it.  I am OK with a removal
>> if it is done at the very end of the series.
>
> I don't think the removal of flags needs to be part of the same series.

Oh, I did not think so, either.

> I suggest a separate patch series dedicated to deleting *all* the extra
> imap infrastructure at once.  That being said, I'm not committing to do
> so.  (We could add it to an "straightforward projects for aspiring git
> developers" list, if we had such a thing.)

A "low-hanging fruit and/or janitorial work" stack may be worth
having.
