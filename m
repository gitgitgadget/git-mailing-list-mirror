From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/2] add interface for /dev/tty interaction
Date: Mon, 06 Aug 2012 13:01:38 -0700
Message-ID: <7v1ujjzt5p.fsf@alter.siamese.dyndns.org>
References: <1336287330-7215-1-git-send-email-rctay89@gmail.com>
 <1344192340-19415-1-git-send-email-rctay89@gmail.com>
 <1344192340-19415-2-git-send-email-rctay89@gmail.com>
 <7vsjc12j5o.fsf@alter.siamese.dyndns.org>
 <20120806194511.GB10039@sigill.intra.peff.net>
 <20120806195616.GC10039@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tay Ray Chuan <rctay89@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Aug 06 22:01:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SyTUv-0005ws-St
	for gcvg-git-2@plane.gmane.org; Mon, 06 Aug 2012 22:01:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964771Ab2HFUBn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Aug 2012 16:01:43 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33972 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756886Ab2HFUBm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Aug 2012 16:01:42 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E86C89E72;
	Mon,  6 Aug 2012 16:01:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xAd+oJINlA/xK8XJ+w3pbWWRz2g=; b=stalej
	NsmZXnLF9yKvTz8aaKS6xrzCt+muUEfh6GA7y8IrMpBmrKeNeQM+Q+NkDUtcUrkW
	uMc9Bt3TlR3rqwdzzsNRAD+2oQDCbK9ydMzDtaeP4Xvy66KPTTLaZBIRdPGBtyXp
	XOtfzXV72N+hTzHTiFK84NJ9sWDVxeMB0MmIk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ptT5sMoK5hLOdmHapZcRtIopKQqDUYFn
	3RoFmtVzxrh8NhNpCA6HO5NMB3VFexZRzMny1EmkV9XbC1o6ctL/rPvtDmSjPjgr
	U79UdvUOcKSUohpNNzoFJgJxu9bvRsEXugx2+kmiMmifUuE9NBp9W37htXuDf3Nv
	LMm9FTLon+E=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D485C9E71;
	Mon,  6 Aug 2012 16:01:41 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 518529E6F; Mon,  6 Aug 2012
 16:01:41 -0400 (EDT)
In-Reply-To: <20120806195616.GC10039@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 6 Aug 2012 15:56:16 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8A0B67CA-E001-11E1-8DCE-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202981>

Jeff King <peff@peff.net> writes:

> Erik has looked into doing a Windows alternative in compat/terminal.c,
> and I think an integer would be insufficient there. In particular, I
> think Windows needs two descriptors to accomplish the same thing (one
> for CONIN$ and one for CONOUT$).  So you'd need to turn term_t into a
> struct (and you'd probably not want to return it by value then).
>
> Maybe it would be better to keep the abstraction as non-leaky as
> possible, and just provide "terminal_can_prompt()" or similar?

OK.  As we won't be giving separate instances of terminals to
different callers anyway, compat/terminal.c can keep a static
variable of whatever type that is necessary for the implementation
around.  That sounds like a reasonable way to go.

> Returning the open descriptor (as Tay's patch does) avoids a race
> condition where /dev/tty can be opened when terminal_can_prompt runs,
> but not when we try to actually read from it. But we can either:
>
>   1. Not care. Even if the tty is opened, if a user has closed the
>      terminal we are going to get a read error anyway. So you can never
>      avoid that race condition in some form.
>
>   2. Open the terminal descriptor when either function is called, and
>      never close it. I don't think there is any reason we can't just
>      leak the descriptor.
>
> -Peff
