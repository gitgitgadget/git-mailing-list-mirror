From: Kevin Bracey <kevin@bracey.fi>
Subject: Re: [PATCH v2 8/8] revision.c: discount UNINTERESTING parents
Date: Thu, 02 May 2013 20:52:12 +0300
Message-ID: <5182A7CC.4040009@bracey.fi>
References: <1367342788-7795-1-git-send-email-kevin@bracey.fi> <1367342788-7795-9-git-send-email-kevin@bracey.fi> <7vmwsfbtu7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 02 21:09:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXyt9-0002P4-HG
	for gcvg-git-2@plane.gmane.org; Thu, 02 May 2013 21:09:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761752Ab3EBTJu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 May 2013 15:09:50 -0400
Received: from 8.mo5.mail-out.ovh.net ([178.32.116.78]:34308 "EHLO
	mo5.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1761341Ab3EBTJt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 May 2013 15:09:49 -0400
X-Greylist: delayed 2400 seconds by postgrey-1.27 at vger.kernel.org; Thu, 02 May 2013 15:09:48 EDT
Received: from mail173.ha.ovh.net (gw6.ovh.net [213.251.189.206])
	by mo5.mail-out.ovh.net (Postfix) with SMTP id F023CFFA68B
	for <git@vger.kernel.org>; Thu,  2 May 2013 19:52:36 +0200 (CEST)
Received: from b0.ovh.net (HELO queueout) (213.186.33.50)
	by b0.ovh.net with SMTP; 2 May 2013 19:52:24 +0200
Received: from 85-23-153-122.bb.dnainternet.fi (HELO ?192.168.1.10?) (kevin@bracey.fi@85.23.153.122)
  by ns0.ovh.net with SMTP; 2 May 2013 19:52:23 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.0; WOW64; rv:17.0) Gecko/20130215 Thunderbird/17.0.3
X-Ovh-Mailout: 178.32.228.5 (mo5.mail-out.ovh.net)
In-Reply-To: <7vmwsfbtu7.fsf@alter.siamese.dyndns.org>
X-Ovh-Tracer-Id: 12093853850074714328
X-Ovh-Remote: 85.23.153.122 (85-23-153-122.bb.dnainternet.fi)
X-Ovh-Local: 213.186.33.20 (ns0.ovh.net)
X-OVH-SPAMSTATE: OK
X-OVH-SPAMSCORE: -100
X-OVH-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeifedrheekucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-Spam-Check: DONE|U 0.502515/N
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeifedrheekucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223249>

On 01/05/2013 00:18, Junio C Hamano wrote:

>> These rules paying more attention to UNINTERESTING do add a tricky
>> wrinkle to behaviour. Because limited revision lists are conventiona=
lly
>> expressed as A..B (ie B ^A), the bottom commit is UNINTERESTING.
> OK.
>
>> Thus
>> its connection to the INTERESTING graph is not privileged over side
>> branches,
> I take that "its connection" refers to the "=3D=3D=3D" link below, th=
e
> nodes connected with "---" form the "INTERESTING graph", and
>
>       ....Z...A=3D=3D=3DX---o---o---B
>            \\    /
>             W---Y
>     =20
> "side branches" refer to the development that built W and Y and
> merged at X.  And you are saying that A=3D=3D=3DX is not "privileged"=
 over
> "Y---X", with some definition of "privileged" I am not sure about.

Okay, that's a good graph. The basic problem is that all the rules abov=
e=20
try to identify a merge from an irrelevant branch and eliminate it. But=
=20
how can we define what a side branch is?

I think the rules I state are conceptually sound - a side branch is an=20
extra parent coming in from outside our limited history graph. But the=20
problem is at the bottom. In the event that someone specifies "A..B"=20
with the above history, we get the resultant graph "W-Y-X-o-o-B". A is=20
not on that graph. So with the rules as they stand, "A" being=20
UNINTERESTING makes it get treated as a side branch of X, which isn't=20
good. A needs to be INTERESTING for the purpose of side-branch logic.

So when someone says "A..B" and generates "W-Y-X-o-o-B", we want to kno=
w=20
that X's parent path "(Z)-W-Y-X" is the (possibly irrelevant) side=20
branch, not "(A)-X".

Example undesirable behaviour, with A treated as a side branch:

1) If only commit A changed our file, and merge X took "old" version Y=20
for some reason, under these rules "--full-history A..B" would show=20
nothing. X doesn't consider A because it's UNINTERESTING. If there had=20
been an intervening (even irrelevant) commit A1 between A1 and X, X=20
would have been shown.

2) If only commit A changed our file, and merge X took A, with this=20
rules"--simplify-merges A..B" would show X, with two rewritten=20
UNINTERESTING parents A and Z. That's not what we want - Z is an=20
irrelevant side-branch in this case. If there had been an intervening=20
(unsimplifiable) commit A1 between A and X, X would have had INTERESTIN=
G=20
parent A1, and WY would have been successfully discarded.

