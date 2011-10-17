From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] daemon: report permission denied error to clients
Date: Mon, 17 Oct 2011 14:03:03 -0700
Message-ID: <7vhb37l4ag.fsf@alter.siamese.dyndns.org>
References: <20111014211921.GB16429@sigill.intra.peff.net>
 <1318803076-4229-1-git-send-email-drizzd@aon.at>
 <1318803076-4229-2-git-send-email-drizzd@aon.at>
 <20111017020912.GB18536@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Clemens Buchacher <drizzd@aon.at>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Oct 17 23:03:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RFuL3-0001Po-TM
	for gcvg-git-2@lo.gmane.org; Mon, 17 Oct 2011 23:03:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755179Ab1JQVDI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Oct 2011 17:03:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51738 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754184Ab1JQVDG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Oct 2011 17:03:06 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D954D4D47;
	Mon, 17 Oct 2011 17:03:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=prLVivlarCoEmhikhhcWmCheo4E=; b=g9mCTG95oht9rqrzu/Ex
	bMA03G0i9tbovybhNkaYaJN8AB8g9F8aQLKZaqVN9c6YVdMt7nCoS1POsce5Dw7I
	7/1jfzbu9nysraQhnCr3NaZZp+vvdeRRC/J2CVjguMnCVifnZrTy+w8xnbcFxPiE
	0qg1kaarwYXK4sFkntS6uRk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=vXRVOccr3NJmOANGOpc/p77ErRHvLatsW3Le7TdvyYLdGH
	rP4f+U6gTLoWEnAaCsRsk1oY11Ctjv9ZPEqMQckfomhnQPjrPKXeyIxqRa03Bmsl
	r+QLlHOd98KrviXek1GN3oBIuNbQCbxrL7p7kL18ZfnnenJLpV4QiVA4Y/L9M=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D046A4D46;
	Mon, 17 Oct 2011 17:03:05 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 611F64D45; Mon, 17 Oct 2011
 17:03:05 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6878E03C-F903-11E0-96B7-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183823>

Jeff King <peff@peff.net> writes:

> On Mon, Oct 17, 2011 at 12:11:16AM +0200, Clemens Buchacher wrote:
>
> I like the intent. This actually does leak a little more information
> than the existing --informative-errors, as before you couldn't tell the
> difference between "not found" and "not exported".

I personally think this is going a bit too far, even for "informative"
option, by allowing to fish for possible list of usernames. It would make
it a tougher sell to later default to "informative", I am afraid.

Suppose you are setting up your own repository (either on your own box or
on a box with a separate administrator), and youare wondering why your
attempted access failed. You know /pub/repo/sito.git exists (you created
it after all) and you get "no such repository: /repo/sito.git" when you
ran:

    $ git clone git://host/repo/sito.git/

If you have another repository in /pub/repo/ that does already work, and
if you know /pub/repo/sito.git/ is fine locally (e.g. you can see local
command like "git log" works fine there), then even if you see "not found"
you would know to compare what the difference between these two are.

If there is no other repositories in /pub/repo/ or you are setting up many
repositories on this same box for the first time, wouldn't it be plausible
that you _are_ the administrator of the box and have access to the daemon
log to diagnose the problem more easily anyway?

I can see how this is "leaking a little more information", but I am not
convinced that leak is helping legit users more than helping unwanted
snoopers.

> The new calling conventions for this function seem a little weird.  I
> would expect either "return negative, and set errno" for usual library
> code, or possibly "return negative error value". But "return -1, or a
> positive error code" seems unusual to me.
>
> One of:
>
>   errno = EACCESS;
>   return -1;
>
> or
>
>   return -EACCESS;
>
> would be more idiomatic, I think.

Yes, the former would probably be easier to handle.
