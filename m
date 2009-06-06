From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/3] bisect: when skipping, choose a commit away from a skipped commit
Date: Fri, 05 Jun 2009 22:19:32 -0700
Message-ID: <7vzlcmdjmj.fsf@alter.siamese.dyndns.org>
References: <20090605040238.8885.92790.chriscool@tuxfamily.org>
	<20090605041044.8885.92104.chriscool@tuxfamily.org>
	<7vmy8np44z.fsf@alter.siamese.dyndns.org>
	<200906060638.25566.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Sam Vilain <sam@vilain.net>,
	"H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@elte.hu>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Sat Jun 06 07:21:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCoLY-0005kP-Tc
	for gcvg-git-2@gmane.org; Sat, 06 Jun 2009 07:21:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751815AbZFFFUA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Jun 2009 01:20:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751445AbZFFFT7
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Jun 2009 01:19:59 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:58201 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752813AbZFFFTz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jun 2009 01:19:55 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090606051931.VTAP2915.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Sat, 6 Jun 2009 01:19:31 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo01.cox.net with bizsmtp
	id 0VKY1c00A4aMwMQ03VKYRJ; Sat, 06 Jun 2009 01:19:32 -0400
X-VR-Score: -100.00
X-Authority-Analysis: v=1.0 c=1 a=4e42I7BXjMAA:10 a=8Hn-nT45BrsA:10
 a=dIu3SnmMAAAA:8 a=LyZXNj_hYiT7xaHYGe8A:9 a=MX8JcioaZcP3y6d9CisA:7
 a=eBnYXR3gBu8m1sYJDsgguZCpE_8A:4 a=Rn8qiON8_f4A:10 a=k7cj8AfdmP7oi0wq:21
 a=o0ykAukQjRvMnHqr:21
X-CM-Score: 0.00
In-Reply-To: <200906060638.25566.chriscool@tuxfamily.org> (Christian Couder's message of "Sat\, 6 Jun 2009 06\:38\:25 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120873>

Christian Couder <chriscool@tuxfamily.org> writes:

> For example using the following script:
>
> -------------
> #!/bin/sh
>
> new_commit() {
>     num="$1"
>     echo "line for commit $num" >> hello
>     git commit -m "commit $num" hello
> }
>
> touch hello
> git add hello
>
> for val in $(seq 100)
> do
>   new_commit $val
> done

But isn't this a totally uninteresting case of 100 _single_ strand of
pearls?  For a linear history, you do not even need the bisect machinery;
you can even bisect by hand.

>> Imagine you have a graph like this (G is good, B is bad, and both
>> branches have similar number of commits):
>>
>> 	G-------------y--z--a--b--c--B
>>                               /
>>         G--------------f--e--d
>>
>> In the above graph, a and d would give the best bisection, because they
>> can reach about half the number of nodes in the entire graph, and the
>> goal of the basic "find_bisection()" is to find a commit that cuts the
>> graph into closest-to-the-equal halves.  For this reason, 'a' and 'd'
>> would be near the beginning of the output from find_bisection(find_all)
>> you run when there are untestable commits in your managed_skipped().
>>
>> Suppose 'd' was already marked untestable, but 'a' is not.  And 'd' has
>> slightly better "goodness" value than 'a'.
>>
>> 	Side note.  I do not think the situation should change drastically
>> 	if 'a' has a better "goodness" value than 'd' has, but your
>> 	"skipped_first" logic that I already said I do not understand in
>> 	my earlier comment treats them quite differently, so this example
>> 	explicitly talks about the case where 'd' is better than 'a'.
>>
>> You do not check 'a' but check somewhere much older, either on the top
>> branch or on the bottom branch.  Why?
>
> The reason is that it would make the code more complex to check that we are 
> in this case, and that this case may not happen very often (it relies on 
> both being near a merge and having branches of the same size), and that we 
> don't loose much (see above my reference to what HPA wrote) by testing a 
> commit quite far away.

I think what you are missing is that you are not even guaranteeing "quite
far away" in the _topological_ space, especially in the presense of merges.

If you focus on a totally linear history, yes, picking somewhere away, in
the "goodness" scale space, from the optimal point (and there is a single
optimal point) that is untestable happens to take you away from that
particular untestable one in the topology space as well.  But that only
holds true when you have no merges.

My example graph was not an extreme special case at all.  It is just an
illustration of a typical real-life history.  Sure, I told you to assume
that both sides have about equal number of commits, but if the top branch
were longer, then instead of 'a', perhaps 'y' or its parent may be the
next best commit.  It is still very close in the "goodness" space to the
untestable commit 'd', but it is very far away from it in the topological
space, but your algorithm discards it because it is close in the
"goodness" scale space.  And the distance in the topological space from
untestable ones is what we seek here.

>>  - The point chosen should be far from any known untestable commits.  We
>>    do not currently have function to count distance from untestable
>>    commits, nor make a call to such a function after filtering untestable
>>    commits, but I think we should.
>
> I think this should be the case with my patch series.

Why?  You are picking "away, in the goodness scale, from the _best_ one".
I've already explained why it does not follow that the commit chosen that
way is _topologically_ away from _untestable_ ones.

> I agree that we could probably analyse the graph much better than what my 
> patch series does, but I think that it would be quite complex.

If you do not want complexity, let's not even do this "away in the
goodness space from the best one".  Your three patches already add
complexity to the algorithm, and I do not think what they do is worth it.
It solves a wrong problem, that does not have anything to do with "stay
away from untestable ones in the topological space".
