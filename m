From: Kevin Bracey <kevin@bracey.fi>
Subject: Re: [PATCH v3 3/3] git-merge-one-file: revise merge error reporting
Date: Thu, 14 Mar 2013 08:27:33 +0200
Message-ID: <51416DD5.2030805@bracey.fi>
References: <1362601978-16911-1-git-send-email-kevin@bracey.fi> <1363137142-18606-1-git-send-email-kevin@bracey.fi> <1363137142-18606-3-git-send-email-kevin@bracey.fi> <7vehfj2neh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>,
	Ciaran Jessup <ciaranj@gmail.com>,
	Scott Chacon <schacon@gmail.com>,
	Alex Riesen <raa.lkml@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 14 07:28:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UG1e4-0003gs-84
	for gcvg-git-2@plane.gmane.org; Thu, 14 Mar 2013 07:28:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754083Ab3CNG1k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Mar 2013 02:27:40 -0400
Received: from 5.mo5.mail-out.ovh.net ([87.98.173.103]:51009 "EHLO
	mo5.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753699Ab3CNG1j (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Mar 2013 02:27:39 -0400
Received: from mail183.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo5.mail-out.ovh.net (Postfix) with SMTP id AB58DFF8E4E
	for <git@vger.kernel.org>; Thu, 14 Mar 2013 07:39:04 +0100 (CET)
Received: from b0.ovh.net (HELO queueout) (213.186.33.50)
	by b0.ovh.net with SMTP; 14 Mar 2013 08:27:36 +0200
Received: from 85-23-153-122.bb.dnainternet.fi (HELO ?192.168.1.10?) (kevin@bracey.fi@85.23.153.122)
  by ns0.ovh.net with SMTP; 14 Mar 2013 08:27:35 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.0; WOW64; rv:17.0) Gecko/20130215 Thunderbird/17.0.3
X-Ovh-Mailout: 178.32.228.5 (mo5.mail-out.ovh.net)
In-Reply-To: <7vehfj2neh.fsf@alter.siamese.dyndns.org>
X-Ovh-Tracer-Id: 7914794870528315608
X-Ovh-Remote: 85.23.153.122 (85-23-153-122.bb.dnainternet.fi)
X-Ovh-Local: 213.186.33.20 (ns0.ovh.net)
X-OVH-SPAMSTATE: OK
X-OVH-SPAMSCORE: -100
X-OVH-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeiuddrgeegucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-Spam-Check: DONE|U 0.506651/N
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeiuddrgeegucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218115>

On 13/03/2013 19:57, Junio C Hamano wrote:
> Kevin Bracey <kevin@bracey.fi> writes:
>
>> -		echo "Added $4 in both, but differently."
>> +		echo "ERROR: Added $4 in both, but differently."
>> +		ret=1
> The problem you identified may be worth fixing, but I do not think
> this change is correct.
>
> This message is at the same severity level as the message on the
> other arm of this case that says "Auto-merging $4".  In that other
> case arm, we are attempting a true three-way merge, and in this case
> arm, we are attempting a similar three-way merge using your "virtual
> base".
>
> Neither has found any error in this case arm yet.  The messages are
> both "informational", not an error.  I do not think you would want
> to set ret=1 until you see content conflict.

I disagree here. At the minute, it does set ret to 1 (but further down 
the code - bringing it up here next to the "ERROR" print clarifies 
that), and will report the merge as failed, conflict in the 3-way merge 
or not. Which I think is correct.

We have to stop for user inspection here. We do have a fake base; we 
can't trust the 3-way merge with it.

The virtual 3-way merge will take ABCDE and ABDE and produce ABCDE 
without conflict. That's flat wrong if the real base they failed to tell 
Git about was ABCDE.

Despite being useful, I'm still slightly uncomfortable that it can 
produce something without any conflict markers. The user really needs to 
look at properly.

(And one interesting related glitch, or at least thing that puzzled me 
when it happened. This is from memory, so may be slightly mistaken, but 
what seemed to happen was that if you have rerere enabled, then 
mergetool tends to say "nothing to merge", because it relies on "rerere 
remaining", which relies on conflict markers. I think you could still 
force a mergetool up by specifying the specific file though.)

Maybe the virtual base itself should be different. Maybe it should put a 
??????? marker in place of every unique line. So you get:

Left   ABCEFGH
Right XABCDEFJH  -> Merge result <|X>ABC<|D>EF<G|J>H
VBase ?ABC?EF??H

That actually feels like it may be the correct answer here. And it's 
effectively what P4Merge does in its "2-way" mode I failed to invoke. 
(At least for the result view).

Kevin
