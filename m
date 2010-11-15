From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] use persistent memory for rejected paths
Date: Mon, 15 Nov 2010 10:31:33 -0800
Message-ID: <7vvd3yl9q2.fsf@alter.siamese.dyndns.org>
References: <7vbp5ymfyo.fsf@alter.siamese.dyndns.org>
 <20101114130205.GA27560@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@imag.fr>
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Mon Nov 15 19:32:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PI3qQ-0000mO-V7
	for gcvg-git-2@lo.gmane.org; Mon, 15 Nov 2010 19:31:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758113Ab0KOSbo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Nov 2010 13:31:44 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:37397 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758097Ab0KOSbn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Nov 2010 13:31:43 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 504D22142;
	Mon, 15 Nov 2010 13:31:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zgJM7L91OR1HNV0EQGEVVayXeBY=; b=QmfhyQ
	HJZcdSAA4uw2rpl2iTPQXMkhirBdmMd+FKZz7f/x9QZuaq2AcyKUnsgm+u5FnGPe
	/ocrcfAYHHvbZp+gojEMcCCwABBKWJw4RbTJAuqxclqMtwLmVSdOpOu/E5gw09uq
	UUB0xYPvYDIGMcxvsqaSWYS5YPzgcM7iOLwQ8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uXEVF+IxoZ3fR+K9eE2o4XE87aF9WKaM
	GEm2oTa72o1FXMPcM3AiGnRyHIsxbTfN+eQMjhSKZ2f0FbqWXp7TR9LZczpWQtTm
	2bfeVmU2kKFCP30RboFEtzlabVkkBvvwpUhtGAq2Tq4N1gECev8qQwLP1U8V3CSS
	i+NBFLlrouA=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1D97B2141;
	Mon, 15 Nov 2010 13:31:47 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 0DA3C2140; Mon, 15 Nov 2010
 13:31:42 -0500 (EST)
In-Reply-To: <20101114130205.GA27560@localhost> (Clemens Buchacher's message
 of "Sun\, 14 Nov 2010 14\:02\:05 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 9A920628-F0E6-11DF-A582-B53272ABC92C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161499>

Clemens Buchacher <drizzd@aon.at> writes:

> An aborted merge prints the list of rejected paths as part of the
> error message. Some of those paths do not have static buffers, so
> we have to keep a copy. Use string_list's to accomplish this.
>
> Previous to this fix, the error message would print whatever was
> stored in the stack at that point.

Hmmm, all calls to add_rejected_path() seems to be with ce->name as the
path parameter, and I do not think we ever free cache entries (either
taken from the index or synthesized during the merge), so I am a bit
surprised that this is necessary (namely, if some ce->name points into the
stack, wouldn't that be a more serious bug than misreporting???).

> With this change, the path list is printed in the order of
> processing.  Previously, the order was reversed.

That is true but I wonder if the order should be "whatever the processing
order happens to be" in the first place, as this is a report to the end
user, no?  Perhaps "collect in strlist, sort at the end before showing" is
a more desirable thing to do?

Still, I am more disturbed by the "some do not have static"...
