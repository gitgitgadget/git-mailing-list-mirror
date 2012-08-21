From: Junio C Hamano <gitster@pobox.com>
Subject: Re: receive.denyNonNonFastForwards not denying force update
Date: Mon, 20 Aug 2012 20:49:42 -0700
Message-ID: <7vpq6kgazt.fsf@alter.siamese.dyndns.org>
References: <CAHgXSop42qWcAEGn6=og8Pistv_Jrwhgcnv3B_ORVtSMi1fCHA@mail.gmail.com>
 <CAHgXSooFj2PJtcOWqsVNHUzMBQnH0cYzPjfs1CkzVuufwRVrog@mail.gmail.com>
 <7vzk5pjxy3.fsf@alter.siamese.dyndns.org>
 <CAMK1S_hMTGhiKDow3x-UZ7eNnTtpLd2=QUf6-YoQF1-O1ywi2w@mail.gmail.com>
 <7v628dght9.fsf@alter.siamese.dyndns.org>
 <20120821015738.GA20271@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sitaram Chamarty <sitaramc@gmail.com>,
	John Arthorne <arthorne.eclipse@gmail.com>,
	git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Aug 21 05:49:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3fTT-0000Ux-Ol
	for gcvg-git-2@plane.gmane.org; Tue, 21 Aug 2012 05:49:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751214Ab2HUDtq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Aug 2012 23:49:46 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48757 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750813Ab2HUDtp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2012 23:49:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D71798875;
	Mon, 20 Aug 2012 23:49:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tKTk2+bihVNpucIKV4KZ7WZNc2A=; b=rbzs9k
	Z2APPmGQzK449tv813KFC3zIb02nRiQJFPk5jrxtVbAShW76QB4/kjcPShYnoTN7
	x+IUuSFA2xL7WD1xtdYWewpWnUAhkccktF/Vhw28x6Hn5QVU/8PpRvpozeVhlOdY
	qJ4oDUJF6ALMw2S9ed+9E9PVpI+3oA0/YC6sg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qHFSPVtYGE2CWArGaQ2Gy97UYNtRKVEM
	Y7/CGqi7v6vlL07ipxjitdhjnbDGlG5GgvjQPm4xSkTi8wUOvmfbgolBuupYOMCA
	HrrLIablyJt4GDzFAf3fdJigapr+loLHQteNzTf0YW2GwrLwq7mJnodwJ6ac5PaP
	ac37WZKlgOk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 77C648874;
	Mon, 20 Aug 2012 23:49:44 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D3A668871; Mon, 20 Aug 2012
 23:49:43 -0400 (EDT)
In-Reply-To: <20120821015738.GA20271@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 20 Aug 2012 21:57:38 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3E527B50-EB43-11E1-9F0D-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203924>

Jeff King <peff@peff.net> writes:

> On Mon, Aug 20, 2012 at 06:22:26PM -0700, Junio C Hamano wrote:
>
>> Does anybody recall if this is something we did on purpose?  After
>> eyeballing the callchain starting from cmd_receive_pack() down to
>> receive_pack_config(), nothing obvious jumps at me.
>
> No, I do not think it was on purpose. And it would be very hard to do
> so, anyway; config callbacks are not given any information about the
> source of the config variable, and cannot distinguish between repo,
> global, and system-level config variables.

I was looking for setenv() to refuse system wide defaults; that
actually is fairly simple.

>> Could this be caused by a chrooted environment not having
>> /etc/gitconfig (now I am just speculating)?
>
> That seems far more likely to me. Another possibility is that the file
> is not readable by the user running receive-pack.

Good point. We explicitly use access(R_OK) and pretend as if a path
that is known to exist but not readable is missing; perhaps we may
want to diagnose this as a misconfiguration and issue a warning?
