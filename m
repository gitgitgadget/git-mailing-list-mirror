From: Junio C Hamano <gitster@pobox.com>
Subject: Re: segmentation fault (nullpointer) with git log --submodule -p
Date: Thu, 24 Jan 2013 15:56:23 -0800
Message-ID: <7va9ry87a0.fsf@alter.siamese.dyndns.org>
References: <20130123143816.GA579@krypton.darkbyte.org>
 <20130123200222.GB19832@sigill.intra.peff.net>
 <510124F5.9090505@atlas-elektronik.com>
 <CACsJy8B9O=A26_=sv1JEYdtazsWa4khZkqpTgFSSTs_RGGPZqQ@mail.gmail.com>
 <51013FDD.5030004@atlas-elektronik.com>
 <CACsJy8CEofqi9S8-SDx_O+Ko0i56aRZ4KEJrVnbFum6zzsJrJg@mail.gmail.com>
 <20130124232721.GA16036@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Duy Nguyen <pclouds@gmail.com>,
	Stefan =?utf-8?Q?N=C3=A4we?= <stefan.naewe@atlas-elektronik.com>,
	Armin <netzverweigerer@gmail.com>, Jonathon Mah <jmah@me.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 25 00:56:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TyWf4-0006Kz-4d
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jan 2013 00:56:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755248Ab3AXX43 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jan 2013 18:56:29 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53294 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752277Ab3AXX42 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jan 2013 18:56:28 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 560BFBCC8;
	Thu, 24 Jan 2013 18:56:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QSny/i59xT9b5Kd1ZdQxulKxWDw=; b=cVzU4i
	o8vkaektKWIZ5P31qR2uYexJKqHoY/IIvFJrq6+WVkz7UfpkaTmOInzG/JiDccMw
	s44Kea+pH7jz2s8tj+ES1MgK/guLTOrJkm0xYCtFFW1zsqi3KIPp/xiLsq30IKgv
	FhdUKit88hoQzjEhJVY9SSOwQHmDDD1n7yrio=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xFWaDrJyPIFFl4jHwJzn4X30YUbX0WDY
	4+qm401Wy8DTm2uzQsCGueVflEhtNMi67PJVrRZE7kLF2CIt8cJKbgUX17EgsQWm
	VhF4LbzUGososuKCpp+t8uvna2ceX9/XIx10xNN1gvcyJ1NdcumzDSwsTAD1RZMg
	Ja7s6uoz7kc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 49A90BCC6;
	Thu, 24 Jan 2013 18:56:25 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BFEADBCC4; Thu, 24 Jan 2013
 18:56:24 -0500 (EST)
In-Reply-To: <20130124232721.GA16036@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 24 Jan 2013 18:27:21 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A9187B74-6681-11E2-8FB3-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214473>

Jeff King <peff@peff.net> writes:

> ... (e.g., how should "log" know that a submodule diff might later want
> to see the same entry? Should we optimistically free and then make it
> easier for the later user to reliably ensure the buffer is primed? Or
> should we err on the side of keeping it in place?).

My knee-jerk reaction is that we should consider that commit->buffer
belongs to the revision traversal machinery.  Any other uses bolted
on later can borrow it if buffer still exists (I do not think pretty
code rewrites the buffer contents in place in any way), or they can
ask read_sha1_file() to read it themselves and free when they are
done.
