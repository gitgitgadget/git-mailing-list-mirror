From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 3/7] show: honor --textconv for blobs
Date: Fri, 10 May 2013 11:04:01 -0700
Message-ID: <7vfvxu1zla.fsf@alter.siamese.dyndns.org>
References: <7vy5c1l6nb.fsf@alter.siamese.dyndns.org>
	<c4ed1e0b67877e6453b8c269290e09e1672ce37d.1368197380.git.git@drmicha.warpmail.net>
	<7vy5bm22f8.fsf@alter.siamese.dyndns.org>
	<20130510173434.GA3154@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri May 10 20:04:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uarfz-0003hF-IJ
	for gcvg-git-2@plane.gmane.org; Fri, 10 May 2013 20:04:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757927Ab3EJSEI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 May 2013 14:04:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55908 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757883Ab3EJSEE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 May 2013 14:04:04 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B7EAF1DABE;
	Fri, 10 May 2013 18:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=axQQ7kypArR/w2MJLuVHeP//78o=; b=rHc6qm
	gLjWww1CEjFTNuICuvhuJFPhiVXe202xoYt1oH1eLBe90C8J34DluOfnmpHy19em
	f9GN/gBGy/tbBtlXy+PAkYa8bqms3FsUwbWplTHYRttuzvKTCdpsILKAWqOQEY5W
	395LBHtOq1h1CxUod+9pn10EwLT2MWytQHzpo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Cb6iKzQOigRPfBnknZg87kp9XAYfVCmN
	csc7kU+ybM5yvTaTqjcm/h5jJJe4CbBxuXV6j4DsGxhrSBHioJh4lYBnbX23eJMH
	XFWZfdE0kJ8MDKKrt0YiKEYzaJTva64+26PJddJEXT1p4BdRb7f7Cb6BPgETVJE2
	rAHJHGsE8/s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AFDCA1DABD;
	Fri, 10 May 2013 18:04:03 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 18D861DABA;
	Fri, 10 May 2013 18:04:03 +0000 (UTC)
In-Reply-To: <20130510173434.GA3154@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 10 May 2013 19:34:34 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FF6F4346-B99B-11E2-B01D-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223886>

Jeff King <peff@peff.net> writes:

> On Fri, May 10, 2013 at 10:02:51AM -0700, Junio C Hamano wrote:
>
>> > Make "show" on blobs behave like "diff", i.e. honor "--textconv" by
>> > default and "--no-textconv" when given.
>> [...]
>> So "show" on blobs does show the raw contents by default, but the
>> user can explicitly ask to enable textconv with --[no-]textconv.  Is
>> the second paragraph in the log message still valid?
>
> Yes, I had the same thought...

I'd rewrite the paragraph to something like:

    Make "show" on blobs honor "--textconv" when it is asked.  The default
    is not to apply textconv, which is in line with what "cat-file" does.

>> > +	if (get_sha1_with_context(obj_name, 0, sha1c, &obj_context))
>> > +		die("Not a valid object name %s", obj_name);
>> 
>> This looks somewhat unfortunate.
>> [...]
>> I wonder if enriching rev_info->pending with the context information
>> might be a clean solution to avoid this redundant but unavoidable
>> conversion, but that is a separate and future topic, I think.
>
> It would be, and indeed, that is similar to what the final patch does.

OK, I wasn't paying attention ;-)

> The problem is that it requires an extra allocation (we do not want to
> unconditionally put the object_context into the object_array because it
> is too big, so we add only a pointer). So having rev_info->pending store
> that information would mean that callers would have to know to free it
> when freeing the pending array. We would have to either teach each
> existing caller to do so, or perhaps enable the behavior only when a
> certain flag is set (e.g., rev->keep_object_context or something).

One thing to notice is that those accessing rev->pending before
calling prepare_revision_walk(), as opposed to those receiving
objects in rev->commits via get_revision(), are the only ones that
care about the context and wants to act differently depending on
where these came from and how they were specified.

That suggests at least two possibilities to me:

 - Perhaps we can place the context in rev->pending and clear them
   when prepare_revision_walk() moves them to rev->commits, without
   introducing rev->keep_object_context?

 - Perhaps instead of extending object-array, we can move this kind
   of information to rev_cmdline and enrich that structure?
