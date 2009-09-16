From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 0/2] Speed up fetch with large number of tags
Date: Wed, 16 Sep 2009 15:52:37 -0700
Message-ID: <7vtyz2wlhm.fsf@alter.siamese.dyndns.org>
References: <20090916074737.58044.42776.julian@quantumfyre.co.uk>
 <7vbplb2pi7.fsf@alter.siamese.dyndns.org>
 <alpine.LNX.2.00.0909162141140.13697@reaper.quantumfyre.co.uk>
 <20090916224253.GB14660@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Julian Phillips <julian@quantumfyre.co.uk>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Sep 17 00:54:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mo3Ob-0000R9-97
	for gcvg-git-2@lo.gmane.org; Thu, 17 Sep 2009 00:54:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757939AbZIPWwp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2009 18:52:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754568AbZIPWwp
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Sep 2009 18:52:45 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:53299 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755262AbZIPWwo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Sep 2009 18:52:44 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 283D4531A0;
	Wed, 16 Sep 2009 18:52:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/OqmC+H05xRLhxejuUamptn3OhM=; b=QsmMAa
	eiRMOLinN9Uu79wWM/5YhYju4oLn2IzL5djIa+5ZLtaISCxKtNuPfhOl6Ll+MhiD
	GRmoXbUJ2Ifvp4mC8zn81QYj1PvUimFGKJzS7pd2bdyAcHqMVScMWyrMOOugM90r
	xbv2hDY/PeQvLsn9O5NVePzAbqY+FfA3Jxs0M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xLM+Jc+VQnGc9oTXwvMB6wGoe9tr9XRs
	dEi+lTfYfft2tUWNygsraTqjfyG/2pODRlGsPXLtWn3OND2yu4kPf10jZHhfhXof
	nqpUxTLLM9UjeWVrOA5ZHa6CvVl1aRtCkPKr+fhO34wo68FVGUEcDFTW4aCZB/mI
	CEf3dpGLPvo=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id F37B45319F;
	Wed, 16 Sep 2009 18:52:43 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 8FF675319D; Wed, 16 Sep 2009
 18:52:39 -0400 (EDT)
In-Reply-To: <20090916224253.GB14660@spearce.org> (Shawn O. Pearce's message
 of "Wed\, 16 Sep 2009 15\:42\:53 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A53976FA-A313-11DE-ADA8-8B19076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128689>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> JGit depends on the fact that the refs list is sorted by the remote
> peer, and that foo^{} immediately follows foo.  I don't think this
> has ever been documented, but all sane implementations[1] follow
> this convention and it may be something we could simply codify as
> part of the protocol standard.
>
> [1] Sane implementations are defined to be what I consider to be
>     the two stable implementations in deployed use, git.git and JGit.

There is no strong reason for ordering of refs between themselves
(i.e. refs/heads/master comes before refs/heads/next) other than the fact
that we sort and then walk due to packed-refs reasons.

But emitting tag X and then its peeled representation X^{} immediately
after it is quite fundamental in the way how anybody sane would implement
ls-remote.  There is no reason to violate the established order other than
"I could do so", and in order not to show X and X^{} next to each other,
you would need _more_ processing.

So I would say it is very safe to assume this.

Also, you might not have noticed, but my illustration patch was merely
using it as a hint to optimize, and if the last ref we saw was not X when
it is turn to handle X^{}, it simply falled back to the original logic,
iow, the patch never compromised the correctness.
