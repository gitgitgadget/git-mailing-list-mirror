From: Andreas Ericsson <ae@op5.se>
Subject: Re: Wine + GIT
Date: Wed, 07 Dec 2005 00:27:55 +0100
Message-ID: <43961E7B.3000607@op5.se>
References: <4394CD68.8020500@codeweavers.com> <4394F50E.7030803@pobox.com> <20051206230844.GA3876@reactrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Dec 07 00:30:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EjmE9-0000I0-9s
	for gcvg-git@gmane.org; Wed, 07 Dec 2005 00:28:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030292AbVLFX2A (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Dec 2005 18:28:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030293AbVLFX2A
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Dec 2005 18:28:00 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:42973 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1030292AbVLFX17
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 6 Dec 2005 18:27:59 -0500
Received: from [192.168.1.19] (1-2-9-7a.gkp.gbg.bostream.se [82.182.116.44])
	by smtp-gw1.op5.se (Postfix) with ESMTP id 311216BCBE
	for <git@vger.kernel.org>; Wed,  7 Dec 2005 00:27:56 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
In-Reply-To: <20051206230844.GA3876@reactrix.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13303>

Nick Hengeveld wrote:
> On Mon, Dec 05, 2005 at 09:18:54PM -0500, Jeff Garzik wrote:
> 
> 
>>One other comment:  http:// is the slowest of all three transports. 
>>git:// (git daemon) is preferred, followed by rsync.
>>
>>http:// takes forever, comparatively.
> 
> 
> Has that been the general git user experience?


It certainly is for me, and I know most of my colleagues think so too.


>  While there are
> certainly disadvantages to the http transport, I didn't think that
> performance was one of them.
> 
> For comparison, I ran some clones this morning/afternoon with the
> following results:
> 

When you clone you need to get all the objects. If the objects aren't 
packed on the remote end (which is usually the case), the git protocol 
will pack them for you which takes quite some time for a large repo and 
puts the server under considerable stress.

When you pull incrementally the native git protocol does some figuring 
out of the minimum set of packs it needs to send you.

> 
> Clone of kernel.org/pub/scm/git/git.git
> 
> http
> real    0m24.204s       real    0m25.750s       real    0m24.094s
> user    0m5.870s        user    0m5.530s        user    0m5.350s
> sys     0m0.660s        sys     0m0.710s        sys     0m0.600s
> 
> rsync
> real    1m3.952s        real    1m3.417s        real    1m4.360s
> user    0m0.090s        user    0m0.130s        user    0m0.120s
> sys     0m0.210s        sys     0m0.230s        sys     0m0.210s
> 
> git
> real    0m54.715s       real    0m55.928s       real    0m56.411s
> user    0m0.980s        user    0m0.980s        user    0m1.040s
> sys     0m0.220s        sys     0m0.140s        sys     0m0.160s
> 


In general, rsync:// should be the fastest protocol to clone over. Why 
you got the numbers listed above I have no idea, but I'm guessing the 
rsync daemon was under quite a bit of stress. http could in that case be 
faster since apache handles multiple clients better than rsync, but only 
if you're on a very fast line with low round trip time to the server as 
it needs to do a lot of downloading and checking to see where it's at 
and what it needs.

You may also want to take notice of the fact that the git-daemon can use 
cached pack-files, in which case it doesn't have to do so much manual 
packing. If cache-files are present, the git protocol *should* be the 
fastest to clone over as well.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
