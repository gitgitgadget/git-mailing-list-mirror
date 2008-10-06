From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [EGIT PATCH 3/6] Add a method to get refs by object Id
Date: Mon, 6 Oct 2008 01:15:54 -0700
Message-ID: <20081006081554.GD27516@spearce.org>
References: <1223249802-9959-1-git-send-email-robin.rosenberg@dewire.com> <1223249802-9959-2-git-send-email-robin.rosenberg@dewire.com> <1223249802-9959-3-git-send-email-robin.rosenberg@dewire.com> <1223249802-9959-4-git-send-email-robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Mon Oct 06 10:17:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KmlH8-00052L-Bj
	for gcvg-git-2@gmane.org; Mon, 06 Oct 2008 10:17:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751745AbYJFIP4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Oct 2008 04:15:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751512AbYJFIPz
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Oct 2008 04:15:55 -0400
Received: from george.spearce.org ([209.20.77.23]:55519 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751203AbYJFIPz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Oct 2008 04:15:55 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 87E3C3835F; Mon,  6 Oct 2008 08:15:54 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1223249802-9959-4-git-send-email-robin.rosenberg@dewire.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97573>

Robin Rosenberg <robin.rosenberg@dewire.com> wrote:
> diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
> index dfce1b8..3fc5236 100644
> --- a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
> +++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
> @@ -939,6 +940,33 @@ public String getBranch() throws IOException {
>  	}
>  
>  	/**
> +	 * @return a map with all objects referenced by a peeled ref.
> +	 */
> +	public Map<AnyObjectId, List<Ref>> getAllRefsByPeeledObjectId() {

Do we really want to promise List here?  Can we make it just
Collection instead?

> +		Map<String, Ref> allRefs = getAllRefs();
> +		HashMap<AnyObjectId, List<Ref>> ret = new HashMap<AnyObjectId, List<Ref>>(allRefs.size());
> +		for (Map.Entry<String,Ref> e : allRefs.entrySet()) {
> +			Ref ref = e.getValue();

I think this is cleaner:

	for (Ref ref : allRefs.values()) {

as you never use the key.

> +			AnyObjectId target = ref.getPeeledObjectId();
> +			if (target == null)
> +				target = ref.getObjectId();
> +			List<Ref> list = ret.get(target);
> +			if (list == null) {
> +				list = Collections.singletonList(ref);
> +			} else {
> +				if (list.size() == 1) {
> +					ArrayList<Ref> list2 = new ArrayList<Ref>(2);
> +					list2.add(list.get(0));
> +					list = list2;
> +				}
> +				list.add(ref);
> +			}
> +			ret.put(target, list);

Hmm.  Putting the list every time is pointless.  This is may run
faster because we (on average) only do one hash lookup per target,
not 2:

	List<Ref> nl = Collections.singletonList(ref);
	List<Ref> ol = ret.put(target, nl);
	if (ol != null) {
		if (ol.size() == 1) {
			nl = new ArrayList<Ref>(2);
			nl.add(ol.get(0));
			nl.add(ref);
			ret.put(target, nl);
		} else {
			ol.add(ref)
			ret.put(target, ol);
		}
	}

The trick is that most targets have exactly one Ref, so the first
ret.put will return null and we'll never worry about the expansion
cases.  In the rare cases where more than one Ref points at the
same object we'll degrade into doing two hash lookups per target,
which is no worse than what you have right now.

-- 
Shawn.
