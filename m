From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [EGIT PATCH 2/2] Provide the ability to configure the
	quickdiff baseline
Date: Fri, 11 Jul 2008 05:00:35 +0000
Message-ID: <20080711050035.GE32633@spearce.org>
References: <1215729672-26906-1-git-send-email-robin.rosenberg@dewire.com> <1215729672-26906-2-git-send-email-robin.rosenberg@dewire.com> <1215729672-26906-3-git-send-email-robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Marek Zawirski <marek.zawirski@gmail.com>
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Fri Jul 11 07:02:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHAly-0007A9-1P
	for gcvg-git-2@gmane.org; Fri, 11 Jul 2008 07:02:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751803AbYGKFAg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2008 01:00:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751759AbYGKFAg
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jul 2008 01:00:36 -0400
Received: from george.spearce.org ([209.20.77.23]:35992 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751251AbYGKFAf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2008 01:00:35 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 706EF38222; Fri, 11 Jul 2008 05:00:35 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1215729672-26906-3-git-send-email-robin.rosenberg@dewire.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88081>

Robin Rosenberg <robin.rosenberg@dewire.com> wrote:
> +		TreeEntry blobEnry = repository.mapTree(baseline).findBlobMember(gitPath);
> +		if (blobEnry != null) {
> +			Activator.trace("(GitQuickDiffProvider) compareTo: " + baseline);
> +			ObjectLoader loader = repository.openBlob(blobEnry.getId());

For what it is worth, it is probably faster to use TreeWalk:

	final TreeWalk tw = TreeWalk.forPath(
		repository,
		gitPath,
		new ObjectId[]{ repository.resolve(baseline + "^{tree}") });
	if (tw != null) {
		Activator.trace("(GitQuickDiffProvider) compareTo: " + baseline);
		ObjectLoader loader = repository.openBlob(tw.getObjectId(0));

I probably should teach TreeWalk how to do the ^{tree} on its own
so it can just take a tree-ish here, but you still had to invoke
resolve to go from String to ObjectId so its not major problem.

The reason TreeWalk is faster is we spend less time parsing the
entries, and we avoid entries which are after the path we need to
walk down.  E.g. if the subtree we need to enter into is in the
middle of the parent tree TreeWalk won't even touch the remainder
of the parent tree records.  Tree/TreeEntry still does.

-- 
Shawn.
