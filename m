From: Martin Fick <mfick@codeaurora.org>
Subject: Re: remove_duplicates() in builtin/fetch-pack.c is O(N^2)
Date: Tue, 22 May 2012 16:19:30 -0600
Organization: CAF
Message-ID: <201205221619.31738.mfick@codeaurora.org>
References: <4FB9F92D.8000305@alum.mit.edu> <3b77e2a3-872a-41c1-9a51-0f219a549c04@email.android.com> <20120522182157.GB20305@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	git discussion list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed May 23 00:19:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWxQY-0006bh-13
	for gcvg-git-2@plane.gmane.org; Wed, 23 May 2012 00:19:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755623Ab2EVWTd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 May 2012 18:19:33 -0400
Received: from wolverine02.qualcomm.com ([199.106.114.251]:60448 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754698Ab2EVWTc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 May 2012 18:19:32 -0400
X-IronPort-AV: E=McAfee;i="5400,1158,6719"; a="191365887"
Received: from pdmz-css-vrrp.qualcomm.com (HELO mostmsg01.qualcomm.com) ([199.106.114.130])
  by wolverine02.qualcomm.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 22 May 2012 15:19:32 -0700
Received: from mfick-lnx.localnet (pdmz-snip-v218.qualcomm.com [192.168.218.1])
	by mostmsg01.qualcomm.com (Postfix) with ESMTPA id 4AF7410004A9;
	Tue, 22 May 2012 15:19:32 -0700 (PDT)
User-Agent: KMail/1.13.5 (Linux/2.6.32.49+drm33.21-mfick7; KDE/4.4.5; x86_64; ; )
In-Reply-To: <20120522182157.GB20305@sigill.intra.peff.net>
X-Length: 2632
X-UID: 106
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198260>

On Tuesday, May 22, 2012 12:21:57 pm Jeff King wrote:
> On Mon, May 21, 2012 at 11:51:16PM -0600, Martin Fick 
wrote:
> AFAIK, ref advertisement scales linearly. Which is
> probably not acceptable over a slow link, and we could
> do better.

Right, although it is not just a slow link issue.  Linear or 
not, this problem does not scale, it needs to be based on N, 
the number of refs which need updating, not N the number of 
refs in the repo.

I gave the following numbers to Junio and Shawn recently and 
I figure it is probably worth mentioning them here to 
perhaps give others some insights into just how bad this 
problem can be...

Android consists of approximately 400 projects, and if 
anyone tags their builds regularly, that means that they 
will be tagging 400 projects per build.  We have something 
like 10K tags on average across 400 projects, so when we do 
a simple No Op sync just to see if all 400 projects are up 
to date, this yields about 200MB of data over the wire (4M 
refs)!!!

That 200MB is using a -j4 on repo sync and it chews up about 
1.5 cores on a high end server to serve that 200MB for over 
1min.  Now imagine a build bot needing to build about 25 
images in parallel all just doing a No Op sync to see if 
they are up to date!  That's 25 * 200MB = 5GB data and 25 * 
1.5 cores ~= 36 cores. That means our high end 24 core 
server falls over all for a No Op.

As you can imagine, we really would like to see this 
eliminated from our workflows.  If we want to check 400 
projects to see if they are up to date, it should be 400 
refs, not 400 * 10K,

-Martin

-- 
Employee of Qualcomm Innovation Center, Inc. which is a 
member of Code Aurora Forum
