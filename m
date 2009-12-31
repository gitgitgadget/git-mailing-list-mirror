From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/6] run-command: optimize out useless shell calls
Date: Thu, 31 Dec 2009 11:47:42 -0800
Message-ID: <7v4on7x6w1.fsf@alter.siamese.dyndns.org>
References: <20091230095634.GA16349@coredump.intra.peff.net>
 <20091230105536.GC22959@coredump.intra.peff.net> <4B3CD74D.7020605@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Nanako Shiraishi <nanako3@lavabit.com>,
	git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Thu Dec 31 20:47:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NQR02-0006fI-Gp
	for gcvg-git-2@lo.gmane.org; Thu, 31 Dec 2009 20:47:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751162AbZLaTrz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Dec 2009 14:47:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751129AbZLaTry
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Dec 2009 14:47:54 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:58368 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750889AbZLaTry (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Dec 2009 14:47:54 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0DB898C756;
	Thu, 31 Dec 2009 14:47:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pM8yTyOiU2tks3a2T+t0WtDqwTY=; b=EYiSXB
	FIGEcgYjN2pkX/Rst2sVNyJpvi1AO6Vaw5woHeoxKtg1O9V5rab7Bri2y+8fT19I
	CD9zpxzqw0GZOHbv0XwQVxsRvSHg8O6bqcnoCcMOb/voYChvOan6ktR6U1vCsdN7
	xkVzkmZ69jz+ZM7HBKr1bGI5Syy1kuxC65Ddw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sfbrLc6U9H27/sK1jwiBTuJxHAhxfEz3
	a4xhxg3lXudqWk+BHafzvKqeLI12frHJEB+mX+dvs+91rJBOzZaD8yqhtjst/YnZ
	DmAbonJJzli6ghKMEucBbl7gGFkjPKW/XaGCoQzdFKMthmVLgLOwLUxbDyBfhJsG
	8f9l+o5e4Vs=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C8AA98C752;
	Thu, 31 Dec 2009 14:47:47 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 11FBB8C74F; Thu, 31 Dec
 2009 14:47:43 -0500 (EST)
In-Reply-To: <4B3CD74D.7020605@kdbg.org> (Johannes Sixt's message of "Thu\,
 31 Dec 2009 17\:54\:37 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 5F311E26-F645-11DE-B283-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135968>

Johannes Sixt <j6t@kdbg.org> writes:

> to help people set
>
>  PAGER=C:\Program Files\cygwin\bin\less
>
> That is, we first try to run the program without the shell, then retry
> wrapped in sh -c.
>
> Wouldn't it be possible to do the same here, assuming that we don't
> have programs such as "editor -f" in the path?

It is a cute idea that covers 70-80% of the cases, as you also have to
assume that you don't have to specify your own pager on a path with IFS
(e.g. "Program files" in your example) and give your parameter to the
pager at the same time, e.g.

    PAGER="C:\Program Files\cygwin\bin\less -FRSX"

Because it has its own LESS environment to set FRSX and you can get away
with:

    PAGER="C:\Program Files\cygwin\bin\less"
    LESS=FRSX

"less" is not a representative example for this issue.  In real life I
suspect that custom programs that we don't ship with git (or you don't
ship with msysgit) would lack such a workaround, (and that is why I didn't
say "98% of the cases").
