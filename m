From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fetch-pack: Avoid memcpy() with src==dst
Date: Sun, 07 Dec 2008 18:47:21 -0800
Message-ID: <7viqpvbcxy.fsf@gitster.siamese.dyndns.org>
References: <1228596609-12720-1-git-send-email-trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Dec 08 03:50:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L9WCf-0001yZ-JM
	for gcvg-git-2@gmane.org; Mon, 08 Dec 2008 03:50:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754191AbYLHCr2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Dec 2008 21:47:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754092AbYLHCr2
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Dec 2008 21:47:28 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:46787 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754088AbYLHCr1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Dec 2008 21:47:27 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 30C36185A8;
	Sun,  7 Dec 2008 21:47:27 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id DDEDB1856A; Sun, 
 7 Dec 2008 21:47:23 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 8C971262-C4D2-11DD-901C-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102517>

Thomas Rast <trast@student.ethz.ch> writes:

> memcpy() may only be used for disjoint memory areas, but when invoked
> from cmd_fetch_pack(), we have my_args == &args.  (The argument cannot
> be removed entirely because transport.c invokes with its own
> variable.)

It makes me wonder if it might be a better fix to abolish the use of file
scoped global "args" and pass a pointer to "struct fetch_pack_args"
throughout the callchain instead.

In the current code, cmd_fetch_pack() is the only caller that passes &args
to this function, but it is not so implausible to have a future callchain
that makes two calls to cmd_fetch_pack(), perhaps implementing some sort
of alias to fetch from multiple places, would horribly break without such
a fix, because cmd_fetch_pack() assumes that args is in its pristine
state.

I'll apply this to 'maint' and merge it up, because the patch is
independent of the above issue.

Thanks.
