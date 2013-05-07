From: Kevin Bracey <kevin@bracey.fi>
Subject: Re: [PATCH v3 3/9] t6111: new TREESAME test set
Date: Tue, 07 May 2013 18:19:56 +0300
Message-ID: <51891B9C.5040608@bracey.fi>
References: <1367767977-14513-1-git-send-email-kevin@bracey.fi> <1367767977-14513-4-git-send-email-kevin@bracey.fi> <7v1u9jrgl4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 07 17:29:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZjpn-00085K-Qv
	for gcvg-git-2@plane.gmane.org; Tue, 07 May 2013 17:29:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756932Ab3EGP3j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 May 2013 11:29:39 -0400
Received: from mo4.mail-out.ovh.net ([178.32.228.4]:41699 "EHLO
	mo4.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756834Ab3EGP3i (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 May 2013 11:29:38 -0400
Received: from mail628.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo4.mail-out.ovh.net (Postfix) with SMTP id EB401104E2DB
	for <git@vger.kernel.org>; Tue,  7 May 2013 17:19:59 +0200 (CEST)
Received: from b0.ovh.net (HELO queueout) (213.186.33.50)
	by b0.ovh.net with SMTP; 7 May 2013 17:20:02 +0200
Received: from 85-23-153-122.bb.dnainternet.fi (HELO ?192.168.1.10?) (kevin@bracey.fi@85.23.153.122)
  by ns0.ovh.net with SMTP; 7 May 2013 17:20:00 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.0; WOW64; rv:17.0) Gecko/20130215 Thunderbird/17.0.3
X-Ovh-Mailout: 178.32.228.4 (mo4.mail-out.ovh.net)
In-Reply-To: <7v1u9jrgl4.fsf@alter.siamese.dyndns.org>
X-Ovh-Tracer-Id: 1990591037441347800
X-Ovh-Remote: 85.23.153.122 (85-23-153-122.bb.dnainternet.fi)
X-Ovh-Local: 213.186.33.20 (ns0.ovh.net)
X-OVH-SPAMSTATE: OK
X-OVH-SPAMSCORE: -100
X-OVH-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeifedrieeiucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-Spam-Check: DONE|U 0.500022/N
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeifedrieeiucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223580>

On 06/05/2013 23:36, Junio C Hamano wrote:
> Kevin Bracey <kevin@bracey.fi> writes:
>
>> +#        ,---E--.   *H----------.             * marks !TREESAME parent paths
>> +#       /        \ /             \*
>> +# *A--*B---D--*F-*G---------K-*L-*M
>> +#   \     /*       \       /
>> +#    `-C-'          `-*I-*J
>> +#
>> +# A creates "file", B and F change it.
>> +# Odd merge G takes the old version from B.
>> +# I changes it, but J reverts it.
>> +# H and L both change it, and M merges those changes.
>> + ...
>>
>> +check_outcome failure 'M H L J I G F B A' --simplify-merges -- file # drops G
> Even though E simplifies down to B, making G a merge between B and F (the former is an ancestor of the latter), G is kept, because...?
>
> Because the path at B and F are different?

G's simplified parent B is marked for deletion by the redundant parent scan; it would be redundant in any normal merge scenario. But here, because of the odd merge, it gets a reprieve from the "don't drop all TREESAME parents" rule. So merge G remains with 2 parents: B (its "content" parent) and F (its "topological" parent).

> I have to wonder what should happen if D makes path different from B, and then F makes path the same as B.  B and F should still be kept.

That would happen. G would be TREESAME to F, so the "keep 1 TREESAME" rule wouldn't need to kick in, parent B would be dropped from G, and G would simplify to F.


> +# Check that odd merge G remains shown when F is the bottom.
> I did not have a chance to say this when you responded in the
> previous round with that "bottom" thing before you sent this new round,
> but I am not sure if it is a good idea to pay special attention to the
> "bottom"-ness.  Very often, instead of running "git log -- path" and
> stopping when seeing enough by killing the pager, people run
> "git log HEAD~200.. -- path" to pick "recent enough"
> commits, but the number 200 is very much arbitrary.

True, the bottom can be arbitrary. But that actually turns out to be the key argument in favour of what I'm doing. The reason for treating the bottom "specially" is actually to prevent side branches that are immediately above the bottom from being treated specially. In early tests of the side branch logic, it became clear that whether a side branch was displayed or not depended on whether it was exactly adjacent to the bottom. The behaviour was arbitrary and annoying.

Considering your arbitrary bottom example, observe what happens if there's an irrelevant topic merge coming in at HEAD~199, and you try various bottoms around that point, without treating the bottom "specially". You get a transient simplification failure as the bottom passes:

* Bottom=HEAD~300 - below the topic branch point:

Normal simplification will work fine for the topic branch; it is unaffected by limiting, so the entire topic branch and merge is simplified away. This worked fine before this patch series (assuming a normal merge).

Now we move forward to put the bottom between the topic branch point and merge.

* Bottom=HEAD~201:                (B=bottom, o=other UNINTERESTING, x=INTERESTING, *=!TREESAME)

         B--*x---x--*x    simplifies to      B--*x---x--*x
                /*                                  /*
       o---x---x                                   o

   New rules reduce to      B--*x--*x      (1 TREESAME INTERESTING parent,
                                           so ignore UNINTERESTING side)

* Move bottom up one to HEAD~200:

             B---x--*x    simplifies to          B---x--*x
                /*                                  /*
       o---x---x                                   o

                                           (Merge can't be dropped -
                                            2 UNINTERESTING parents that differ)

If I can't treat bottoms specially, then I can't distinguish between the merge's two UNINTERESTING parents, so I have to show the merge.

* Move bottom up one again to HEAD~199, and the branch is excluded by the path-spec anyway:

                 B--*x

So the net effect there is that we have a side branch merge that is shown for _exactly_ one choice of bottom commit on the mainline. It's not shown for 'HEAD~5000..' to 'HEAD~201..', and it's not shown for 'HEAD~199..' to 'HEAD..'. But it pops up in 'HEAD~200..'.  Something's wrong with that picture, and treating the bottom as interesting removes the effect. Fuller discussion below.

>> +check_result 'M L H' F..M -- file
> OK.  It is still one possible history to explain what we have in the path at the end.

Yes, but I don't really like it much. It's not clear that we came from an ancestor of F, not F itself. But there's nothing you can do about that in this most basic of commands, and at least adding any option does reveal the truth that we're not based on F. Even just "--parents" (implied in gitk) reveals that H came from B.

>> +check_result 'M L K J I H G' F..M --full-history --parents -- file
> OK.
>
> It almost makes me suspect that the --full-history option should flip
> revs->rewrite_parents on (but not revs->print_parents, unless the --parents
> option asks us to) when the option is parsed.

I don't think so. Why do we want to show K unless we have to? It would just be a lot of noise in a normal "git log" - this tree isn't typical. In a normal tree, most merges will be more like K - so when requesting a log of a specific file, the mainline won't have modified the relevant file during the life of most irrelevant topic branches, so those branches' merges will be fully TREESAME and can be omitted.

I assume --simplify-merges had to be invented to get rid of the noise of all the pointless fully-TREESAME merges from "--full-history --parents", which keeps all merges. But without --parents, a file-specific --full-history isn't currently that bad.


>> +check_result 'M L J I H' E..M --ancestry-path -- file
> Because F is outside our graph with --ancestry-path, G does not bring
> anything new to path relative to its remaining parent E and should not be shown.  OK.

Yep. And this works because we treat bottom E as a parent of G for TREESAME, despite it being UNINTERESTING. If we didn't, then E and F would be "equals", and G would have to be shown.

>> +check_outcome failure 'M L K J I H' E..M --ancestry-path --parents --
>> +file
> This fails in what way?  G is shown, because the !treesame with now irrelevant F comes into play?

Yes, that's right. Sorry, missing comment.

>> +check_outcome failure 'M H L J I' E..M --ancestry-path
>> +--simplify-merges -- file # includes G
> Makes me wonder how "--ancestry-path --full-history" would work with this range and with/without the pathspec.

--ancestry-path implies full-history, as far as I can see.

>> +check_outcome failure 'M L H' G..M -- file # includes J I
>> +check_outcome failure 'M L H' G..M --parents -- file # includes J I
> I am not sure if it should be a failure or your expectation is wrong.
> G is outside the graph, so as far as the remainder of the graph is concerned,
> J is the sole remaining parent of K and I and J did change the path in question.
>
> What makes you think I and J should be excluded in these cases?

Because it's the simplest answer to the question "what happened in M since G", which is what "G..M" is supposed to mean. And because I J _would_ have been excluded and we would have got 'M L H' if we added an extra null commit G1 between G and K. That suggests an instability in our logic. Why should adding a totally irrelevant commit affect whether I-J is hidden? I J is hidden in every case apart from when you specify K^ as bottom. Why is K^ a special bottom?

Graph theory time!

This all comes about because the formal graph definition doesn't match the user interface. The question "B..C" currently generates a graph of all commits in C since B, and the connections between those commits. It turns out to be problematic that the graph doesn't include the connection to B itself. It would be fine if only worrying about nodes in the graph. But it's not fine when you start doing graph operations that care about edge connections to parents.

Thinking linearly, consider:

A..C:   o--o--B--o--o--C

The two queries "A..B" and "B..C" should, between them, cover "A..C", surely? But with the current logic, they don't:

A..B:   o--o--B
B..C:            o--o--C

Wherever you place B, the following edge gets "deleted" from consideration. Not a problem for A..B, because we never consider graph commits' children. But it's a problem for B..C - it affects the graph operations on the first commit of the graph. Which is what triggers this G..M problem here. In all normal circumstances, the default graph following would always choose to take K's first TREESAME parent, and ignore IJ. But when the bottom is specifically K^, it breaks, because that mainline TREESAME edge is removed from consideration. K is handled differently because it's still on the graph, but it's lost its mainline parent.

Looking at the graph above, with my proposed addition of G1:

K~3..M:

        *G---G1--<-K-*L-*M
          \       /
           `-*I-*J

K~2..M:

             G1--<-K-*L-*M
                  /
             *I-*J

K^..M:

                   K-*L-*M    - whoops. Get diverted onto IJ
                  /
             *I-*J

K..M:

                      L-*M

So for exactly one position of bottom along the mainline, we "forget" the path of our mainline, and get diverted, because we're not including the bottom in the graph. This is just like the HEAD~200 example - different graph optimisation, but same symptom and root cause. Include the bottom in the graph, but unprinted, and it works:

K~3..M:

  (F)---*G---G1--<-K-*L-*M
          \       /
           `-*I-*J

K~2..M:

       (G)---G1--<-K-*L-*M
          \       /
           `-*I-*J
K^..M:

            (G1)-<-K-*L-*M
                  /
             *I-*J

K..M:

                      L-*M

What I'm effectively doing is extending the graph to actually include the unshown bottom. I think it just makes more sense. We connect up the linear history:

A..B:  (A)--o--o--B
B..C:            (B)--o--o--C

The two are now connected, with every commit and edge considered once between them. The A..B and B..C graphs are now really connected at B. In the second range, we don't print B, but do treat it as if it was part of the graph for graph-edge-based operations that want to distinguish between relevant and irrelevant parents. Which then means that the choice of split point B on the mainline between A and C doesn't perturb the side branch logic, because we always consider the same edges, regardless of where B is. B doesn't "delete" its following edge. And "B..C" now really is "how did we get from B to C" - it includes that first step.

(In a non-linear graph, in this scheme, A..B and B..C aren't fully connected - all other commit boundaries between the sets are disjoint, and they only connect at B. But that's what makes the "side branch" logic work out - we can tell which path the user cares about at the bottom boundary, and hence which paths are the sides. Anything UNINTERESTING && !BOTTOM will be an ancestor of a bottom, and thus can be candidate for side-branch simplification, which is what we want to happen with 'HEAD~200..' above).

> Shouldn't the same logic as "--ancestry-path [EF]..M" we saw earlier apply here?
> That is, "-a-p E..M" makes F the sole remaining parent of G and G does change the
> path from F so it should be shown, while "-a-p F..M" makes E the sole parent of G,
> and G does not change the path from E, so it should not be shown.

That's muddled. I assume you mean:

> That is, "-a-p F..M" makes F the sole remaining parent of G and G does change the
> path from F so it should be shown, while "-a-p E..M" makes E the sole parent of G,
> and G does not change the path from E, so it should not be shown.

Which is the way the logic works - we treat F and E as interesting/priority parents when they're specified as a bottom in each case. Without doing that, G would have 2 differing and equally (un)important parents in each case, and thus would be shown in both cases.

In this case, the same logic says that G is treated as an interesting parent of K because it is the specified bottom. Which then enables the default following to follow that path direct to G, rather than having to go down the IJ path (which leads to G anyway).

Kevin
