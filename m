From: Junio C Hamano <gitster@pobox.com>
Subject: Re: who's on first? - following first parent and merge-management
Date: Thu, 08 Mar 2012 09:30:57 -0800
Message-ID: <7vpqcndmpa.fsf@alter.siamese.dyndns.org>
References: <jj6s47$m98$1@dough.gmane.org>
 <7vwr6woo8p.fsf@alter.siamese.dyndns.org>
 <7vty1zfwmd.fsf@alter.siamese.dyndns.org>
 <20120308071403.GE7643@sigill.intra.peff.net>
 <4F5867D4.1010904@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>,
	Neal Kreitzinger <nkreitzinger@gmail.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Mar 08 18:31:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5hBE-0004K0-3V
	for gcvg-git-2@plane.gmane.org; Thu, 08 Mar 2012 18:31:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757823Ab2CHRbC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Mar 2012 12:31:02 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44584 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753814Ab2CHRbA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Mar 2012 12:31:00 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8E8EB677D;
	Thu,  8 Mar 2012 12:30:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mxKg7dPOLWUiyPJiM5sy6v1yVOE=; b=kmHc3o
	ElV2HSNyoyqore4c9vrgTAlj7bISzmyj43o+7cxk0DPRQ/+3KjRfuwkZ/20ZjnTi
	A3uoxKHaSClpXX8FbihabNb3OtifwX1K9pwg+csZ2ZRxhFi/JxyT6AL7jMetu+5m
	lqbpd28esc5XNQog0QDgi8eOifNPqdN0jgVoU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Vn0miK61QqNdQudm5UNqHpJQlkMKhfzs
	nQYGXrK/EUy2PedVw+qYIpuBnN+Yck2blz71rwJQLyNFNUv5ruGtNj5hXRr23eYz
	5D6S6taUEvq+9104NHibNRRB588IXTgduMFKcLB/bmpqzlDj9c7OzdQmVvbfRtkk
	Hg2UkXuRqKo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 85771677C;
	Thu,  8 Mar 2012 12:30:59 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 03383677B; Thu,  8 Mar 2012
 12:30:58 -0500 (EST)
In-Reply-To: <4F5867D4.1010904@viscovery.net> (Johannes Sixt's message of
 "Thu, 08 Mar 2012 09:03:32 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 780723B8-6944-11E1-ADB6-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192619>

Johannes Sixt <j.sixt@viscovery.net> writes:

> I have wished for such a thing several times already.
>
> It happens when I have a topic with changes that trigger a complete
> rebuild of the project. When I merge it to master, I have to
>
>    # on topic
>    git checkout master   #1
>    git merge topic       #2
>
> #1 triggers a rebuild, but I don't do a build. Then #2 again triggers a
> rebuild, but in reality the only changes since the last build are those
> from master since the topic forked (no, I can't use ccache).
>
> To avoid the situation,...
> This would not be necessary if the order of the merge parents could be
> specified, e.g.:
>
>    # on topic
>    git merge --into master

I think the underlying mechanism needed to implement the above
shares a lot with what Jeff called "crazy idea", but where you would
want to be after such a merge may be different in these two cases.

With the "crazy idea", you merge the other branch that happened to
be the mainline into your work in reverse. You would explain such a
merge as "I am merging early part of my topic that will eventually
do X to mainline now, to make later conflict resolution easier, even
though it is not yet complete" or something like that, and you will
continue working on your topic starting from the resulting merge.
The real project mainline will not be updated with this merge until
the topic is complete (in other words, you do not push).

I have a feeling that your "git merge-to master" may be different.
You may explain the resulting commit as "This topic is complete for
now and is ready for master", and the master gets updated with the
result, but you may want to keep "topic" free of unrelated random
other development that happened on "master" since they diverged.
That way, "topic" can further be polished and you will leave the
door open to merge it down to even older releases than "master".
