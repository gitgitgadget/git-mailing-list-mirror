From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] archive: fix archive generation for empty trees
Date: Wed, 07 Mar 2012 22:38:07 -0800
Message-ID: <7vpqcnfvhs.fsf@alter.siamese.dyndns.org>
References: <1331165362-78065-1-git-send-email-brodie@sf.io>
 <20120308055520.GB7643@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brodie Rao <brodie@sf.io>,
	=?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 08 07:38:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5WzQ-0002J5-Up
	for gcvg-git-2@plane.gmane.org; Thu, 08 Mar 2012 07:38:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751399Ab2CHGiL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Mar 2012 01:38:11 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40956 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751159Ab2CHGiK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Mar 2012 01:38:10 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 763F77B44;
	Thu,  8 Mar 2012 01:38:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EZFtV789flGCoRQrm367sxMvx8c=; b=WwKH02
	cRJpHqH+spyvoj8M0nch+pC65yQVt2P7bph2quRc0sin/Bm/mJ7fbqsbD2RLXWhS
	Oq0y5gOJoOKsy29V6Thz9Oz1NKe2TY/NboGMoyE+X1Ube7fR9ZCkJPTb6FfWwAZs
	g2Ms4V4CHSpN997HH2WG0MKt8ZH7HELbG+kEo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=B1KsALFkMwbjn8IbFOiP2P0ZCpwZ3Wts
	dSWL1R3L3Rk++ZGM7Rx7A7N/TwGfTjsY/le77UVDOToqEM41Yw9nS+CEByg37rma
	3ek1SDWe9zaYVug6ZkfHZIczqkShrJqPq6NJGE8NCUUi1AgZyvrcGwN42/h4Yosc
	JLgen6AOP90=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6D4387B43;
	Thu,  8 Mar 2012 01:38:09 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 778DF7B42; Thu,  8 Mar 2012
 01:38:08 -0500 (EST)
In-Reply-To: <20120308055520.GB7643@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 8 Mar 2012 00:55:20 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 44951392-68E9-11E1-8237-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192525>

Jeff King <peff@peff.net> writes:

>> Now, instead of "", we use a pathspec prefix of NULL. If no path
>> arguments were provided, get_pathspec() will return NULL, and we won't
>> try to verify the existence of any paths in the tree.
>
> Yeah, this looks like the right thing to do. The get_pathspec code
> treats a NULL prefix specially as "no prefix", and I think that is what
> we are trying to say here (i.e., we are interpreting pathspecs from the
> root).

Yes, that sounds sane.

> ... However, prefix_pathspec does a lot of magic parsing;
> it's unclear to me whether this is all in support of properly
> adding the prefix, or if its side effects are important.

These "magic" are for things like :(root)/path that will explicitly
refuse the prefix when run from a subdirectory.

In the longer term, get_pathspec() should be converted to directly
deal with "struct pathspec", but we are not there yet.  There are
too many code left-over, even after Duy's last pathspec related
topic, that still look at ->raw field of "struct pathspec" and they
all need to be taught to work with the unified pathspec matching
machinery.  This is one of the lots of unfinished loose ends, which
might be a good GSoC project but may be a bit too large for a
student to bite and chew.
