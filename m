From: Kevin Bracey <kevin@bracey.fi>
Subject: Re: [PATCH v3 10/9] revision.c: treat A...B merge bases as if manually
 specified
Date: Tue, 07 May 2013 18:52:13 +0300
Message-ID: <5189232D.4060305@bracey.fi>
References: <1367767977-14513-1-git-send-email-kevin@bracey.fi> <1367859096-25909-1-git-send-email-kevin@bracey.fi> <7vli7rpzt0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 07 17:52:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZkBi-0004dM-CC
	for gcvg-git-2@plane.gmane.org; Tue, 07 May 2013 17:52:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755014Ab3EGPwR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 May 2013 11:52:17 -0400
Received: from 18.mo4.mail-out.ovh.net ([188.165.54.143]:48303 "EHLO
	mo4.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752479Ab3EGPwR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 May 2013 11:52:17 -0400
Received: from mail628.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo4.mail-out.ovh.net (Postfix) with SMTP id AD636104EA4C
	for <git@vger.kernel.org>; Tue,  7 May 2013 17:52:15 +0200 (CEST)
Received: from b0.ovh.net (HELO queueout) (213.186.33.50)
	by b0.ovh.net with SMTP; 7 May 2013 17:52:18 +0200
Received: from 85-23-153-122.bb.dnainternet.fi (HELO ?192.168.1.10?) (kevin@bracey.fi@85.23.153.122)
  by ns0.ovh.net with SMTP; 7 May 2013 17:52:17 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.0; WOW64; rv:17.0) Gecko/20130215 Thunderbird/17.0.3
X-Ovh-Mailout: 178.32.228.4 (mo4.mail-out.ovh.net)
In-Reply-To: <7vli7rpzt0.fsf@alter.siamese.dyndns.org>
X-Ovh-Tracer-Id: 2535526590733324504
X-Ovh-Remote: 85.23.153.122 (85-23-153-122.bb.dnainternet.fi)
X-Ovh-Local: 213.186.33.20 (ns0.ovh.net)
X-OVH-SPAMSTATE: OK
X-OVH-SPAMSCORE: -100
X-OVH-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeifedrieejucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-Spam-Check: DONE|U 0.5/N
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeifedrieejucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223583>

On 07/05/2013 00:24, Junio C Hamano wrote:
> Kevin Bracey <kevin@bracey.fi> writes:
>
>> The documentation assures users that "A...B" is defined as 'r1 r2 --not
>> $(git merge-base --all r1 r2)'. This isn't in fact quite true, because
>> the calculated merge bases are not sent to add_rev_cmdline().
> We want the commands to be able to tell which ones in revs->pending
> and revs->commits were specified by the end user and how.  While I
> think it makes sense to mark these negative merge bases with "These
> came from the command line with A...B syntax", I am not sure if it
> is the best way to do so in add_pending_commit_list().
Layering violation? The callers of add_pending_commit_list() should be 
doing it themselves? Yes, I suppose it was a bit of a convenience hack, 
having add_pending_commit_list do it.
>
> By the way, why does this have anything to do with the history
> traversal series in the first place?

The answer's in the test, but it's not that clear in this series 
addendum, with the test newly appearing and passing. The next version of 
the series will have the test in initially as a failure.

Without this patch, "git log E...F file" will unnecessarily show D, as 
it has 2 differing non-priority parents B and C.

Whereas "git log E F ^B file" doesn't show D. So we have a behaviour 
difference between two allegedly equivalent commands.

When querying E...F, C is a side branch between the merge base B and F, 
so D should be removable, just as for "B..F" or "E F ^B". So we need to 
give B the BOTTOM marker to make that work, as if it had been specified 
"E F ^B".


>
> When there is anythning marked UNINTERESTING on the rev->pending
> before calling prepare_revision_walk(), you have a history with some
> bottom boundaries, and when there isn't, your bottom boundaries are
> root commits.  If you want to behave differently depending on how
> the user gave us the revision range from the command line, e.g.
> acting differently between "A ^B" and "B..A", cmdline is a good
> place to learn the exact form, but at the history traversal level, I
> do not think you should even care.  Why does the code even look at
> the cmdline, and not rev->pending?
>

Well, on this first pass I wanted to be sure I was using the same 
definition of "bottom" as ancestry-path, so I hacked the flag setting in 
there, and I believe the answer to "why not just look at UNINTERESTING" 
lies in commit 281eee4. If I understand that correctly, it goes wrong 
when you have multiple negative specifications - some initial walking is 
done, meaning we can't distinguish between specified bottoms and other 
walk results.

Now, the current structure of the code is clearly silly, and my "hack" 
comment acknowledged that - if we have the BOTTOM flag, we could just 
set that immediately during command parsing, and neither this nor 
ancestry-path would need to look back at the command line to identify 
what the bottom commits were. But I didn't want to start work on that 
without further discussion about the merits of the BOTTOM flag.

(Actually, no, I'm not looking back at the command line, I just know 
that ancestry-path does, so I make sure I arrange it so that my 
inspection of rev->pending shows the same bottom commits as its 
inspection of the command line).

Kevin
