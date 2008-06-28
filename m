From: "David Jeske" <jeske@willowmail.com>
Subject: Re: An alternate model for preparing partial commits
Date: Sat, 28 Jun 2008 19:12:35 -0000
Message-ID: <11818.3912629776$1214680744@news.gmane.org>
References: <9af502e50806281125v5459f7deuc14256044b3e726@mail.gmail.com>
	<willow-jeske-01l7H4tHFEDjCgPV-01l82hwbFEDjCX70>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "Jakub Narebski" <jnareb@gmail.com>,
	"Stephen Sinclair" <radarsat1@gmail.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Robert Anderson" <rwa000@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 28 21:18:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCfwn-0003Bo-2Q
	for gcvg-git-2@gmane.org; Sat, 28 Jun 2008 21:18:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752374AbYF1TSA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Jun 2008 15:18:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752489AbYF1TSA
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Jun 2008 15:18:00 -0400
Received: from w2.willowmail.com ([64.243.175.54]:33387 "HELO
	w2.willowmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750928AbYF1TR7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jun 2008 15:17:59 -0400
Received: (qmail 5794 invoked by uid 90); 28 Jun 2008 19:17:54 -0000
X-Mailer: Willow v0.02
Received: from 67.188.42.104 at Sat, 28 Jun 2008 19:12:35 -0000
In-Reply-To: <9af502e50806281125v5459f7deuc14256044b3e726@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86738>

-- Robert Anderson wrote:
> If I come back to a branch on which there are several
> commits which have not been pushed yet, how do I know which are
> "temporary" and which are "for real" commits?  I cannot.  It is
> impossible.  The information is not there.

This comment resonates with me Robert. Because git's concept of a workspace
is a "non-tracking branch", git doesn't automate having "temporary" and "for
real" commits intermixed in the workspace, or having more than one "named set
of temporary commits".

Imagine if we use git's mechanisms to setup a "p4 change" style workflow. In
that workflow, we can have multiple outstanding named changes in the same
working-files. This seems simple and reasonable to me, I use it quite a bit in
p4. My most common use of it is to prevent myself from accidentally publishing
a set of edited files that are supposed to remain local as I'm iterating (I
throw them in a "don't submit this yet" pending change).

If we dynamically compose a "workspace" out of 2 temporary "changes" it might
look like this:


:        /---PQ    workspace/1
:   |<- Q   /      change/feature1
:   |<---- P       change/feature2
:   |
: --A<--B          master

You're working in workspace 1, and you could pretty easily make the equivilant
of "git commit -c change/feature2". That would say, "hey, commit this change,
and then merge it down to "change/feature2 branch" as R'.

:        /---PQ---R       workspace/1
:   |<- Q   /    /        change/feature1
:   |<---- P<---R'        change/feature2
:   |
: --A<--B          master

This seems doable, and git's mechanisms would make it pretty easy (though it
feels dangerous to me).

You can then merge either change onto the master when it's done. Your little
wrapper could give you a "workspace rebase" which could destroy the workspace,
rebase all the features, and recompose the workspace. If you want to rebase one
of the changes onto the master, again, your wrapper destroys the workspace,
rebases and pushes the change, rebases the rest of the changes, and recreates
your workspace.

All of that "destroying the workspace" is required because rebase is a change
operation which does not contain merge-history. In the setup above, your
"change/*" branches are effectively "published to your workspace", so if you
rebase either of them, you're technically rebasing something that's published,
and "workspace" will be in a world of hurt.  Therefore, one solution is to
destroy the workspace, making the rebase a valid operation, then recompose it.
Personally, I'd like to see rebase made to have merge history, using some kind
of "soft-dag-link" that would cause it to work for anyone who had those
changes, while not causing the history to show or hold onto those parents.
