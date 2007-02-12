From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: [RFC] Speeding up a null fetch
Date: Mon, 12 Feb 2007 00:18:29 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0702120014510.5695@beast.quantumfyre.co.uk>
References: <200702112332.14698.julian@quantumfyre.co.uk>
 <20070211235218.GH31488@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Feb 12 01:18:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGOtu-0006hU-Hp
	for gcvg-git@gmane.org; Mon, 12 Feb 2007 01:18:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750968AbXBLASb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Feb 2007 19:18:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750987AbXBLASb
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Feb 2007 19:18:31 -0500
Received: from neutron.datavampyre.co.uk ([212.159.54.235]:58875 "EHLO
	neutron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750968AbXBLASb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Feb 2007 19:18:31 -0500
Received: (qmail 28360 invoked by uid 103); 12 Feb 2007 00:18:29 +0000
Received: from 192.168.0.7 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (clamdscan: 0.88.7/2551. spamassassin: 3.1.3. perlscan: 1.25st.  
 Clear:RC:1(192.168.0.7):. 
 Processed in 0.032669 secs); 12 Feb 2007 00:18:29 -0000
Received: from unknown (HELO beast.quantumfyre.co.uk) (192.168.0.7)
  by neutron.datavampyre.co.uk with SMTP; 12 Feb 2007 00:18:29 +0000
X-X-Sender: jp3@beast.quantumfyre.co.uk
In-Reply-To: <20070211235218.GH31488@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39344>

On Sun, 11 Feb 2007, Shawn O. Pearce wrote:

> Julian Phillips <julian@quantumfyre.co.uk> wrote:
>> Investigation showed that the main culprit seemed to be show-ref
>> having to build a sorted list of all refs for every ref that was being
>> checked.  So I used the patch below to reduce this to a single call to
>> show-ref (unless the ref had been updated).  With this patch the fetch
>> timed dropped to just under 1m - obviously quite a lot faster (better
>> than I expected in fact).
>
> Have a look at the `pu` branch in git.git.  Junio has done some
> work in this area to handle 1000 refs better:
>
>  ...
>  commit 58fef67cb067b6dee8f94b7b0e0c1a2d324e3505
>  Author: Junio C Hamano <junkio@cox.net>
>  Date:   Tue Jan 16 02:31:36 2007 -0800
>
>    git-fetch: rewrite another shell loop in C
>
>    Move another shell loop that canonicalizes the list of refs for
>    underlying git-fetch-pack and fetch-native-store into C.
>
>    This seems to shave the runtime for the same 1000 branch
>    repository from 30 seconds down to 15 seconds (it used to be 2
>    and half minutes with the original version).
>
>    Signed-off-by: Junio C Hamano <junkio@cox.net>
>
>  commit 3fc3729cd08e9d40dad54ccdd4db53900eca197b
>  Author: Junio C Hamano <junkio@cox.net>
>  Date:   Tue Jan 16 01:53:29 2007 -0800
>
>    git-fetch: move more code into C.
>
>    This adds "native-store" subcommand to git-fetch--tool to
>    move a huge loop implemented in shell into C.  This shaves about
>    70% of the runtime to fetch and update 1000 tracking branches
>    with a single fetch.
>
>    Signed-off-by: Junio C Hamano <junkio@cox.net>
>  ...
>

I shall have to see how this work fares with ~9000 refs ... but it 
certainly sounds good.

>> However, this seems more band-aid than fix, and I wondered if someone
>> more familiar with the git internals could point me in the right
>> direction for a better fix, e.g. should I look at rewriting fetch in C?
>
> Rewriting fetch in C is a lot of work, not just in developing it,
> but in testing that all existing functionality is preserved and no
> new bugs are introduced.  Rewriting some of the performance critical
> parts perhaps makes sense.

Indeed - this is why I asked rather than just diving in.

> Rewriting them in Python doesn't, as
> we no longer have any Python dependency, and would like to keep it
> that way (actuallly, some folks are also trying to remove the Perl
> dependency from some of our critical tools).

I only used python for speed of development, I was simply trying to verify 
my suspicions.  I certainly wouldn't expect a python script to get added 
(having seen all the python scripts get replaced).

-- 
Julian

  ---
There are no accidents whatsoever in the universe.
 		-- Baba Ram Dass
