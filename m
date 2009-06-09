From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v3 0/3] automatically skip away from broken commits
Date: Tue, 09 Jun 2009 15:54:29 -0700
Message-ID: <4A2EE825.1020200@zytor.com>
References: <20090606043853.4031.78284.chriscool@tuxfamily.org> <m3prdd4t6s.fsf@localhost.localdomain> <4A2E7BA7.8000901@zytor.com> <200906092355.51244.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	git@vger.kernel.org, Sam Vilain <sam@vilain.net>,
	Ingo Molnar <mingo@elte.hu>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 10 00:55:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MEAE0-0007Oh-1O
	for gcvg-git-2@gmane.org; Wed, 10 Jun 2009 00:55:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753561AbZFIWyr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jun 2009 18:54:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753069AbZFIWyr
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jun 2009 18:54:47 -0400
Received: from terminus.zytor.com ([198.137.202.10]:60026 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751000AbZFIWyq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jun 2009 18:54:46 -0400
Received: from anacreon.sc.intel.com (hpa@localhost [127.0.0.1])
	(authenticated bits=0)
	by terminus.zytor.com (8.14.3/8.14.1) with ESMTP id n59MsTZb024638
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 9 Jun 2009 15:54:30 -0700
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
In-Reply-To: <200906092355.51244.jnareb@gmail.com>
X-Virus-Scanned: ClamAV 0.94.2/9447/Tue Jun  9 12:54:17 2009 on terminus.zytor.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121234>

Jakub Narebski wrote:
> 
> Let us also assume that we have some model of probability that a commit
> is untestable. In the example below numbers are ad hoc, and unrealistic.
> 

What I mostly meant was that there simply is no such model that will be
ideal (since we simply don't have that information, almost by
definition), so therefore the overall algorithm can't be ideal, either.

However, Christian and you do make a very good point that instead of a
linear-probability random selection, it probably makes sense to bias the
randomness in favor of the commits that are more likely to provide
higher information gain.  This is effectively what Christian's patch
does in a somewhat clumsy way.

One of the nice things about combining a random algorithm with bias is
that the bias doesn't have to be perfect, it just have to be good
enough.  For example, we can take dramatic shortcuts like not taking
topology into accounts.

A logical bias function would indeed be an estimate of the information
gain.  One way we can calculate the effective information gain is by
take the list in "goodness order" that we already have, and treat it as
if it had originally been a linear history -- this will usually not be
the case, but we're probabilistically getting away with murder here.

The sorting in "goodness order" of a linear history means sorting
middlemost first, so the modified information density function with x
being the position in the list (x = 0 for best, x = 1 for worst) looks like:

- 1/(2 ln 2) * [ (1-x) ln (1-x) + (1+x) ln (1+x) - 2 ln 2 ]

I'd have to brush up some more of my calculus in order to remember how
to come up with a transformation function which would take a random
number and give us this exact probability distribution, but again, I
don't think it's hugely important; I suspect any function which gives us
a probability distribution that's even in the right neighborhood would
give us excellent results.

	-hpa
