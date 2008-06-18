From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [egit-jgit] excluded patterns are decorated as being untracked
Date: Wed, 18 Jun 2008 00:39:31 -0400
Message-ID: <20080618043931.GC11793@spearce.org>
References: <4857E9A0.7070408@redhat.com> <200806172316.46416.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Galder Zamarreno <galder.zamarreno@redhat.com>,
	git@vger.kernel.org, Florian Koeberle <florianskarten@web.de>,
	Marek Zawirski <marek.zawirski@gmail.com>
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Wed Jun 18 06:40:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8pTF-0002nH-Gc
	for gcvg-git-2@gmane.org; Wed, 18 Jun 2008 06:40:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752385AbYFREji (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2008 00:39:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752513AbYFREji
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jun 2008 00:39:38 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:35938 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752353AbYFREjh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jun 2008 00:39:37 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.69)
	(envelope-from <spearce@spearce.org>)
	id 1K8pSI-0006pI-13; Wed, 18 Jun 2008 00:39:34 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id E1CB120FBAE; Wed, 18 Jun 2008 00:39:31 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <200806172316.46416.robin.rosenberg.lists@dewire.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85361>

Robin Rosenberg <robin.rosenberg.lists@dewire.com> wrote:
> Btw, Here is an attempt to match folders by Team ignore patterns too.
> 
> (OT: I did not format the code. (please try, and you'll see why). We'll have
> to come up with something better than an 80-column format, it's so seventies)

Ignoring the patch for a second, I'm a die-hard 80 column format
person.  You can pry my 80 column wide terminals from me long after
I'm dead.

In Java it may seem like an 80 column limit is a problem, because
the code often gets nested deep and far to the right, such as in
this example here.  I find that just like in C, when code is this
far indented to the right in Java its too damn complex as-is and
should be refactored into smaller methods, and anonymous types
should perhaps be converted to named inner classes or top-level
classes of their own right.

My laptop display panel is only 1440 pixels wide.  By the time I
get my Eclipse workbench open I have about 90 characters wide for
the editor page, given how I place the other views and non-Eclipse
applications around the edges.  Pushing much beyond 80 characters
wide makes it very hard to read code quickly.

And no, I do not want to tote a laptop with a display that is 9000
pixels wide, thanks.

So IMHO, code in jgit+egit should try to target 80 characters wide
as much as possible.  If you can't hit that you need to rethink how
you have the code structured.  I've never refactored something into
smaller more modular methods (to hit the 80 target) and said "gee,
that refactoring made my code harder to understand, what with those
highly descriptive method names and javadoc I gave everything".

OK, now you can call me crazy.
 
> diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/op/TrackOperation.java b/org.spearce.egit.core/src/org/spearce/egit/core/op/TrackOperation.java
> index 6521f1c..af16cdb 100644
> --- a/org.spearce.egit.core/src/org/spearce/egit/core/op/TrackOperation.java
> +++ b/org.spearce.egit.core/src/org/spearce/egit/core/op/TrackOperation.java
> @@ -90,13 +90,20 @@ public class TrackOperation implements IWorkspaceRunnable {
>  							public boolean visit(IResource resource) throws CoreException {
>  								try {
>  									String repoPath = rm.getRepoRelativePath(resource);
> +									// We use add to reset the assume valid bit, so we check the bit
> +									// first. If a resource within a ignored folder is marked
> +									// we ignore it here, i.e. there is no way to unmark it expect
> +									// by explicitly selecting and invoking track on it.
>  									if (resource.getType() == IResource.FILE) {
>  										Entry entry = index.getEntry(repoPath);
> -										if (!Team.isIgnored((IFile)resource) || entry != null && entry.isAssumedValid()) {
> +										if (!Team.isIgnoredHint(resource) || entry != null && entry.isAssumedValid()) {
>  											entry = index.add(rm.getWorkDir(), new File(rm.getWorkDir(), repoPath));
>  											entry.setAssumeValid(false);
>  										}
>  									}
> +									if (Team.isIgnoredHint(resource))
> +										return false;
> +
>  								} catch (IOException e) {
>  									e.printStackTrace();
>  									throw Activator.error(CoreText.AddOperation_failed, e);

-- 
Shawn.
