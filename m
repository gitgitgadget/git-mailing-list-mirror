From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/5] combine-diff: handle binary files as binary
Date: Mon, 30 May 2011 12:32:40 -0700
Message-ID: <7vipssm1bb.fsf@alter.siamese.dyndns.org>
References: <20110523201529.GA6281@sigill.intra.peff.net>
 <20110523202734.GC6298@sigill.intra.peff.net>
 <7vpqn0ofy5.fsf@alter.siamese.dyndns.org>
 <20110530143627.GC31490@sigill.intra.peff.net>
 <20110530161927.GC24431@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon May 30 21:33:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QR8D5-0007vh-OC
	for gcvg-git-2@lo.gmane.org; Mon, 30 May 2011 21:33:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752233Ab1E3Tcw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 May 2011 15:32:52 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:56424 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752051Ab1E3Tcw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 May 2011 15:32:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 055DE5448;
	Mon, 30 May 2011 15:34:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Nzh87w1AON3nB6i0lQGZWPUtaDw=; b=mlVd7c
	+FxoFKqoYZjg9CWcMh1jY9VLDd1NMARWPVfQSF3m3eaKUzZoJ4RD0t9JB/W8+jcj
	PsQCAgB4NvA+J7a20m8aZ449F+PqEIbhoM1qOWFUF5DnPbbcHh4MKQkg3HZAqoaA
	1SQU7VL64rGtOpv8j+PPJCzwKYSkB5z9cwPu4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=W/uSWtBOYkwm9dQ9PkdqtNiN5VJIxQk0
	3Kia/zoxpqaobWzpnPqjArOpO9Z/pke6lh6r2YUuWRdOSvt4YuW8FpoCWp8QFA6B
	kuNvTcBZKZqa/wk93u21q+8HoNoJOF8HjUiuCjRWudXMxJjkUVTxs0gp0whhWvKl
	4tELq5Hm1s8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B60F95447;
	Mon, 30 May 2011 15:34:54 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 4F4615446; Mon, 30 May 2011
 15:34:49 -0400 (EDT)
In-Reply-To: <20110530161927.GC24431@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 30 May 2011 12:19:27 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E51BE7FC-8AF3-11E0-AA47-D6B6226F3D4C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174769>

Jeff King <peff@peff.net> writes:

>   git log -p --cc --merges origin/master
>
> on git.git using both v1.7.5.3 and the jk/combine-diff-binary-etc
> branch. And it turns out that the extra loads really don't make a
> difference in practice. My best-of-5 for the two cases were:

I am not surprised. git.git is small enough and developer machines these
days are beefy enough so that most of the data from the disk are sitting
in the buffer cache, and if you are well packed and Linus's law "a file
always grows" holds true, it is likely that you are also benefiting from
the delta-base cache, as the history traversal of the command goes newer
to older.

>   $ time git.v1.7.5.3 log -p --cc --merges origin/master >/dev/null
>   real    0m59.518s
>   user    0m58.672s
>   sys     0m0.688s

Comparing that with the run time of the same log without patch generation
would roughly give the cost of "all text combined" diff. I suspect more
than 90% of the time goes to running the textual diff algorithm.

I guess you are hinting that we should optimize that part before worrying
about the wastage of reading these blobs always twice.
