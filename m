From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] receive-pack: send pack-processing stderr over
 sideband
Date: Fri, 21 Sep 2012 09:49:40 -0700
Message-ID: <7v7grn8gnv.fsf@alter.siamese.dyndns.org>
References: <20120921053057.GA9768@sigill.intra.peff.net>
 <20120921053455.GB9863@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Sep 21 18:50:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TF6QM-0005AM-Ed
	for gcvg-git-2@plane.gmane.org; Fri, 21 Sep 2012 18:49:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756411Ab2IUQtp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Sep 2012 12:49:45 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42530 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751932Ab2IUQto (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Sep 2012 12:49:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7B6358EB1;
	Fri, 21 Sep 2012 12:49:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4G/KmC/18tUJqNCfwhwb5cI1VlM=; b=YlLSjH
	ZsSaeq1f7sknFzJjGBkVrmQJ3i2nzxxrFhkS7Rw8TRjt4TNcVpokC//V+FsqMo2d
	shmvxIaLedGp0oT8gbdoeyvWZrYYEg7soCx8fxWpHnpFHQVA4Y4KeXE73GaAuhCU
	GWqt9UydgQQScblcLaLU5Z2yRSFJiQb3xOXgg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KJKjvITjg9Nc/C3vln4QBPeMEIwZRRvT
	MF4Ufjj9F2vBrG5weO60ZfpoFtWEMwSyRr3vemtFboLUbybTcDC6ZMHmXKqntRY8
	ZH0jGCMsnaCPqqt5JmZ/ykrgeZHvvtCsGNuybYM4HtiSohbGlJhipWLsdxPAaEW/
	BTc1C8VO/4o=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6100E8EAF;
	Fri, 21 Sep 2012 12:49:43 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 017188EAB; Fri, 21 Sep 2012
 12:49:41 -0400 (EDT)
In-Reply-To: <20120921053455.GB9863@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 21 Sep 2012 01:34:55 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 56FF23B0-040C-11E2-9CAD-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206132>

Jeff King <peff@peff.net> writes:

> Receive-pack invokes either unpack-objects or index-pack to
> handle the incoming pack. However, we do not redirect the
> stderr of the sub-processes at all, so it is never seen by
> the client. From the initial thread adding sideband support,
> which is here:
>
>   http://thread.gmane.org/gmane.comp.version-control.git/139471
>
> it is clear that some messages are specifically kept off the
> sideband (with the assumption that they are of interest only
> to an administrator, not the client). The stderr of the
> subprocesses is mentioned in the thread, but it's unclear if
> they are included in that group, or were simply forgotten.
>
> However, there are a few good reasons to show them to the
> client:
>
>   1. In many cases, they are directly about the incoming
>      packfile (e.g., fsck warnings with --strict, corruption
>      in the packfile, etc). Without these messages, the
>      client just gets "unpacker error" with no extra useful
>      diagnosis.
>
>   2. No matter what the cause, we are probably better off
>      showing the errors to the client. If the client and the
>      server admin are not the same entity, it is probably
>      much easier for the client to cut-and-paste the errors
>      they see than for the admin to try to dig them out of a
>      log and correlate them with a particular session.

I agree with the "probably" above (and also with points 1 and 3),
but it at the same time feel a bit iffy.  The server side would lose
log entries to check when the operator observes higher error rate
and starts suspecting something recently broke, and the lost clue
cannot be recovered without contacting the pushers, no?

>   3. Users of the ssh transport typically already see these
>      stderr messages, as the remote's stderr is copied
>      literally by ssh. This brings other transports (http,
>      and push-over-git if you are crazy enough to enable it)
>      more in line with ssh. As a bonus for ssh users,
>      because the messages are now fed through the sideband
>      and printed by the local git, they will have "remote:"
>      prepended and be properly interleaved with any local
>      output to stderr.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---

Will queue; thanks.
