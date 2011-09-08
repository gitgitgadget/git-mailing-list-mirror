From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 1/2] remote: write correct fetch spec when renaming
 remote 'remote'
Date: Wed, 07 Sep 2011 20:43:01 -0700
Message-ID: <7vzkifzol6.fsf@alter.siamese.dyndns.org>
References: <1314924634-12235-1-git-send-email-martin.von.zweigbergk@gmail.com>
 <7vaaah6zx0.fsf@alter.siamese.dyndns.org>
 <alpine.DEB.2.00.1109062136350.12564@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 08 05:43:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1VWM-0007Z2-6Q
	for gcvg-git-2@lo.gmane.org; Thu, 08 Sep 2011 05:43:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932185Ab1IHDnI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Sep 2011 23:43:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65255 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932154Ab1IHDnH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Sep 2011 23:43:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 62D9E596C;
	Wed,  7 Sep 2011 23:43:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=m+kbi4jth2RjjSFNWpr3xV9ddbs=; b=WWg7pj
	FRt46DQNMmwXA+XblxdaWmtbPzM+ZsXB5hn9/EWyr7nrMcdw220Gv8y4vvd2kH5H
	itRjlZD0AhiHRmocCLR4jpy8D4n3gGKaOtkOmzdY99UXjOEzt0XqVDo86xJl2wuq
	RRBgJqRhKTd5ZqVy3te1lEdb3r07CuYcgdoPg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Swig7GGwfoRRhe0GMNBvTK3OC2K5GNXw
	uJ6IcxcTaEr7Mo+n3e6n3KJkQmEHmxXzHXazfF7jZ5k+j0fAal9KILxStuciEUl+
	wdxZPXDbvF5PAW53KUJ78mJpg1diDvEDGUzWfm95Zy6PNr4V4UXSNUM9+UqcBIaH
	tKZhs9HXySM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 599CF596B;
	Wed,  7 Sep 2011 23:43:03 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B501F5968; Wed,  7 Sep 2011
 23:43:02 -0400 (EDT)
In-Reply-To: <alpine.DEB.2.00.1109062136350.12564@debian> (Martin von
 Zweigbergk's message of "Wed, 7 Sep 2011 21:40:57 -0400 (EDT)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A77DAEC6-D9CC-11E0-88A8-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180936>

Martin von Zweigbergk <martin.von.zweigbergk@gmail.com> writes:

> same pattern both when updating refspecs and when renaming refs. Of
> course, we can never be certain that a ref "refs/remotes/origin/foo"
> is really related to the remote called "origin". The user could have
> simply created the ref manually. Is that what you are getting at?

You have two separate and independent code that are not linked together
but should logically be.

One updates fetch refspec whose RHS is "refs/remotes/$OLD/<anything>" to
"refs/remotes/$NEW/<the same thing>". If you do not find any such fetch
refspec, then you do not update these configuration variables, which is
good.

Later in the same mv() function, the other one renames refs/remotes/$OLD/
to refs/remotes/$NEW/, even when you did not find any fetch refspec that
stores under "refs/remotes/$OLD/<anything>" in the earlier logic.

Now, these actual refs may have been placed manually by the user. They may
have been placed by an old config that the user may have edited. You
simply do not know.

But you know one thing. You _do_ know is that these refs did _not_ come
from any "[remote "$OLD"] fetch = ..." configuration, and by inference, it
will not come from any "[remote "$NEW"] fetch = ...", in other words, they
do not have any relation with the "$NEW" remote. So I do not see a good
reason to move them from refs/remotes/$OLD/ to refs/remotes/$NEW/. That
was what I was pointing out.
