From: Nicolas Pitre <nico@cam.org>
Subject: Re: Funny repack behaviour
Date: Sat, 08 Apr 2006 15:44:31 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0604081528070.2215@localhost.localdomain>
References: <Pine.LNX.4.63.0604081233170.3283@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 08 21:45:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FSJND-0002tq-N2
	for gcvg-git@gmane.org; Sat, 08 Apr 2006 21:45:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751416AbWDHToe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 8 Apr 2006 15:44:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751417AbWDHToe
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Apr 2006 15:44:34 -0400
Received: from relais.videotron.ca ([24.201.245.36]:50423 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1751416AbWDHToe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Apr 2006 15:44:34 -0400
Received: from xanadu.home ([74.56.105.38]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0IXF00K9H5I70WK0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Sat, 08 Apr 2006 15:44:31 -0400 (EDT)
In-reply-to: <Pine.LNX.4.63.0604081233170.3283@wbgn013.biozentrum.uni-wuerzburg.de>
X-X-Sender: nico@localhost.localdomain
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18522>

On Sat, 8 Apr 2006, Johannes Schindelin wrote:

> Hi,
> 
> I just accidentally reran "git-repack -a -d" on a repository, where I just 
> had run it. And I noticed a funny thing: Of about 4000 objects, it reused 
> all but 8. So I reran it, and it reused all but 2. I ran it once again, 
> and it reused all.
> 
> The really funny thing is: it created the same pack every time!

Probably not.  Subsequent packs were most probably even smaller !

> It is not critical, evidently, but I'd like to know what is causing this 
> rather undeterministic behaviour. (Before you ask: no, I did not make a 
> backup before running the tests, so I unfortunately cannot reproduce it).

To reproduce, or rather to reset the pack state, just use
"git-repack -a -f -d" then  "git-repack -a -d" multiple times again.

For example, on the current git archive:

$ git-repack -a -f -d
[...]
Total 16548, written 16548 (delta 11007), reused 5390 (delta 0)
Pack pack-af9d39abfcb5fd6fd554f7fc8d1704f8dd2329e0 created.

pack size = 6032083 bytes.

$ git-repack -a -d
[...]
Total 16548, written 16548 (delta 11030), reused 16525 (delta 11007)
Pack pack-af9d39abfcb5fd6fd554f7fc8d1704f8dd2329e0 created.

pack size = 5976610 bytes

$ git-repack -a -d
[...]
Total 16548, written 16548 (delta 11030), reused 16548 (delta 11030)
Pack pack-af9d39abfcb5fd6fd554f7fc8d1704f8dd2329e0 created.

Pack size =  5976610 bytes

So in this case it took 2 itterations before converging on a smaller 
pack by 55473 bytes.

I thought the reuse logic might sacrifice a bit on compression given the 
speed boost, but I don't get why it is the opposite in practice and that 
-f doesn't produce the smallest pack up front.


Nicolas
