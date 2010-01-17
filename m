From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/8] rerere: use ll_merge() instead of using xdl_merge()
Date: Sun, 17 Jan 2010 11:01:23 -0800
Message-ID: <7v4omk8sjg.fsf@alter.siamese.dyndns.org>
References: <1263721144-18605-1-git-send-email-gitster@pobox.com>
 <1263721144-18605-6-git-send-email-gitster@pobox.com>
 <201001171252.38826.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sun Jan 17 20:01:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NWaNa-0005VA-IP
	for gcvg-git-2@lo.gmane.org; Sun, 17 Jan 2010 20:01:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754169Ab0AQTBd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Jan 2010 14:01:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752911Ab0AQTBd
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Jan 2010 14:01:33 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:47198 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752552Ab0AQTBc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jan 2010 14:01:32 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7F1EE9186E;
	Sun, 17 Jan 2010 14:01:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Uo19rfpWNbcMrqS6RQFQMjj9OCs=; b=XQbdXd
	GeRN0pyC4OnFzTmKMnmSgUQ4Nu1dnHkSRlvZtsjbkUPjBihyEljngADn3VJdVesQ
	kI5Eird9zuNUarcu9Ah823BvMdpNgMXTdTV7RvNqIlK6aqDzHFz1FsWVuh0VkbL4
	ASm1HYzbHsruT+hLaKzz6MyZK7LNEdtJ338Uo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Bc9TQmYzotfecz+mO0cEIYtilTlct6Qi
	dajiaeexT8KGgRBhEnKOx7BLxJ65j0SWezKBQp4DAXJGdClnp4HJnkmSuk6Hf1ON
	tfRt+lWU6ST8+KcInrEX87aQThGJeW8vTPOoU+YMN2MOmjt/XgHnQHS46fCcpaAY
	zJEisaxWqzc=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5ED0B91863;
	Sun, 17 Jan 2010 14:01:28 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B332091862; Sun, 17 Jan
 2010 14:01:25 -0500 (EST)
In-Reply-To: <201001171252.38826.j6t@kdbg.org> (Johannes Sixt's message of
 "Sun\, 17 Jan 2010 12\:52\:38 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B78AF5DA-039A-11DF-AAF9-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137307>

Johannes Sixt <j6t@kdbg.org> writes:

> On Sonntag, 17. Januar 2010, Junio C Hamano wrote:
>> This allows us to pay attention to the attribute settings and custom
>> merge driver the user sets up.
>
> I do not think that this change is necessary; I even think that it is wrong, 
> in particular, custom merge drivers should *not* be used anymore.

You are right in that nothing is strictly necessary as long as there are
other ways to do so.  This does not have to be how the issue is solved,
but I found this to be one and the most natural way to allow rerere to pay
attention to per-path conflict marker length attribute.

Contents that you would want to use custom merge drivers would not benefit
from the current rerere that uses the default textual merge. In your
customized XML merge editor example, the merged contents have irrelevant
line breaks on either side of the merge that break textual merge (and that
is the reason you are using a custom XML aware merge script to begin with).

So I didn't think using ll_merge() makes things worse, and that was the
reason why I did it this way.

But I admit I didn't think things through (and that is why your name was
on the Cc: line).  If you really want to forbid custom merge drivers, I
think we can add an option to ll_merge() to specify which attribute to
ignore, and force the default textual merge in the codepath, or we can go
back to the xdl_merge() but pass a custom conflict marker length in
xmparam_t, as a follow-up fix.
