From: Kevin Bracey <kevin@bracey.fi>
Subject: Re: breakage in revision traversal with pathspec
Date: Wed, 11 Sep 2013 22:39:15 +0300
Message-ID: <5230C6E3.3080406@bracey.fi>
References: <xmqqy574y4pz.fsf@gitster.dls.corp.google.com> <522F8ED2.9000408@bracey.fi> <xmqq38pcwc21.fsf@gitster.dls.corp.google.com> <5230AD23.2050009@bracey.fi> <20130911182444.GD4326@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 11 21:58:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJqYC-00073j-Pa
	for gcvg-git-2@plane.gmane.org; Wed, 11 Sep 2013 21:58:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757363Ab3IKT6A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Sep 2013 15:58:00 -0400
Received: from 5.mo2.mail-out.ovh.net ([87.98.181.248]:42187 "EHLO
	mo2.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757308Ab3IKT56 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Sep 2013 15:57:58 -0400
Received: from mail195.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo2.mail-out.ovh.net (Postfix) with SMTP id 615C1DC4012
	for <git@vger.kernel.org>; Wed, 11 Sep 2013 21:39:19 +0200 (CEST)
Received: from b0.ovh.net (HELO queueout) (213.186.33.50)
	by b0.ovh.net with SMTP; 11 Sep 2013 21:45:51 +0200
Received: from 62-183-157-30.bb.dnainternet.fi (HELO ?192.168.1.10?) (kevin@bracey.fi@62.183.157.30)
  by ns0.ovh.net with SMTP; 11 Sep 2013 21:45:49 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.0; WOW64; rv:17.0) Gecko/20130215 Thunderbird/17.0.3
X-Ovh-Mailout: 178.32.228.2 (mo2.mail-out.ovh.net)
In-Reply-To: <20130911182444.GD4326@google.com>
X-Ovh-Tracer-Id: 14442199580516651115
X-Ovh-Remote: 62.183.157.30 (62-183-157-30.bb.dnainternet.fi)
X-Ovh-Local: 213.186.33.20 (ns0.ovh.net)
X-OVH-SPAMSTATE: OK
X-OVH-SPAMSCORE: -100
X-OVH-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeikedrledvucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-Spam-Check: DONE|U 0.500507/N
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeikedrledvucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234603>

On 11/09/2013 21:24, Jonathan Nieder wrote:
> Kevin Bracey wrote:
>
>> On reflection I'm not sure what we should for the "simple history"
>> view of v1.8.3.1..v1.8.4. We're not rewriting parents, so we don't
>> get a chance to reconsider the merge as being zero-parent, and we do
>> have this little section of graph to traverse at the bottom:
>>
>>            1.8.3
>>              o----x----x----x----x---x---     (x = included, o = excluded, *=!treesame)
>>                  /
>>                 /*
>>    o--x--x--x--x
> [...]
>> 1) if identical to any on-graph parent, follow that one, and rewrite
>> the merge as a non-merge. We currently do not follow to an identical
>> off-graph parent. This long-standing comment in try_to_simplify_commit
>> applies: "Even if a merge with an uninteresting side branch brought
>> the entire change we are interested in, we do not want to lose the
>> other branches of this merge, so we just keep going."
>>
> [...]
>> I currently feel instinctively more disposed to dropping the older
>> "don't follow off-graph identical parents" rule. Let the default
>> history go straight to v1.8.3 even though it goes off the graph,
>> stopping us traversing the topic branch.
> Thanks for this analysis.  Interesting.
>
> The rule (1) comes from v1.3.0-rc1~13^2~6: ...
>
> I think you're right that dropping the "don't follow off-graph
> treesame parents" rule would be a sensible change.  The usual point of
> the "follow the treesame parent" rule is to avoid drawing undue
> attention to merges of ancient history where some of the parents are
> side-branches with an old version of the files being tracked and did
> not actually change those files.  That rationale applies just as much
> for a merge on top of an UNINTERESTING rev as any other merge.
I agree about the rationale still applying - why not follow off-graph, 
unless you're doing --ancestry-path? (Fortunately ancestry_path already 
disables simplify_history). That makes more sense if you try to ignore 
the misleading comment. In a typical "v1..v3" range, the temporal 
limiting means that it's paths to the mainline that will tend to be 
marked UNINTERESTING, not to the topic branches...

But I can imagine going off graph it may previously have tripped up 
other parts of the code. It could be that this Git 1.3.0 rule ended up 
covering over some of the older merge hiding logic flakiness. Maybe it's 
no longer necessary. I'll do some experiments.

Now, one bit of news - I have just figured out why gitk is behaving 
differently. It transforms ".." before it reaches git.

To see the effect at the command line: "git log v1.8.3..v.1.8.4" hides 
the merge, but "git log ^v1.8.3 v1.8.4" shows it. Whoops. A new example 
of a dotty shorthand not being exactly equivalent.

In the ".." case the v1.8.3 tag gets peeled before being sent to 
add_rev_cmdline , and the "mark bottom commits" logic works. But in the 
"^" case, the v1.8.3 doesn't get peeled. Junio - any thoughts on the 
correct place to fix that? (And gitk actually does ^<tag-sha>, just to 
be odd, so that needs to be handled too). Should these things be peeled 
in revs->cmdline or not? We should be consistent.

Kevin
