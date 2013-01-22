From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] Finishing touches to "push" advises
Date: Mon, 21 Jan 2013 23:26:30 -0800
Message-ID: <7vwqv5brvd.fsf@alter.siamese.dyndns.org>
References: <20130121234002.GE17156@sigill.intra.peff.net>
 <1358836230-9197-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Chris Rorvick <chris@rorvick.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 22 08:27:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxYG2-0001Og-UI
	for gcvg-git-2@plane.gmane.org; Tue, 22 Jan 2013 08:26:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752426Ab3AVH0h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jan 2013 02:26:37 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36340 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751003Ab3AVH0h (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jan 2013 02:26:37 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2671E883C;
	Tue, 22 Jan 2013 02:26:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KyPn/S2aLFQFXN+R4TJNu3kOJ1A=; b=KxzELF
	OzFJfeTupG3FzuFVvHtVh6xwYbDQN7TkOt6zAJ9dPpl4ez6iz1SQVcw6gv3uvO7H
	P5Q9V2X3yP72vfcvA37EgOKJ+zCG4BZUFSq/lK3DDccweO5VqMvAO+fDN8BTZOh/
	shQd9wj+bS1/usbxfSzyclUggJAMh9udNeYfo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Wgh+qBsxYiksqXCOeNJj0oQj9erKRR+f
	jLe2SbN6tD+i6xa+THzcDwNU9hCdZsOMyUhzddpyzLqtuiJkyprqY0K247JjuRlM
	rUjLxX3N8gGNUywqsSAjoCO0J7bwi8LMLwHl3WxmEjuQ9rzsiQyKGcUC7xy+0kiw
	+NfSdVS8EVE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1CAEF883B;
	Tue, 22 Jan 2013 02:26:32 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A9789883A; Tue, 22 Jan 2013
 02:26:31 -0500 (EST)
In-Reply-To: <1358836230-9197-1-git-send-email-gitster@pobox.com> (Junio C.
 Hamano's message of "Mon, 21 Jan 2013 22:30:27 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0B34D6E6-6465-11E2-83C9-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214206>

As far as I am concerned, I am pretty much done with this topic, at
least for now.  Of course if there are bugreports I'll try to help
resolving them, but I do not expect myself adding new object-type
based policy decision to this codepath.

The call the updated call makes to ref_newer() no longer feeds
certain combinations to the function, because the NULL-ness of the
old and commit-ness of both are checked before making a call.

I notice that builtin/remote.c has another callsite for ref_newer().
Although I didn't look at the code, I think it is trying to see if
the branch can be pushed as a fast-forward to the remote (or the
remote tip moved since you started building on top of it).

It probably makes sense to refactor the logic that is run per-ref in
the loop in the set_ref_status_for_push() function into a new helper
function, inline ref_newer() there, and have the remaining callers
of ref_newer() to use that new helper function, which knows the new
rules such as "refs/tags/ cannot be replaced with anything without
force".
