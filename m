From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [3/4] What's not in 1.5.2 (new topics)
Date: Fri, 18 May 2007 14:00:07 +0200
Organization: At home
Message-ID: <f2k4g6$879$2@sea.gmane.org>
References: <200705170539.11402.andyparkins@gmail.com> <7v4pmcauu3.fsf@assigned-by-dhcp.cox.net> <20070517215841.GB29259@mellanox.co.il> <200705180141.06862.Josef.Weidendorfer@gmx.de> <464CF435.1010405@midwinter.com> <20070518045025.GT4489@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 18 14:05:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hp1Cq-0001sp-W3
	for gcvg-git@gmane.org; Fri, 18 May 2007 14:05:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754426AbXERMFG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 May 2007 08:05:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754545AbXERMFG
	(ORCPT <rfc822;git-outgoing>); Fri, 18 May 2007 08:05:06 -0400
Received: from main.gmane.org ([80.91.229.2]:53096 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754426AbXERMFF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 May 2007 08:05:05 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1Hp1Cg-0001Pc-7H
	for git@vger.kernel.org; Fri, 18 May 2007 14:05:02 +0200
Received: from host-89-229-25-173.torun.mm.pl ([89.229.25.173])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 18 May 2007 14:05:02 +0200
Received: from jnareb by host-89-229-25-173.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 18 May 2007 14:05:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-89-229-25-173.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47598>

[Cc: Petr Baudis <pasky@suse.cz>, Josef Weidendorfer
<Josef.Weidendorfer@gmx.de>, "Michael S. Tsirkin" <mst@dev.mellanox.co.il>,
Junio C Hamano <junkio@cox.net>, Andy Parkins <andyparkins@gmail.com>,
Nicolas Pitre <nico@cam.org>, git@vger.kernel.org]

Petr Baudis wrote:
> On Fri, May 18, 2007 at 02:32:53AM CEST, Steven Grimm wrote:

>> For example -- and yes, this is partially a rehash of other people's 
>> ideas -- instead of mapping a subproject path directly to revision@URL, 
>> instead map it to revision@symbolic name. The symbolic name is then 
>> separately mapped to a URL, and it's that symbolic name that can be 
>> locally overridden. The mappings of symbolic names to URLs is 
>> unversioned; the mapping of subprojects to revision@symbolic is 
>> versioned. Local overrides happen at the symbolic->URL mapping.
>> 
>> So you'd have something like
>> 
>> version 1: kernel-src/ -> kernel24
>> version 2: kernel-src/ -> kernel26
>> unversioned:
>>    kernel24 -> git://whatever/2.4
>>    kernel26 -> git://whatever/2.6
>> 
>> And then locally, the override is:
>> 
>>    kernel24 -> git://myhost/2.4
> 
> Yes, this would be nice; in one of my first mails in this thread I
> devoted a non-trivially large writeup to this, then proceeded to remove
> it since this has a serious problem.
> 
> Actually, Git already has a nice mechanism to handle these unversionaed
> pointers - tags. Just make refs/tags/subproject/kernel24 containing the
> URL to fetch. It's even easily overridable locally (and not easily
> overridable remotely...).
> 
> The problem is ugly too, though - suddenly, you have created a SINGLE
> UNIVERSE-WIDE NAMESPACE INSIDE A DISTRIBUTED VCS. And that's not going
> to work well. I think I don't have to elaborate too much - the
> aforementioned FreeBSD people will have different ideas about kernels
> than you, _you_ will have different idea about kernels in few tens of
> years than now, then if you need to merge or probably even fetch, you
> will get into big trouble.
> 
> Notice that we don't have any such namespace right now (except the
> D(SHA1) namespace, which is however possible only because it's so huge
> _and_ the names are assigned automagically in a way that virtually
> guarantees uniqueness across the whole universe) - tags come closest,
> but there is nothing that fundamentally breaks when a clash happens
> inside the namespace - it's just UI thing. But subproject names are
> etched to the history - once you name it, you just can't get rid of it
> forever.

There is a bit ugly solution for this: instead of using symbolic name
in versioned .gitmodules for a subproject (for a repo), use subproject
identifier (inode), and put it in the tag object (or config) together with
the URL.  Git would then search all the subproject / submodule info for
a given inode.  You could have more than one inode / identifier name for
a subproject repo; this would avoid the "independently created" issue
with using inodes / file-ids in distributed SCM.  One would have to
ensure however that different subprojects get assigned different inodes.

This is yet another level of indirection, and needs searching all the
subprojects info; but I don't think that there would be that many
subprojects used.


Besides we make use of one such global namespace: version tags (although
they _could_ have different names, e.g. v0.6.0 and gitgui-0.6.0).

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
