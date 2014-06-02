From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] pack-objects: use free()+xcalloc() instead of xrealloc()+memset()
Date: Mon, 02 Jun 2014 16:09:12 -0700
Message-ID: <xmqqbnua3o4n.fsf@gitster.dls.corp.google.com>
References: <538B0969.9080409@web.de>
	<20140602194246.GD2510@sigill.intra.peff.net>
	<878upf9h9v.fsf@fencepost.gnu.org>
	<20140602215911.GA4612@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Kastrup <dak@gnu.org>,
	=?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
	Git Mailing List <git@vger.kernel.org>,
	Vicent Marti <tanoku@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 03 01:09:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WrbM3-0002d0-Ai
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jun 2014 01:09:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753111AbaFBXJT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jun 2014 19:09:19 -0400
Received: from smtp.pobox.com ([208.72.237.35]:53476 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751740AbaFBXJS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2014 19:09:18 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 45F3D1D8A8;
	Mon,  2 Jun 2014 19:09:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1jjkkL3L0rv/Za8Rl5siy8DUJD0=; b=qPUeSw
	joxgCWzgn2V4aTg66UixMFdGy5iL/6xfBPuRjgJtRO4o9LKZDiOcSv/ZkU55tTxd
	qfPMPCAkxVxLlLCSRJrPmvbgj409E2lIu8KfR9rpSgsKdkhbrq6iGNUYKTitpIZN
	GB5hy3Dm01trKzBHfM/jFFeBCV+XKPn7WNCDI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=C6H3T5QWT7yhMQC11XWc1xZ/jxjsXeiu
	AGh9DNhFyhnqikvu4vX/umaS83hgUMLnQYXAwa1638m2po782A7uM0Elqqe6nK76
	BQl0GxxTfLjlPAOW0XnLneHgcxKvb6g26I0f89+NWOnH3Z07JfYBJmZwQOUfVkgD
	jKt2v7jv5wg=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3BFC61D8A7;
	Mon,  2 Jun 2014 19:09:18 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 9DCE91D8A6;
	Mon,  2 Jun 2014 19:09:14 -0400 (EDT)
In-Reply-To: <20140602215911.GA4612@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 2 Jun 2014 17:59:11 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: EA3EC870-EAAA-11E3-B2A3-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250607>

Jeff King <peff@peff.net> writes:

> On Mon, Jun 02, 2014 at 10:40:44PM +0200, David Kastrup wrote:
>
>> > BTW, the code does git-blame to Vicent's 2834bc2 (which I also worked
>> > on), but actually originated in 7a979d9 (Thin pack - create packfile
>> > with missing delta base., 2006-02-19). Not that it matters, but I was
>> > just surprised since the code you are changing did not seem familiar to
>> > me. I guess there was just too much refactoring during the code movement
>> > for git-blame to pass along the blame in this case.
>> 
>> Without -M, "too much refactoring" for git-blame may just be moving a
>> function to a different place in the same file.
>
> I tried "git blame -M -C -C -C pack-objects.c" but couldn't get anything
> but the whole thing blamed to 2834bc2.

Are you two being a bit too unreasonable, or trying to be fanciful
and funny and I am not getting the humor?

Here is the relevant part of what 2834bc27 (pack-objects: refactor
the packing list, 2013-10-24) removes from builtin/pack-objects.c:

-	object_ix = xrealloc(object_ix, sizeof(int) * object_ix_hashsz);
-	memset(object_ix, 0, sizeof(int) * object_ix_hashsz);

And here is how the same rehash is done in pack-objects.c at the
toplevel in the new code:

+	pdata->index = xrealloc(pdata->index, sizeof(uint32_t) * pdata->index_size);
+	memset(pdata->index, 0, sizeof(int) * pdata->index_size);

Surely, the code structure may be similar, but the similarity ends
there.  These lines are not equivalent even under the "-w" option.
