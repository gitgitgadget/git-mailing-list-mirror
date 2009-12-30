From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-update-index: report(...) now flushes stdout after
 printing the report line
Date: Wed, 30 Dec 2009 11:46:26 -0800
Message-ID: <7v1vic1bzh.fsf@alter.siamese.dyndns.org>
References: <loom.20091119T221732-624@post.gmane.org>
 <20091230224122.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sebastian Thiel <byronimo@gmail.com>, git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Wed Dec 30 20:46:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NQ4VG-0008FG-0i
	for gcvg-git-2@lo.gmane.org; Wed, 30 Dec 2009 20:46:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753329AbZL3Tqi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Dec 2009 14:46:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753317AbZL3Tqh
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Dec 2009 14:46:37 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:53041 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752948AbZL3Tqh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Dec 2009 14:46:37 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7864C8C6A9;
	Wed, 30 Dec 2009 14:46:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=oWlJZaFe0H0yIGxl1GhlbCr378A=; b=IJ4lWP
	J+dNmw1vD/lvbC0O1BE1X+YUPA8ioyBNq8SCy3dlJOL1m+rdOAceLmFoRy6gH8ci
	QqFNAhAW1V/R42HfIOGijZsUjS11qV/FQrTCQf/lWiWbIrRy1EU+2igND8d3B9Jj
	jq7E0mbQBW3dW4stuEZEXCvNJYUHf/sawvRLs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=A/2yBoB+2t5IJZ/1AYiFT/uU6+8fZSCA
	BMSFFRnDgaK9Dvbt6SGnj+WCUz0gDaFUcs99e8C3fRTP7WG2d67njLiIj9Ca/lFq
	iRo0MAKBJvBJcyi9qbAcaAiz42M5FGNepwx+lFYVMwOVqkMQYXyJeg8T3EZ6tB8p
	dF1IEjrU2qg=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 429668C6A5;
	Wed, 30 Dec 2009 14:46:32 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 785B98C6A3; Wed, 30 Dec
 2009 14:46:28 -0500 (EST)
In-Reply-To: <20091230224122.6117@nanako3.lavabit.com> (Nanako Shiraishi's
 message of "Wed\, 30 Dec 2009 22\:41\:22 +0900")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 07BF92E0-F57C-11DE-83F6-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135918>

Nanako Shiraishi <nanako3@lavabit.com> writes:

> Junio, could you tell us what happened to this thread?

I didn't feel I had enough energy to read the commit log message after
seeing it was badly linewrapped and didn't have a sign-off, so I didn't
read it.

I've read it now; it is unclear from the proposed commit log message how
this fits in the larger picture.  Presumably this change is meant to be
useful when driving update-index through --stdin?  To see if I got the
intention right, let me try paraphrasing it...

    update-index: flush standard output after each action is reported

    A scripted Porcelain that runs "git update-index --stdin" might want
    to use a bidirectional pipe, while feeding one path at a time and
    reading the output from report() every time after feeding a path.

    Such a Porcelain would deadlock if the standard output is not flushed
    after report().

I don't know if the above is what Sebastian meant, though..

An obvious question, when phrased this way, is "what impact does this
change have for scripted Porcelains that don't use bi-di pipe?"  I think
the answer would be "The I/O overhead for flushing would increase", but I
don't know if it would be "... would increase but it is still negligible"
or "... would increase too much to make it noticeably or unusably slow
especially if it feeds hundreds of paths".  If it is the latter, this may
need to be controlled by another command line option.

Sebastian, care to redo the justification, make it a bit more readable,
and add your sign-off?

Thanks.
