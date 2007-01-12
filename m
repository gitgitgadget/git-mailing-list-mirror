From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: Restraining git pull/fetch to the current branch
Date: Fri, 12 Jan 2007 14:08:28 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0701121332100.1493@reaper.quantumfyre.co.uk>
References: <Pine.LNX.4.64.0701112127000.12870@beast.quantumfyre.co.uk>
 <7vejq1yrt2.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 12 15:08:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H5N58-0006SA-51
	for gcvg-git@gmane.org; Fri, 12 Jan 2007 15:08:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750918AbXALOIb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 12 Jan 2007 09:08:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750924AbXALOIb
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Jan 2007 09:08:31 -0500
Received: from neutron.datavampyre.co.uk ([212.159.54.235]:36772 "EHLO
	neutron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750918AbXALOIa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jan 2007 09:08:30 -0500
Received: (qmail 27208 invoked by uid 103); 12 Jan 2007 14:09:09 +0000
Received: from 192.168.0.16 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (clamdscan: 0.88.7/2437. spamassassin: 3.1.3. perlscan: 1.25st.  
 Clear:RC:1(192.168.0.16):. 
 Processed in 0.032454 secs); 12 Jan 2007 14:09:09 -0000
Received: from unknown (HELO reaper.quantumfyre.co.uk) (192.168.0.16)
  by neutron.datavampyre.co.uk with SMTP; 12 Jan 2007 14:09:09 +0000
X-X-Sender: jp3@reaper.quantumfyre.co.uk
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vejq1yrt2.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36672>

On Thu, 11 Jan 2007, Junio C Hamano wrote:

> Julian Phillips <julian@quantumfyre.co.uk> writes:
>
>> While trying out git on a large repository (10000s of commits, 1000s
>> of branches, ~2.5Gb when packed) at work I noticed that doing a pull
>> was taking a long time (longer than I was prepared to wait anyway).
>
> Are they all real branches?  In other words, does your project
> have 1000s of active parallel development?

(Oops, over enthusiastic with the 0 there, I mean 100s of branches, about 
880 atm).

They are mostly topic style branches, with only 20 or so in active use at 
any one time.  The idea of having to cope with 100s of active branches at 
the same time (given that we currently are using subversion) is quite 
frankly terrifying.

> Also, assuming the answer to the above question is yes, will you
> have 1000s of branches on your end and will work on any one of
> them?

It would be necessary to have access to all of the currently active 
branches at least, with the added complication that the set of current 
active branches changes quite rapidly.

> If you do not care all 1000s branches but only are interested in
> selected few, you could change that configuration to suit your
> needs better.

I think the problem here would be keeping track of which branches are 
currently active.  Some scheme could probably be derived, but I was hoping 
that fetching an unchanged branch would be sufficently fast that it would 
be necessary.  I appear to have been wrong :(

> I suspect most of the time is being spent in the
> append-fetch-head loop in fetch_main shell function in
> git-fetch.sh The true fix would not be to limit the number of
> branches updated, but to speed that part of the code up.

Indeed, each call to append_fetch_head is taking ~1.7s (~1.5s user, ~0.2s 
sys).  So simply looping over all the branches explains the ~27m that a 
complete fetch takes. (This is for fetch with no updates).  Given that a 
"clone orig new" takes ~8m30 (half of which would seem to be IO), it looks 
like it may be faster to create a new repository each time instead of 
updating the old one, which is certainly a viable workaround - but might 
imply that fetch has some room for improvement?

-- 
Julian

  ---
There is nothing stranger in a strange land than the stranger who comes
to visit.
