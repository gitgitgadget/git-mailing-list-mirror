From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [EGIT PATCH 05/20] Reverse pack index implementation: PackReverseIndex
Date: Mon, 16 Jun 2008 00:06:36 -0400
Message-ID: <20080616040635.GU11793@spearce.org>
References: <1213566349-25395-1-git-send-email-marek.zawirski@gmail.com> <1213566349-25395-2-git-send-email-marek.zawirski@gmail.com> <1213566349-25395-3-git-send-email-marek.zawirski@gmail.com> <1213566349-25395-4-git-send-email-marek.zawirski@gmail.com> <1213566349-25395-5-git-send-email-marek.zawirski@gmail.com> <1213566349-25395-6-git-send-email-marek.zawirski@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: robin.rosenberg@dewire.com, git@vger.kernel.org
To: Marek Zawirski <marek.zawirski@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 16 06:07:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K860I-000258-8V
	for gcvg-git-2@gmane.org; Mon, 16 Jun 2008 06:07:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750838AbYFPEGl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2008 00:06:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750831AbYFPEGl
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jun 2008 00:06:41 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:35636 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750804AbYFPEGk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2008 00:06:40 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.69)
	(envelope-from <spearce@spearce.org>)
	id 1K85z7-0001O5-MQ; Mon, 16 Jun 2008 00:06:25 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 896A420FBAE; Mon, 16 Jun 2008 00:06:36 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <1213566349-25395-6-git-send-email-marek.zawirski@gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85162>

Marek Zawirski <marek.zawirski@gmail.com> wrote:
> Let us quickly find ObjectId or next object for specified offset in a
> pack, in O(log n) time.
...
> diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/PackReverseIndex.java b/org.spearce.jgit/src/org/spearce/jgit/lib/PackReverseIndex.java
...
> +	/**
> +	 * Object ids corresponding to {@link #offsets32} and {@link #offsets64}.
> +	 */
> +	private final int names[];

This could be smaller if it was an array of indexes into the index,
rather than the ObjectId itself.  Thus we need only 1 int per object
and not 5 ints per object.

But I see why you are doing it; PackIndex.MutableEntry exposes the
ObjectId and not the nth position of the object within the index.

> +	PackReverseIndex(final PackIndex index) {
> +		final long count = index.getObjectCount();
> +		if (count > Integer.MAX_VALUE)
> +			throw new IllegalArgumentException(
> +					"Huge indexes (> 2^31 entries) are not supported by jgit, yet");

For what its worth, this limit is actually:

	Integer.MAX_VALUE / Constants.OBJECT_ID_LENGTH / 4

as you store the entire ObjectId data for the index in a single int[]
array called names.  So you'll get an ArrayIndexOutOfBoundsException
or maybe OutOfMemoryError when you try to build names later on, and
never really hit this case here.

> +	ObjectId findObject(final long offset) {
> +		if (offset <= Integer.MAX_VALUE) {
> +			final int i32 = Arrays.binarySearch(offsets32, (int) offset);
> +			if (i32 < 0)
> +				return null;
> +			final int iNames = i32 * Constants.OBJECT_ID_LENGTH / 4;

This probably should be:

	final int iNames = i32 * (Constants.OBJECT_ID_LENGTH / 4);

as then we don't overflow the precision of int when i32 is large.

> +			return ObjectId.fromRaw(names, iNames);
> +		} else {
> +			final int i64 = Arrays.binarySearch(offsets64, offset);
> +			if (i64 < 0)
> +				return null;
> +			final int iNames = (i64 + offsets32.length)
> +					* Constants.OBJECT_ID_LENGTH / 4;

Again, watch out for overflow.

-- 
Shawn.
