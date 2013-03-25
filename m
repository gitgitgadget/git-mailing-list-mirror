From: Junio C Hamano <gitster@pobox.com>
Subject: Re: propagating repo corruption across clone
Date: Mon, 25 Mar 2013 13:01:59 -0700
Message-ID: <7vboa7xn7s.fsf@alter.siamese.dyndns.org>
References: <20130324183133.GA11200@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Mar 25 21:02:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKDbG-00020h-Jy
	for gcvg-git-2@plane.gmane.org; Mon, 25 Mar 2013 21:02:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933013Ab3CYUCF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Mar 2013 16:02:05 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33650 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751691Ab3CYUCD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Mar 2013 16:02:03 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3D64CB203;
	Mon, 25 Mar 2013 16:02:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4D9X2dBozMedHOYViFsXgGtVwDc=; b=xdx5Xa
	EcN61R8GwRnNCH19fACWt3HSEgYWQduqBiaLO7rh8eLEXXXThX+sLdALz3uPHUM5
	LNB/fPyVO+GNp/htMO2vXssZKKShoQrRU5ZVApWlgB6e5DLqxNYvtsiHozNs1h5z
	/DT6Rx6Z4MMNRSOS/ttndQIm4ddqb1eZo69wQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CgtNnjM+YIPWP5NahooukiqSvxsXVP3+
	65+W8uY5kH9K/px6tUuAL05cjAx0ui0+BG09R4gj2MrRSPXXDE3CNvbXtmk1N37h
	PMsLB+mY9nRXCcaSDQbIwXRrdI2mKjLggPeG+WGOmyud09xyGsQHcS2QojdILNce
	5XkYTUn07zc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 915ADB1FF;
	Mon, 25 Mar 2013 16:02:01 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AC2B7B1F7; Mon, 25 Mar 2013
 16:02:00 -0400 (EDT)
In-Reply-To: <20130324183133.GA11200@sigill.intra.peff.net> (Jeff King's
 message of "Sun, 24 Mar 2013 14:31:33 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DB03A83C-9586-11E2-A30E-EA7A2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219072>

Jeff King <peff@peff.net> writes:

> We _do_ see a problem during the checkout phase, but we don't propagate
> a checkout failure to the exit code from clone.  That is bad in general,
> and should probably be fixed. Though it would never find corruption of
> older objects in the history, anyway, so checkout should not be relied
> on for robustness.

It is obvious that we should exit with non-zero status when we see a
failure from the checkout, but do we want to nuke the resulting
repository as in the case of normal transport failure?  A checkout
failure might be due to being under quota for object store but
running out of quota upon populating the working tree, in which case
we probably do not want to.

> We do not notice the sha1 mis-match on the sending side (which we could,
> if we checked the sha1 as we were sending). We do not notice the broken
> object graph during the receive process either. I would have expected
> check_everything_connected to handle this, but we don't actually call it
> during clone! If you do this:
>
>   $ git init non-local && cd non-local && git fetch ..
>   remote: Counting objects: 3, done.
>   remote: Total 3 (delta 0), reused 3 (delta 0)
>   Unpacking objects: 100% (3/3), done.
>   fatal: missing blob object 'd95f3ad14dee633a758d2e331151e950dd13e4ed'
>   error: .. did not send all necessary objects
>
> we do notice.

Yes, it is OK to add connectedness check to "git clone".

> And one final check:
>
>   $ git -c transfer.fsckobjects=1 clone --no-local . fsck
>   Cloning into 'fsck'...
>   remote: Counting objects: 3, done.
>   remote: Total 3 (delta 0), reused 3 (delta 0)
>   Receiving objects: 100% (3/3), done.
>   error: unable to find d95f3ad14dee633a758d2e331151e950dd13e4ed
>   fatal: object of unexpected type
>   fatal: index-pack failed
>
> Fscking the incoming objects does work, but of course it comes at a cost
> in the normal case (for linux-2.6, I measured an increase in CPU time
> with "index-pack --strict" from ~2.5 minutes to ~4 minutes). And I think
> it is probably overkill for finding corruption; index-pack already
> recognizes bit corruption inside an object, and
> check_everything_connected can detect object graph problems much more
> cheaply.

> One thing I didn't check is bit corruption inside a packed object that
> still correctly zlib inflates. check_everything_connected will end up
> reading all of the commits and trees (to walk them), but not the blobs.

Correct.

> So I think at the very least we should:
>
>   1. Make sure clone propagates errors from checkout to the final exit
>      code.
>
>   2. Teach clone to run check_everything_connected.

I agree with both but with a slight reservation on the former one
(see above).

Thanks.
