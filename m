From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [EGIT PATCH 4/9] Add a method to listen to changes in any
	repository
Date: Fri, 11 Jul 2008 04:28:22 +0000
Message-ID: <20080711042822.GC32633@spearce.org>
References: <1215729651-26781-1-git-send-email-robin.rosenberg@dewire.com> <1215729651-26781-2-git-send-email-robin.rosenberg@dewire.com> <1215729651-26781-3-git-send-email-robin.rosenberg@dewire.com> <1215729651-26781-4-git-send-email-robin.rosenberg@dewire.com> <1215729651-26781-5-git-send-email-robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Marek Zawirski <marek.zawirski@gmail.com>
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Fri Jul 11 06:29:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHAG4-0000xF-69
	for gcvg-git-2@gmane.org; Fri, 11 Jul 2008 06:29:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751274AbYGKE2Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2008 00:28:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750853AbYGKE2X
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jul 2008 00:28:23 -0400
Received: from george.spearce.org ([209.20.77.23]:47901 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750828AbYGKE2X (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2008 00:28:23 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id E659738222; Fri, 11 Jul 2008 04:28:22 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1215729651-26781-5-git-send-email-robin.rosenberg@dewire.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88079>

Robin Rosenberg <robin.rosenberg@dewire.com> wrote:
> diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
> index 6f78652..dfa3045 100644
> --- a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
> +++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
> @@ -95,6 +95,7 @@ public class Repository {
>  	private GitIndex index;
>  
>  	private List<RepositoryListener> listeners = new Vector<RepositoryListener>(); // thread safe
> +	static private List<RepositoryListener> allListeners = new Vector<RepositoryListener>(); // thread safe
...
>  	void fireRefsMaybeChanged() {
>  		if (refs.lastRefModification != refs.lastNotifiedRefModification) {
>  			refs.lastNotifiedRefModification = refs.lastRefModification;
>  			final RefsChangedEvent event = new RefsChangedEvent(this);
> -			for (final RepositoryListener l :
> -				listeners.toArray(new RepositoryListener[listeners.size()])) {
> +			List<RepositoryListener> all = new ArrayList<RepositoryListener>(
> +					listeners);
> +			all.addAll(allListeners);
> +			for (final RepositoryListener l : all) {
>  				l.refsChanged(event);

I don't think this pattern is thread-safe like you think it is.
Adding (or removing) an allListener while you are trying
to copy the allListener collection for delivery can cause a
ConcurrentModificationException.

The preimage here is not even correct because toArray locks the
vector and will grow the input array if it was too small, but it
nulls out the later entries if the array was too large.  Thus you
can NPE inside of the fire loop.

The only safe way to do this is to lock the collection while you copy
it into an array or list, then later iterate that to do the delivery.

Both of the fire implemenations in this patch have this issue.  :-|

-- 
Shawn.
