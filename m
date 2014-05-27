From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v8 41/44] refs.c: add a new flag for transaction delete for refs we know are packed only
Date: Tue, 27 May 2014 11:27:53 -0700
Message-ID: <xmqqzji3f55i.fsf@gitster.dls.corp.google.com>
References: <1400174999-26786-1-git-send-email-sahlberg@google.com>
	<1400174999-26786-42-git-send-email-sahlberg@google.com>
	<537F67DD.5010101@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ronnie Sahlberg <sahlberg@google.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue May 27 20:28:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WpM6W-0000Qj-PH
	for gcvg-git-2@plane.gmane.org; Tue, 27 May 2014 20:28:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752226AbaE0S2A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2014 14:28:00 -0400
Received: from smtp.pobox.com ([208.72.237.35]:63934 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751477AbaE0S17 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2014 14:27:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C57081A100;
	Tue, 27 May 2014 14:27:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Hds/tbh4kzkHTozk3FegBRvAGjk=; b=vHo1Dw
	+P7WOCC1M1tnbbAf1QwKWwjO7kaBh9ZnBwVZpFBLv/lY/TYNeFR9Ghpfzrbf52bV
	bzz3C5xJYmoHYBJCe/IqKHv/x6Mq/gkXRFR2/E5HWWiTnHNDEDPDREjM+sU4g3cY
	6HaGEad+3XY0I4Bs/WKPqmCGwmem2xY1wqe1g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=b6dMzTCwjoAGG6RT+XsS+Dfs2i8WSVd9
	VSOKyNkzXJyG9/iQ1KHRgVpO8Fb0XH0f6frAif+Ht4SBcxqYQUjuhfKdsrydoAZc
	v8lsy7rxszbeBJxjDc4myRiawQVlEEUfU9ThYWhd7mgcvNLEuhM4TzkN98iZ372N
	feemm8IUSX8=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BB8ED1A0FF;
	Tue, 27 May 2014 14:27:58 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 439A41A0FB;
	Tue, 27 May 2014 14:27:55 -0400 (EDT)
In-Reply-To: <537F67DD.5010101@alum.mit.edu> (Michael Haggerty's message of
	"Fri, 23 May 2014 17:23:09 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 9EE0F282-E5CC-11E3-8207-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250182>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> This suggests to me that our current structure is best modeled as two
> independent reference back ends, with a third implementation of the same
> reference API whose job it is to compose the first two.  In pseudocode,
> ...

That is an interesting view.

How does reflog fit into the picture?  Is it a completely
independent thing that is called from any implementation of
ReferenceBackend interface?

> From this point of view it is clear that packing refs is not an
> operation that belongs in the ReferenceBackend API, but rather in the
> StackedReferenceBackend interface.

When an implementation of ReferenceBackend has skewed performance
characteristics (e.g. PackedReferenceBackend really prefers to be
modified in bulk), how would that interact with the abstraction?

For example, when the application does:

    begin_transaction()
    for ref in many_refs():
	delete_reference(ref)
    commit_transaction()

StackedReferenceBackend() that consists of Loose on top of Packed
may want to implement the commit phase like so:

    - tell Packed backend to repack without the deleted refs
    - tell Loose backend to delete the deleted refs

But the above would not quite work, as somebody needs to remove logs
for refs that were only in the Packed backend, and "repack without
these refs" API supported by the Packed backend cannot be that
somebody---"repack packed-refs without A B C" cannot unconditionally
remove logs for A B C without checking if A B C exists as Loose.



    
