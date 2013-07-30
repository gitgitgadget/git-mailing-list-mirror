From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] sha1_file: introduce close_one_pack() to close packs on fd pressure
Date: Tue, 30 Jul 2013 08:39:48 -0700
Message-ID: <7v61vsxdiz.fsf@alter.siamese.dyndns.org>
References: <1375157113-608-1-git-send-email-bcasey@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>, <spearce@spearce.org>,
	Brandon Casey <drafnel@gmail.com>, Jeff King <peff@peff.net>
To: Brandon Casey <bcasey@nvidia.com>
X-From: git-owner@vger.kernel.org Tue Jul 30 17:39:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V4C1l-00006H-KS
	for gcvg-git-2@plane.gmane.org; Tue, 30 Jul 2013 17:39:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755422Ab3G3Pjx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jul 2013 11:39:53 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58487 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751725Ab3G3Pjw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jul 2013 11:39:52 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 34224343C0;
	Tue, 30 Jul 2013 15:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Iyn5yExZyVDra+uH0xF5nk3/aWk=; b=k0A80D
	o3Gait6LDd5fFIGQ8cFQn+H0Ktr9QKSVH9QU+2Uc0eLUhCIuKaRQ3N/fjtZi80Jh
	ClohZe0MI9Xf2oKaFR2a4UDDlWJhfLNv9uoGFVohRJhvG1tX+sjxswAINGa3JOhQ
	3SbabQWqW3k4wTxYqMXXFAR3sFneKFGn/6dJU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QzM0/HknsPZjXisTSUo6oeXDehGlggZN
	C9hinN5FnVMVRriJGG63nNWUGz9Tei6oxzmSgaV1jcykvPGNxYo1u6RXrYDrcllc
	LWvD+PPDjJuyy4EHFmsueUzHgiPhov8nhipe+setULxPT3tTxT0H8wguFyzhXscs
	lxbFSIKfEDs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 270D0343BE;
	Tue, 30 Jul 2013 15:39:52 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 60A7E343B4;
	Tue, 30 Jul 2013 15:39:50 +0000 (UTC)
In-Reply-To: <1375157113-608-1-git-send-email-bcasey@nvidia.com> (Brandon
	Casey's message of "Mon, 29 Jul 2013 21:05:13 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 457B58E4-F92E-11E2-82F1-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231368>

Brandon Casey <bcasey@nvidia.com> writes:

> From: Brandon Casey <drafnel@gmail.com>
>
> When the number of open packs exceeds pack_max_fds, unuse_one_window()
> is called repeatedly to attempt to release the least-recently-used
> pack windows, which, as a side-effect, will also close a pack file
> after closing its last open window.  If a pack file has been opened,
> but no windows have been allocated into it, it will never be selected
> by unuse_one_window() and hence its file descriptor will not be
> closed.  When this happens, git may exceed the number of file
> descriptors permitted by the system.

An interesting find.  The patch from a cursory look reads OK.

Thanks.

> This is not likely to occur during upload-pack since upload-pack
> reads each object from the pack so that it can peel tags and
> advertise the exposed object.

Another interesting find.  Perhaps there is a room for improvements,
as packed-refs file knows what objects the tags peel to?  I vaguely
recall Peff was actively reducing the object access during ref
enumeration in not so distant past...
