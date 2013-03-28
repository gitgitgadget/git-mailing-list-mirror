From: =?ISO-8859-1?Q?Kenneth_=D6lwing?= <kenneth@olwing.se>
Subject: Collective wisdom about repos on NFS accessed by concurrent clients
 (== corruption!?)
Date: Thu, 28 Mar 2013 11:22:08 +0100
Message-ID: <515419D0.7030107@olwing.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Mar 28 11:31:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULA6z-0007F2-NY
	for gcvg-git-2@plane.gmane.org; Thu, 28 Mar 2013 11:31:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755407Ab3C1Kah (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Mar 2013 06:30:37 -0400
Received: from hotelroom5.mainloop.net ([192.121.13.73]:60637 "EHLO
	hotelroom5.mainloop.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755117Ab3C1Kag (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Mar 2013 06:30:36 -0400
X-Greylist: delayed 479 seconds by postgrey-1.27 at vger.kernel.org; Thu, 28 Mar 2013 06:30:36 EDT
X-No-Relay: not in my network
Received: from [IPv6:::1] (unknown [82.214.25.167])
	by hotelroom5.mainloop.net (Postfix) with ESMTPSA id B0488721E5
	for <git@vger.kernel.org>; Thu, 28 Mar 2013 11:22:33 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130307 Thunderbird/17.0.4
X-Antivirus: AVG for E-mail 2013.0.2904 [2641/6209]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219380>

Hi,

I'm hoping to hear some wisdom on the subject so I can decide if I'm 
chasing a pipe dream or if it should be expected to work and I just need 
to work out the kinks.

Finding things like this makes it sound possible:
   http://permalink.gmane.org/gmane.comp.version-control.git/122670
but then again, in threads like this:
   http://kerneltrap.org/mailarchive/git/2010/11/14/44799
opinions are that it's just not reliable to trust.

My experience so far is that I eventually get repo corruption when I 
stress it with concurrent read/write access from multiple hosts (beyond 
any sort of likely levels, but still). Maybe I'm doing something wrong, 
missing a configuration setting somewhere, put an unfair stress on the 
system, there's a bona fide bug - or, given the inherent difficulty in 
achieving perfect coherency between machines on what's visible on the 
mount, it's just impossible (?) to truly get it working under all 
situations.

My eventual usecase is to set up a bunch of (gitolite) hosts that all 
are effectively identical and all seeing the same storage and clients 
can then be directed to any of them to get served. For the purpose of 
this query I assume it can be boiled down to be the same as n users 
working on their own workstations and accessing a central repo on an NFS 
share they all have mounted, using regular file paths. Correct?

I have a number of load-generating test scripts (that from humble 
beginnings have grown to beasts), but basically, they fork a number of 
code pieces that proceed to hammer the repo with concurrent reading and 
writing. If necessary, the scripts can be started on different hosts, 
too. It's all about the central repo so clients will retry in various 
modes whenever they get an error, up to re-cloning and starting over. 
All in all, they can yield quite a load.

On a local filesystem everything seems to be holding up fine which is 
expected. In the scenario with concurrency on top of shared NFS storage 
however, the scripts eventually fails with various problems (when the 
timing finally finds a hole, I guess) - possible to clone but checkouts 
fails, errors about refs pointing wrong and errors where the original 
repo is actually corrupted and can't be cloned from. Depending on test 
strategy, I've also had everything going fine (ops looks fine in my 
logs), but afterwards the repo has lost a branch or two.

I've experimented with various NFS settings (e.g. turning off the 
attribute cache), but haven't reached a conclusion. I do suspect that it 
just is a fact of life with a remote filesystem to have coherency 
problems with high concurrency like this but I'd be happily proven wrong 
- I'm not an expert in either NFS or git.

So, any opionions either way would be valuable, e.g. 'it should work' or 
'it can never work 100%' is fine, as well as any suggestions. Obviously, 
the concurrency needed to make it probable to hit this seems so unlikely 
that maybe I just shouldn't worry...

I'd be happy to share scripts and whatever if someone would like to try 
it out themselves.

Thanks for your time,

ken1
