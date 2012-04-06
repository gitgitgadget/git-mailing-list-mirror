From: Martin Fick <mfick@codeaurora.org>
Subject: Re: Interleaved remote branch update problems
Date: Thu, 05 Apr 2012 23:32:40 -0600
Message-ID: <9a97881f-a49e-47b2-9c14-b067bc7a525c@email.android.com>
References: <201204051549.14397.mfick@codeaurora.org> <20120406003710.GC14224@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Apr 06 07:36:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SG1pz-0008T0-5g
	for gcvg-git-2@plane.gmane.org; Fri, 06 Apr 2012 07:35:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752585Ab2DFFfu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Apr 2012 01:35:50 -0400
Received: from wolverine02.qualcomm.com ([199.106.114.251]:25202 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751937Ab2DFFft (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Apr 2012 01:35:49 -0400
X-IronPort-AV: E=McAfee;i="5400,1158,6671"; a="177101407"
Received: from pdmz-ns-mip.qualcomm.com (HELO mostmsg01.qualcomm.com) ([199.106.114.10])
  by wolverine02.qualcomm.com with ESMTP/TLS/ADH-AES256-SHA; 05 Apr 2012 22:35:49 -0700
Received: from [192.168.1.160] (pdmz-snip-v218.qualcomm.com [192.168.218.1])
	by mostmsg01.qualcomm.com (Postfix) with ESMTPA id 1CB5E10004AA;
	Thu,  5 Apr 2012 22:35:49 -0700 (PDT)
User-Agent: K-9 Mail for Android
In-Reply-To: <20120406003710.GC14224@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194846>



Jeff King <peff@peff.net> wrote:
>On Thu, Apr 05, 2012 at 03:49:14PM -0600, Martin Fick wrote:
>
>> I have noticed that git push --force does not reliably force 
>> a push to remote branches.  In particular, it will not 
>> update a remote branch if that branch has been updated since 
>> the beginning of the push.  Is this normal, is this 
>> expected?
>
>Yes, that's expected. --force means "it's OK to push something that
> will rewind history", not "it's OK to clobber somebody else who is
> pushing at the same time".

But why is it ok to clobber somebody else right after they pushed, this seems like splitting hairs?  Why force me to wait to clobber?  Afterall, git goes through great pains to only lock a ref for the small duration of time when it is updated.  But this behavior means that it effectively is actually locked for the entire duration of a push except that it teases a client into thinking it is not locked until then end of a potential costly transfer.

And what about the fast forward case?  If client A is pushing change a and then client B starts pushing b which depends on a, why shouldn't B succeed as long as A succeeds first, even without the force flag?  But it does not work this way even with the force flag.


> The determination for the former happens on the client
>side, and for the latter on the server side.
>
>If you want the latter, you would need a protocol extension, I think;
>I'm pretty sure the client doesn't transmit the force flag at all to
>the
>server (and I don't think this should be tied to the force flag
>automatically; they are two different cases, and you may be in a
>situation where it is safe to do the former but not necessarily the
>latter).

I think this use case distinction is irrelevant to users on a shared server unless you could somehow tell git to "only clobber the branch if it currently points to shax".  Which is sort of what git is pretending to do, but it isn't really since the user isn't specifying shax, it is determined when the push starts and is inherently subject to a race.  It's not like the user can safely determine what the remote branch points to before they update it to see if it is ok to clobber it.

Just a user's perspective...

-Martin

Employee of Qualcomm Innovation Center,Inc. which is a member of Code Aurora Forum
