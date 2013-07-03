From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFD] Making "git push [--force/--delete]" safer?
Date: Wed, 03 Jul 2013 12:53:45 -0700
Message-ID: <7vmwq3e7xy.fsf@alter.siamese.dyndns.org>
References: <7vfvvwk7ce.fsf@alter.siamese.dyndns.org>
	<CALKQrgenpqKUxOZ+p79NsaQD9M2-q4h93ZqN0oencVo-QZF=zg@mail.gmail.com>
	<CALKQrgdovWTd50LVDnNR+BhurWgSCKkhr88wCo01VZF3sd5PNg@mail.gmail.com>
	<7vli5ogh8r.fsf@alter.siamese.dyndns.org>
	<CALKQrge_REZKfds0T-owJOn2BvfLmHpk7yQeSog=yvofE_zKJQ@mail.gmail.com>
	<CAF5DW8++sc2VYmdJEjbD_ue_wtDFj21vcyFzNWU0M+rAm2X0sQ@mail.gmail.com>
	<CALKQrgfQhVVC1NxizjCQdDmNfihfyEgypYddWB0CMTPqW9Mxtg@mail.gmail.com>
	<51D40203.1010100@alum.mit.edu> <51D413BA.6080709@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Johan Herland <johan@herland.net>,
	Jonathan del Strother <maillist@steelskies.com>,
	git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Jul 03 21:53:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UuT7h-0006MR-AV
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jul 2013 21:53:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756066Ab3GCTxt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jul 2013 15:53:49 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59911 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753118Ab3GCTxs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jul 2013 15:53:48 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E40062DD44;
	Wed,  3 Jul 2013 19:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ndZ+5Y3YXuLwvQQ3tqM5j9g8TNo=; b=HsVf4N
	3WBfIuHjBf7uUIDezMPdy1npHf3+D+gNBO17l1lldxJmP/nF58xNNVL9Tnhr/QgU
	RHJpb3+AvD8eL9izt0JoXA0nHtcZfDfM4zlLVsFcpQ/WlBN0D7ARvTstItlkJxIp
	0GbTYs6fZNooHuoDfg+U75EPgKIphzVVBYfSE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VcjC87fkHwwYCSYBw4Kea7jNfqsG87zi
	RE1M9ZBfdNCMZT3aAAek8RtqHq3Oof7y6oRNtPZnj8FqdR3aaDPdgcsPM5wH4eA0
	x3eXPYYzfsCkIYSCbmc4gtNZJifcuI110P3h6txgA6eMiuzROKtHgjMnSqBFYStX
	tlmhqPTtueo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D78562DD43;
	Wed,  3 Jul 2013 19:53:47 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4B20D2DD41;
	Wed,  3 Jul 2013 19:53:47 +0000 (UTC)
In-Reply-To: <51D413BA.6080709@viscovery.net> (Johannes Sixt's message of
	"Wed, 03 Jul 2013 14:06:18 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 463CDC36-E41A-11E2-8B67-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229516>

Johannes Sixt <j.sixt@viscovery.net> writes:

> I don't think that is necessary. We already have *two* options to
> force-push a ref: the + in front of refspec, and --force.

They mean exactly the same thing; the only difference being that "+"
prefix is per target ref, while "--force" covers everything, acting
as a mere short-hand to add "+" to everything you push.

If the "--lockref/--update-only-if-ref-is-still-there" option
defeats "--force", it should defeat "+src:dst" exactly the same way.
