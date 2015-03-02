From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 0/5] protocol v2 for upload-pack
Date: Sun, 01 Mar 2015 18:58:48 -0800
Message-ID: <xmqqmw3wf6l3.fsf@gitster.dls.corp.google.com>
References: <CAGZ79ka8Zg86qqvWByNiP3F6a9QggO-bNY3ZZ9g+A-MdKYQ7NQ@mail.gmail.com>
	<1425085318-30537-1-git-send-email-sbeller@google.com>
	<54F2D7C2.4010700@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
	pclouds@gmail.com
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Mon Mar 02 04:01:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YSGbf-0004io-18
	for gcvg-git-2@plane.gmane.org; Mon, 02 Mar 2015 04:01:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752235AbbCBC64 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Mar 2015 21:58:56 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:61195 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751781AbbCBC64 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Mar 2015 21:58:56 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CD8583C237;
	Sun,  1 Mar 2015 21:58:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6CVpT5MkVZItXU3hFCmTwflqzPE=; b=XMm99d
	X53XK3Hr0qIq/h14MB+Dw6bMA2hv6tbp5dcluQt5OkHlrBRF3lxWKJDqnoCNd3pc
	u/RFr8z4MMMHP4IUKn3CNsaGOgiEm2aRCEKQMwOka7fyWgxXPUTD7jA/mkxEXYJ5
	uDs8sR1NhPxXe00A+ucj6Ep4OQxNFEWQQU6N8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sXLfboxT0KY8RZjS5ua/lzlonwRVcZgX
	eMekXDzpAAv4FSV54dDj1FuH9BCFHGTjxLTbikLJbPGiOTU+cE5lBhO2gYl1q12m
	YR+KqJIkvHHF3z15G4PChte0MV0ZynmhQ+tbsspsKqAcPz0+QDSU59YNnLBuQg7G
	I4IVS3WHwCI=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C5CF23C235;
	Sun,  1 Mar 2015 21:58:49 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 500953C233;
	Sun,  1 Mar 2015 21:58:49 -0500 (EST)
In-Reply-To: <54F2D7C2.4010700@kdbg.org> (Johannes Sixt's message of "Sun, 01
	Mar 2015 10:11:30 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 0CF4CF3C-C088-11E4-976F-29999F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264574>

Johannes Sixt <j6t@kdbg.org> writes:

> You may also consider an idea I proposed here:
>
> http://thread.gmane.org/gmane.comp.version-control.git/206886/focus=207342
>
> The idea is that the exchange begins as usual, but when the v2 client
> sees that the server also supports v2, then it begins sending its
> desired refs. When the server notices that the client spoke while it
> was still sending out its megabytes of ref advertisments, it stops the
> v1 advertisements and continues with v2 protocol.

Yes, it would be possible to design the protocol in such a way
provided if we can find a v1 protocol message that we can use so
that a new client will send it as "I am a client capable of talking
the new protocol" and the message appears as a no-op to older
servers.  And that would allow us to transparently upgrade the
protocol in-line.  That would be a big plus.

And there seems to be such a message for both fetch and push
protoocol, as discussed in $gmane/264512 a few days ago.

But I think the current thinking is that it is OK to avoid the
ugliness and complexity of having to say "oops, sorry but I did not
hear your 'I am new enough' soon enough and sent a lot of v1
advertisement, let's resync with v2 protocol" and instead upgrade
the old client upon the _next_ exchange (see $gmane/264309).
