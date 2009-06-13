From: Ferry Huberts <ferry.huberts@pelagic.nl>
Subject: Re: [JGIT PATCH 2/2] Allow core.packedGitLimit to exceed "2 g"
Date: Sat, 13 Jun 2009 09:56:10 +0200
Message-ID: <4A335B9A.7080808@pelagic.nl>
References: <1244848986-10526-1-git-send-email-spearce@spearce.org> <1244848986-10526-2-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Jun 13 09:56:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MFO68-0003Jv-IU
	for gcvg-git-2@gmane.org; Sat, 13 Jun 2009 09:56:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752576AbZFMH4M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Jun 2009 03:56:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750997AbZFMH4L
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Jun 2009 03:56:11 -0400
Received: from hupie.xs4all.nl ([82.95.241.251]:58115 "EHLO
	Lighthouse.internal.Hupie.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751146AbZFMH4K (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 13 Jun 2009 03:56:10 -0400
Received: from [192.168.0.51] (unknown [192.168.0.51])
	by Lighthouse.internal.Hupie.com (Postfix) with ESMTP id F0C6958BDF7;
	Sat, 13 Jun 2009 09:56:10 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
In-Reply-To: <1244848986-10526-2-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121485>

Shawn O. Pearce wrote:
> A 64 bit JVM might actually be able to dedicate more than 2 GiB of
> memory to the window cache, and on a busy server, this may be an
> ideal configuration since JGit can't always reliably use mmap.  By
> treating the limit as a long we increase our range to 2^63, which
> is far beyond what any JVM heap would be able to actually support.
> 
> Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
> ---
>  .../src/org/spearce/jgit/lib/WindowCache.java      |   13 +++++++------
>  .../org/spearce/jgit/lib/WindowCacheConfig.java    |    8 ++++----
>  2 files changed, 11 insertions(+), 10 deletions(-)
> 
> diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/WindowCache.java b/org.spearce.jgit/src/org/spearce/jgit/lib/WindowCache.java
> index 0c60853..b6a35ad 100644
> --- a/org.spearce.jgit/src/org/spearce/jgit/lib/WindowCache.java
> +++ b/org.spearce.jgit/src/org/spearce/jgit/lib/WindowCache.java
> @@ -41,6 +41,7 @@
>  import java.io.IOException;
>  import java.lang.ref.ReferenceQueue;
>  import java.util.concurrent.atomic.AtomicInteger;
> +import java.util.concurrent.atomic.AtomicLong;
>  
>  /**
>   * Caches slices of a {@link PackFile} in memory for faster read access.
> @@ -140,7 +141,7 @@ static final void purge(final PackFile pack) {
>  
>  	private final int maxFiles;
>  
> -	private final int maxBytes;
> +	private final long maxBytes;
>  
>  	private final boolean mmap;
>  
> @@ -150,7 +151,7 @@ static final void purge(final PackFile pack) {
>  
>  	private final AtomicInteger openFiles;
>  
> -	private final AtomicInteger openBytes;
> +	private final AtomicLong openBytes;
>  
>  	private WindowCache(final WindowCacheConfig cfg) {
>  		super(tableSize(cfg), lockCount(cfg));
> @@ -161,7 +162,7 @@ private WindowCache(final WindowCacheConfig cfg) {
>  		windowSize = 1 << windowSizeShift;
>  
>  		openFiles = new AtomicInteger();
> -		openBytes = new AtomicInteger();
> +		openBytes = new AtomicLong();
>  
>  		if (maxFiles < 1)
>  			throw new IllegalArgumentException("Open files must be >= 1");
> @@ -173,7 +174,7 @@ int getOpenFiles() {
>  		return openFiles.get();
>  	}
>  
> -	int getOpenBytes() {
> +	long getOpenBytes() {
>  		return openBytes.get();
>  	}
>  
> @@ -233,12 +234,12 @@ private long toStart(final long offset) {
>  
>  	private static int tableSize(final WindowCacheConfig cfg) {
>  		final int wsz = cfg.getPackedGitWindowSize();
> -		final int limit = cfg.getPackedGitLimit();
> +		final long limit = cfg.getPackedGitLimit();
>  		if (wsz <= 0)
>  			throw new IllegalArgumentException("Invalid window size");
>  		if (limit < wsz)
>  			throw new IllegalArgumentException("Window size must be < limit");
> -		return 5 * (limit / wsz) / 2;
> +		return (int) Math.min(5 * (limit / wsz) / 2, 2000000000);

Math.min returns a long because the prototype Math.min(long,long) will
be chosen. The cast can then overflow and fail. Better change the return
type to a long:
+ return Math.min(5 * (limit / wsz) / 2, 2000000000L);

>  	}
>  
>  	private static int lockCount(final WindowCacheConfig cfg) {
> diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/WindowCacheConfig.java b/org.spearce.jgit/src/org/spearce/jgit/lib/WindowCacheConfig.java
> index ea28164..97edd3a 100644
> --- a/org.spearce.jgit/src/org/spearce/jgit/lib/WindowCacheConfig.java
> +++ b/org.spearce.jgit/src/org/spearce/jgit/lib/WindowCacheConfig.java
> @@ -47,7 +47,7 @@
>  
>  	private int packedGitOpenFiles;
>  
> -	private int packedGitLimit;
> +	private long packedGitLimit;
>  
>  	private int packedGitWindowSize;
>  
> @@ -85,7 +85,7 @@ public void setPackedGitOpenFiles(final int fdLimit) {
>  	 * @return maximum number bytes of heap memory to dedicate to caching pack
>  	 *         file data. <b>Default is 10 MB.</b>
>  	 */
> -	public int getPackedGitLimit() {
> +	public long getPackedGitLimit() {
>  		return packedGitLimit;
>  	}
>  
> @@ -94,7 +94,7 @@ public int getPackedGitLimit() {
>  	 *            maximum number bytes of heap memory to dedicate to caching
>  	 *            pack file data.
>  	 */
> -	public void setPackedGitLimit(final int newLimit) {
> +	public void setPackedGitLimit(final long newLimit) {
>  		packedGitLimit = newLimit;
>  	}
>  
> @@ -162,7 +162,7 @@ public void setDeltaBaseCacheLimit(final int newLimit) {
>  	 */
>  	public void fromConfig(final RepositoryConfig rc) {
>  		setPackedGitOpenFiles(rc.getInt("core", null, "packedgitopenfiles", getPackedGitOpenFiles()));
> -		setPackedGitLimit(rc.getInt("core", null, "packedgitlimit", getPackedGitLimit()));
> +		setPackedGitLimit(rc.getLong("core", null, "packedgitlimit", getPackedGitLimit()));
>  		setPackedGitWindowSize(rc.getInt("core", null, "packedgitwindowsize", getPackedGitWindowSize()));
>  		setPackedGitMMAP(rc.getBoolean("core", null, "packedgitmmap", isPackedGitMMAP()));
>  		setDeltaBaseCacheLimit(rc.getInt("core", null, "deltabasecachelimit", getDeltaBaseCacheLimit()));
