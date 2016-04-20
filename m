From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/5] fix deadlock in git-push
Date: Wed, 20 Apr 2016 14:17:16 -0700
Message-ID: <xmqqwpnst1yb.fsf@gitster.mtv.corp.google.com>
References: <20160419223945.GA18055@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 20 23:17:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aszUy-0000l7-6i
	for gcvg-git-2@plane.gmane.org; Wed, 20 Apr 2016 23:17:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751391AbcDTVRU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Apr 2016 17:17:20 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53882 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751078AbcDTVRT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2016 17:17:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 92B1014526;
	Wed, 20 Apr 2016 17:17:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TnfJyktIVCccLxHtSsHmgbi3+YY=; b=Qg7k6f
	UAyfn3oEszVNELJoLa2xPVQ6k8zrR9OrLHRx1Vi9fHbglw628hElcN2VWzq5vAae
	IeCrV1htjP+0F+WRrZt40kiIUZ2w0FEulXcf40WSvyj9PDRDNV4tUkCo9mjKFppj
	Fmvy+dzifFFtMr6L7BDLcirPcr0P5tnSH7WZQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VRVL5Ms4pwA70c8e4RGP4VArj95/Q2ma
	jAcNW4g1f3qiHB5CtXHRYDsOMZn369Uaqjhq0ZZ6aF+6ARlxzylXWFyoahX8HeJV
	nAOoWJNORQk5/6ibosRx2IOyZajXo37LVadEDd6Q+qNNRZKYMAfSdE3MQfnIYPgQ
	y6nLSxFBAck=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 8B43014525;
	Wed, 20 Apr 2016 17:17:18 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0565114524;
	Wed, 20 Apr 2016 17:17:17 -0400 (EDT)
In-Reply-To: <20160419223945.GA18055@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 19 Apr 2016 18:39:46 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 4307AF8E-073D-11E6-A98B-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292082>

Jeff King <peff@peff.net> writes:

> The first patch below fixes the deadlock. Unfortunately, it turns it
> into a likely SIGPIPE death. Which is an improvement, but not ideal.
>
> Patches 2 and 3 address that by fixing the way we handle SIGPIPE in
> async threads.
>
> Patches 4 and 5 are cleanups to earlier topics that are enabled by the
> new SIGPIPE handling.
>
>   [1/5]: send-pack: close demux pipe before finishing async process
>   [2/5]: run-command: teach async threads to ignore SIGPIPE
>   [3/5]: send-pack: isolate sigpipe in demuxer thread
>   [4/5]: fetch-pack: isolate sigpipe in demuxer thread
>   [5/5]: t5504: drop sigpipe=ok from push tests

Thanks for a very well explained series.

We do not call finish_async (rather, we do not use async) from that
many places, and from a cursory look this codepath is the only case
where we may encounter this kind of deadlock (the ones in
receive-pack is about relaying the error messages back to the other
end over sideband multiplexing)?
