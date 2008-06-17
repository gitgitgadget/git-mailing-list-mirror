From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [egit-jgit] excluded patterns are decorated as being untracked
Date: Tue, 17 Jun 2008 23:16:46 +0200
Message-ID: <200806172316.46416.robin.rosenberg.lists@dewire.com>
References: <4857E9A0.7070408@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Florian Koeberle <florianskarten@web.de>,
	Marek Zawirski <marek.zawirski@gmail.com>
To: Galder Zamarreno <galder.zamarreno@redhat.com>
X-From: git-owner@vger.kernel.org Tue Jun 17 23:21:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8icD-0006Qn-SE
	for gcvg-git-2@gmane.org; Tue, 17 Jun 2008 23:21:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755514AbYFQVU1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2008 17:20:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755281AbYFQVU1
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jun 2008 17:20:27 -0400
Received: from av12-1-sn2.hy.skanova.net ([81.228.8.185]:58705 "EHLO
	av12-1-sn2.hy.skanova.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755012AbYFQVU0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Jun 2008 17:20:26 -0400
Received: by av12-1-sn2.hy.skanova.net (Postfix, from userid 502)
	id 1EDE1382FB; Tue, 17 Jun 2008 23:20:24 +0200 (CEST)
Received: from smtp4-1-sn2.hy.skanova.net (smtp4-1-sn2.hy.skanova.net [81.228.8.92])
	by av12-1-sn2.hy.skanova.net (Postfix) with ESMTP
	id F034D38260; Tue, 17 Jun 2008 23:20:23 +0200 (CEST)
Received: from [10.3.4.244] (h250n1fls32o811.telia.com [213.67.100.250])
	by smtp4-1-sn2.hy.skanova.net (Postfix) with ESMTP id 9A85337E48;
	Tue, 17 Jun 2008 23:20:23 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <4857E9A0.7070408@redhat.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85322>

tisdagen den 17 juni 2008 18.43.12 skrev Galder Zamarreno:
> Hi,
> 
> I've been using egit for a few weeks and firstly, I'd like to thank the 
> people involved in the project for the work done so far.
> 
> There's one thing that has been bugging me about egit though which is 
> related to the decoration of untracked files. Egit/JGit does not seem to 
> pay attention to .git/info/exclude that I have configured so that 
> anything under output folder is excluded.
This is a correct observation. It is a missing feature so far.

> Egit/JGit does seem to have decorations working fine for patterns 
> specified in "Team/Ignored Resources" but it only applies it to files 
> not folders, hence, adding "output" as pattern does not work and 
I haven't noticed, but looking at the code its seems some we should
use Team.isIgnoredHint instead of what we do now (which only
take a file as an argument). Patch below. The reason I haven't noticed
is that I have only depended on Eclipse marking of resources as "derived"
which worked. (You can mark resources as derived youself in the properties
of that resource, and Egit will ignore it).

> instead, I have to specify any pattern that would match a file within 
> the output folder which is not practical. Folders are taken into account 
> as ignored resources in subeclipse (subversion eclipse plugin)
> 
> I can see two ways of implementing this that I'm happy to have a look 
> into but I wanted to get some advice from the experts of egit/jgit to 
> indicate which would be the preferred solution going forward.
> 
> 1.- Implement .git/info/exclude functionality in egit/jgit
We need that. Florian came up with a set of patches that should be
usable for this. I haven't applied them to the tree yet.

> 2.- Improve the decoration handling in jgit/egit so that it can check 
> whether the file is under a pattern that should be excluded. I tried to 
> implement this but requires using API that eclipse considers internal.
> 
> What do people think? Should I bother with 2 or is it better to 
> implement decorations for patterns in .git/info/exclude correctly?

The decoration should not ignore anything except what the resource filters
(affecting visibility) dictates. If a resource is tracked it should be shown unless
visibility is prevented by a resource filter or other view specific mechanism.
When we track (add) resources recursively we should honor the git ignore
patterns, but only for add. Everywhere else we do not just ignore resources
that match an ignore pattern.

Btw, Here is an attempt to match folders by Team ignore patterns too.

(OT: I did not format the code. (please try, and you'll see why). We'll have
to come up with something better than an 80-column format, it's so seventies)

-- robin

>From 42eadb50b9b87e5324f941ce2d2371e07577f55a Mon Sep 17 00:00:00 2001
From: Robin Rosenberg <robin.rosenberg@dewire.com>
Date: Tue, 17 Jun 2008 22:48:52 +0200
Subject: [PATCH] Apply Team/Ignore settings to folders too when tracking new resources

We used to only care for file resources. Now folders, and their content,
are ignored if the folder name matches a pattern marked as ignored
in the Team settings.


Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../org/spearce/egit/core/op/TrackOperation.java   |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/op/TrackOperation.java b/org.spearce.egit.core/src/org/spearce/egit/core/op/TrackOperation.java
index 6521f1c..af16cdb 100644
--- a/org.spearce.egit.core/src/org/spearce/egit/core/op/TrackOperation.java
+++ b/org.spearce.egit.core/src/org/spearce/egit/core/op/TrackOperation.java
@@ -90,13 +90,20 @@ public class TrackOperation implements IWorkspaceRunnable {
 							public boolean visit(IResource resource) throws CoreException {
 								try {
 									String repoPath = rm.getRepoRelativePath(resource);
+									// We use add to reset the assume valid bit, so we check the bit
+									// first. If a resource within a ignored folder is marked
+									// we ignore it here, i.e. there is no way to unmark it expect
+									// by explicitly selecting and invoking track on it.
 									if (resource.getType() == IResource.FILE) {
 										Entry entry = index.getEntry(repoPath);
-										if (!Team.isIgnored((IFile)resource) || entry != null && entry.isAssumedValid()) {
+										if (!Team.isIgnoredHint(resource) || entry != null && entry.isAssumedValid()) {
 											entry = index.add(rm.getWorkDir(), new File(rm.getWorkDir(), repoPath));
 											entry.setAssumeValid(false);
 										}
 									}
+									if (Team.isIgnoredHint(resource))
+										return false;
+
 								} catch (IOException e) {
 									e.printStackTrace();
 									throw Activator.error(CoreText.AddOperation_failed, e);
-- 
1.5.5.1.178.g1f811
