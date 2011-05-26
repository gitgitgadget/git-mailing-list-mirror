From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 1/2] Support multiple virtual repositories with a
 single object store and refs
Date: Wed, 25 May 2011 21:08:21 -0700
Message-ID: <7vsjs2yuh6.fsf@alter.siamese.dyndns.org>
References: <1306274066-4092-1-git-send-email-jamey@minilop.net>
 <7v7h9f7kzx.fsf@alter.siamese.dyndns.org>
 <alpine.DEB.1.00.1105250847380.2701@bonsai2>
 <20110525154405.GA4839@oh.minilop.net>
 <alpine.DEB.1.00.1105260152430.2701@bonsai2> <20110526000104.GA3439@leaf>
 <alpine.DEB.1.00.1105260239480.2701@bonsai2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Josh Triplett <josh@joshtriplett.org>,
	Jamey Sharp <jamey@minilop.net>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Sixt <johannes.sixt@telecom.at>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu May 26 06:08:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPRsT-0006da-Hy
	for gcvg-git-2@lo.gmane.org; Thu, 26 May 2011 06:08:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750753Ab1EZEIj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2011 00:08:39 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:34643 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750735Ab1EZEIh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2011 00:08:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A71935467;
	Thu, 26 May 2011 00:10:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wNujov17UT8MTDINOWSAx4R7wPc=; b=vQxbEd
	CDLBonxvrmHH7PQb0cnX7uxT3MaREWQRGBRAsqdMQvZnUjMMMlMYvU9BP31ZjONK
	6SKl4smP4uzFmxl0EMbJ5FkByOvXw8BSwsPx4Fq6RI9wzNffG80ygtOWoXAOcjgH
	BdrtUg1znkuZ0TDx3tNeiUGui43qRT/juNDF4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cjKIVGJFweWDEoPfIBW7hx/B66ZjvyHy
	y3tU5+3NSf3vqKOFsb65un7dK+79xuqw6rMjywTeAQ/2ZY0V7VzpfeZh2/f7ZN1U
	4XtUWvY7QzFgE5S3P2T2KYIqD6uBluq+wFgPau8yyzP/tyJtwYBonT/Yy5xOAgG7
	kX528/+1f7o=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 383895463;
	Thu, 26 May 2011 00:10:37 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 82CE65462; Thu, 26 May 2011
 00:10:29 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.1105260239480.2701@bonsai2> (Johannes
 Schindelin's message of "Thu, 26 May 2011 02:40:49 +0200 (CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1C341AD8-874E-11E0-B979-D6B6226F3D4C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174492>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> Not that we know of.  Are we missing something?
>
> This is a change of protocol by my understanding:
>
> -- snip --
>  	if (sent_capabilities)
> -		packet_write(1, "%s %s\n", sha1_to_hex(sha1), path);
> +		packet_write(1, "%s %s%s\n", sha1_to_hex(sha1), refnameprefix, path);
> -- snap --

I think this is not a change in the protocol per-se, but rather a botched
attempt to make refs/virt/one/refsheads/foo this side has appear as if it
is refs/heads/foo to the other side. In other words, you probably spotted
a bug.

When read with the "chroot" analogy of Peff and Shawn earlier in the
thread in mind, shouldn't the sending end that is pretending that only a
part of its ref namespace is actually the whole thing _stripping_ the
prefix from the real namespace, rather than appending the extra prefix?

I've been down sick, feeling feverish, this afternoon, so I may be
remembering what I understood while reading the code incorrectly, but that
was the impression I got.
