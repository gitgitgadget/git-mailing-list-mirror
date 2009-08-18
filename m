From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] graph API: fix bug in graph_is_interesting()
Date: Tue, 18 Aug 2009 16:53:45 -0700
Message-ID: <7vk5103chi.fsf@alter.siamese.dyndns.org>
References: <1250628954.114121983@192.168.1.201>
 <20090818211812.GL8147@facebook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Santi =?utf-8?Q?B=C3=A9jar?= <santi@agolina.net>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Aug 19 01:54:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdYVK-0002jf-3s
	for gcvg-git-2@lo.gmane.org; Wed, 19 Aug 2009 01:54:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751658AbZHRXxw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Aug 2009 19:53:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750900AbZHRXxv
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Aug 2009 19:53:51 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:48158 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751054AbZHRXxv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Aug 2009 19:53:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 882072E446;
	Tue, 18 Aug 2009 19:53:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4DEAlWbYx8a37EbNHILJttZdQU4=; b=UHjq4k
	IcJqimagma0XMRkvW0OG7FlcfcKXIkTuEdiD4youuiRRqZTj1YQLEasbfqFTH7/8
	Cyl6GoZNhEoJ6Xe14cXN55xAOb++M/7iFnMDx7jqp30KcwGuEmaDUCUN74aOb1IH
	+DGyGgwYfbwEGJbnFiT3W9V/pqZZB4krOxC20=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JBG4fAHU07DRoukp28pz1SxVmTxUjaWW
	UJja+0B13kqWMqyInHnTvFCdxx0z29ZNDBgQKjM2g/zMIRPXXDhFu5h3kUKNLHzH
	zlsCttIkD2zJy2LZtD/Yv9L5pKNwpaRu9kr/795oTKbG4dKj9upXUUmqux2PRcsr
	JMUX6uF30zM=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 678302E445;
	Tue, 18 Aug 2009 19:53:50 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 5A21D2E444; Tue, 18 Aug 2009
 19:53:47 -0400 (EDT)
In-Reply-To: <20090818211812.GL8147@facebook.com> (Adam Simpkins's message of
 "Tue\, 18 Aug 2009 14\:18\:12 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 609C7A2E-8C52-11DE-8CAA-3142836986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126485>

Adam Simpkins <simpkins@facebook.com> writes:

> -	return (commit->object.flags & (UNINTERESTING | TREESAME)) ? 0 : 1;
> +	return simplify_commit(graph->revs, commit) == commit_show;

If you do this after revision.c finished the traversal (e.g. "limited"
case), I think it should be Ok.

But calling simplify_commit() while the traversal is still in progress is
asking for trouble.  I do not recall the details anymore but when I tried
to make the "simplify-merges" algorithm incremental, I had seen funny
breakage caused by calling simplify_commit() twice on the same commit.

I suspect that this change will break the primary traversal.
