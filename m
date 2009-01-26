From: Keith Cascio <keith@CS.UCLA.EDU>
Subject: Re: [PATCH v1 1/3] Introduce config variable "diff.primer"
Date: Sun, 25 Jan 2009 18:40:02 -0800 (PST)
Message-ID: <alpine.GSO.2.00.0901251345240.12651@kiwi.cs.ucla.edu>
References: <1232904657-31831-1-git-send-email-keith@cs.ucla.edu> <1232904657-31831-2-git-send-email-keith@cs.ucla.edu> <7v1vurf7lq.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 26 03:42:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRHQQ-0001Hk-Ta
	for gcvg-git-2@gmane.org; Mon, 26 Jan 2009 03:42:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750970AbZAZCkI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jan 2009 21:40:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750747AbZAZCkI
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jan 2009 21:40:08 -0500
Received: from Kiwi.CS.UCLA.EDU ([131.179.128.19]:41619 "EHLO kiwi.cs.ucla.edu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750726AbZAZCkH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jan 2009 21:40:07 -0500
Received: from kiwi.cs.ucla.edu (localhost.cs.ucla.edu [127.0.0.1])
	by kiwi.cs.ucla.edu (8.13.8+Sun/8.13.8/UCLACS-6.0) with ESMTP id n0Q2e2pn021244;
	Sun, 25 Jan 2009 18:40:02 -0800 (PST)
Received: from localhost (keith@localhost)
	by kiwi.cs.ucla.edu (8.13.8+Sun/8.13.8/Submit) with ESMTP id n0Q2e29k021241;
	Sun, 25 Jan 2009 18:40:02 -0800 (PST)
X-Authentication-Warning: kiwi.cs.ucla.edu: keith owned process doing -bs
In-Reply-To: <7v1vurf7lq.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 2.00 (GSO 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107161>

On Sun, 25 Jan 2009, Junio C Hamano wrote:

> Your Subject is good; in a shortlog output that will be taken 3 months
> down the road, it will still tell us what this patch was about, among 100
> other patches that are about different topics.

Thanks, I value the encouragement.

> The proposed commit log message describes what the patch does, but it does
> not explain what problem it solves, nor why the approach the patch takes
> to solve that problem is good.  Lines that are too short and too dense
> without paragraph breaks do not help readability either.

Noted, future versions will be better.

> You can work around the backward incompatibility you are introducing for known 
> users that you broke with your patch, by including updates to them, and that 
> is what your patches to git-gui and gitk are, but that is a sure sign that the 
> approach is flawed.
> 
> The point of lowlevel plumbing (e.g. diff-{files,index,tree}) is to give 
> people's scripts an interface that they can rely on.  It is not about giving a 
> magic interface that all the users are somehow magically upgraded without 
> change, when the underlying git is upgraded.


I believe, as I know you do as well, concept is the right way to approach code.  
I believe in the power of concept, and I agree that porcelain/plumbing is a good 
and powerful concept, and should not be violated.

> If a script X does not use "ignore whitespace" without an explicit request
> from the end user when it runs diff-tree internally, installing a new
> version of diff-tree should *NOT* magically make script X to run it with
> "ignore whitespace", because you do not know what the script X uses
> diff-tree output for and how, even when the end user sets diff.primer to
> get "ignore whitespace" applied to his command line invocation of "git
> diff" Porcelain.  Imagine a case where the operation of that script X
> relies on seeing at least two context lines around the hunk in order to
> correctly parse textual diff output from "diff-index -p", and the user
> sets "-U1" in diff.primer --- you would break the script and it is not
> fair to blame the script for not explicitly passing -U3 and relying on the
> default.
>
> Scriptability by definition means you do not know how scripts written by
> people around plumbing use the output; I do not think you can sensibly say
> "this should not be turned on in a machine friendly output, but this is
> safe to use".
> 
> I would not be opposed to an enhancement to the plumbing that the scripts
> can use to say "I am willing to take any option (or perhaps "these
> options") given to me via diff.primer".  Some scripts may want to be just
> a pass-thru of whatever the underlying git-diff-* command outputs, and it
> may be a handy way to magically upgrade them to allow their invocation of
> lowlevel plumbing to be affected by what the end-user configured.  But
> that magic upgrade has to be an opt/in process.

I agree opt-in is always better with new grammar/semantics.  However, the 
constraint I was trying to live inside is: if I call "git diff" on the command 
line with no options at all, then primer active.  Yet perhaps that's not 
possible, and the only way to do primer is to require opt-in spelled "--primer".  
Then I can tell bash to alias 'gitdiff' as 'git diff --primer' and use that on 
the command line.  And I could patch git-gui and gitk to call 'git diff --primer 
--no-color'.  Note that would still require the same magnitude of change to the 
git-gui and gitk Tcl code as occurs with my v1 patch.

It would be really cool if there was a way
to make this work without "--primer" !!!
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Worth considering: I believe Git users who've written their own scripts are not 
the type to use diff.primer blindly, if at all.  If they did use it, they'd be 
very thoughtful about its consequences for their existing scripts.  Based on 
that belief, and the fact that I already protected every script in Git core, and 
that I could work with the authors of contrib to do the same there, I have a 
very high degree of confidence that no existing script would be broken the day 
you release diff.primer, if ever :(

Because an enhancement *could* break existing scripts is not sufficient grounds 
to declare it worthless.  My gut tells me there is a sane way to do this, but I 
need more familiarity with the "literature" to discover it.

I see evidence there is already anxiety surrounding the necessity of 
"machine-friendliness", Cf. 
http://article.gmane.org/gmane.comp.version-control.git/107006

I think my DIFF_MACHINE_FRIENDLY() cpp macro with --machine-friendly command 
line option does a nice job of making that explicit, so we could all just relax!  
When a monster is lurking under the bridge threatening the kingdom, put it to 
death once and for all!  Rather than relying on an elaborate system of 
conventions prescribing how to tip-toe acrosss the bridge just the right way 
while pretending the monster isn't there.

> There are funny indentation to align the same variable names on two
> adjacent lines and such; please don't.

You're right.  I'm sorry.  I'll fix all style to adhere to local convention.

                                    -- Keith
