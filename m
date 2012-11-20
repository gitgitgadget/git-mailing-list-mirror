From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] pickaxe: use textconv for -S counting
Date: Mon, 19 Nov 2012 16:48:22 -0800
Message-ID: <7vr4npt7zd.fsf@alter.siamese.dyndns.org>
References: <20121028124540.GF11434@sigill.intra.peff.net>
 <20121028124701.GB24548@sigill.intra.peff.net>
 <7vk3tpcd0w.fsf@alter.siamese.dyndns.org>
 <20121115012131.GA17894@sigill.intra.peff.net>
 <7v3905uncf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Peter Oberndorfer <kumbayo84@arcor.de>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Nov 20 01:48:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tac11-0007Bs-O5
	for gcvg-git-2@plane.gmane.org; Tue, 20 Nov 2012 01:48:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752893Ab2KTAsZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Nov 2012 19:48:25 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55355 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751006Ab2KTAsZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Nov 2012 19:48:25 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DA2C66091;
	Mon, 19 Nov 2012 19:48:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=USIvfx50xTFzL7qPzTU+p8HkQeQ=; b=b81DUmBQvPUq/W65ZTKE
	bEIh3mCZIZt0ekaZ3yYfnlQdHuSfFkpLiAOsXiWuCNjkOXYYyM7bQROiik6q0RZY
	xiLowdNKGJvRXfIAS+MmsLRvdPSOhMFCdEQSUEbcbwGkxNQn6bWAXc3pkeX+16IO
	QBO0/B2f3QsCJDfziVOUDSk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=B/5BSZ41Gw7zxKECaiXuxuBd/bFOl/T3BYkDdg5Qx1AVy2
	pG7jVNnNgGp7mFPG1BI3SGdwNeZtVUXHkF0T0GgCmfhVhjy0m0tHIjNHnmhZt363
	AoXdjMaZElLGk7JYuV1gr26L4d5+82kOKLGxekBmOmiKmTis7TWwWuK4ap8uM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C7FA06090;
	Mon, 19 Nov 2012 19:48:24 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3EFF7608F; Mon, 19 Nov 2012
 19:48:24 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FD290878-32AB-11E2-A977-C2612E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210071>

Junio C Hamano <gitster@pobox.com> writes:

>> Exact renames are the obvious one, but they are not handled here.
>
> That is half true.  Before this change, we will find the same number
> of needles and this function would have said "no differences" in a
> very inefficient way.  After this change, we may apply different
> textconv filters and this function will say "there is a difference",
> even though we wouldn't see such a difference at the content level
> if there wasn't any rename.

... but I think that is a good thing anyway.

If you renamed foo.c to foo.cc with different conversions from C
code to the text that explain what the code does, if we special case
only the exact rename case but let pickaxe examine the converted
result in a case where blobs are modified only by one byte, we would
get drastically different results between the two cases.

Corollary to this is what should happen when you update the attributes
between two trees so that textconv for a path that did not change
between preimage and postimage are different.  Ideally, we should
notice that the two converted result are different, perhaps, but I
do not like the performance implications very much.
