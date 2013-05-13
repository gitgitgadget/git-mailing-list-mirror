From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 03/10] refs.c: Refactor code for mapping between shorthand names and full refnames
Date: Sun, 12 May 2013 21:56:14 -0700
Message-ID: <7vmwrzsck1.fsf@alter.siamese.dyndns.org>
References: <1368289280-30337-1-git-send-email-johan@herland.net>
	<1368289280-30337-4-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, jrnieder@gmail.com
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Mon May 13 06:56:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ubko8-0004Tu-RE
	for gcvg-git-2@plane.gmane.org; Mon, 13 May 2013 06:56:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751436Ab3EME4R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 May 2013 00:56:17 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41676 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750763Ab3EME4Q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 May 2013 00:56:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E11D01985F;
	Mon, 13 May 2013 04:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=kYrVq2VTTsLA2nkoWW1Eo/UZSqA=; b=eUQqAxPhe1lsdvkQd0Kk
	6lE3krjJDK0BzT4+wbjUFC23E14/1ZToGWjpZksWrSQbsbceybP6KvJ6T+dz9lIO
	2CJOAlax0WpcTprOSPTpEXvC33a2aN/jECIM04nx/OI1vyZTnX2eiagjGD1BxmPN
	bm+NqPPYV2IvwYL5P0b5/Tw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=iKUhnVuYtKHPYJBcLwlI1ILSGjNpOPD7Cn3ZJsZsgrA1rh
	aV0GPCozlq8cjVYteet9JYIAZRskJqLBFNvPb7i02AeB0U4iuvYw/VOoAi0C0mTc
	e371VzdWpMIrnyc8usVyvPmaRscXt14L4o/fVuDftCh9K+fMyODY6iRMTj+QE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D4A1D1985E;
	Mon, 13 May 2013 04:56:15 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 587ED1985A;
	Mon, 13 May 2013 04:56:15 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 70E8794A-BB89-11E2-81BA-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224083>

Johan Herland <johan@herland.net> writes:

> The refname_expand() function no longer uses mkpath()/mksnpath() to
> perform the pattern expansion. Instead, it uses strbuf_expand(), which
> removes the need for using fixed-length buffers from the code.

It is a brilliant idea to use strbuf_expand() for this. I like it.

I notice that you later introduce %1 (that is 'one', not 'el'), but
unless you are planning to introduce %2 and %3 that semantically
fall into a similar category as %1, I would rather see a different
letter used that is mnemonic to what the placeholder _means_.  

The choice of the letter is arbitrary and may not look like it
matters that much, because it is not exposed to the end user.  But
by switching from the sprintf() semantics that shows things given to
it in the order they were given, without knowing what they mean, and
introducing a strbuf_expand() machinery tailored for refnames (and
refnames only), the new code assigns meanings to each part of the
refname, and we can afford to be more descriptive.

The choice of '%*' is justifiable, "it is the closest to the '*' we
traditionally used to replace only one thing", but '%1' does not
look the best placeholder to use, at least to me.
