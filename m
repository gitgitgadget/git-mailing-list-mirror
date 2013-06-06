From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 0/4] real reachability checks for upload-archive
Date: Thu, 06 Jun 2013 10:27:48 -0700
Message-ID: <7vsj0vywrv.fsf@alter.siamese.dyndns.org>
References: <20120111193916.GA12333@sigill.intra.peff.net>
	<20120111194232.GB12441@sigill.intra.peff.net>
	<loom.20130529T133942-310@post.gmane.org>
	<20130605163823.GE8664@sigill.intra.peff.net>
	<20130605223551.GF8664@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ian Harvey <iharvey@good.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jun 06 19:27:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ukdyd-0002Ls-Vj
	for gcvg-git-2@plane.gmane.org; Thu, 06 Jun 2013 19:27:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751693Ab3FFR1v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Jun 2013 13:27:51 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64450 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751190Ab3FFR1v (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Jun 2013 13:27:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A26782391B;
	Thu,  6 Jun 2013 17:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=eEfi4l2FXzwiBS7/WzPxhmIHNuc=; b=mRrp4Z
	bL2WWk+Eh9jku2qFj146EwG1CRPTjQdCOIHAcLmbCHfiU2BEqJ4P5X+pEbPzZm31
	Ou5PkPT/J2cFJSZAXrpyh9QPM2D/m5lJT1HcJ3LIvMOI49I/GRi0yiMoqhu215UI
	3LnVZ/z1JygzcixjLc45x0SuVQrvSanZdwadQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=v4ikex3dLnuXmVi8209xtneeQwtnpRG1
	uOptmWQGEwoVsigXUGm5E7oNUAki96l5V0gg2p0rGEUv8tMqvwi45rK8/lXS+VO6
	H9MqVi4g3vqinQHVjloZycsfjWTrnXuhcPTMxCXl/zs6E3WwWx2ZiWdvTBfSdlHB
	ClEHeXJs3ZI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9965323918;
	Thu,  6 Jun 2013 17:27:50 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1AC7223915;
	Thu,  6 Jun 2013 17:27:50 +0000 (UTC)
In-Reply-To: <20130605223551.GF8664@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 5 Jun 2013 18:35:51 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6962C2F4-CECE-11E2-B3B2-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226516>

Jeff King <peff@peff.net> writes:

> On Wed, Jun 05, 2013 at 12:38:23PM -0400, Jeff King wrote:
>
>>   2. Actually do a reachability check. Doing a full object check to
>>      allow fetching an arbitrary tree by sha1 is probably prohibitively
>>      expensive[2], but we could allow the form "<commit>[:<path>]", check
>>      that "<commit>" is reachable, and then allow arbitrary paths within
>>      it.
>
> Thinking on this more, the full reachability check is no worse than what
> a clone has to do to fetch the full repository. Here's a series that
> does the full check. I'm not entirely happy with the performance,
> though; details are in patch 3.

For some repository-servers, it may be OK to enable this by default,
but I suspect it would be better to have at least an opt-out server
configuration.

> I think I'd be tempted to just go the more limiting "commit is
> reachable" route, instead, which would solve your case (and most sane
> cases).

Yes, I think that is a reasonable thing to do.  After all, as you
noted in 4/4, you cannot ask for a single blob, and not being able
to ask for a single tree is not much different.

>   [1/4]: clear parsed flag when we free tree buffers
>   [2/4]: upload-archive: restrict remote objects with reachability check
>   [3/4]: list-objects: optimize "revs->blob_objects = 0" case
>   [4/4]: archive: ignore blob objects when checking reachability
>
> -Peff
