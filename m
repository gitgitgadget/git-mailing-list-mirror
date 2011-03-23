From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [RFH] git cherry vs. git rev-list --cherry, or: Why does "..."
 suck?
Date: Wed, 23 Mar 2011 17:46:05 +0100
Message-ID: <4D8A23CD.9030203@drmicha.warpmail.net>
References: <4D889119.3020009@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Mar 23 17:49:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2RFh-0000sJ-JR
	for gcvg-git-2@lo.gmane.org; Wed, 23 Mar 2011 17:49:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753364Ab1CWQtk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Mar 2011 12:49:40 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:38952 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751755Ab1CWQtk (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Mar 2011 12:49:40 -0400
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 8F9E8201DD
	for <git@vger.kernel.org>; Wed, 23 Mar 2011 12:49:39 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Wed, 23 Mar 2011 12:49:39 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=0TO9kASBVoznvDweaYZOw6TU7Zg=; b=uJX2JhOSZKxD0bPJ03/r76fG3IcFg6hPYzCGUCgVTo5fUKyao+uXZ9IcmJ+we32qzpDfHn5PMfRYShN8pJ70rFsB5Q4ITRQOCzTbs48EHqTOw6v5MWagGwlsveRfbvYZ20Q392JRvXDqGjLL5oyd5Z+f9e7khTztk2wIIzGIe2k=
X-Sasl-enc: iUvGwgvAwwzIfbJezVwLHs1efyPibzb9Dg0cxuE09B9g 1300898979
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 339B540C459
	for <git@vger.kernel.org>; Wed, 23 Mar 2011 12:49:39 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110305 Remi/fc14 Lightning/1.0b3pre Thunderbird/3.1.9
In-Reply-To: <4D889119.3020009@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169852>

Adding some recent insight:

Michael J Gruber venit, vidit, dixit 22.03.2011 13:07:
> Performance
> ===========
> 
> I don't get this:
> 
> git cherry A B: 0.4s
> git rev-list --cherry A...B: 1.7s
> (more details below)

I can get the latter down to 0.95s and this

> merge-base A B: 0.95s
> merge-base --all A B: 0.95s
> rev-parse A...B: 0.95s

to 0.16s each. The downside is that merge-base may give a few
unneccessary candidates (commits which are ancestors of other commits it
returns), but this does not change the results for rev-list, of course.

I get this dramatic speedup by removing the check for duplicates from
get_merge_bases_many() in commit.c. After a first merge_bases_many()
run, returning N commits, that check calls merge_bases_many() again for
each pair (N choose 2) to check whether one is contained in the other.
Quite a bottleneck. Removing it works great. But can we live with a few
additional merge bases?

Michael
