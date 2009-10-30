From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH v4 03/26] pkt-line: Make packet_read_line easier to
 debug
Date: Fri, 30 Oct 2009 12:35:17 -0700
Message-ID: <7veioklloq.fsf@alter.siamese.dyndns.org>
References: <1256774448-7625-1-git-send-email-spearce@spearce.org>
 <1256774448-7625-4-git-send-email-spearce@spearce.org>
 <7vhbtidgmp.fsf@alter.siamese.dyndns.org>
 <20091029151152.GX10505@spearce.org>
 <7v1vkm6id9.fsf@alter.siamese.dyndns.org>
 <20091029215829.GD10505@spearce.org>
 <20091030175741.GC18583@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Oct 30 20:35:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3xG8-0002PG-Fi
	for gcvg-git-2@lo.gmane.org; Fri, 30 Oct 2009 20:35:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756185AbZJ3Tf1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2009 15:35:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755487AbZJ3Tf1
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Oct 2009 15:35:27 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:49892 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755451AbZJ3Tf0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2009 15:35:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id AE7DE6D50C;
	Fri, 30 Oct 2009 15:35:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2VenBHVdvxm5aN2MI1LhG4iDA44=; b=tpea8l
	IRrut6Cif3m0+XBeI3zDTBFfuvhfVQtDS4jDUSMdbhcxgJsdAgV7L4sY8pTbswB3
	uH9pDFKwyNkoDe/HzUUCmKBaoRZbFz518T31z7YxN2p01Krk9M1IZulkMXWPP29d
	EPQlfosHh5DC7AVnJaTXbb2POy3PpAKzItUYg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ONF0LYLvbP5c1C7NhPaROjIP5bFO0i6x
	/bdeu8iLWab0V0nVj6JqzVC0hvSx2FIrjAj70Cl6rNUIFKayiuSN7hkYK71gZsip
	2OV3bFL/gEQr8EXHhHIpuwWYo5nd2BJdXijUw2sO18NMHXTGMuEznWwc7CEWxUUB
	iKXb4yAaZ70=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8222A6D50B;
	Fri, 30 Oct 2009 15:35:26 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 038A96D4FF; Fri, 30 Oct
 2009 15:35:18 -0400 (EDT)
In-Reply-To: <20091030175741.GC18583@coredump.intra.peff.net> (Jeff King's
 message of "Fri\, 30 Oct 2009 13\:57\:41 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 5FBCEC5C-C58B-11DE-B56A-1B12EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131736>

Jeff King <peff@peff.net> writes:

> On Thu, Oct 29, 2009 at 02:58:29PM -0700, Shawn O. Pearce wrote:
>
>> Junio C Hamano <gitster@pobox.com> wrote:
>> > > The NUL assignment isn't about safe_read(), its about making the
>> > > block of 4 bytes read a proper C-style string so we can safely pass
>> > > it down into the snprintf that is within die().
>> > 
>> > I knew and understood all of what you just said.  static linelen[] is not
>> > about stack allocation.  It's about letting the compiler initialize it to
>> > five NULs so that you do not have to assign NUL to its fifth place before
>> > you die.  This removes one added line from your patch.
>> 
>> Thanks, I get it now.  Patch amended.
>
> I am just a bystander, so maybe my opinion is not worth anything, but
> personally I think you are obfuscating the code to save a single line.

Well, the comment was not a serious "you should do it this way" to begin
with.  An extra assignment in the error path is not a big deal.
