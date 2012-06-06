From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Handling racy entries in the v5 format [Re: [GSoC] Designing a
 faster index format - Progress report week 7]
Date: Wed, 06 Jun 2012 10:31:26 -0700
Message-ID: <7vk3zkmjo1.fsf@alter.siamese.dyndns.org>
References: <20120604200746.GK6449@tgummerer>
 <87aa0gbwon.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Gummerer <t.gummerer@gmail.com>, <git@vger.kernel.org>,
	<mhagger@alum.mit.edu>, <pclouds@gmail.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Jun 06 19:31:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ScK51-0000sk-CN
	for gcvg-git-2@plane.gmane.org; Wed, 06 Jun 2012 19:31:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757212Ab2FFRbb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jun 2012 13:31:31 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38737 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752217Ab2FFRba (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jun 2012 13:31:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BF36E8132;
	Wed,  6 Jun 2012 13:31:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DhQVTvBhUWgfgcHgNJgkjeexJ7Q=; b=exn4Bm
	7Ble3Nbp9CB2QtbVStIUmAIhvUglt9/a+FAK3MNH643aNNqOGJzRuY8Z12XIRY9q
	WoXlCsx1dV6bfCPriMkROAI134Mz/ZlxW4/qgVhE7N2gcPcy9RhASKArDhdqWa2p
	2PY/ryO2LKTCLL0poz4LQrl3Xdm70opE603Ss=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ru98KFtxxHMwZttYyOUKIMXDYrtRehsk
	Wx8C6REXfIzKY0Cl9YFPSk7WSwuugl8nulCzKVIzyVUL6z33G1WA902efw2zYv/z
	ENC9XJFywuhzvyyf7VNW3+auJvgDj5b4EZ07Otp99ux6ro4UAqsZsGN+ucpQ4t2Z
	eHtWjP5gywY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B6C398131;
	Wed,  6 Jun 2012 13:31:28 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2D990812F; Wed,  6 Jun 2012
 13:31:28 -0400 (EDT)
In-Reply-To: <87aa0gbwon.fsf@thomas.inf.ethz.ch> (Thomas Rast's message of
 "Wed, 6 Jun 2012 11:45:44 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7298094C-AFFD-11E1-B484-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199339>

Thomas Rast <trast@student.ethz.ch> writes:

> (Michael, we have adapted it somewhat this since you left IRC.)
>
>   When writing an entry: check whether ce_mtime >= index.mtime.  If so,
>   write out ce_mtime=0.
>
> The index.mtime here is a lower bound on the mtime of the new index,
> obtained e.g. by touching the index and then stat()ing it immediately
> before writing out the changed entries.

Is this even workable?  I found that "open, read a byte, write it
back in place, then stat" was not giving useful timestamp and that
was the reason the original racy-git code chose not to do this.

You may be able to do "open, read a byte, write it back in place,
fsync, close and then stat", but doing so while holding that file
also as a lock feels somewhat dirty...