3) Even before my new rules, there is one existing place trying to spot=
=20
side branches, and it can fail here for the same reasons. See=20
simplify_history's "even if a merge with an uninteresting side branch=20
brought the entire change we are interested in" test. It would do the=20
wrong thing at X, if W had made a change and Y reverted it. "git log=20
A..B" would show W and Y, which is not what we want. As the scan hits X=
,=20
it follows parent Y rather than just go for first parent A, because it=20
thinks A is "an uninteresting side branch". Again, if there had been an=
=20
intervening commit A1 before X, X would have followed A1 and W and Y=20
would not have been shown.

All 3 cases work if A is treated as "INTERESTING" for side-branch rules=
=2E=20
We shouldn't have needed to put in an extra A1 commit to make them work=
=2E

>>   #          D---E-------F
>>   #         /     \       \
>> +#    B---C-G0-G--H---I---J
>>   #   /                     \
>>   #  A-------K---------------L--M
>>   #
>>
>>
>> Conceptually, the "ancestry-path" shouldn't get affected by any
>> pathspec. The range "--ancestry-path G0..M" should be equivalent to
>> the range "G0..M ^F ^E ^K", and with the rule to ignore non-sameness
>> with uninteresting side branches, I would have expected that H and J
>> would be equally irrelevant, because E and F would be outside the
>> graph we would want to look at sameness.

Those two pathspecs produce the same graph of commits, and yes, they've=
=20
always produced the same thing up until now. But we're trying to do=20
something new(ish) here. We're trying to define "side branch", to allow=
=20
us to make more useful pruning comparisons. And we can't reliably defin=
e=20
"side branch" unless we can reliably define where we're coming from.

Looking at this case, given that graph of commits G-H-I-J-L-M (produced=
=20
by any pathspec/flags), that is "easy" because it's linear. The bottom=20
of the INTERESTING graph has a single parent, and we can follow it=20
straight from bottom to top. We can deduce that non-merge "G" is bottom=
,=20
and thus call the connections to E and F "sides". (But that could have=20
been wrong if the graph had been made some other way, and the user=20
wasn't asking for history since G0).

But if presented with H-I-J-L-M we get stuck. The lowest commit in our=20
graph has 2 parents. How do we distinguish between E and G? Which is th=
e=20
side, and which is the bottom? We can only define "side branch" here if=
=20
we know where our bottom is. The version of this patch as posted can't=20
distinguish whether E or G is more important, so merge H always gets=20
shown. And that makes me unhappy. And note that normal=20
merge-simplification will often prune away boring non-merge commits,=20
leaving the user-specified UNINTERESTING bottom attached to an=20
INTERESTING graph by a merge commit like this. So it would be very=20
common to stumble over this first connection onto the INTERESTING graph=
=20
with --simplify-merges.

So my proposal here is that for pruning purposes, we need to mark the=20
bottom(s), so we can reliably identify the sides.A side branch is=20
spotted by being UNINTERESTING && !BOTTOM.

Doing this means that "--ancestry-path E..M", "--ancestry-path G..M" an=
d=20
"G..M ^F ^E ^K" would all produce a walk starting at H, but for pruning=
=20
purposes they will prioritise differences against specified bottom=20
commits, and discount them against non-specified boundary commits.

So "E..M" will treat "G" as a side branch, and "G..M" will treat "D-E"=20
as a side branch. "--ancestry-path E..M" will show H iff it differs fro=
m=20
E, and "--ancestry-path G..M" will show H iff it differs from G.

And as a result, manually specifying with "G..M ^F ^E ^K" will be payin=
g=20
extra attention to merges H, J and L, caring if they differ from listed=
=20
commits E F and K, and not treating them as ignorable side branches. H=20
will be shown if it differs from either G or E.

All of which feels right and good to me, but it does mean the neat=20
mathematical purity of the commit set model is somewhat disrupted -=20
different pathspecs specifying the same set of commits will prune=20
differently. But I think the behaviour fits intuitive expectation well.=
=20
When a user specifies "A..B" or "B ^A", they almost always mean that=20
they want the change since A, and they=92re not thinking of A as a =93c=
ommit=20
set subtraction=94. The specific edge to A is important to them. So let=
's=20
be helpful and meet normal expectation, and treat the edge between the=20
INTERESTING graph and the specified bottom commit as important.

Revised patch 8/8 doing this follows. The fact it adds a BOTTOM flag=20
potentially has an impact on other areas, as noted in the comments. If=20
we went down this route, the BOTTOM flag addition would obviously want=20
to be a separate preceding patch, covering impact on=20
collect_bottom_commits etc.

And the thing about "only need merges with 2+ INTERESTING parents for=20
topology" should really be separated out too - that's actually quite=20
distinct from the TREESAME side branch stuff, and rather more=20
straightforward.

Kevin
