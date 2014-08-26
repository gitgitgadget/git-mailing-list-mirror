From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Check order when reading index
Date: Tue, 26 Aug 2014 09:53:04 -0700
Message-ID: <xmqqmwarjiq7.fsf@gitster.dls.corp.google.com>
References: <xmqq38cpsmli.fsf@gitster.dls.corp.google.com>
	<1408903047-8302-1-git-send-email-jsorianopastor@gmail.com>
	<xmqqvbpgmqmh.fsf@gitster.dls.corp.google.com>
	<20140825194430.GI30953@peff.net>
	<CAPc5daW-ZckFfhyueNLnPaBeriAmCUVJjFc1cw0O5iRi8F+Kng@mail.gmail.com>
	<CAPuZ2NHafXQthtuq-RnTvpjVfNPaXHEy8SejuhPEnG+MwCK=sg@mail.gmail.com>
	<20140826122008.GC29180@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jaime Soriano Pastor <jsorianopastor@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Aug 26 18:53:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMJzr-0006Yx-3P
	for gcvg-git-2@plane.gmane.org; Tue, 26 Aug 2014 18:53:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752335AbaHZQxW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2014 12:53:22 -0400
Received: from smtp.pobox.com ([208.72.237.35]:56435 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751851AbaHZQxW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2014 12:53:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 46F67327FD;
	Tue, 26 Aug 2014 12:53:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/trTd8YGLq5zukZEZEqbCrRiBo4=; b=R9OAjm
	1lu+LfHBeCAkhzR0BcjdVMNvidajQnSjHDojiSytoMAEFwLyh3ms8XlqhEKUumoM
	I60x2cjDbUv4rw9TntG/iUJq0MtUgEjnzC205jDP5oSqXRUPvJM6el3eIDFWUGFc
	aCwFOUiShBr3e+EaTmOe/Kge58rt2RASMfCTo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=A9cbAhaVkxpCff1LHe3dcmCi3NsX1oyQ
	iGs1eInoKa/VH9CerNCtSWvUwkHCyZjANa40Fex7syJR6OiO8jUItd6XglcAg5tT
	7jNof9Q1KvfOtDvUyGfiqAuc1NV0V/SJ6CcyeEGW+mt0g3feEGZkEs3DRfB8DGhc
	gCWtspSQC44=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3DCBA327FC;
	Tue, 26 Aug 2014 12:53:16 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 883FD327F6;
	Tue, 26 Aug 2014 12:53:06 -0400 (EDT)
In-Reply-To: <20140826122008.GC29180@peff.net> (Jeff King's message of "Tue,
	26 Aug 2014 08:20:09 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 73BB09C8-2D41-11E4-9C22-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255917>

Jeff King <peff@peff.net> writes:

>> With "natively" do you mean some internal state that is never written
>> into the index? If this were the case then there wouldn't be any
>> problem with the restriction when reading the index file.
>
> FWIW, that was my question on reading Junio's response, too.

The current code may not put two stage #1 entries for the same path
but allowing such entries was a part of the design from very early
days; iow it is a valid index file, unlike the one that has both
stage #0 and stage #1 for the same path.  It is a no-no to reject
such an index as long as we are discussing to add a new code to
tighten the sanity check on the file content.

>> I have also tried to reproduce it by directly calling
>> git-merge-recursive and the most I have got is what it seemed to be
>> like a conflict in the stage #1:
>> 
>> $ git ls-files -s
>> 100644 1036ba5101378f06aa10c5fa249b67e14f83166b 1 conflict
>> 100644 2638c45f8e7bc5b56f70e92390153572811782c3 2 conflict
>> 100644 178481050188cf00d7d9cd5a11e43ab8fab9294f 3 conflict
>> 
>> $ git cat-file blob 1036ba5101378f06aa10c5fa249b67e14f83166b
>> <<<<<<< Temporary merge branch 1
>> G
>> =======
>> E
>> F
>> >>>>>>> Temporary merge branch 2
>
> Yes, I think merge-recursive resolves the earlier merges and then feeds
> the result into the main merge. And that's how you end up with the
> "temporary merge branch" name instead of something useful.

Yes---that is what I meant by the "virtual stuff".  Unlike resolve
work by Daniel (around Sep 2005 $gmane/8088) that tried to use
multiple ancestors directly in a single merge, recursive limits
itself to repeated use of pairwise merges.
