From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: Restraining git pull/fetch to the current branch
Date: Mon, 15 Jan 2007 13:06:55 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0701151253190.9916@reaper.quantumfyre.co.uk>
References: <Pine.LNX.4.64.0701112127000.12870@beast.quantumfyre.co.uk>
 <7vejq1yrt2.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0701121332100.1493@reaper.quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 15 19:34:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@m.gmane.org
Received: from main.gmane.org ([80.91.229.2] helo=ciao.gmane.org)
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6VVl-0000Oq-Kq
	for gcvg-git@m.gmane.org; Mon, 15 Jan 2007 18:20:45 +0100
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1H6VA7-0003eK-9O
	for gcvg-git@m.gmane.org; Mon, 15 Jan 2007 17:58:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932307AbXAONG6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 Jan 2007 08:06:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932311AbXAONG6
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Jan 2007 08:06:58 -0500
Received: from neutron.datavampyre.co.uk ([212.159.54.235]:35207 "EHLO
	neutron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932307AbXAONG5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jan 2007 08:06:57 -0500
Received: (qmail 3056 invoked by uid 103); 15 Jan 2007 13:06:55 +0000
Received: from 192.168.0.16 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (clamdscan: 0.88.7/2441. spamassassin: 3.1.3. perlscan: 1.25st.  
 Clear:RC:1(192.168.0.16):. 
 Processed in 0.033603 secs); 15 Jan 2007 13:06:55 -0000
Received: from unknown (HELO reaper.quantumfyre.co.uk) (192.168.0.16)
  by neutron.datavampyre.co.uk with SMTP; 15 Jan 2007 13:06:55 +0000
X-X-Sender: jp3@reaper.quantumfyre.co.uk
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <Pine.LNX.4.64.0701121332100.1493@reaper.quantumfyre.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36843>

On Fri, 12 Jan 2007, Julian Phillips wrote:

>>  I suspect most of the time is being spent in the
>>  append-fetch-head loop in fetch_main shell function in
>>  git-fetch.sh The true fix would not be to limit the number of
>>  branches updated, but to speed that part of the code up.
>
> Indeed, each call to append_fetch_head is taking ~1.7s (~1.5s user, ~0.2s 
> sys).  So simply looping over all the branches explains the ~27m that a 
> complete fetch takes. (This is for fetch with no updates).  Given that a 
> "clone orig new" takes ~8m30 (half of which would seem to be IO), it looks 
> like it may be faster to create a new repository each time instead of 
> updating the old one, which is certainly a viable workaround - but might 
> imply that fetch has some room for improvement?

I have had a chance to spend a little more time looking at this.  It would 
appear that the major culprit is show-ref.

Running "git show-ref --hash <ref>" takes ~1.7s, compared to 0.002s for 
"cat $GIT_DIR/<ref>".  If I add the following to the top of 
append_fetch_head a null fetch takes 1m28s instead of ~27m.

local_head_=$(cat $GIT_DIR/$local_name_);
if [ "$head_" == "$local_head_" ]; then
 	return;
fi

Looking at the code for show-ref it appears to looks at all the refs to 
find the one you ask for.  This makes fetch O(n^2) in no of branches, 
which would seem not strictly necessary - but then I am not really 
familiar with the internal working of git.  I noticed that the man page 
for show-ref says that its use over direct access is encouraged, but as it 
stands it is far too slow to be used in fetch when you have a large 
many-branched repository...

(In looking at this I also discovered that if you have too many branches 
then fetch will die with a too long command line error when calling 
git-fetch-pack.)

-- 
Julian

  ---
I will never lie to you.
