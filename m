From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: newbie questions about git design and features (some wrt hg)
Date: Sat, 3 Feb 2007 21:55:15 +0100
Message-ID: <200702032155.16987.jnareb@gmail.com>
References: <3c6c07c20701300820l42cfc8dbsb80393fc1469f667@mail.gmail.com> <200702022056.32791.jnareb@gmail.com> <20070203200638.GA6888@xanadu.kublai.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Matt Mackall <mpm@selenic.com>, Junio C Hamano <junkio@cox.net>,
	mercurial@selenic.com, git@vger.kernel.org
To: Brendan Cully <brendan@kublai.com>
X-From: git-owner@vger.kernel.org Sat Feb 03 21:54:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDRtV-0003el-02
	for gcvg-git@gmane.org; Sat, 03 Feb 2007 21:53:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751638AbXBCUxz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Feb 2007 15:53:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751643AbXBCUxz
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Feb 2007 15:53:55 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:26080 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751635AbXBCUxy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Feb 2007 15:53:54 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1031113uga
        for <git@vger.kernel.org>; Sat, 03 Feb 2007 12:53:53 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=szgaYB6L6QLYZxrkkiNqw3Mudu7nx91q0gWc/ez7g6DdGv3K8bNFJfWzUhrHmJA2xHhDhzA0VOYcR4D5FlJP8bd2o2NOIfM76gXA3QPBZhaPb/jpybX/8vgiteMypxBafbGPtD8qVy0j1zXXcPlDTlqCIp3yy3lwck6ozCH6ve4=
Received: by 10.67.22.2 with SMTP id z2mr6422159ugi.1170536033010;
        Sat, 03 Feb 2007 12:53:53 -0800 (PST)
Received: from host-81-190-29-4.torun.mm.pl ( [81.190.29.4])
        by mx.google.com with ESMTP id l33sm6184623ugc.2007.02.03.12.53.52;
        Sat, 03 Feb 2007 12:53:52 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <20070203200638.GA6888@xanadu.kublai.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38599>

On 03.02.2007, Brendan Cully <brendan@kublai.com> wrote:
> On Friday, 02 February 2007 at 20:56, Jakub Narebski wrote:

>> For example you are on branch 'master', you tag current release
>> e.g. v1.3.4, then you checkout branch 'devel'... and you don't have
>> v1.3.4 tag available unless you merge in .hgtags from 'master'.
>> At least from what I understand of Mercurial tags behaviour.
> 
> This would be bad, if it were true.
> 
> $ hg up devel
> 2 files updated, 0 files merged, 0 files removed, 0 files unresolved
> $ cat .hgtags
> 6acda9aa5d8c621b3db2f2daab878d8de726d227 base
> $ hg tags
> tip                                4:b1f003583d8e
> v1.3.4                             2:87e43e86318f
> base                               0:6acda9aa5d8c

The above sequence of commands is not enough to reproduce the situation
I want to talk about, namely situation (repository structure) as in 
below:

                    /-\ 
   1---a---2---3---T---t---b   .... 'master' branch
        \ 
         \-2'--3'--c           .... 'devel' branch

where 'a' is branching point (merge base) of 'master' and 'devel' 
branches, 'T' is tagged changeset (revision, commit), 't' is commit
where .hgtags with 'T' tag was committed. Changesets (revisions)
'b' and 'c' are tips of 'master' and 'devel' branch, respectively.

If .hgtags was an ordinary file, then at revision marked in above
graph as '2' it wouldn't have tag 'T'.  Documentation (Mercurial
HOWTO to be more exact) tells that hg uses .hgtags version from the
tip.  But when we are at branch 'devel', the version from the tip
is version 'c' without 'T', not version 'b' with 'T'... if .hgtags
would behave as described in documentation.

It looks however (if what you say above is true also for the situation 
as in above graph, i.e. when at 'devel' branch we have 'T' in .hgtags)
that Mercurial always uses _latest_ version of .hgtags file (as in 
external wall time, having notihing to do with the history as 
represented in repository). But then we cannot say that we can merge
.hgtags file, so it is probably not the case. It is also contrary to 
what I gathered from documentation.

If above was true, i.e. .hgtags doesn't behave at all as normal file in 
working area, then what the heck it is doing there, and not somewhere 
under .hgtags!?!

> As mentioned before, hg has local tags which sound an awful lot like
> git tags. 

Git tags can be propagated. hg local tags cannot be propagated. hg tags 
"in history" always are propagated.

> It also has properly versioned tags.

Reusing in-tree version control to version tags is IMVHO not a good 
idea. Git has reflogs if you truly need to have history of tags.

> And, by the way, if you  
> push a branch, you only push the tags that were committed on that
> branch. Furthermore, you can push based on a tag name that isn't
> committed in the branch you're pushing. 

It seems awfully complicated.

> I think the "globally global" 
> nonsense elsewhere in this thread may be a result of not understanding
> this.
> 
> I'm probably done with this thread too. There's too much ignorant
> speculation to make it very productive.

-- 
Jakub Narebski
Poland
