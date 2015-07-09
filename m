From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH] fast-import: Do less work when given "from" matches
 current branch head
Date: Fri, 10 Jul 2015 07:30:18 +0900
Message-ID: <20150709223018.GA3403@glandium.org>
References: <20150709055227.GA32360@glandium.org>
 <1436424609-26159-1-git-send-email-mh@glandium.org>
 <xmqqk2u9uky9.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Shawn Pearce <spearce@spearce.org>,
	Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 10 00:30:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZDKKv-0001IP-3w
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jul 2015 00:30:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754319AbbGIWa3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jul 2015 18:30:29 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:55456 "EHLO
	glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754135AbbGIWa1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jul 2015 18:30:27 -0400
Received: from glandium by zenigata with local (Exim 4.86_RC4)
	(envelope-from <glandium@glandium.org>)
	id 1ZDKKg-0001BC-6F; Fri, 10 Jul 2015 07:30:18 +0900
Content-Disposition: inline
In-Reply-To: <xmqqk2u9uky9.fsf@gitster.dls.corp.google.com>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273782>

On Thu, Jul 09, 2015 at 01:37:02PM -0700, Junio C Hamano wrote:
> Mike Hommey <mh@glandium.org> writes:
> 
> Cc'ed a few people who appear at the top of "shortlog --no-merges";
> I think the end result is not incorrect, but I want to hear second
> opinions on this one.  I do not know Shawn still remembers this
> code, but what is under discussion seems to have come mostly from
> ea5e370a (fast-import: Support reusing 'from' and brown paper bag
> fix reset., 2007-02-12).
> 
> >  	if (!skip_prefix(command_buf.buf, "from ", &from))
> >  		return 0;
> >  
> > -	if (b->branch_tree.tree) {
> > -		release_tree_content_recursive(b->branch_tree.tree);
> > -		b->branch_tree.tree = NULL;
> > -	}
> > +	hashcpy(sha1, b->branch_tree.versions[1].sha1);
> >  
> >  	s = lookup_branch(from);
> >  	if (b == s)
> 
> The part that deals with a branch that is different from the current
> one is not visible in the context (i.e. when s = lookup_branch(from)
> returned a non-NULL result that is different from b) but it used to,
> and continues to with this patch, copy sha1 from branch_tree.sha1
> and branch_tree.versions[] from sha1 and branch_tree.versions[1] of
> the specified branch.
> 
> That codepath used to release the contents of branch_tree.tree when
> it did so, but it no longer does so after this patch because of the
> removal we see above.
> 
> Does that mean the original code was doing a release that was
> unnecessary?  Or does it mean this patch changes what happens on
> that codepath, namely (1) leaking resource, and/or (2) keeping a
> tree of the original 'b' that does not have anything to do with the
> tree of 's', preventing the later lazy-load code from reading the
> tree of 's' and instead of building on top of a wrong tree content?

I guess the question is whether branch_tree.tree can be in a state that
doesn't match that of branch_tree.versions[1].sha1. If not, then if s
and b have the same branch_tree.versions[1].sha1 for some reason, then
keeping the old branch_tree.tree makes no practical difference from
resetting it. Except it skips the busy-work.

Mike
