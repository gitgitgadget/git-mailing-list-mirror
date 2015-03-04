From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: git describe --contains doesn't work properly for a commit
Date: Wed, 04 Mar 2015 16:06:17 +0100
Message-ID: <54F71F69.3080500@drmicha.warpmail.net>
References: <20150226133534.GB14878@dhcp22.suse.cz> <20150226142314.GC14878@dhcp22.suse.cz> <20150304105408.GA19693@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>, Michal Hocko <mhocko@suse.cz>
X-From: git-owner@vger.kernel.org Wed Mar 04 16:06:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTAsY-00038f-K1
	for gcvg-git-2@plane.gmane.org; Wed, 04 Mar 2015 16:06:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758498AbbCDPGU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Mar 2015 10:06:20 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:58333 "EHLO
	out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758243AbbCDPGU (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Mar 2015 10:06:20 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 549DF20A99
	for <git@vger.kernel.org>; Wed,  4 Mar 2015 10:06:17 -0500 (EST)
Received: from frontend2 ([10.202.2.161])
  by compute3.internal (MEProxy); Wed, 04 Mar 2015 10:06:19 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:message-id:date:from
	:mime-version:to:cc:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=5cn1QVgo59xPFfRIl7j+5a
	lSCdE=; b=ZFMYcdtUz6nXQ0i5nsZHXxW0lOKXgDHkbO+96rQJBWPESOEO6tOoO0
	ftZdBwIz6opRMgFpy+NA629mFa9uLSAYSpeHE5J4fsrfR6IkI3pYBLbtZIMIBE+t
	ULYWVGtG9HscgdMRsJq6PuQkJjUc8IqIPWmmgsKUm/jq9utemckks=
X-Sasl-enc: mockk9SWAAha80xWvUmaZWZgk405YKqTstz/SFqTeyD+ 1425481578
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 65C65680198;
	Wed,  4 Mar 2015 10:06:18 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
In-Reply-To: <20150304105408.GA19693@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264762>

Jeff King venit, vidit, dixit 04.03.2015 11:54:
> On Thu, Feb 26, 2015 at 03:23:14PM +0100, Michal Hocko wrote:
> 
>> The commit in the middle was ammended to have committer date in the
>> past.
>> $ git describe --contains d63972e4e4e7eda0444e56739ad09bfbc476b9bd
>> tag~1
>>
>> but
>> $ git describe --contains 108a0d5972fd2e5f25b2f38cfd2fee73031ff9d3
>> fatal: cannot describe '108a0d5972fd2e5f25b2f38cfd2fee73031ff9d3'
>>
>> I guess this is the same issue reported previously here:
>> http://git.661346.n2.nabble.com/git-describe-contains-fails-on-given-tree-td5448286.html
> 
> Yes, the "describe --contains" algorithm uses timestamps to cut off the
> traversal, so it can do the wrong thing if there's clock skew. It has a
> "slop" margin of one day, but skew larger than that can fool it.
> 
>> Can this be fixed somehow or it would lead to other kind of issues?
> 
> The options are basically:
> 
>   1. Stop cutting off the traversal based on timestamps. This will make
>      the common case of valid timestamps much slower, though, as it will
>      have to walk all the way to the roots.
> 
>   2. Use a different slop mechanism. For example, keep walking up to 5
>      commits past a commit suspected to be past the cutoff. This is
>      relatively easy to do (we do it for "--since" checks), and would
>      catch your case above. But of course it does not catch all cases of
>      skew.
> 
>   3. Introduce a more trust-worthy mechanism for ordering commits. The
>      timestamp here is really just a proxy for the oft-discussed
>      "generation number" of the commit within the graph. We've avoided
>      adding generation numbers because of the storage/complexity issues.

Hmmh.

Storage: one int (or maybe less) per commit doesn't sound too bad. We
can probably do without on bare repos by default.

Complexity: Was that due to replace refs? Other than that, it seemed to
be simple: max(parent generation numbers)+1.

... or can reachability bitmaps help???

Michael
