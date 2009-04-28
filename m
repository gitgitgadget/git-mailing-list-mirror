From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [JGIT RFC PATCH 2/2] Rewrite WindowCache to be easier to follow and maintain
Date: Wed, 29 Apr 2009 01:19:59 +0200
Message-ID: <200904290120.00039.robin.rosenberg.lists@dewire.com>
References: <1240885572-1755-1-git-send-email-spearce@spearce.org> <1240885572-1755-2-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Apr 29 01:20:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lywb1-0003GI-VO
	for gcvg-git-2@gmane.org; Wed, 29 Apr 2009 01:20:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755050AbZD1XUH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Apr 2009 19:20:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752308AbZD1XUG
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Apr 2009 19:20:06 -0400
Received: from mail.dewire.com ([83.140.172.130]:16739 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753988AbZD1XUF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Apr 2009 19:20:05 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 2763910233FA;
	Wed, 29 Apr 2009 01:20:04 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 63jZIN6ciw8e; Wed, 29 Apr 2009 01:20:02 +0200 (CEST)
Received: from sleipner.localnet (unknown [10.9.0.8])
	by dewire.com (Postfix) with ESMTP id B430510233F2;
	Wed, 29 Apr 2009 01:20:02 +0200 (CEST)
User-Agent: KMail/1.11.2 (Linux/2.6.28-11-generic; KDE/4.2.2; i686; ; )
In-Reply-To: <1240885572-1755-2-git-send-email-spearce@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117835>

tisdag 28 april 2009 04:26:12 skrev "Shawn O. Pearce" <spearce@spearce.org>:
> To keep the code simple a WindowCache.reconfigure() now discards the
> entire current cache, and creates a new one.  That invalidates every
> open file, and every open ByteWindow, and forces them to load again.
> 
> reconfigure is no longer a thread safe operation, as there is no easy
> way to lock out other threads while the cache change is taking place.
> I don't think cache reconfigurations occur frequently enough in
> application code that we can justify the additional overhead required
> by a multi-reader/single-writer lock around every cache access.
> Instead, the Javadoc is updated to warn application authors against
> changing this on the fly.

As for non-thread-safe reconfigure, we have to solve it somehow since
I'd expect to be able to reconfigure the cache in Eclipse. Forcing a restart might
be an ok workaround for that particular case. Could one somehow, thread safely, 
let the old cache live on until no-one uses it and the GC takes care of it, and 
redirect new accesses to the new cache.

> diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/ByteArrayWindow.java b/org.spearce.jgit/src/org/spearce/jgit/lib/ByteArrayWindow.java
> index 5dc3d28..6b96b10 100644
> --- a/org.spearce.jgit/src/org/spearce/jgit/lib/ByteArrayWindow.java
> +++ b/org.spearce.jgit/src/org/spearce/jgit/lib/ByteArrayWindow.java
...
> @@ -86,7 +74,8 @@ int inflate(final byte[] array, final int pos, final byte[] b, int o,
>  		return o;
>  	}
>  
> -	void inflateVerify(final byte[] array, final int pos, final Inflater inf)
> +	@Override
> +	protected void inflateVerify(final int pos, final Inflater inf)
>  			throws DataFormatException {
>  		while (!inf.finished()) {
>  			if (inf.needsInput()) {
> @@ -98,26 +87,4 @@ void inflateVerify(final byte[] array, final int pos, final Inflater inf)
>  		while (!inf.finished() && !inf.needsInput())
>  			inf.inflate(verifyGarbageBuffer, 0, verifyGarbageBuffer.length);
>  	}

Not related to this patche really, but the static buffer makes a but nervous,
I don't think your test massaged  that part since it did not enable memory mapping.

> diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/OffsetCache.java b/org.spearce.jgit/src/org/spearce/jgit/lib/OffsetCache.java
> +	OffsetCache(final int tSize, final int lockCount) {
...
> +		int eb = (int) (tableSize * .1);
> +		if (64 < eb)
> +			eb = 64;
> +		else if (eb < 4)
> +			eb = 4;
			^no coverage in unit testt
> +		if (tableSize < eb)
> +			eb = tableSize;
			^no coverage in unit testt
> +		evictBatch = eb;
> +	}
> +
...
> +	V getOrLoad(final PackFile pack, final long position) throws IOException {
> +		final int slot = slot(pack, position);
> +		final Entry<V> e1 = table.get(slot);
> +		V v = scan(e1, pack, position);
> +		if (v != null)
> +			return v;
> +
> +		synchronized (lock(pack, position)) {
> +			Entry<V> e2 = table.get(slot);
> +			if (e2 != e1) {
-- this block not coverred
> +				v = scan(e2, pack, position);
> +				if (v != null)
> +					return v;
> +			}
> +
> +			v = load(pack, position);
> +			final Ref<V> ref = createRef(pack, position, v);
> +			hit(ref);
> +			for (;;) {
> +				final Entry<V> n = new Entry<V>(clean(e2), ref);
> +				if (table.compareAndSet(slot, e2, n))
> +					break;
> +				e2 = table.get(slot);
--       ^not covered
> +			}
> +		}
> +
> +		if (evictLock.tryLock()) {
> +			try {
> +				gc();
> +				evict();
> +			} finally {
> +				evictLock.unlock();
> +			}
> +		}
> +
> +		return v;
> +	}
> +
> +	private V scan(Entry<V> n, final PackFile pack, final long position) {
> +		for (; n != null; n = n.next) {
> +			final Ref<V> r = n.ref;
> +			if (r.pack == pack && r.position == position) {
> +				final V v = r.get();
> +				if (v != null) {
> +					hit(r);
> +					return v;
> +				}
> +				n.dead = true;
> +				break;
	these two lines not covered^
...
> +	private void evict() {
> +		final int start = rng.nextInt(tableSize);
> +		int ptr = start;
> +		while (isFull()) {
	The whole body of the loop not covered. It could be that RepositoryTestCase should
	set a very low limit on some parameters, such as maximum number of opened files.
...
> +	void removeAll(final PackFile pack) {
> +		for (int s = 0; s < tableSize; s++) {
> +			final Entry<V> e1 = table.get(s);
> +			boolean hasDead = false;
> +			for (Entry<V> e = e1; e != null; e = e.next) {
> +				if (e.ref.pack == pack) {
> +					e.kill();
> +					hasDead = true;
> +				} else if (e.dead)
> +					hasDead = true;
	uncovered statement ^
> +			}
> +			if (hasDead)
> +				table.compareAndSet(s, e1, clean(e1));
> +		}
> +		gc();
> +	}

> +	@SuppressWarnings("unchecked")
> +	private void gc() {
> +		R r;
> +		while ((r = (R) queue.poll()) != null) {
> +			// Sun's Java 5 and 6 implementation have a bug where a Reference
> +			// can be enqueued and dequeued twice on the same reference queue
> +			// due to a race condition within ReferenceQueue.enqueue(Reference).

Reference to the official Sun bug? Might help if someone wants to implement
a flag to avoid this (if necessary...)

> +	protected int hash(final int packHash, final long position) {
> +		return (packHash + (int) (position >>> 4)) >>> 1;
> +	}
Since we never use the baselass this one isn't covered... ok anyway I think.

> +	private static <V> Entry<V> clean(Entry<V> top) {
> +		while (top != null && top.dead) {
> +			top.ref.enqueue();
> +			top = top.next;
> +		}
> +		if (top == null)
> +			return null;
> +		final Entry<V> n = clean(top.next);
> +		return n == top.next ? top : new Entry<V>(n, top.ref);
		two last lines uncovered.

> +		final synchronized boolean canClear() {
> +			if (cleared)
> +				return false;
	uncovered return ^

This is a huge patch... I might comment on more later. As you may see, I think we need to lessen 
our dependence on faith based testing. (The MoveDeleteHook doesn't work
well either and it depends on code not covererd in unit tests at all, though
I'm not sure that will reveal the problem yet).

-- robin
