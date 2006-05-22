From: Sean <seanlkml@sympatico.ca>
Subject: Re: [PATCH 0/2] tagsize < 8kb restriction
Date: Mon, 22 May 2006 19:12:40 -0400
Message-ID: <BAYC1-PASMTP1164FE2A24B4D1B4C0A607AE9A0@CEZ.ICE>
References: <4471CF23.1070807@gmx.de>
	<7vac99c1hv.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: BjEngelmann@gmx.de, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 23 01:18:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FiJfb-0002lX-Q2
	for gcvg-git@gmane.org; Tue, 23 May 2006 01:18:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751174AbWEVXSh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 22 May 2006 19:18:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751295AbWEVXSh
	(ORCPT <rfc822;git-outgoing>); Mon, 22 May 2006 19:18:37 -0400
Received: from bayc1-pasmtp11.bayc1.hotmail.com ([65.54.191.171]:65134 "EHLO
	BAYC1-PASMTP11.BAYC1.HOTMAIL.COM") by vger.kernel.org with ESMTP
	id S1751174AbWEVXSg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 May 2006 19:18:36 -0400
X-Originating-IP: [69.156.138.66]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([69.156.138.66]) by BAYC1-PASMTP11.BAYC1.HOTMAIL.COM over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Mon, 22 May 2006 16:23:27 -0700
Received: from guru.attic.local (guru.attic.local [10.10.10.28])
	by linux1.attic.local (Postfix) with ESMTP id D7F65644C28;
	Mon, 22 May 2006 19:18:34 -0400 (EDT)
To: Junio C Hamano <junkio@cox.net>
Message-Id: <20060522191240.1cb8c93f.seanlkml@sympatico.ca>
In-Reply-To: <7vac99c1hv.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.15; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 22 May 2006 23:23:28.0187 (UTC) FILETIME=[BB25A0B0:01C67DF6]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Mon, 22 May 2006 12:18:04 -0700
Junio C Hamano <junkio@cox.net> wrote:

> Now, about the usage of such a long tag for your purpose.
> 
> As you noticed, commits and tags are the only types of objetcs
> that can refer to other commits structurally.  But there are
> cases where you do not even need nor want structural reference.
> For example, 'git cherry-pick' records the commit object name of
> the cherry-picked commit in the commit message as part of the
> text -- such a commit does not have structural reference to the
> original commit, and we would not _want_ one.  I have a strong
> suspicion that your application does not need or want structural
> reference to commits, and it might be better to merely mention
> their object names as part of the text the application produces,
> just like what 'git cherry-pick' does.

What seems to becoming clear as more people find new ways to use
git is that many of them would be well served by having a solid
infrastructure to handle metadata.  Consider the case above: _git_
itself doesn't need a structural reference, but users and external
applications definitely need to be able to lookup which metadata
is associated with any given commit.  Having a git standard for
this type of data would help.  Tags already do this, so they're
likely to be used and abused in ways not initially envisioned,
just because git doesn't have another such facility.
 
> Presumably you will have one such tag per commit, and by default
> 'fetch' (both cg and git) tries to follow tags, which means
> anybody who fetches new revision would automatically download
> this QA data -- that is one implication of using a tag to store
> this information.  Without knowing the nature of it, I am not
> sure if everybody who tracks the source wants such baggage.  If
> not, then use of a tag for this may not be appropriate.

Right.  It would be much nicer if it was possible to request or
ignore specific types of metadata when fetching; yet another
reason that it would be great if git had something built in
which anticipated this need.
 
> Another question is if the QA data expected to be amended or
> annotated later, after it is created.
> 
> If the answer is yes, then you probably would not want tags --
> you can create a new tag that points at the same commit to
> update the data, but then you have no structural relationships
> given by git between such tags that point at the same commit.
> You could infer their order by timestamp but that is about it.
> I think you are better off creating a separate QA project that
> adds one new file per commit on the main project, and have the
> file identify the commit object on the main project (either
> start your text file format for QA data with the commit object
> name, or name each such QA data file after the commit object
> name).  Then your automated procedure could scan and add a new
> file to the QA project every time a new commit is made to the
> main project, and the data in the QA project can be amended or
> annotated and the changes will be version controlled.

There are a lot of nice features with using a separate meta-data
branch.  However, you lose the ability to do lookups like you can
with tags.  A tag like index that gave the ability to associate
commits on otherwise unrelated branches might be a way to get
the best of both worlds.  However, there will be times where
version controlled meta-data is overkill.  Just need to codify a
git-standard for meta data, so that git can help where possible.
 
> If the answer is no, then it is probably better to just use an
> append-only log file that textually records which entry
> corresponds to which commit in the project.  If it is not
> version controlled, and if it is not part of the main project, I
> do not see much point in putting the data under git control and
> in the same project.

It would be very nice if git gave a standard way to lookup and
perhaps even display metadata.   Could add an option to git log
for example that said, show all metadata of a certain type.

There are a limitless number of examples where people want to
associate extra information with each commit.  Other SCM's call
these "attributes" or have other such names.  Given git's design
it isn't too hard to imagine offering the ability for version 
controlled (or not) and public (or not) meta-data.  Very similar
to tags, but perhaps with a few extra features.

If git already offered this feature, there'd be no need for a
flat-file ref-log; the data could be stored in a git-standard
way for metadata and gain the features of whatever tools grow
up around it, like querying, inspecting, purging etc..  All of
a sudden people would be able to look at (and perhaps even update)
their own meta data via git log/qgit/gitk/gitweb etc..   All we
need is a standard that everyone can conform with.

Sean
