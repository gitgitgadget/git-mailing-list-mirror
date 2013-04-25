From: Kevin Bracey <kevin@bracey.fi>
Subject: Re: [RFC/PATCH] Make --full-history consider more merges
Date: Thu, 25 Apr 2013 18:48:47 +0300
Message-ID: <5179505F.2000108@bracey.fi>
References: <7v4nfcj2kq.fsf@alter.siamese.dyndns.org> <1366658602-12254-1-git-send-email-kevin@bracey.fi> <7vzjwqny64.fsf@alter.siamese.dyndns.org> <5176B854.2000707@bracey.fi> <7va9ona77d.fsf@alter.siamese.dyndns.org> <7v61zb8j5d.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 25 18:24:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVOy0-0007Lm-De
	for gcvg-git-2@plane.gmane.org; Thu, 25 Apr 2013 18:24:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758894Ab3DYQYM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Apr 2013 12:24:12 -0400
Received: from 17.mo1.mail-out.ovh.net ([87.98.179.142]:36984 "EHLO
	mo1.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757968Ab3DYQYL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Apr 2013 12:24:11 -0400
Received: from mail425.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo1.mail-out.ovh.net (Postfix) with SMTP id 4079CFF98E6
	for <git@vger.kernel.org>; Thu, 25 Apr 2013 17:48:58 +0200 (CEST)
Received: from b0.ovh.net (HELO queueout) (213.186.33.50)
	by b0.ovh.net with SMTP; 25 Apr 2013 17:49:15 +0200
Received: from 85-23-153-122.bb.dnainternet.fi (HELO ?192.168.1.10?) (kevin@bracey.fi@85.23.153.122)
  by ns0.ovh.net with SMTP; 25 Apr 2013 17:49:14 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.0; WOW64; rv:17.0) Gecko/20130215 Thunderbird/17.0.3
X-Ovh-Mailout: 178.32.228.1 (mo1.mail-out.ovh.net)
In-Reply-To: <7v61zb8j5d.fsf@alter.siamese.dyndns.org>
X-Ovh-Tracer-Id: 5798947470878609624
X-Ovh-Remote: 85.23.153.122 (85-23-153-122.bb.dnainternet.fi)
X-Ovh-Local: 213.186.33.20 (ns0.ovh.net)
X-OVH-SPAMSTATE: OK
X-OVH-SPAMSCORE: 0
X-OVH-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeifedrgeegucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecu
X-Spam-Check: DONE|U 0.5/N
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeifedrgeegucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecu
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222390>

On 25/04/2013 04:59, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>>> So, given all that, revised patch below:
> I tried to squeeze the minimum test I sent $gmane/220919 to the test
> suite.  I think the "do not use --parents option for this test"
> switch needs to be cleaned up a bit more, but it fails without your
> patch and does pass with your patch.
>
> I somehow was hoping that your fix to TREESAME semantics would also
> correct the known breakage documented in that test, but it seems
> that I was too greedy ;-)
Thanks for the test addition. Maybe we will be able to satisfy your 
greed in this series. There could be more worth doing here, and I think 
getting TREESAME precise is key.

I think I do want to take the step of storing "treesame per parent". And 
once we do that, as well as avoiding the expensive re-diff, we have much 
richer information readily available as a simplification input (and output).

I'm working on a patch that does this - filling in an initial treesame[] 
array as a decoration in try_to_simplify_commit() is easy, and 
maintaining the array through later parent rewrites isn't as onerous as 
I feared - there are only a few places that rewrite parents after the 
initial scan. With a couple of helper functions to do things like 
"delete nth", I think it'll be quite tidy.

I believe that simplify_merges itself needs at least one addition, and 
could use the treesame[] array to do it: if after doing reduce_heads, a 
commit is now different to all remaining parents, but there was a 
TREESAME parent eliminated, that parent should be reinstated. That would 
clearly highlight missed merges, showing both that "older" TREESAME 
parent and the newer !TREESAME parent that would have been taken in a 
normal merge.

And maybe there's more simplify_merges could do, if it had this full 
TREESAME information available.

(But even after you do all this stuff to get the right commits out, we 
then hit a niggle of mine that gitk forces --cc diffs - even if it shows 
shows the offending merge commit, you can't get it to do a diff...)

Kevin
