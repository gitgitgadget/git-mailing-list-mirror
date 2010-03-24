From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Make xmalloc and xrealloc thread-safe
Date: Wed, 24 Mar 2010 11:44:45 -0700
Message-ID: <7vaatxk19e.fsf@alter.siamese.dyndns.org>
References: <20100323161713.3183.57927.stgit@fredrik-laptop>
 <20100323173114.GB4218@fredrik-laptop> <20100323184309.GA31668@spearce.org>
 <4c8ef71003231421u789c4332h461c066add0ec7b1@mail.gmail.com>
 <alpine.LFD.2.00.1003231945480.31128@xanadu.home>
 <4c8ef71003240823o7cd733bn5f19699305c94cba@mail.gmail.com>
 <alpine.LFD.2.00.1003241133430.694@xanadu.home>
 <ec874dac1003241122s3d592f26n1b23d23144939218@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@fluxnic.net>,
	Fredrik Kuivinen <frekui@gmail.com>, git@vger.kernel.org,
	Johannes Sixt <j6t@kdbg.org>,
	Junio C Hamano <gitster@pobox.com>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Mar 24 19:45:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NuVZn-0007JX-Lo
	for gcvg-git-2@lo.gmane.org; Wed, 24 Mar 2010 19:45:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932266Ab0CXSpE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Mar 2010 14:45:04 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:64327 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932177Ab0CXSpB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Mar 2010 14:45:01 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E6575A5F87;
	Wed, 24 Mar 2010 14:44:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qOQCeAvKC9Got8SjrhqdEG95Xmg=; b=QStABg
	kqpx/GetlU+m0ueyiaJhW+/c3Ww5xuTVDUINPaxvIm0z8wVSMRgUTNa3VB+Rim3C
	gXwNb/IH2YNgPw+k/dD9AFCgnyqIUY6xvV9z5YAt7mPQ+vxiffEiBy113VV5CVQj
	GeKNugaJIP4sHIv/8ho4Qp7kSoirOay/b1Tns=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Uev/tEuPmfsCNIf/M/hsSN3a1EjXGSOd
	VW3sMLzDsm67a4RHhB4oL4qzAi/dfrxsODN/myKhBMpTfrSYWxtPSajwrYS/SSWd
	h8rbKToQxI+sLn1PyzgZHtXRPQwC68DOVspAjo9kM6FiMjaKKCqXXlKee75p92ae
	0kvH2hLADeQ=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8E497A5F7F;
	Wed, 24 Mar 2010 14:44:54 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 12092A5F7A; Wed, 24 Mar
 2010 14:44:46 -0400 (EDT)
In-Reply-To: <ec874dac1003241122s3d592f26n1b23d23144939218@mail.gmail.com>
 (Shawn Pearce's message of "Wed\, 24 Mar 2010 11\:22\:23 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 56739D56-3775-11DF-8326-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143101>

Shawn Pearce <spearce@spearce.org> writes:

> I thought pack-objects did all object access from the main thread and
> only delta searches on the worker threads?

Hmm, you lost me.  try_delta() is the one that reads the data out of
either loose object or from an existing pack for comparison lazily, and
that is what each worker thread runs repeatedly in find_deltas()...
