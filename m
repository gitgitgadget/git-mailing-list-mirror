From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-fetch pulls already-pulled objects?
Date: Thu, 29 Oct 2015 11:42:23 -0700
Message-ID: <xmqqwpu5qzxs.fsf@gitster.mtv.corp.google.com>
References: <D256A718.1373A%strager@fb.com>
	<xmqqd1vxshrd.fsf@gitster.mtv.corp.google.com>
	<D257AC36.1376F%strager@fb.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Matt Glazar <strager@fb.com>
X-From: git-owner@vger.kernel.org Thu Oct 29 19:42:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zrs9f-00050h-SP
	for gcvg-git-2@plane.gmane.org; Thu, 29 Oct 2015 19:42:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756588AbbJ2Sm2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Oct 2015 14:42:28 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:52653 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751700AbbJ2Sm0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Oct 2015 14:42:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2F22E2404E;
	Thu, 29 Oct 2015 14:42:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IC2FFhW5V35pEpNtLrkMj6QUJZc=; b=YRrOdo
	2NoxI9N5TVK8fP43tCXvFvc2u4kil56umvA0s9fHJSOUD7wnGwfQ7CUofPomM1zc
	d8GxfdBA/ofWeEveSm6c0uJFy2wmBetAdXJxmRr1RmSQrE+DqI2gHlDGg850xlco
	RBJaUnr+svotIOw9fJhFQu2QFFQ8b6J0Btv6Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Iv1zHO+GBUnGngjGLKeOm+Ukg+yPs0wK
	3u4vYkaqXdoKmux2H5sYuete9xfdWOsX+Y5XHnTiXOG6UwAEd+ysateAhWVYSfZQ
	We8p0W2BGzEIkV3DlWKUEV/wVS0NdNxkRrP1plMVNXh1XSj1LlFehwDmzV+vFR+8
	MCPYiW4B4r4=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 25B362404D;
	Thu, 29 Oct 2015 14:42:25 -0400 (EDT)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id AB0292404C;
	Thu, 29 Oct 2015 14:42:24 -0400 (EDT)
In-Reply-To: <D257AC36.1376F%strager@fb.com> (Matt Glazar's message of "Thu,
	29 Oct 2015 18:08:44 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: CBE7CAAA-7E6C-11E5-AA83-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280455>

Matt Glazar <strager@fb.com> writes:

> Would negotiating the tree object hashes be possible on the client without
> server changes? Is the protocol that flexible?

The protocol is strictly "find common ancestor in the commit
history".  Everything else is done on the sender.

>>The object transfer is done by first finding the common ancestor of
>>histories of the sending and the receiving sides, which allows the
>>sender to enumerate commits that the sender has but the receiver
>>doesn't.  From there, all objects [*1*] that are referenced by these
>>commits that need to be sent.

>>[Footnote]
>>
>>*1* There is an optimization to exclude the trees and blobs that can
>>be cheaply proven to exist on the receiving end.  If the receiving
>>end has a commit that the sending end does *not* have, and that
>>commit happens to record a tree the sending end needs to send,
>>however, the sending end cannot prove that the tree does not have to
>>be sent without first fetching that commit from the receiving end,
>>which fails "can be cheaply proven to exist" test.

I forgot to mention the recent "pack bitmap" addition.  It makes the
set of "can be cheaply proven to exist" a lot larger.

If for example the sender needs to send one commit C because it
determined that the receiver has history up to commit C~1, without
the bitmap, even when C^{tree} (i.e. the tree of C) is identical to
C~2^{tree} (i.e. the tree of C~2), it would have sent that tree
object because "proving that the receiver already has it" would
require the sender to dig its history back, starting from C~1
(i.e. the commit that is known to exist at the receiver), to
enumerate the objects contained in the common part of the history,
which fails the "can be cheaply proven to exist" test.

The "pack bitmap" pre-computes what commits, trees and blobs should
already exist in the repository given a commit for which bitmap
exists.  Using the bitmap, from C~1 (i.e. the commit known to exist
at the receiving end), it can be proven cheaply that C^{tree} that
happens to be identical to C~2^{tree} already exists over there, and
the sender can use this knowledge to reduce the transfer.

The "pack bitmap" however does not change the fundamental structure.
If your receiver has a commit that is not known to the sender, and
that commit happens to record the same tree recorded in the commit
that needs to be sent, there is no way for the sender to know that
the receiver has it, exactly because the exchange between them is
purely "find common ancestor in history".
