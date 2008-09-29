From: Andreas Ericsson <ae@op5.se>
Subject: Re: interactive rebase not rebasing
Date: Mon, 29 Sep 2008 08:42:07 +0200
Message-ID: <48E078BF.5030806@op5.se>
References: <20080928235013.5c749c6e.stephen@exigencecorp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Stephen Haberman <stephen@exigencecorp.com>
X-From: git-owner@vger.kernel.org Mon Sep 29 08:43:31 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KkCTi-0000Sv-Me
	for gcvg-git-2@gmane.org; Mon, 29 Sep 2008 08:43:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751720AbYI2GmV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Sep 2008 02:42:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751734AbYI2GmV
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Sep 2008 02:42:21 -0400
Received: from mail.op5.se ([193.201.96.20]:56519 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751713AbYI2GmU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Sep 2008 02:42:20 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 0A5541B80050;
	Mon, 29 Sep 2008 08:33:29 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.478
X-Spam-Level: 
X-Spam-Status: No, score=-2.478 tagged_above=-10 required=6.6
	tests=[AWL=0.021, BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ssc8hKYtxeSp; Mon, 29 Sep 2008 08:33:24 +0200 (CEST)
Received: from clix.int.op5.se (unknown [172.27.78.6])
	by mail.op5.se (Postfix) with ESMTP id B44F51B8008E;
	Mon, 29 Sep 2008 08:33:23 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <20080928235013.5c749c6e.stephen@exigencecorp.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96999>

Stephen Haberman wrote:
> Hello,
> 
> Per the emails from me last week, I'm working in an environment with
> shared topic branches and am trying to find a bullet-proof way for devs
> to rebase their local commits after the topic branch has moved.
> 
> The easy approach would be to just let `git pull` create merge commits,
> and I would have been done with this long ago, but I'm striving to get
> rebasing to "just work" and avoid the ugliness of same-branch merge
> commits. Cross-branch merge commits are cool, but not same-branch.
> 
> So, here's a crazy scenario we've ran into--a new release has hit
> stable, with two devs working on the same topic branch, and both of them
> merge. One wins, and the other has to rebase. Previously, this was
> replaying commits, but with great tips from the list last week, `rebase
> -i -p` is handling most scenarios.
> 
> However, not this one:
> 
> # A --C------            <-- origin/stable
> #  \  |      \
> #   B -- D -- E -- F     <-- origin/topic2
> #    \|
> #     g -- h             <-- topic2
> 
> topic2 is a dev that has locally merged stable in g, moved on in h, is
> ready to push, but another dev already merged stable in E, and also
> committed F.
> 
> If we do a `git pull --no-rebase`, the result is:
> 
> # A --C------            <-- origin/stable
> #  \  |      \
> #   B -- D -- E -- F     <-- origin/topic2
> #    \|             \
> #     g -- h ------- i   <-- topic2
> 
> But i is a same-branch merge, and we'd rather rebase to something like:
> 
> # A --C------            <-- origin/stable
> #  \         \
> #   B -- D -- E -- F     <-- origin/topic2
> #                   \
> #                    h'  <-- topic2
> 
> (...maybe g' in there if g resolved stable conflicts differently
> E did them. I'm not sure, I haven't gotten there yet.)
> 
> However, currently, `git rebase -i -p origin/topic2` results in:
> 
> # A --C------            <-- origin/stable
> #  \  |      \
> #   B -- D -- E -- F     <-- origin/topic2
> #    \|
> #     g -- h             <-- topic2
> 
> Nothing has changed. g & h haven't moved...I can keep executing this
> operation and the commits never make it on top of origin/topic2's F. 
> 
> Frustratingly, if I run non-interactive rebase, it works perfectly.

I can imagine. Since you don't want to preserve the merges in this
case, you shouldn't be using the -p flag.

In fact, for this particular scenario (assuming "h" is really the only
commit on topic2), you probably want to just cherry-pick that commit
into origin/topic2:

   git checkout topic2
   git reset --hard origin/topic2
   git cherry-pick ORIG_HEAD

would work nicely for that. If topic2 and topic1 resolved merge
conflicts differently, cherry-picking topic2 will give conflicts again,
so they'll have to be resolved. rebase (without -p) will have the same
effect, ofcourse.

I don't think you can have a single command that does all the things
you want, because the possible differences in input makes it very nearly
impossible to always do "the right thing". For this case, you don't
want to preserve merges, so "git rebase" without -p does the right
thing. For that other case earlier this week, you wanted to preserve
merges, so "git rebase -p" does the right thing there. It's complex
to try to dwim things like that, and complexity will cause very weird
and surprising errors when it *does* fail.

Instead, I think you should give your developers some training in the
more advanced parts of git's integration tools and also look over
your workflow. Frequently merging 'master' into a topic is very rarely
the right thing to do. It's usually better to rebase the topic onto
master or cherry-pick relevant bugfixes from 'master' into the topic.
If two devs need to work on one topic, then that topic probably needs
breaking up into a sub-topic. However, sub-topics should never merge
'master' into them themselves; only 'topic'. Otherwise you'll get
more merges than work done.


> But
> I've got other cases (see earlier posts) that do need the interactive
> rebase. Personally, I could probably make do with trying each and
> seeing what happened, but I'm really trying to find a bullet proof
> command/alias/script for devs to run and have it "just work".
> 

Or you could sit down and think about what you want to happen and then
run the appropriate command. ;-)

> I've attached a test that sets up the DAG as above and currently passes
> by asserting the not-desired/unchanged-DAG result. The assert for the
> desired result is commented out at the end.
> 

Thanks for this. If all bug-reports had this, bugfixing would be a lot
easier. However, for this particular case, I'm not so sure it's a bug.

> Am I correct in asserting this is some sort of bug in the interactive
> rebase such that g & h are not ending up on top of F?
> 

Assuming you're passing a correct input file to rebase -i; yes. At the
very least, "h" should be moved to the tip of origin/topic2.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
