From: Kevin Bracey <kevin@bracey.fi>
Subject: Re: breakage in revision traversal with pathspec
Date: Wed, 11 Sep 2013 00:27:46 +0300
Message-ID: <522F8ED2.9000408@bracey.fi>
References: <xmqqy574y4pz.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 11 00:44:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJWg0-0007rI-RP
	for gcvg-git-2@plane.gmane.org; Wed, 11 Sep 2013 00:44:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752813Ab3IJWos (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Sep 2013 18:44:48 -0400
Received: from 3.mo5.mail-out.ovh.net ([46.105.40.108]:51864 "EHLO
	mo5.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752777Ab3IJWos (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Sep 2013 18:44:48 -0400
Received: from mail629.ha.ovh.net (gw6.ovh.net [213.251.189.206])
	by mo5.mail-out.ovh.net (Postfix) with SMTP id D5D7E1004125
	for <git@vger.kernel.org>; Tue, 10 Sep 2013 23:27:49 +0200 (CEST)
Received: from b0.ovh.net (HELO queueout) (213.186.33.50)
	by b0.ovh.net with SMTP; 10 Sep 2013 23:29:13 +0200
Received: from 62-183-157-30.bb.dnainternet.fi (HELO ?192.168.1.10?) (kevin@bracey.fi@62.183.157.30)
  by ns0.ovh.net with SMTP; 10 Sep 2013 23:29:11 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.0; WOW64; rv:17.0) Gecko/20130215 Thunderbird/17.0.3
X-Ovh-Mailout: 178.32.228.5 (mo5.mail-out.ovh.net)
In-Reply-To: <xmqqy574y4pz.fsf@gitster.dls.corp.google.com>
X-Ovh-Tracer-Id: 10315213472352211160
X-Ovh-Remote: 62.183.157.30 (62-183-157-30.bb.dnainternet.fi)
X-Ovh-Local: 213.186.33.20 (ns0.ovh.net)
X-OVH-SPAMSTATE: OK
X-OVH-SPAMSCORE: 0
X-OVH-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeikedrledtucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecu
X-Spam-Check: DONE|U 0.507617/N
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeikedrledtucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecu
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234498>

On 10/09/2013 20:19, Junio C Hamano wrote:
> I am grumpy X-<.
>
> It appears that we introduced a large breakage during 1.8.4 cycle to
> the revision traversal machinery and made pathspec-limited "git log"
> pretty much useless.
>
> This command
>
>      $ git log v1.8.3.1..v1.8.4 -- git-cvsserver.perl
>
> reports that a merge 766f0f8ef7 (which did not touch the specified
> path at all) touches it.
>
> Bisecting points at d0af663e (revision.c: Make --full-history
> consider more merges, 2013-05-16).
>
That merge appearing *with* --full-history would seem like correct 
behaviour to me. Or at least it's what I intended.

That merge *did* touch that path - that file differs between the two 
parents, and it resolved on one of them.

This goes back to my original motivation for the change - the ability to 
find merges that resolved in unexpected ways - I want "--full-history" 
to show every merge where the end result is not identical to every parent.

This does mean that "--full-history" will show more merges than it used 
to for a pathspec - it will show merges in from topic branches which 
didn't touch that pathspec, but where the mainline did change it.

These extra merges can be pared back by "--simplify-merges", which will 
generally eliminate any irrelevant topic branches, although not for 
topic branches that are rooted older than your bottom commit, like in 
this example.


However, your particular example occurs *without*--full-history, which 
suggests a problem.

That merge is right near the bottom of the range. Its first parent is 
v1.8.3. It has an incoming pre-1.8.3 topic branch 
(fc/transport-helper-error-reporting) with an old version of 
git-cvsserver.perl (which the merge correctly didn't take). Display of 
that sort of bottom-of-range merge is a problem area I did try to 
address - it was problematic in older Git versions, but that problem was 
partially concealed by the overly-permissive "hide any merge identical 
to any one parent" logic, and became more exposed by my "show more merges".

I'm pretty certain non-full "git log v1.8.3..v1.8.4" shouldn't show that 
merge. And indeed it doesn't. Yay! At this point the various "follow 
first parent if identical", "prioritise on-graph treesame" and "treat 
bottom commits as on-graph" rules are working. That merge is identical 
to v1.8.3, its first parent, and we've expressed an interest in v1.8.3, 
so that's treated as on-graph, so it doesn't get shown.

(Oddly, "gitk v1.8.3..v1.8.4" fails and shows the merge. It seems gitk 
fails here because of the annotated tag: "gitk v1.8.3^0..v1.8.4" 
correctly shows nothing. So one apparent "failure to peel" bug 
somewhere. Can't seem to provoke this with git log.)

"git log v1.8.3.1..v1.8.4" on the other hand I'm not so sure about. The 
"follow first treesame parent" logic doesn't kick in because the merge's 
only treesame parent (v1.8.3) is off-graph. The merge is not treesame to 
its only on-graph parent (fc/transport-helper-error-reporting), so that 
"default following" rule doesn't activate.

I'm going to have to think a bit. "git log (--ancestry-path?) 
fc/transport-helper-error-reporting..v1.8.4" should definitely show that 
merge - we want to see how we got from the version of the file on the 
specified topic branch to the different version in v1.8.4.

Maybe if the first-treesame-parent rule was reapplied again later after 
rewriting? After we've pruned away the topic branch by rewriting because 
its commits don't touch the pathspec, then our merge is left with two 
off-graph rewritten parents. At which point maybe it would be reasonable 
for the default log to reapply the "follow first treesame parent" rule 
if all remaining parents are off-graph.

Does that make sense? Going to have to think harder.

I note that "gitk v1.8.3^0..v1.8.4" and "git log --parents 
v1.8.3..v1.8.4" show that merge in Git 1.8.3, but not in Git 1.8.4. So 
we're going partially forwards, at least.

Kevin
