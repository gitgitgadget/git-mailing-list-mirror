From: Eric Wong <e@80x24.org>
Subject: Re: [PATCH v2 2/3] mailsplit: support unescaping mboxrd messages
Date: Mon, 6 Jun 2016 23:02:48 +0000
Message-ID: <20160606230248.GA15906@dcvr.yhbt.net>
References: <20160605044641.9221-1-e@80x24.org>
 <20160605044641.9221-3-e@80x24.org>
 <xmqq7fe2xjii.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 07 01:02:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bA3XG-00085P-QP
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jun 2016 01:02:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752527AbcFFXCP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jun 2016 19:02:15 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:53834 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751071AbcFFXCO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jun 2016 19:02:14 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id B11D21FEAB;
	Mon,  6 Jun 2016 23:02:13 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <xmqq7fe2xjii.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296571>

Junio C Hamano <gitster@pobox.com> wrote:
> This just makes me wonder if there is a practical reason why people
> would not want this always enabled.  I just looked at output from
> 
>     $ git log --grep='>>*From '

Missing '^' ?

Auto-unescaping in mailsplit might throw off people on older
versions of git if reserialized as mail, though.
Maybe in a few years, we can consider it.

Auto-escaping on the other hand, I think we start doing in
--pretty=email by default soon/today.  At least for lines
matching the stricter is_from_line() check from mailsplit.

> in the kernel repository, and I saw no cases where the committer
> really wanted to preserve the leading one or more '>' on that line.
> No, I didn't go through all of 150+ such commits, but I did check
> the couple dozen of them from the recent history.
> 
> Our history also have 5 instances of them, none of which should have
> had the leading '>' if the committer were careful.

Right, but I'm actually more worried about unescaped /^From /
breaking further attempts to split.

	git log --grep='^From .*:.*:.* .*'

...finds 45 commits in Linux 4.6.1 which might cause incorrect
splits.  We have 5 of those ourselves.

Technically it is backwards-incompatible, but I would rather
leave an extra '>' in the commit than break a split.

> > +>From the beginning, mbox should have been mboxrd
> 
> Indeed ;-)

Yes, I'm really wishing we did this 11 years ago :)
