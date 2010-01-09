From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] ls-files: fix overeager pathspec optimization
Date: Fri, 08 Jan 2010 23:16:08 -0800
Message-ID: <7veilzaguf.fsf@alter.siamese.dyndns.org>
References: <4B474C73.8080100@mtu.net>
 <4B4751EA.8060707@drmicha.warpmail.net>
 <20100108162404.GA5799@coredump.intra.peff.net>
 <7vr5q05z74.fsf@alter.siamese.dyndns.org>
 <20100108164132.GA6171@coredump.intra.peff.net>
 <7vskag1r5o.fsf@alter.siamese.dyndns.org>
 <7v8wc8jw3k.fsf@alter.siamese.dyndns.org>
 <7vvdfcfjxo.fsf@alter.siamese.dyndns.org>
 <7veim0w68q.fsf_-_@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1001081520240.7821@localhost.localdomain>
 <7v3a2gnnv2.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1001081619570.7821@localhost.localdomain>
 <7v8wc8kshh.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1001081701570.7821@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jon Schewe <jpschewe@mtu.net>, spearce@spearce.org,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Jan 09 08:16:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NTVYm-0003h3-Gl
	for gcvg-git-2@lo.gmane.org; Sat, 09 Jan 2010 08:16:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751296Ab0AIHQ0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Jan 2010 02:16:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751300Ab0AIHQ0
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Jan 2010 02:16:26 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:59995 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751295Ab0AIHQZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jan 2010 02:16:25 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 95EE68FA7C;
	Sat,  9 Jan 2010 02:16:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rWPR3q62hf+ULkmlw2Ddozy+v9Q=; b=JtgZYX
	QLSNfjTb88XvTjFwcj4AAl5P//NBZ3njggsmP6P5D5PfA+/fywqJLAcftTf0Pxt/
	OA4gAlcdzcI2AGH6yLJHddpQMR6lWTtuoWVnrVBujfONQfkwCaaxQtzgOlhlLXRw
	iSggC7UIInDMaPmxYmFxWJpbV2CX5aNgZrKE0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=r7+qq4XTYn9nRttSMJ4y8mbORhgH3CSN
	svl7E8oSS26gJeXrY3Mvj6Dz5yCE0x435K1ljFDuOLZDfYKEHFCiglF0EWA5pVEf
	7eIbUYqE2Jx4/Zlz3MefC4u2BZ5PsGqARxk3sG1UyfOMePp3S6EJx9K67jTqpl+G
	Qo+RIAqksHs=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 337328FA7B;
	Sat,  9 Jan 2010 02:16:17 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1F9B08FA7A; Sat,  9 Jan
 2010 02:16:09 -0500 (EST)
In-Reply-To: <alpine.LFD.2.00.1001081701570.7821@localhost.localdomain>
 (Linus Torvalds's message of "Fri\, 8 Jan 2010 17\:07\:46 -0800 \(PST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E0CEEEAE-FCEE-11DE-9F3A-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136520>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> I'd have to see both patches to be able to tell. I do admit that while I
> acked your patch, it sure ain't _pretty_ to do that special odd
> "has_leading_ignored_dir()" thing.

Revised patch (v4) series is coming shortly.
