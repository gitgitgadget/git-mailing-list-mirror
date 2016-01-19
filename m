From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git filter-branch not removing commits when it should in 2.7.0
Date: Tue, 19 Jan 2016 13:14:33 -0800
Message-ID: <xmqqbn8h9squ.fsf@gitster.mtv.corp.google.com>
References: <AF975DD2-988F-47A8-BFC3-3BBC27419305@wolfram.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, John Fultz <jfultz@wolfram.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jan 19 22:14:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aLdbt-0003rp-1a
	for gcvg-git-2@plane.gmane.org; Tue, 19 Jan 2016 22:14:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757269AbcASVOh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jan 2016 16:14:37 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:52484 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753224AbcASVOg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jan 2016 16:14:36 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 32BF83DAC3;
	Tue, 19 Jan 2016 16:14:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=j33Pf4VEgDsD8jH9fN/Div4OFSc=; b=QRkc0q
	QFuktXdxj6gqUMLQxsunlMaZ1OU41JwYnXW0QMYISeGHz4/vZzqWdihMwxecmQiP
	Ca5pRlC85ytAW6Jihk6aElC14l4nuADxHTlwLagmidgzD4FUiEjuTCbk8kR9k0kX
	dMUX093gG1YSkiUPOxR5rE2tvEMQM8DBBI+V8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nPsL9DTHS5oaioZ8n5WB0BcrDqH3zFKD
	i+dMh+nJJ820+7rrCx+/uZyREUcIyDf1hr33wjJPyUhC+KbMrpV7iXa0eDg33phq
	TcUW/GYgjYx9n78KAiP+DtabDJWqwLk0zf8T0Ah6o83b34NRTe63UnVFFgB7svBG
	qSVfB/PV6vs=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2A64F3DAC2;
	Tue, 19 Jan 2016 16:14:35 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 9A0443DAC1;
	Tue, 19 Jan 2016 16:14:34 -0500 (EST)
In-Reply-To: <AF975DD2-988F-47A8-BFC3-3BBC27419305@wolfram.com> (John Fultz's
	message of "Tue, 19 Jan 2016 14:48:40 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A3A38A28-BEF1-11E5-B4ED-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284379>

John Fultz <jfultz@wolfram.com> writes:

> This seems to be a 2.7.0 regression in filter-branch.  The bug is reproducible on Mac/Windows (haven't tried Linux) in the 2.7.0 production releases.
>
> Make an empty repo and put an empty commit in the history.  E.g.,
>
> echo > foo && git add . && git commit -m "commit 1" && git commit --allow-empty -m "commit 2"
>
> Now try to use filter-branch to remove the empty commit.  Both of the following methods leave master unchanged, but both worked in 2.6.4:
>
> git filter-branch --prune-empty
> git filter-branch --commit-filter 'git_commit_non_empty_tree "$@"'
>
> Let me know if you need any more information.  Thanks.
>
> Sincerely,
>
> John Fultz
> jfultz@wolfram.com
> User Interface Group
> Wolfram Research, Inc.

Thanks.

Since there were only 5 changes to git-filter-branch.sh between
v2.6.0 and v2.7.0, it was fairly easy to pinpoint.

Reverting the following commit from v2.7.0 seems to give the same
result as v2.6.0 for "--prune-empty" experiment.

commit 348d4f2fc5d3c4f7ba47079b96676b4e2dd831fc
Author: Jeff King <peff@peff.net>
Date:   Fri Nov 6 01:24:29 2015 -0500

    filter-branch: skip index read/write when possible
    
    If the user specifies an index filter but not a tree filter,
    filter-branch cleverly avoids checking out the tree
    entirely. But we don't do the next level of optimization: if
    you have no index or tree filter, we do not need to read the
    index at all.
    
    This can greatly speed up cases where we are only changing
    the commit objects (e.g., cementing a graft into place).
    Here are numbers from the newly-added perf test:
    
      Test                  HEAD^              HEAD
      ---------------------------------------------------------------
      7000.2: noop filter   13.81(4.95+0.83)   5.43(0.42+0.43) -60.7%
    
    Signed-off-by: Jeff King <peff@peff.net>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>
