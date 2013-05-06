From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/3] fast-export: improve speed by skipping blobs
Date: Mon, 06 May 2013 09:32:41 -0700
Message-ID: <7vli7srrva.fsf@alter.siamese.dyndns.org>
References: <1367793534-8401-1-git-send-email-felipe.contreras@gmail.com>
	<1367793534-8401-3-git-send-email-felipe.contreras@gmail.com>
	<20130506123111.GB3809@sigill.intra.peff.net>
	<7v7gjctabm.fsf@alter.siamese.dyndns.org>
	<20130506162008.GB7992@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Antoine Pelisse <apelisse@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon May 06 18:32:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZOLI-000855-Sv
	for gcvg-git-2@plane.gmane.org; Mon, 06 May 2013 18:32:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754507Ab3EFQcp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 May 2013 12:32:45 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52769 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754006Ab3EFQco (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 May 2013 12:32:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D7A511CCDD;
	Mon,  6 May 2013 16:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gmscv6GjClhEFMHVmmkExWsM2+s=; b=TfEib5
	1vEaMJgL1yFtaY2VogAeXuK1RtF1MNICjoLQ51qNrnnRiiH+EailfWBwdsruENDZ
	2hOqbVGXc8zvDCm7pCD3iaHBdcwlgmoggez/GT82/o+VvguHmmUR0gd/qTilm69f
	KCQH/IOZ7xUfjlz9N+8eCFyVYa+FHbPnskWsA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dSkAorGcWHi0gCF/DcEQQyyRclMFdKb6
	iA8iXgPOBbcDDT3R+zfAIh7COGYW40ijVoEeY7VkVbpqLs4Qp+bwdR5Q+7PtEz79
	HlKPZXvFSUMmNquiqVzE0za7MG8dfWjPvhLmxp9OD6s+lLGJ+W3wTDTPu1BMSY9o
	jp0L/cRSyws=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CE74E1CCDC;
	Mon,  6 May 2013 16:32:43 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 355C81CCD9;
	Mon,  6 May 2013 16:32:43 +0000 (UTC)
In-Reply-To: <20130506162008.GB7992@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 6 May 2013 12:20:08 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9384D166-B66A-11E2-A438-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223470>

Jeff King <peff@peff.net> writes:

> On Mon, May 06, 2013 at 08:08:45AM -0700, Junio C Hamano wrote:
>
>> > I'm also not sure why your claim "we don't care about blobs" is true,
>> > because naively we would want future runs of fast-export to avoid having
>> > to write out the whole blob content when mentioning the blob again.
>> 
>> The existing documentation is fairly clear that marks for objects
>> other than commits are not exported, and the import-marks codepath
>> discards anything but commits, so there is no mechanism for the
>> existing fast-export users to leave blob marks in the marks file for
>> later runs of fast-export to take advantage of.  The second
>> invocation cannot refer to such a blob in the first place.
>
> OK. If the argument is "we do not write them, so do not bother reading
> them back in", I think that is reasonable.

The way I read builtin/fast-export.c::import_marks() is that it is
more like "we do not write them, and we do not read them back in
either IN THE CURRENT CODE".
