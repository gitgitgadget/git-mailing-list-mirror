From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Multi-head fetch proposal
Date: Thu, 29 Sep 2005 02:25:37 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0509290149540.19126@wgmdd8.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Thu Sep 29 02:25:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EKmF7-0007X3-MW
	for gcvg-git@gmane.org; Thu, 29 Sep 2005 02:25:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751248AbVI2AZk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Sep 2005 20:25:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751280AbVI2AZk
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Sep 2005 20:25:40 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:48091 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751248AbVI2AZj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Sep 2005 20:25:39 -0400
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP id 9B67D13D1FB
	for <git@vger.kernel.org>; Thu, 29 Sep 2005 02:25:38 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP id 7DC35B3CFC
	for <git@vger.kernel.org>; Thu, 29 Sep 2005 02:25:38 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP id 60C3E59CFD
	for <git@vger.kernel.org>; Thu, 29 Sep 2005 02:25:38 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP id 416CE13D1FB
	for <git@vger.kernel.org>; Thu, 29 Sep 2005 02:25:38 +0200 (CEST)
X-X-Sender: gene099@wgmdd8.biozentrum.uni-wuerzburg.de
To: Git Mailing List <git@vger.kernel.org>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9451>

Hi,

I reported a while ago that a fetch downloaded objects which were already 
in the repository. While that was true, it was not the whole truth: This 
only happened with multi-head fetch.

As far as I can tell, what happened was this:

- fetch-pack connected to the server
- it asked correctly for the remote refs
- it then opened a (local) pipe to git-rev-list
- it sent quite a few refs from that pipe over the wire
- on the other side, upload-pack marked these refs as "fetcher got those"
- since upload-pack has a limit on that list (only 16) it soon said STFU 
- it turned out that quite a few common refs were not yet marked
- so upload-pack would upload these

The reason is that git-rev-list would happily output parents of refs 
which were already acknowledged by upload-pack to be common refs.

I just sent out a patch which makes this irrelevant for the case that most 
or all of these heads are already fetched.

Now, to really solve the multi-head problem, which really is the problem 
"how to find the edges of the common commits", I propose the following:

For each remote ref known to be not in the local repository, find the 1st, 
2nd, 4th, 8th, ... parents. Send these to upload-pack to be marked. For 
each ack'ed ref (i.e. remote side also has it), do a binary search to find 
the edge (i.e. the youngest common ref) on that DAG branch.

(To ease the burden on the server side, one coul mark only the edges 
as stop gaps for upload-pack. However, it might make things too 
complicated.)

Of course, the trick is to do that asynchronously, so that the network 
bandwidth is used optimally. This means that not each ack'ed ref 
leads to a binary search, but only those refs where no descendant was 
ack'ed.

BTW this does not need any change of the protocol. In fact, it only needs 
a change to fetch-pack.

I'd also increase MAX_HAS in upload-pack.

Ciao,
Dscho
