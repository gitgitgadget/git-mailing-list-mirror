From: Andreas Ericsson <ae@op5.se>
Subject: Re: Mercurial on BigTable
Date: Thu, 11 Jun 2009 04:02:45 +0200
Message-ID: <4A3065C5.3070203@op5.se>
References: <d411cc4a0906101215t313b2037k713aa1ce974c30cc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git list <git@vger.kernel.org>
To: Scott Chacon <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 11 04:03:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MEZd4-00061Y-GS
	for gcvg-git-2@gmane.org; Thu, 11 Jun 2009 04:02:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755944AbZFKCCs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jun 2009 22:02:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754949AbZFKCCr
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Jun 2009 22:02:47 -0400
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:47246 "HELO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754873AbZFKCCr (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Jun 2009 22:02:47 -0400
Received: from source ([209.85.220.207]) by na3sys009aob110.postini.com ([74.125.148.12]) with SMTP
	ID DSNKSjBlx+kZnaYxJzH1w3acQxT4+UVRAdrD@postini.com; Wed, 10 Jun 2009 19:02:50 PDT
Received: by fxm3 with SMTP id 3so1279821fxm.28
        for <git@vger.kernel.org>; Wed, 10 Jun 2009 19:02:47 -0700 (PDT)
Received: by 10.86.31.18 with SMTP id e18mr1720124fge.72.1244685767088;
        Wed, 10 Jun 2009 19:02:47 -0700 (PDT)
Received: from clix.int.op5.se ([212.112.163.94])
        by mx.google.com with ESMTPS id 4sm4939651fgg.18.2009.06.10.19.02.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 10 Jun 2009 19:02:46 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
In-Reply-To: <d411cc4a0906101215t313b2037k713aa1ce974c30cc@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121324>

Scott Chacon wrote:
> Has anyone watched this yet?
> 
> http://code.google.com/events/io/sessions/MercurialBigTable.html
> 
> It's kind of interesting - a Googler talks about getting Mercurial
> running on BigTable.  What fascinates me is that if I'm not horribly
> mistaken, it seems like they just threw out the revlog format entirely
> and just store the data in a key-value store as sort of a Git-like
> content addressable filesystem.

It does indeed seem like that, yes. Would have been fun to be there to
congratulate him on implementing something that's already existed for
about three years ;-)

>  I had thought they were taking
> advantage of the revlog structure somehow, but it appears like they
> basically just changed the underlying data format to be much more like
> Git and rewrote ah Hg speaking server on top of that.  They even
> explicitly store the head values like refs instead of reading
> childless nodes out of the revlog, which is what I thought Hg did.
> 

Well, storing the head values as refs is the only thing that makes
sense if you're using a database to track things, since you'd otherwise
have to map in too much data to get any sort of performance at all
out of it.

> Does anyone know how they do the graph walking efficiently with this
> structure?  He mentioned it was about half as fast as native Hg, but
> that seemed to be acceptable.

Yes, so they don't. DAG walking means they have to look up several
changesets in a linear fashion, but if they don't know the order
up front they'll have to suffer the penalty of actually fetching
each commit from the bigtable database over the network. It would
be similar to storing git objects in a database on a different
host, which would also be quite a lot slower than just hitting an
mmap()'ed file in binary form.

>  Curious if anyone had any thoughts or
> information on this.  Shawn, are there technical reasons why this
> works well the way they're doing it for Hg but would not for Git (like
> in the repo MINA based server)?  It looks like the data structure and
> protocol exchange are incredibly similar after they threw away all the
> revlog stuff.  Or is it just that they're fine with the speed loss and
> the Android project would not be?
> 

I'm more curious as to why they didn't choose git. The only explanation
that was actually true is that hg works well over HTTP (if you can call
3 network requests per not-up-to-date head "well"). Since I can't imagine
them not doing proper research before launching a project that almost
certainly cost quite a lot of money, and I personally think that the
"http rules all" explanation sounded weak, I'm guessing there were other
reasons as to why they didn't go with git instead, and I'm fairly curious
to hear them. If I was to take a guess, I'd say git is written in a pretty
unfriendly way for implementing other storage engines.

Ah well. In a year or two they'll probably support git as well. One can
hope at least ;-)

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
