From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Possible regression: overwriting untracked files in a fresh repo
Date: Mon, 24 Aug 2009 15:39:26 -0700
Message-ID: <7viqgc3kgx.fsf@alter.siamese.dyndns.org>
References: <alpine.DEB.1.00.0908241829510.11375@intel-tinevez-2-302>
 <20090824190710.GB25168@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Aug 25 00:39:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MfiCd-0001LB-5p
	for gcvg-git-2@lo.gmane.org; Tue, 25 Aug 2009 00:39:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753619AbZHXWjk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Aug 2009 18:39:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753501AbZHXWjk
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Aug 2009 18:39:40 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:36509 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752885AbZHXWjj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Aug 2009 18:39:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 63001369F5;
	Mon, 24 Aug 2009 18:39:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=sj64D1+z3lqi6r4T5FKl7TiO2Mg=; b=KTCk1M
	GaNGYWz0M9izQHwND+7yNx++6SRBA/r48+pcN4Bewtyfb+ExLdkZjsfeu664eUWk
	MoJnrHsw0HqEvPeIs6BjLnNWLQ8Bd0yPQdFdnGYdcOpD9+ZTMNKZJb2u9AJG6Dmp
	luJ3WIEnpMA2tUjJNWpdMsBQHZQgWl7ibkB6I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IbSTY+4SY62XbQHwfLEkFPnamJSpuDRn
	z2ec5NujmsRCpm+ZspwgcVG8KvfgiQbRfj2Xx1fwTQKGMEh871eNV4/eSFCf7oba
	EsdLQzRG0v9B0PdEJr0gdV/e57gHDRTmnNdwkecMymKC8KmldU/udK+OQXIIT2Eb
	e0o4AgS19Hg=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 38D3E369F1;
	Mon, 24 Aug 2009 18:39:33 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 50146369D7; Mon, 24 Aug 2009
 18:39:27 -0400 (EDT)
In-Reply-To: <20090824190710.GB25168@coredump.intra.peff.net> (Jeff King's
 message of "Mon\, 24 Aug 2009 15\:07\:10 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: FE65B4D6-90FE-11DE-AB50-8B19076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126979>

Jeff King <peff@peff.net> writes:

> However, if I then do this:
>
>   (cd parent && echo content >another && git add . && git commit -m more)
>   (cd child && git fetch ../parent && git checkout -b new FETCH_HEAD)
>
> then it does complain. I'm guessing there is a different code path for
> the case that we have no index at all, and that it is not properly
> checking for overwrites.

I think it is this "opts->force = 1" done when you are on an unborn
branch.

	if (!old.commit && !opts->force) {
		if (!opts->quiet) {
			warning("You appear to be on a branch yet to be born.");
			warning("Forcing checkout of %s.", new->name);
		}
		opts->force = 1;
	}
