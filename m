From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v8 1/4] sha1_file.c: support reading from a loose object of unknown type
Date: Fri, 17 Apr 2015 14:10:50 -0700
Message-ID: <xmqq4moepijp.fsf@gitster.dls.corp.google.com>
References: <552E9816.6040502@gmail.com>
	<1429117143-4882-1-git-send-email-karthik.188@gmail.com>
	<xmqqmw29jg78.fsf@gitster.dls.corp.google.com>
	<20150415221824.GB27566@peff.net> <20150417142310.GA12479@peff.net>
	<xmqqd232hgj8.fsf@gitster.dls.corp.google.com>
	<20150417205125.GA7067@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org,
	sunshine@sunshineco.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Apr 17 23:10:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YjDXO-0004sP-TW
	for gcvg-git-2@plane.gmane.org; Fri, 17 Apr 2015 23:10:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753409AbbDQVKz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Apr 2015 17:10:55 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:55990 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751927AbbDQVKy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Apr 2015 17:10:54 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9861E497CB;
	Fri, 17 Apr 2015 17:10:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0NR69R1/0lYlShYyQ9mPr1609f8=; b=eb6+t0
	Kw/DWQ4Qp6CifJ4sT9Lmfz0FLekKXbIELwlLJv+Wk+TZ07vBOvyemu14qsWql8W9
	FxS72PmwMcW+chdFXjdU1csybwwkk7vjt7bW8hgUO88wWyIR1SF5BfijByGe4M02
	cXCVLyF1wLRupQATV3R6ZjZqj1S/abRP3Xk3o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xAK98OwgUsSUnTeJck73OlJ/iUjMSjdm
	VeQbwobnrZmveCYtRq4Ap8OUjK8VUQkMzuJuyBy12F4H4sesxa5x+4qlx6bJhx2S
	TiQldIkKHmnyt6YSIjiXZZe5pCyuJZbovcURt0g8xWISMRPaISzTNzTGur1Yw42/
	bshCPEWWTv0=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 91CEA497CA;
	Fri, 17 Apr 2015 17:10:53 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0683D497C8;
	Fri, 17 Apr 2015 17:10:53 -0400 (EDT)
In-Reply-To: <20150417205125.GA7067@peff.net> (Jeff King's message of "Fri, 17
	Apr 2015 16:51:26 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 3B2B16DA-E546-11E4-A581-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267393>

Jeff King <peff@peff.net> writes:

> On Fri, Apr 17, 2015 at 09:21:31AM -0700, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>> 
>> > If there _is_ a performance implication to worry about here, I think it
>> > would be that we are doing an extra malloc/free.
>> 
>> Thanks for reminding me; yes, that also worried me.
>
> As an aside, I worried about the extra allocation for reading the header
> in the first place. But it looks like we only do this on the --literally
> code path (and otherwise use the normal unpack_sha1_header).  Still, I
> wonder if we could make this work automagically.  That is, speculatively
> unpack the first N bytes, assuming we hit the end-of-header. If not,
> then go to a strbuf as the slow path. Then it would be fine to cover all
> cases; the normal ones would be fast, and only ridiculous things would
> incur the extra allocation.

Yes, that was what I was hoping to see eventually ;-)
