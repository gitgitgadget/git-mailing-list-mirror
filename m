From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: Re: rev-list --parents --full-history + path: something's fishy
Date: Sun, 25 May 2008 14:26:53 +0200
Message-ID: <200805251426.54755.johannes.sixt@telecom.at>
References: <e1dab3980805230808s59798351r9ed702c7d0dedd2a@mail.gmail.com> <1211660214.483877b69a107@webmail.nextra.at> <alpine.LFD.1.10.0805241817500.3081@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, David Tweed <david.tweed@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun May 25 14:27:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K0FKK-0002ef-4m
	for gcvg-git-2@gmane.org; Sun, 25 May 2008 14:27:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757125AbYEYM1A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 May 2008 08:27:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756448AbYEYM1A
	(ORCPT <rfc822;git-outgoing>); Sun, 25 May 2008 08:27:00 -0400
Received: from smtp1.srv.eunet.at ([193.154.160.119]:39157 "EHLO
	smtp1.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755229AbYEYM1A (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 May 2008 08:27:00 -0400
Received: from dx.sixt.local (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp1.srv.eunet.at (Postfix) with ESMTP id 3F0B833BF2;
	Sun, 25 May 2008 14:26:57 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id D423B64872;
	Sun, 25 May 2008 14:26:56 +0200 (CEST)
User-Agent: KMail/1.9.3
In-Reply-To: <alpine.LFD.1.10.0805241817500.3081@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82861>

On Sunday 25 May 2008 03:21, Linus Torvalds wrote:
> On Sat, 24 May 2008, Johannes Sixt wrote:
> > but this does not:
> >
> > $ git rev-list --full-history --parents HEAD -- a
> > M A B
> > B A
> > A
>
> That is the "correct" output.
>
> That's what "--full-history" means: do not simplify merges away when all
> the data comes from just one branch (in this case from "B").
>
> So it shows you commit 'M' because you asked for full-history.
>
> Commit 'M' has parents 'C' and 'B', but since 'C' doesn't actually modify
> the file at all, the regular commit simplification will simplify 'C' away,
> so now that parent 'C' will become 'A'. So 'M' has the _simplified_
> parent's 'A' and 'B'.
>
> Then it shows 'B' (parent 'A') and 'A' (no parent).

The history was this:

   C--M
  /  /
 A--B

Now assume that both B and C change a, but so that it is identical in both B 
and C. I thought that --full-history makes a difference *only* for this case, 
because without --full-history the revision walk would choose either B or C 
(not quite at random, but in an unspecified manner), but not both; but 
with --full-history the revision walk would go both paths.

This makes a difference in git-filter-branch --subdirectory-filter: We do want 
to simplify history to those commits that touch a path, but we don't want to 
simplify away the case outlined in the previous paragraph.

> > Of course, I'd expected to see this:
> >
> > $ git rev-list --full-history --parents HEAD -- a
> > B A
> > A
>
> Why did you ask for --full-history, if you're not interested in merges
> that are irrelevant? To get what you wanted, just do
>
> 	git rev-list --parents HEAD -- a
>
> and it should give you exactly that output.

In the case at hand this would be sufficient, but in git-filter-branch we 
don't want to prune branches whose modifications to a path make the path 
identical.

What shall we do in git-filter-branch --subdirectory-filter?

-- Hannes
