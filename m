From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] format-patch: Properly escape From_ lines when creating
 an mbox.
Date: Tue, 08 Jun 2010 20:50:01 -0700
Message-ID: <7vljaorhjq.fsf@alter.siamese.dyndns.org>
References: <1276045305-20743-1-git-send-email-cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>
To: Carl Worth <cworth@cworth.org>
X-From: git-owner@vger.kernel.org Wed Jun 09 05:50:21 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMCJ1-0001f3-8r
	for gcvg-git-2@lo.gmane.org; Wed, 09 Jun 2010 05:50:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754315Ab0FIDuM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jun 2010 23:50:12 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:63552 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752038Ab0FIDuL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jun 2010 23:50:11 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D591DBA27E;
	Tue,  8 Jun 2010 23:50:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=OsE1OlmKXOs4uen6b2rd1m8EZyk=; b=maPmaZBNIJg6bU0bHkzDrmA
	HbZRYPv53VMg9Bnlsem9iepm32WQKDpUAhVh+/cgGDCmK/w6ohdqSVca7edW3oqb
	TzgREB87AGckDAg8f6WH3WZZe+H2WECVk8n+rrbZp2dK34dPnviqCwqA1Uu6gu5M
	6iN9RFw9IKf8LpyHcaX0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=tC5NMVh1qQRVxPgQpeD16Q9+taBJyR8bBra4BHXx3X9tpKN1L
	2nnDj2MkgN0DS58uIkDGcrDWADsuUXIvJTJKxLjonc6gICcJEayEi4hZKKdOrSjb
	sf2CShWp5myc/0nifsJTjCHTKL7v9B1hBhu67AoE9va1kdpE16umB26Yxo=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A1F44BA27D;
	Tue,  8 Jun 2010 23:50:06 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D68C0BA27B; Tue,  8 Jun
 2010 23:50:02 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 17C418E2-737A-11DF-915D-6730EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148739>

Carl Worth <cworth@cworth.org> writes:

> Without this patch series, there's no documented way that an external
> tool can use to reliably construct an mbox that will be correctly handled
> by "git am". The best one could do is to peek inside the git implementation
> and notice that it wants unescaped "From " lines, that it will ignore any
> "From " line that doesn't end with something very much like asctime format,
> and then somehow ensure that no messages in the mbox have lines that begin
> with "From " and end with something like asctime format, (which won't be
> possible in all cases without corrupting the message).

I have this small suspicion that mboxrd may be a suboptimal choice, when
you consider how robustly we can notice a failure (and to a lessor extent,
recover from it) when using output from "format-patch --stdout" to
sneakernet between existing and updated versions of git.  Especially
because your implementation quotes lines that begin with "From "
unconditionally (even when the tail end of the line would never be a
valid-looking timestamp).  Such an output will confuse existing mailsplit,
but the worst part of the story is that somebody who is applying a series
of patches will _not_ notice the breakage.  The payload of the second and
subsequent messages will likely be concatenated as if it were part of the
first message, ignoring cruft between patches, but the resulting tree
would likely to be the same as what the sending end intended.

Compared to that, I think a failure to split a message in the middle (iow,
commit message happened to have a line that begins with "From " and ends
with a timestamp-looking string) is much easier to notice (because the
first part of the message that was incorrectly split at such a line will
not have any patch, so "git am" will stop).  IOW, failure to split is
easier to notice than splitting too eagerly.

Perhaps perfect is an enemy of good?
