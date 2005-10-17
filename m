From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [kernel.org users] Re: auto-packing on kernel.org? please?
Date: Mon, 17 Oct 2005 15:13:21 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0510171348370.23242@iabervon.org>
References: <Pine.LNX.4.64.0510131113490.15297@g5.osdl.org> <434EABFD.5070604@zytor.com>
 <434EC07C.30505@pobox.com> <Pine.LNX.4.64.0510131422161.23590@g5.osdl.org>
 <435264B1.2010204@de.bosch.com> <Pine.LNX.4.63.0510161122570.23242@iabervon.org>
 <20051016161244.GE5509@reactrix.com> <43527E86.8000907@didntduck.org>
 <7vzmp9xuwe.fsf@assigned-by-dhcp.cox.net> <20051016213341.GF5509@reactrix.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 17 21:10:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ERaLN-00046c-OD
	for gcvg-git@gmane.org; Mon, 17 Oct 2005 21:08:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932267AbVJQTIS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 17 Oct 2005 15:08:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932277AbVJQTIR
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Oct 2005 15:08:17 -0400
Received: from iabervon.org ([66.92.72.58]:6666 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S932267AbVJQTIR (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Oct 2005 15:08:17 -0400
Received: (qmail 17013 invoked by uid 1000); 17 Oct 2005 15:13:21 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 17 Oct 2005 15:13:21 -0400
To: Nick Hengeveld <nickh@reactrix.com>
In-Reply-To: <20051016213341.GF5509@reactrix.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10190>

On Sun, 16 Oct 2005, Nick Hengeveld wrote:

> On Sun, Oct 16, 2005 at 09:56:49AM -0700, Junio C Hamano wrote:
> 
> > That's what the .idx file is for, except that after you fetch
> > the range, you may find you would need something else that the
> > object is delta against.
> 
> Would it make sense to load the pack indexes for each base up front,
> and then fetch individual objects from a pack if they exist in one of
> a base's pack indexes?  In such a case, it may not even make sense to
> try fetching the object directly first.

At the start, you have the option of either fetching the list of packs or 
the object. There are three cases:

 1) the object isn't available separately; we need to fetch the list of 
    packs to find it in a pack.
 2) there aren't any new packs; we need to fetch the object individually.
 3) the object is present both individually and in a pack.

(2) is more common than (1), because we don't repack every update. (3) 
doesn't happen at all, currently, because we prune after packing. So it 
makes most sense to try the object at once.

On the other hand, the parallel code should probably do both at the same 
time, since it can, and it only causes notable latency, not bandwidth. We 
probably also ought to speculatively get any new index files in parallel 
with whatever else we're doing, since it is likely that we'll need some 
pack at some point, and then we'll need all the index files to decide what 
pack to get.

> What are the circumstances under which it makes more sense to fetch the
> whole pack rather than fetching individual objects from it?

I'm not sure there's a good way of deciding without a plan for what 
conditions cause there to be a choice.

	-Daniel
*This .sig left intentionally blank*
