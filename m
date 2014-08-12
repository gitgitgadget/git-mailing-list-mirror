From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] unpack-tree.c: remove dead code
Date: Tue, 12 Aug 2014 11:13:21 -0700
Message-ID: <xmqqha1h60fy.fsf@gitster.dls.corp.google.com>
References: <1407786268-15249-1-git-send-email-stefanbeller@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes.Schindelin@gmx.de, barkalow@iabervon.org,
	git@vger.kernel.org
To: Stefan Beller <stefanbeller@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 12 20:13:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XHGZk-0002u7-AE
	for gcvg-git-2@plane.gmane.org; Tue, 12 Aug 2014 20:13:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754093AbaHLSNc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Aug 2014 14:13:32 -0400
Received: from smtp.pobox.com ([208.72.237.35]:54506 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753126AbaHLSNb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Aug 2014 14:13:31 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0F0C1302E3;
	Tue, 12 Aug 2014 14:13:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZOSWhrtRQ423fUPDEVu/EHYlC6E=; b=fgQbs0
	Qiunnb4m9MK/Uk6WGL1DEGpKgpykPMNUHFQMbK5VAdZ5hyjSbjxmgkYqBzg9H7+7
	1eH+Wwmy5yBPAKY/7rU5e3d4WvFgaf4edqcLEYu3r8/U1f9sMyU3Wr/GTzPnWc1C
	xJxA7u/lrQyrXh5Kr1nzk2pJSU+EGPS+i4h4Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NZWjgAoErNv2dMa3tjKBhQ2x9bejumA8
	sKjtffL/58nau5gb6HTrKhhx/RJ3KdynS4lyIVrhiEZbkgg6gC07QMyPkwXX0CG9
	dw5OKcYQE3nU/NVlczUmzSOiUUcr41JB1QE2VLs+FrWiWkbJny9sAluyQAzjFMWb
	bI6Z89EiWEY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 01B85302DF;
	Tue, 12 Aug 2014 14:13:31 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 4B9DD302D7;
	Tue, 12 Aug 2014 14:13:23 -0400 (EDT)
In-Reply-To: <1407786268-15249-1-git-send-email-stefanbeller@gmail.com>
	(Stefan Beller's message of "Mon, 11 Aug 2014 21:44:28 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 58F3EF2E-224C-11E4-B6BE-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255158>

Stefan Beller <stefanbeller@gmail.com> writes:

> In line 1763 of unpack-tree.c we have a condition on the current tree
> 	if (current) {
> 		...
> Within this block of code we can assume current to be non NULL, hence
> the code after the statement in line 1796:
> 	if (current)
> 		return ...
>
> cannot be reached.
>
> The proposed patch here changes the order of the current tree and the
> newtree part. I'm not sure if that's the right way to handle it.

If the existing code decides to reject the merge and falls into that
code path, src[0] aka current is not NULL at that point as you
noticed, and we would call reject_merge(current, o); we would keep
doing so after this "remove dead code" patch is applied.

If you remove the dead code, which are the inner check for current,
reject_merge() call with newtree and the final fallback of returning
-1, then it would be a faithful "remove dead code without changing
anything else" update.

Having said that, I think current/newtree/oldtree are used in the
call to reject_merge() *only* for their path aka ce->name, and they
all point at the same name (there is no rename funkies here); hence
"all other failures" code path should just rely on current always
being present and become something like this instead:

		/* 20 or 21 */
                ...
	} else if (o->gently) {
        	return -1;
	} else {
        	return reject_merge(current, o);
	}

Thanks.
