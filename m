From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [EGIT PATCH 4/6] Add tags to the graphical history display.
Date: Mon, 6 Oct 2008 01:08:34 -0700
Message-ID: <20081006080834.GC27516@spearce.org>
References: <1223249802-9959-1-git-send-email-robin.rosenberg@dewire.com> <1223249802-9959-2-git-send-email-robin.rosenberg@dewire.com> <1223249802-9959-3-git-send-email-robin.rosenberg@dewire.com> <1223249802-9959-4-git-send-email-robin.rosenberg@dewire.com> <1223249802-9959-5-git-send-email-robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Mon Oct 06 10:09:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KmlA4-0002hj-QZ
	for gcvg-git-2@gmane.org; Mon, 06 Oct 2008 10:09:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751451AbYJFIIh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Oct 2008 04:08:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751432AbYJFIIg
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Oct 2008 04:08:36 -0400
Received: from george.spearce.org ([209.20.77.23]:48446 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751361AbYJFIIf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Oct 2008 04:08:35 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 6BFAB3835F; Mon,  6 Oct 2008 08:08:34 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1223249802-9959-5-git-send-email-robin.rosenberg@dewire.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97572>

FYI, my comments don't fully cover this patch yet.

Robin Rosenberg <robin.rosenberg@dewire.com> wrote:
> diff --git a/org.spearce.jgit/src/org/spearce/jgit/revplot/PlotCommit.java b/org.spearce.jgit/src/org/spearce/jgit/revplot/PlotCommit.java
> index 5a5ef1e..fac89f5 100644
> --- a/org.spearce.jgit/src/org/spearce/jgit/revplot/PlotCommit.java
> +++ b/org.spearce.jgit/src/org/spearce/jgit/revplot/PlotCommit.java
> @@ -58,14 +59,19 @@
>  
>  	PlotCommit[] children;
>  
> +	Ref[] refs;
> +
>  	/**
>  	 * Create a new commit.
>  	 * 
>  	 * @param id
>  	 *            the identity of this commit.
> +	 * @param tags
> +	 *            the tags associated with this commit, null for no tags
>  	 */
> -	protected PlotCommit(final AnyObjectId id) {
> +	protected PlotCommit(final AnyObjectId id, final Ref[] tags) {
>  		super(id);
> +		this.refs = tags;

this.refs isn't final.  There is no reason to be adding it to the
constructor and having this ripple effect all the way up into the
RevWalk class.

Maybe PlotWalk should override next() and only set PlotCommit.refs on
things returned from super.next()?  This way we only do tag lookup
on commits that the filtering rules have said should be shown in
to the application, but the refs should still be inserted prior to
the application seeing the RevCommit.

> @@ -54,6 +66,7 @@
>  	public PlotWalk(final Repository repo) {
>  		super(repo);
>  		super.sort(RevSort.TOPO, true);
> +		reverseRefMap = repo.getAllRefsByPeeledObjectId();

I wonder if this shouldn't be done as part of the StartGenerator
(or something like it but specialized for PlotWalk).  I only say
that because a reused PlotWalk may want to make sure its ref map
is current with the repository its about to walk against.

> +	@Override
> +	protected Ref[] getTags(final AnyObjectId commitId) {
> +		List<Ref> list = reverseRefMap.get(commitId);
> +		Ref[] tags;
> +		if (list == null)
> +			tags = null;
> +		else {
> +			if (list != null && list.size() > 1) {
> +				Collections.sort(list, new Comparator<Ref>() {
> +					public int compare(Ref o1, Ref o2) {
> +						try {
> +							Object obj1 = getRepository().mapObject(o1.getObjectId(), o1.getName());
> +							Object obj2 = getRepository().mapObject(o2.getObjectId(), o2.getName());
> +							long t1 = timeof(obj1);
> +							long t2 = timeof(obj2);
> +							if (t1 > t2)
> +								return -1;
> +							if (t1 < t2)
> +								return 1;
> +							return 0;
> +						} catch (IOException e) {
> +							// ignore
> +							return 0;
> +						}
> +					}
> +					long timeof(Object o) {
> +						if (o instanceof Commit)
> +							return ((Commit)o).getCommitter().getWhen().getTime();
> +						if (o instanceof Tag)
> +							return ((Tag)o).getTagger().getWhen().getTime();
> +						return 0;

You are inside of a PlotWalk, which extends RevWalk, which has very
aggressive caching of RevCommit and RevTag data instances, and very
fast parsers.  Much faster than the legacy Commit and Tag classes.

I think we should use the RevCommit and RevTag classes to handle
sorting here.  RevCommit already has the committer time cached
and stored in an int.  RevCommit probably should learn to do the
same for its "tagger" field.  The tiny extra bloat (1 word) that
adds to a RevTag instance is worth it when we consider implementing
something like this and/or git-describe where sorting tags by their
dates is useful.


> +			tags = list.toArray(new Ref[list.size()]);

I wonder if using a Ref[] here even makes sense given that the data
is stored in a List<Ref>.  I use RevCommit[] inside of RevCommit
generally because the number of entries in the array is 1 or 2 and
the array is smaller than say an ArrayList.

In hindsight those RevCommit[] probably should be a List<RevCommit>
with different list implementations based on the number of parents
needed:

	0 parents:  Collections.emptyList()
	1 parent:   Collections.singletonList()
	2 parents:  some especialized AbstractList subclass
	3 parents:  ArrayList

I think it would actually use less memory per instance, which is
a huge bonus, but we'd pay a downcasting penalty on each access.
HotSpot is supposed to be really good at removing the downcast
penalty from say java.util.List, but I don't if it can beat a typed
array access.

Sorry I got off on a bit of a tangent here.  I'm just trying to
point out that the primary reason I've usd an array before is
probably moot here since the data is already in a List.

> diff --git a/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevWalk.java b/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevWalk.java
> index d7e4c58..41d57c6 100644
> --- a/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevWalk.java
> +++ b/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevWalk.java
> @@ -53,6 +53,7 @@

IMHO this class shouldn't need to be modified.

> @@ -541,7 +542,7 @@ public RevTree lookupTree(final AnyObjectId id) {
>  	public RevCommit lookupCommit(final AnyObjectId id) {
>  		RevCommit c = (RevCommit) objects.get(id);
>  		if (c == null) {
> -			c = createCommit(id);
> +			c = createCommit(id, getTags(id));

This code is performance critical to commit parsing.  Trying to
lookup tags for every commit we evaluate, especially ones that we
will never show in the UI (because they are uninteresting) but that
we still need to parse in order to derive the merge base is just
a huge waste of time.

Same applies for the lookupAny and parseAny methods.

-- 
Shawn.
