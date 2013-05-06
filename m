From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/3] fast-export: improve speed by skipping blobs
Date: Mon, 06 May 2013 08:08:45 -0700
Message-ID: <7v7gjctabm.fsf@alter.siamese.dyndns.org>
References: <1367793534-8401-1-git-send-email-felipe.contreras@gmail.com>
	<1367793534-8401-3-git-send-email-felipe.contreras@gmail.com>
	<20130506123111.GB3809@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Antoine Pelisse <apelisse@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon May 06 17:08:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZN28-0002er-33
	for gcvg-git-2@plane.gmane.org; Mon, 06 May 2013 17:08:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754426Ab3EFPIu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 May 2013 11:08:50 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48687 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754111Ab3EFPIs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 May 2013 11:08:48 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8E95F1BCC7;
	Mon,  6 May 2013 15:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=eSDCAZuF6m84FYFiPxXVENNit+Y=; b=Pl5N+m
	z6fwqPmbKHAy7zVbk+67BrKNnZUScD6iOjsItK+oYnKD2ke6rm5MVVvQp7EoaqxL
	t0qr7xnr/3G7hN5mxU8e1yOn60K8EMzC6JQsJzuaqOcV+h90SiF9k93ZMucMm/mT
	7FkEg6S7V2x4MIcQoDDJptuhYeucxqk7/XNTY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=B3EMhWhNAEWCbf37C652nwbjAX92mrr9
	GuB3fUgsx/9a9TngyPtLiuZEZVylRgbdhicY5oNiW6zogU2fPaFmQl4Pk6NkPUnu
	nZAkI6xQzfaHXNXsv4eHv8sxipThVU/O0mRHgEmntP5WYtPh84OJy8HT0Lsgh1bm
	Sb2q4nG4JZI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 84D8C1BCC6;
	Mon,  6 May 2013 15:08:47 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0B04A1BCC5;
	Mon,  6 May 2013 15:08:46 +0000 (UTC)
In-Reply-To: <20130506123111.GB3809@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 6 May 2013 08:31:11 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D9B9A974-B65E-11E2-B862-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223457>

Jeff King <peff@peff.net> writes:

> On Sun, May 05, 2013 at 05:38:53PM -0500, Felipe Contreras wrote:
>
>> We don't care about blobs, or any object other than commits, but in
>> order to find the type of object, we are parsing the whole thing, which
>> is slow, specially in big repositories with lots of big files.
>
> I did a double-take on reading this subject line and first paragraph,
> thinking "surely fast-export needs to actually output blobs?".
>
> Reading the patch, I see that this is only about not bothering to load
> blob marks from --import-marks. It might be nice to mention that in the
> commit message, which is otherwise quite confusing.

I had the same reaction first, but not writing the blob _objects_
out to the output stream would not make any sense, so it was fairly
easy to guess what the author wanted to say ;-).

> I'm also not sure why your claim "we don't care about blobs" is true,
> because naively we would want future runs of fast-export to avoid having
> to write out the whole blob content when mentioning the blob again.

The existing documentation is fairly clear that marks for objects
other than commits are not exported, and the import-marks codepath
discards anything but commits, so there is no mechanism for the
existing fast-export users to leave blob marks in the marks file for
later runs of fast-export to take advantage of.  The second
invocation cannot refer to such a blob in the first place.

The story is different on the fast-import side, where we do say we
dump the full table and a later run can depend on these marks.

By discarding marks on blobs, we may be robbing some optimization
possibilities, and by discarding marks on tags, we may be robbing
some features, from users of fast-export; we might want to add an
option "--use-object-marks={blob,commit,tag}" or something to both
fast-export and fast-import, so that the former can optionally write
marks for non-commits out, and the latter can omit non commit marks
if the user do not need them. But that is a separate issue.
