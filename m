From: Paul Jakma <paul@clubi.ie>
Subject: Re: impure renames / history tracking
Date: Wed, 1 Mar 2006 18:50:21 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0603011815150.13612@sheen.jakma.org>
References: <Pine.LNX.4.64.0603011343170.13612@sheen.jakma.org>
 <4405C012.6080407@op5.se> <Pine.LNX.4.64.0603011558390.13612@sheen.jakma.org>
 <Pine.LNX.4.64.0603010859200.22647@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Andreas Ericsson <ae@op5.se>, git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Mar 01 20:01:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FEWQL-0006PH-7u
	for gcvg-git@gmane.org; Wed, 01 Mar 2006 19:51:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750758AbWCASvg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Mar 2006 13:51:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751807AbWCASvg
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Mar 2006 13:51:36 -0500
Received: from hibernia.jakma.org ([212.17.55.49]:63643 "EHLO
	hibernia.jakma.org") by vger.kernel.org with ESMTP id S932096AbWCASvf
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 1 Mar 2006 13:51:35 -0500
Received: from sheen.jakma.org (IDENT:U2FsdGVkX1/KjSUOPh7WZubJD5s3dtFfFpHc9doFkWY@sheen.jakma.org [212.17.55.53])
	by hibernia.jakma.org (8.13.1/8.13.1) with ESMTP id k21IoMmP001711;
	Wed, 1 Mar 2006 18:50:34 GMT
X-X-Sender: paul@sheen.jakma.org
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0603010859200.22647@g5.osdl.org>
Mail-Copies-To: paul@hibernia.jakma.org
Mail-Followup-To: paul@hibernia.jakma.org
X-NSA: al aqsar fluffy jihad cute musharef kittens jet-A1 ear avgas wax ammonium bad qran dog inshallah allah al-akbar martyr iraq hammas hisballah rabin ayatollah korea revolt pelvix mustard gas x-ray british airways washington peroxide cool
X-Virus-Scanned: ClamAV version 0.88, clamav-milter version 0.87 on hibernia.jakma.org
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17004>

Hi Linus,

On Wed, 1 Mar 2006, Linus Torvalds wrote:

> The thing is, it does better than anything that _tries_ to be 
> "reliable".
>
> I can pretty much _guarantee_ that you can't do it better.

I'm willing to take that argument to the 'project' concerned, I just 
need to be pretty sure of it.

> Tracking "inodes" - aka file identities - (which is what BK does, 
> and I assume what SVN does) is fundamentally problematic. I 
> particular, it's a horrible problem when two inodes "meet" under 
> the same name. You now have two identities for the same file, and 
> you're fundamentally screwed.

Yes, in that model it is. This interestingly, is not the BK model, I 
suspect (see below).

> It doesn't even need renames to be a problem. JUST THE FACT THAT 
> YOU TRY TO TRACK FILE "IDENTITY" HISTORY IS BROKEN.

If it's "file identity" globally across the lifetime of the project, 
I agree 100% per cent. The 'traditional' SCM concerned does this.

That's not what a solution I'd want to explore either, I'm only 
interested in the identity of files for any one /one/ commit. In 
saying that, I recognise it's pointless to try annotate file-change 
information in multi-parent commits (merges).

> For example, take CVS, which doesn't actually try to do renames, 
> but _does_ try to track the identity of a file, since all the 
> history is tied into that identity: think about what happens in 
> Attic when a file is deleted. Completely broken model.

ACK, {Attic,deleted_files}/ is just horrid.

> And that's really fundamental. CVS doesn't show the problems so 
> much, because CVS actively tries to make it hard to do these 
> things.

ACK.

> With renames-tracking-file-identities, it's _really_ easy to get 
> some major confusion going. What happens when one branch creates a 
> file, and another one renames a file to that same name, and they 
> merge?

Well, the conflict has to be resolved somehow, even today.

> Don't tell me it doesn't happen. It happened under BK. The way BK 
> "solved" it was to keep the two separate identities: one of them 
> got resolved to the new filename, the other one went into the 
> "deleted" directory.

Right. That's what the 'traditional workflow' SCM I'm thinking of 
does - not BK funnily enough, but an SCM predating BK which also 
happens to use SCCS files, and with some of the same high-level 
push/pull constructs as BK (interestingly).

It also tracks name history globally using a deleted_files/ history, 
which is maintained, but I don't think it does this for name merges 
like the above.

In the one I'm thinking of, it does (I /think/, I'm not an expert in 
it) the following:

Given two files, say:

'old:

1.1---1.2---1.3

new:

1.1

- constructs a 'fake' base SCCS revision, empty
- adds the top 'old' version as a branch
- adds the top new version as a new delta

    1.1.1.1
   /
1.1---------1.2

Where in the merged file:

 	1.1: empty
 	1.1.1.1: was 1.3 from 'old'
 	1.2: is 1.1 from 'new'

However, it does /not/ create a deleted_files entry for the 'old' 
file. (AFAICT - I may not have a sufficiently full understanding of 
this SCM)

> Guess what happens when the side that got merged into "deleted" 
> continues to edit the file? That's right - their edits happen on 
> the deleted file, and never show up in the real tree in a 
> subsequent merge ever again.

Indeed - horrid.

> And as far as I can tell, BK really did the best you can do. 
> Following file identities really _is_ fundamentally broken. It 
> sounds like a nice idea, but while you migth solve a few problems, 
> you create a whole raft of much more fundamental problems.

For tracking identity across more than one commit - I fully agree.

That's not what quite I'm thinking of though. Is it worth going on 
with the discussion on a:

 	 'track identities *only* from context of /the/ parent to
           this commit'

> So next time you think about a merge that migt have been improved 
> by tracking renames, please also think about a merge where one of 
> the filenames came from two or more different sources through an 
> earlier merge, and thank your benevolent Gods that they instructed 
> me to make git be based purely on file contents.

Oh, I agree muchely here.

I wouldn't change git. I only wonder if it give its rename-heuristics 
an additional advisory-only hint? (for single-parent commits at least 
- never merges - and only on a per-commit basis).

I probably should first explore how git deals with rename clashes..

regards,
-- 
Paul Jakma	paul@clubi.ie	paul@jakma.org	Key ID: 64A2FF6A
Fortune:
I'm glad I was not born before tea.
 		-- Sidney Smith (1771-1845)
