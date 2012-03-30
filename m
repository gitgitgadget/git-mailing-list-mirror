From: Seth Robertson <in-gitvger@baka.org>
Subject: Re: Maintaining historical data in a git repo
Date: Fri, 30 Mar 2012 11:10:52 -0400
Message-ID: <201203301510.q2UFAqn6003864@no.baka.org>
References: <CA+P+rLeyEcZPudhLWavB74CiDAqpn+iNkk4F8=NK_yGaJPMmyA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: Yuval Adam <yuv.adm@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 30 17:11:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDdTy-0002Wj-VB
	for gcvg-git-2@plane.gmane.org; Fri, 30 Mar 2012 17:11:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751559Ab2C3PK6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Mar 2012 11:10:58 -0400
Received: from tsutomu.baka.org ([66.114.72.182]:59967 "EHLO tsutomu.baka.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751083Ab2C3PK4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Mar 2012 11:10:56 -0400
Received: from no.baka.org (no.baka.org [IPv6:2001:470:88bb::2])
	by tsutomu.baka.org (8.14.4/8.14.4) with ESMTP id q2UFArQM017833
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 30 Mar 2012 11:10:53 -0400
Received: from no.baka.org (localhost [127.0.0.1])
	by no.baka.org (8.14.4/8.14.0) with ESMTP id q2UFAqn6003864;
	Fri, 30 Mar 2012 11:10:53 -0400
In-reply-to: <CA+P+rLeyEcZPudhLWavB74CiDAqpn+iNkk4F8=NK_yGaJPMmyA@mail.gmail.com>
Comments: In reply to a message from "Yuval Adam <yuv.adm@gmail.com>" dated "Fri, 30 Mar 2012 16:34:08 +0300."
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194364>


In message <CA+P+rLeyEcZPudhLWavB74CiDAqpn+iNkk4F8=NK_yGaJPMmyA@mail.gmail.com>, Yuval Adam writes:

    As part of a public project to open-source the Israeli law code, we
    are looking into ways of represent such data in a git repository.

This is extremely cool.  I wish others were forward thinking enough
to do this.

    The main challenge is to represent historical data _in a semantically
    correct way_ within a git repository, while having the ability to
    change data that has occurred in the past.

Revision control shouldn't be used to change the past (even if git
allows this with sufficient amounts of pain/warning to all users).
What it is extremely good at is preserving the past and tracking the
changes that are made.

    For example, we might have revisions B and C of a certain legal
    document, commit to repo, and at a later time want to add revision A
    to the proper place in the git commit tree (probably with rebasing or
    replacing).

There is no problem doing this.  I'll make up a mythical workflow
which might be realistic.  Someone proposes a bill, so a branch for
the proposal is created.  In many of the laws I am familiar with,
there is the text of the law and then the text says "Amend V.5.12.A.b
to add '25: or to commit a nasal offense (as defined in V.5.12.A) with
a shoe'".  So the branch might contain the text of the proposed law
and then actually go through to the document V.5.12.A.b and add the
new data to the appropriate file (in an ideal world that might be an
automatic process, but laws are rarely so precise).  The proposed law
changes and the bill text changes would be committed onto the branch.

As the bill goes through committee people make changes, adding things,
removing things, etc.  Each change is a commit.  One example change
might be a new change saying "remove the change made 2 days ago" or
"make the current version the version from 10 days ago".  Both of
those specific changes would ideally be positive changes.  You would
not actually be deleting the change made two days ago or removing all
changes made between 10 days ago and now, you would be making a new
commit to remove the effects of the unwanted changes.

When the negotiations are over and assuming the bill gets all three
readings (each reading could be a "tag" to document exactly what was
read) and voted into a law, you would then merge the bill branch into
the "law" branch which represents the actual legally active laws.
This could be done as a "squash" merge which hides all of the
committee negotiations or it could be done as a normal merge which
allows the history of the negotiations to be visible, or, depending on
the visibility of the committee negotiations, you could even do a
combination of the two.

And yes, git supports more complex processes automatically, like each
Knesset member making their own proposed changes and the committee
chair merging the appropriate version in if it was approved and the
others being either discarded or archived for history but not
incorporated.

    Allowing decentralization and updates is a major requirement.

git is extremely good at this.

    We're trying to map out the various pros and cons of the different
    options of maintaining such a repo.

Ideally the data being represented would be structured, textual, and
somewhat line oriented, plain text/UTF-8 files (no matter the word
direction) like this email are ideal.  Committing binary Office
documents (Word, OpenXML, ODF, etc) is not ideal, since under most
circumstances/without a lot of work you are not going to get good
differences so that you can easily see the history of the law.  You
can write custom binary drivers to extract this difference information
from these binary documents, but that is the "lot of work" I was
talking about.

You additionally might want to have separate repositories for separate
groups of laws to prevent repositories from getting unwieldy.  There
are tools which let you group repositories together.

    Has anyone ever attempted something like this?

Many people use git to track living documents.  Perhaps not law per
se, but I don't particularly see why that would matter.

    Are there any projects that build on the git plumbing which provide
    wrapper APIs to handle historic data?

Are you talking about "get rid of that change, it was bad" and
"restore this version of the document as the good one" or "how do I
import 64 years of law into git"?  Git provides native tools to handle
both.

    We really could use any reference or advice we can get on this subject.

I'll point you at http://progit.org/book/ as a general reference about
git and http://sethrobertson.github.com/GitBestPractices/ as a
reference about best practices.

					-Seth Robertson
