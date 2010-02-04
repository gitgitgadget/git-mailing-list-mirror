From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fast-import: Stream very large blobs directly to pack
Date: Wed, 03 Feb 2010 18:25:09 -0800
Message-ID: <7vock5yby2.fsf@alter.siamese.dyndns.org>
References: <20100129012350.GD20488@spearce.org>
 <fabb9a1e1001291035l5cd09cb6q1f12037f96dce8a1@mail.gmail.com>
 <20100129183705.GB22101@spearce.org>
 <7vockc45ut.fsf@alter.siamese.dyndns.org>
 <7vmxzw15dt.fsf@alter.siamese.dyndns.org>
 <7v3a1oyrkp.fsf@alter.siamese.dyndns.org> <20100201152826.GE8916@spearce.org>
 <7v7hqtzrmq.fsf@alter.siamese.dyndns.org>
 <20100204020756.GP14799@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	git <git@vger.kernel.org>, Nicolas Pitre <nico@fluxnic.net>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Feb 04 03:25:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcrPM-0001Hb-66
	for gcvg-git-2@lo.gmane.org; Thu, 04 Feb 2010 03:25:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756521Ab0BDCZX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Feb 2010 21:25:23 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:50646 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755639Ab0BDCZW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2010 21:25:22 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id EC8FE967AE;
	Wed,  3 Feb 2010 21:25:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6II3fv1way2vgeOztRqow+cE0pQ=; b=OAX1jE
	7f3PV0re+nzEXQZ2oHp5FbNGSkUj+OQYQp8h2rLfFPVRibslc48WLrAqZM255+Kr
	wAMmYNshNn3aIZqe/g5ZBbicttVsf00Axtvnn04iFQ0Jy7kwyEREds9O68XjYdcg
	a7ylCd0yhuwbZk3TujQUwESupXcmE4oIi9CjI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Fbiwe01nPmBE9US1cpY4BN5eMCYLK31R
	OH4Y7NiAfH7FoKtVv2SoAOAylfYrDDUZL6PVj2iohfoR9s5JAW0yC9KKzxqw+6/X
	9jPxbAoORyX1u9nApbGXkngGkN+//3YtTDIblNID7FUv5nhvWZPScJtojlrbbW/Z
	abs1VNUfzxk=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A778A967A1;
	Wed,  3 Feb 2010 21:25:16 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A8F4A96797; Wed,  3 Feb
 2010 21:25:10 -0500 (EST)
In-Reply-To: <20100204020756.GP14799@spearce.org> (Shawn O. Pearce's message
 of "Wed\, 3 Feb 2010 18\:07\:56 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 88433CD6-1134-11DF-831C-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138934>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> In my v3 patch I thought I replaced this code with:
>
> +               else if (!prefixcmp(a, "--big-file-threshold=")) {
> +                       unsigned long v;
> +                       if (!git_parse_ulong(a + 21, &v))
> +                               usage(fast_import_usage);
> +                       big_file_threshold = v;
>
> So we relied on git_parse_ulong to handle unit suffixes as well.

Yeah, you did; but it didn't carried through the merge process across the
code restructure to add "option_blah" stuff.  Sorry about that.

Looking at the output from

    $ git grep -n -e ' \* 1024 \* 1024' -- '*.c'

I noticed another issue.  Don't we need the same thing for max_packsize?
Or is that _too much_ of a backward incompatible change that we should
wait until 1.7.1?
