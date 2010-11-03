From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: git fetch -v not at all verbose?
Date: Wed, 3 Nov 2010 11:52:49 +0200
Message-ID: <20101103095249.GA9144@redhat.com>
References: <20100121155136.17b59e8f.rctay89@gmail.com>
 <20100121140054.GH18213@onerussian.com>
 <20100121224100.624c9c9d.rctay89@gmail.com>
 <20100121155637.GA19078@spearce.org>
 <20100121160707.GA31276@glandium.org>
 <20100121161016.GA16300@redhat.com>
 <20100121161858.GC19078@spearce.org>
 <20100121163518.GA16466@redhat.com>
 <20100121165737.GG19078@spearce.org>
 <7v8wbrtkvn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 03 10:52:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDa1a-0006Zh-NJ
	for gcvg-git-2@lo.gmane.org; Wed, 03 Nov 2010 10:52:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752839Ab0KCJwy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Nov 2010 05:52:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36551 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751282Ab0KCJww (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Nov 2010 05:52:52 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id oA39qnc6020718
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Wed, 3 Nov 2010 05:52:49 -0400
Received: from redhat.com (vpn-6-164.tlv.redhat.com [10.35.6.164])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id oA39qlMv019852;
	Wed, 3 Nov 2010 05:52:47 -0400
Content-Disposition: inline
In-Reply-To: <7v8wbrtkvn.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.23
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160593>

On Thu, Jan 21, 2010 at 09:42:36AM -0800, Junio C Hamano wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> 
> >> > Are you fetching from a configured remote that has tracking branches,
> >> > or are you fetching through a one-shot URL pasted onto the command
> >> > line?
> >> 
> >> Configured remote.
> >
> > Hmm.  I wonder if we should try to shortcut the commit walking in
> > a case like this and just feed the tracking branches we already have.
> 
> You mean that the main culprit is the presense of thousdands of commits
> that fetcher has obtained through the other remotes (and his own) that the
> uploader makes fetcher walk all the way, in the false hope that there
> might be a commit among them that is closer to the commits being fetched
> than the ones at the tip of tracking branch the fetcher has for this
> uploader currently?
> 
> And the solution might be to tell only about the tips of remote tracking
> branches fetcher has obtained from this particular uploader, not about
> other remote tracking bracnesh it got from others or his own local
> branches (which may have merged from other remotes)?
> 
> It is a clever idea but I suspect it may not work well in practice.  For
> example, suppose a project is two-tier, say, with top-level and subsystem
> repositories, the former of which regularly merge from the latter, and you
> are a participant primarily working on the subsystem.  You fetch daily
> from the subsystem repository, but weekly from the top-level.
> 
> Now, when you fetch from the top-level, the remote tracking refs you have
> for it are much more stale than your other refs.  The top-level would have
> acquired a lot more commits from the same subsystem repository since you
> fetched from there the last time, and you already have many of them
> through your daily fetch from the subsystem repository.  To minimize the
> transfer in such a case, the fetcher does want to tell the uploader that
> it has those commits from the same subsystem repository, so that the
> commit walker can stop at a recent merge into the top-level from the
> subsystem repository.
> 
> There was a discussion about updating the commit walk exchange to bisect
> the history (skip and try a much older one to see if it is reachable, but
> to avoid overshooting, step back and see if a newer one is still common).
> It would be a lot more work and needs to be implemented as a new protocol
> capability, but I think it is the right way to go in the longer term.

I thought about this some more: it seems that nothing in
pack-protocol.txt dictates that client has to send have
lines in order. The whole logic would be on client side.

So a new capability will be there just in case we find a use for a
server-side optimization later on, we don't need the client to behave
differently in any way when this capability is enabled/disabled.
Right?

-- 
MST
