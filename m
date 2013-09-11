From: Kevin Bracey <kevin@bracey.fi>
Subject: Re: breakage in revision traversal with pathspec
Date: Wed, 11 Sep 2013 20:49:23 +0300
Message-ID: <5230AD23.2050009@bracey.fi>
References: <xmqqy574y4pz.fsf@gitster.dls.corp.google.com> <522F8ED2.9000408@bracey.fi> <xmqq38pcwc21.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 11 19:49:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJoXp-0006PB-Mk
	for gcvg-git-2@plane.gmane.org; Wed, 11 Sep 2013 19:49:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756593Ab3IKRtd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Sep 2013 13:49:33 -0400
Received: from 1.mo2.mail-out.ovh.net ([46.105.63.121]:55529 "EHLO
	mo2.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756552Ab3IKRtb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Sep 2013 13:49:31 -0400
Received: from mail195.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo2.mail-out.ovh.net (Postfix) with SMTP id 0B758DC94B7
	for <git@vger.kernel.org>; Wed, 11 Sep 2013 19:49:28 +0200 (CEST)
Received: from b0.ovh.net (HELO queueout) (213.186.33.50)
	by b0.ovh.net with SMTP; 11 Sep 2013 19:56:00 +0200
Received: from 62-183-157-30.bb.dnainternet.fi (HELO ?192.168.1.10?) (kevin@bracey.fi@62.183.157.30)
  by ns0.ovh.net with SMTP; 11 Sep 2013 19:55:57 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.0; WOW64; rv:17.0) Gecko/20130215 Thunderbird/17.0.3
X-Ovh-Mailout: 178.32.228.2 (mo2.mail-out.ovh.net)
In-Reply-To: <xmqq38pcwc21.fsf@gitster.dls.corp.google.com>
X-Ovh-Tracer-Id: 12586716535077507288
X-Ovh-Remote: 62.183.157.30 (62-183-157-30.bb.dnainternet.fi)
X-Ovh-Local: 213.186.33.20 (ns0.ovh.net)
X-OVH-SPAMSTATE: OK
X-OVH-SPAMSCORE: 0
X-OVH-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeikedrledvucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecu
X-Spam-Check: DONE|U 0.500436/N
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeikedrledvucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecu
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234586>

On 11/09/2013 01:23, Junio C Hamano wrote:
> Kevin Bracey <kevin@bracey.fi> writes:
>
>> On 10/09/2013 20:19, Junio C Hamano wrote:
>>> This command
>>>
>>>       $ git log v1.8.3.1..v1.8.4 -- git-cvsserver.perl
>>>
>>> reports that a merge 766f0f8ef7 (which did not touch the specified
>>> path at all) touches it.
>>>
>>> Bisecting points at d0af663e (revision.c: Make --full-history
>>> consider more merges, 2013-05-16).
>>>
>> That merge appearing *with* --full-history would seem like correct
>> behaviour to me. Or at least it's what I intended.
> ... But it shouldn't
> appear if the user does not ask for "--full-history".

Well, there is a functioning semi-work-around for now: avoid difficult 
non-linear questions like "v1.8.3.1..v1.8.4". A question like 
"v1.8.3..v1.8.4" is a lot easier to visualise, and it does already omit 
the merge.

On reflection I'm not sure what we should for the "simple history" view 
of v1.8.3.1..v1.8.4. We're not rewriting parents, so we don't get a 
chance to reconsider the merge as being zero-parent, and we do have this 
little section of graph to traverse at the bottom:

           1.8.3
             o----x----x----x----x---x---     (x = included, o = 
excluded, *=!treesame)
                 /
                /*
   o--x--x--x--x

In effect, we do have a linear section of history to follow, and the 
file does change in the middle of that line. It may be quite hard to 
come up with a solid rule to hide the merge that doesn't go wrong 
somewhere else.

The current rules for this are

1) if identical to any on-graph parent, follow that one, and rewrite the 
merge as a non-merge. We currently do not follow to an identical 
off-graph parent. This long-standing comment in try_to_simplify_commit 
applies: "Even if a merge with an uninteresting side branch brought the 
entire change we are interested in, we do not want to lose the other 
branches of this merge, so we just keep going." For this query, the 
mainline link to 1.8.3 is the "uninteresting side branch"! If you do 
specify v1.8.3..v1.8.4, then v1.8.3 becomes "on-graph" thanks to other 
new rules, and this rule does kick in, hiding the merge.

2) If rule 1 doesn't activate, and it remains as a merge, hide it if 
treesame to all on-graph parents. Previously this rule was "hide if 
treesame to any parent", and so that would have hidden the merge.

Now, when I changed rule 2, I did not think this would affect the 
default log. See my commit message:

     "Now redefine a commit's TREESAME flag to be true only if a commit is
     TREESAME to _all_ of its [later: on-graph] parent. This doesn't 
affect ... the default
     simplify_history behaviour (because partially TREESAME merges are 
turned
     into normal commits)..."

Whoops - partially TREESAME merges are not always turned into normal 
commits.

Maybe the fix is to define TREESAME differently for simplify_history - 
to use the old definition of "identical to any parent" in that case. I'm 
not sure that's right though.

I currently feel instinctively more disposed to dropping the older 
"don't follow off-graph identical parents" rule. Let the default history 
go straight to v1.8.3 even though it goes off the graph, stopping us 
traversing the topic branch.

Kevin
