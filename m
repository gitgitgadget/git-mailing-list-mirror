From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [3/4] What's not in 1.5.2 (new topics)
Date: Thu, 17 May 2007 05:39:10 +0100
Message-ID: <200705170539.11402.andyparkins@gmail.com>
References: <11793556363795-git-send-email-junkio@cox.net> <11793556371774-git-send-email-junkio@cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 17 06:39:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HoXls-0003gc-Cl
	for gcvg-git@gmane.org; Thu, 17 May 2007 06:39:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754537AbXEQEjS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 May 2007 00:39:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755713AbXEQEjS
	(ORCPT <rfc822;git-outgoing>); Thu, 17 May 2007 00:39:18 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:22288 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752276AbXEQEjR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 May 2007 00:39:17 -0400
Received: by ug-out-1314.google.com with SMTP id 44so257706uga
        for <git@vger.kernel.org>; Wed, 16 May 2007 21:39:15 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=f7aF0cEO1BQfOEVWd9OlFPGxJP9q1SI92ypki2FKJG2uE7+H9XoZiQ4zO2+QpQ5Zamj9S+E/gqq2qGSp1lHPc7xZbmwVPQ8VvEuG1pTrrruUCDgXrlbjp8xI1eZS+6OcFVM+iZi13JIJyl6Vc97shYlhugS6KdEDNm7UhrnYLJ4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=jG1TC9p5hUQV396X2X8H+QXl8bTPlk9+8DBmuFjR+jvlBO4txWL+Bf+OtQ8XawJpN+TfmEMZuPcKkAnb8b6d2ncGEPiT7Jefbbkvb2tyXMCtwF+3nekNEphOZIotSPsjgyVtGn0Q5VgWQpgr/1ya4jSOFtzUudEj12W72f0jwXw=
Received: by 10.67.71.15 with SMTP id y15mr7157903ugk.1179376755511;
        Wed, 16 May 2007 21:39:15 -0700 (PDT)
Received: from grissom.local ( [84.201.153.164])
        by mx.google.com with ESMTP id w5sm485856mue.2007.05.16.21.39.13;
        Wed, 16 May 2007 21:39:14 -0700 (PDT)
User-Agent: KMail/1.9.6
In-Reply-To: <11793556371774-git-send-email-junkio@cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47498>

On Wednesday 2007, May 16, Junio C Hamano wrote:

>      (3) git-checkout finds there is .gitmodules file in the
>          tree (and the checked-out working file), which
>          describes these subprojects.  It looks at the config
>          and notices that it does not yet know about them
>          (obviously this is true, as this is the first checkout
>          after clone, but I am trying to outline how checkout
>          after a merge should work in the general case).
>
> 	 It determines where to fetch that subproject from,
> 	 perhaps it uses the default URL described in
> 	 .gitmodules file to, while asking the user for
> 	 confirmation and giving the user a chance to override
> 	 it.  And it records something in the config -- now that
> 	 project is known to this repository.

I've been thinking about this .gitmodules thing and have a concern.  
Aren't we falling into the svn:externals trap?

The svn:externals property is analagous to our .gitmodules file.  svn 
properties were basically just version controlled out-of-tree meta data 
(making them annoying to work with - in-tree is better).  

svn "submodule" support was done by writing something like

  subproject svn://host/blah/blah

In the svn:externals property attached to the directory that 
the "subproject" directory was in.  To translate:

  svn propset svn:externals "subproject svn://blah/blah/blah" .

  git clone git://blah/blah/blah subproject
  git add subproject

The hole that this sort of thing gets you in to is that the 
svn:externals property is version controlled.  Time passes since you 
added the external; in that time the URL becomes invalid.  No problem, 
you simply change the svn:externals property.  KABOOM.  Now any 
historical checkout fails because it checks out the svn:externals 
property from that checkout and tries to use the wrong URL.

Our in-tree .gitmodules will have the same problem.  I recognise that 
you've mitigated that with some "confirm with the user, store in the 
config" hand waving; but that is just hiding the problem: the submodule 
URL is not something that should be version controlled; it is an 
all-of-history property; when it changes for revision N it changes for 
revision N-1, N-2, N-3, etc.  Storing it in .gitmodules implies that 
it's value in the past has meaning - it doesn't.

You mentioned yourself that that problem is not confined to the temporal 
accuracy of .gitmodules, there is spatial accuracy too - there is no 
guarantee that user A wants to use the same submodule URL as user B.  
Fast forward to when we've got submodule support; let's say you start 
using it for git-gui (for example).  Somehow (let's leave the "how" 
till later) I've gotten a working git tree with a git-gui checked out.  
I go to my laptop and clone that repository (note: NOT the upstream 
repository).  When git-clone hits the git-gui submodule it should not 
go looking for the upstream git-gui, I will want it to clone my local 
git-gui submodule.  i.e. in-tree .gitmodules URL for git-gui will be 
wrong.

I hope the above shows that in-tree .gitmodules is wrong; it can only 
ever be a hint, and in a great number of cases it will be an incorrect 
hint.

I know it's so enticing to store it in-tree; it would be great because 
the normal repository object transfer mechanism would get the URL of 
the submodule to the receiver with no changes to current 
infrastructure.  I say: tough luck - we need another mechanism.  The 
submodule URL is a per-repository setting, not a per-project setting.  
When fetching, some out-of-band mechanism for telling the other side 
what URL _this_ repository thinks the submodule is at needs to be 
supplied.  I don't know what space there is in the git protocol for 
putting that information, but I suspect that that is where it needs to 
go.

As an alternative to that, the supermodule could be given the ability to 
proxy for the submodule during clone.  It knows where the submodule is 
stored from it's point of view; is there scope for doing a 
virtual-server-like system were the supermodule git-daemon just changes 
to the submodule repository (in the case it is local) and thereby gives 
the downstream git access to the submodule without it even needing a 
URL.

>  * Perhaps add 'tree' entries in the index.  This may make the
>    current cache-tree extension unnecessary, and I suspect it
>    will simplify various paths that deal with D/F conflicts in
>    the current codebase.
>
>    I suspect this might need 1.6, as it is a one-way backward
>    incompatible change for the 'index', but 'index' is local so
>    it might not be such a big deal.  In the worst case, when the
>    users find "git checkout" from 1.5.2 does not work in a
>    repository checked out with such an updated index format, we
>    could ask them to "rm -f .git/index && git checkout HEAD".

I don't think even that would be necessary.  Assuming that the new index 
format is a superset of the old index format the only way that tree 
entries would get in the index would be by using git-1.6.  Almost by 
definition then, if they are in there your git is up-to-date enough to 
use them.  (modulo me not really understanding what you mean)



Andy

-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
