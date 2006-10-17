From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: VCS comparison table
Date: Tue, 17 Oct 2006 11:20:09 +0200
Message-ID: <200610171120.09747.jnareb@gmail.com>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com> <200610170119.09066.jnareb@gmail.com> <45346290.6050300@utoronto.ca>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: bazaar-ng@lists.canonical.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 17 11:20:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZl6x-0005bz-QU
	for gcvg-git@gmane.org; Tue, 17 Oct 2006 11:19:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423180AbWJQJTo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Oct 2006 05:19:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423181AbWJQJTo
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Oct 2006 05:19:44 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:38674 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1423180AbWJQJTn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Oct 2006 05:19:43 -0400
Received: by nf-out-0910.google.com with SMTP id c2so231476nfe
        for <git@vger.kernel.org>; Tue, 17 Oct 2006 02:19:42 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-disposition:content-type:content-transfer-encoding:message-id;
        b=Qo0W8M+M3dSp7Odwihww0anzmMALTiDmNn8eJiSQxpfkjF6vCT8QCvgH3/RX0K602YeYKPp48ehlCe0nczFSkgfwF3vfT+bzaGuETZcJMFTR5HJnvC/oz9MokLW59kdemf9GFVW3UbvK6gZwWyinu8Hr1R3rmygYcSPpZyWCU7c=
Received: by 10.49.8.1 with SMTP id l1mr1226007nfi;
        Tue, 17 Oct 2006 02:19:42 -0700 (PDT)
Received: from host-81-190-17-207.torun.mm.pl ( [81.190.17.207])
        by mx.google.com with ESMTP id k23sm655358nfc.2006.10.17.02.19.40;
        Tue, 17 Oct 2006 02:19:41 -0700 (PDT)
To: Aaron Bentley <aaron.bentley@utoronto.ca>
User-Agent: KMail/1.9.3
In-Reply-To: <45346290.6050300@utoronto.ca>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29039>

Aaron Bentley wrote:
> Jakub Narebski wrote:
>> Well, <ref>~<n> means <n>-th _parent_ of a given ref, which for branches
>> (which constantly change) is a moving target.
> 
> Ah.  Bazaar uses negative numbers to refer to <n>th parents, and
> positive numbers to refer to the number of commits that have been made
> since the branch was initialized.

How that works with branching point, and with merges? For example
in the case depicted below, how you refer to commit marked by X?

          ---- time --->

    --*--*--*--*--*--*--*--*--*-- <branch>
          \            /
           \-*--X--*--/

The branch it used to be on is gone...


Besides, in git commit object has pointers (in the form of sha1 ids)
to all its parents. So <ref>^ (parent of <ref>), or <ref>^<m> (m-th
parent of <ref>), or <ref>~<n> (n-th parent in 1st-parent lineage
of <ref>) are natural, and fast. <ref>+<n> (which would add yet another
character as forbidden in branch name) would need either serial number
(per repository or per branch) to commit id database, or getting full
history and looking it up in full history.

Branches in git are remembered not by their starting points, but by
their tips (ending points).

>> One cannot have universally valid revision numbers (even
>> only per branch) in distributed development. Subversion can do that
>> only because it is centralized SCM. Global numbering and distributed
>> nature doesn't mix... hence contents based sha1 as commit identifiers.
> 
> Sure.  Our UI approach is that unique identifiers can usefully be
> abstracted away with a combination of URL + number, in the vast
> majority of cases.

Git could do that too, by having file (files) with serial number
or branch/tag+serial number to commit id mapping. But this would
have to be local matter. And this would take some disk space, and
would seriously affect fetch performance (now git just downloads
what it doesn't have and dumps it into repository database).

BTW. what if repository is moved from one URL to another, for example
moving to different host? All "abstracted away" identifiers get
invalidated?

>> But this doesn't matter much, because you can have really lightweight
>> tags in git (especially now with packed refs support). So you can have
>> the namespace you want.
> 
> The nice thing about revision numbers is that they're implicit-- no one
> needs to take any action to update them, and so you can always use them.

Two words: post-commit hook. You can automate action of adding tags
(especially now with packed refs, which means that we can have huge number
of tags and this doesn't affect performance doue to I/O nor repository size)

>> I wonder if any SCM other than git has easy way to "rebase" a branch,
>> i.e. cut branch at branching point, and transplant it to the tip
>> of other branch. For example you work on 'xx/topic' topic branch,
>> and want to have changes in those branch but applied to current work,
>> not to the version some time ago when you have started working on
>> said feature.
> 
> If I understand correctly, in Bazaar, you'd just merge the current work
> into 'xx/topic'.

That is the alternate solution, but this would mean that merge would be
recorded (unless you squash it). And for published branches (like 'next'
for example) it is better solution, because rebase is in fact rewriting
history.

But rebase means that you had

                 A---B---C topic
                /
           D---E---F---G master

Rebasing 'topic' branch on top of master would mean that you would get

                         A'--B'--C' topic
                        /
           D---E---F---G master

where A', B', C' represent the same changeset as A, B, C up to resolved
conflicts.

And yes, that is "bzr graft"
  http://spacepants.org/src/bzrgraft/
equivalent. Do I understand correctly that this is third-party
contribution?

>> What your comparison matrick lacks for example is if given SCM
>> saves information about branching point and merges, so you can
>> get where two branches diverged, and when one branch was merged into
>> another.
> 
> I'm not sure what you mean about divergence.  For example, Bazaar
> records the complete ancestry of each branch, and determining the point
> of divergence is as simple as finding the last common ancestor.  But are
> you considering only the initial divergence?  Or if the branches merge
> and then diverge again, would you consider that the point of divergence?
> 
> merge-point tracking is a prerequisite for Smart Merge, which does
> appear on our matrix.

I was talking about point-of-divergence (branching point, fork point)
tracking, and merge-point tracking (or saving merge information).

>> Plugins = API + detection ifrastructure + loading on demand.
>> Git has API, has a kind of detection ifrastructure (for commands and
>> merge strategies only), doesn't have loading on demand. You can
>> easily provide new commands (thanks to git wrapper) and new merge
>> strategies.
> 
> I'm not sure what you mean by API, unless you mean the commandline.  If
> that's what you mean, surely all unix commands are extensible in that
> regard.

I mean API in the most common sense. 

For commands written in C it means "engine" (plumbing) functions and
data structures which do most work, so writing new command means some
command specific code and calling some functions to do the work.

For commands written in shell it means having versatile plumbing
commands (like for example git-rev-parse, git-rev-list, git-merge-base,
git-cat-file, etc.) which can be joined together including pipes
(--stdin option, --revs option to some commands), and git-sh-setup,
common git shell setup code. 

For commands writtent in Perl it means the same, with Git.pm module
instead of git-sh-setup.


About new command detection: if you put program named git-<command>
in directory with the rest of git commands, then you can call it
as "git <command>" using git wrapper. I think.

About adding new merge strategies: no autodoetection, you would
have to add new merge strategu to git-merge.sh.
-- 
Jakub Narebski
Poland
