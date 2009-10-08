From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH JGit 5/5] added tests for the file based info cache
	update and made pass
Date: Thu, 8 Oct 2009 10:12:45 -0700
Message-ID: <20091008171245.GH9261@spearce.org>
References: <1253062116-13830-1-git-send-email-mr.gaffo@gmail.com> <1253062116-13830-2-git-send-email-mr.gaffo@gmail.com> <1253062116-13830-3-git-send-email-mr.gaffo@gmail.com> <1253062116-13830-4-git-send-email-mr.gaffo@gmail.com> <1253062116-13830-5-git-send-email-mr.gaffo@gmail.com> <1253062116-13830-6-git-send-email-mr.gaffo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "mike.gaffney" <mike.gaffney@asolutions.com>
To: mr.gaffo@gmail.com
X-From: git-owner@vger.kernel.org Thu Oct 08 19:21:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mvwg8-0002xh-Pc
	for gcvg-git-2@lo.gmane.org; Thu, 08 Oct 2009 19:21:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932769AbZJHRNX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Oct 2009 13:13:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932750AbZJHRNX
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Oct 2009 13:13:23 -0400
Received: from george.spearce.org ([209.20.77.23]:56402 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932749AbZJHRNW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Oct 2009 13:13:22 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 03804381FF; Thu,  8 Oct 2009 17:12:45 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1253062116-13830-6-git-send-email-mr.gaffo@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129707>

mr.gaffo@gmail.com wrote:
> From: mike.gaffney <mike.gaffney@asolutions.com>
> Subject: Re: [PATCH JGit 5/5] added tests for the file based info cache
>	update and made pass

"and made pass" is the sneaky way of saying "and I actually
implemented what I should have implemented in the prior commit,
but didn't because ..." ?
 
> diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/CachedPacksInfoFileContentsGeneratorTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/CachedPacksInfoFileContentsGeneratorTest.java
> index bea0b70..10ce9e3 100644
> --- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/CachedPacksInfoFileContentsGeneratorTest.java
> +++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/CachedPacksInfoFileContentsGeneratorTest.java
> @@ -63,10 +63,10 @@ public void testGettingPacksContentsMultiplePacks() throws Exception {
>  		packs.add(new PackFile(TEST_IDX, TEST_PACK));
>  		
>  		StringBuilder expected = new StringBuilder();
> -		expected.append("P ").append(TEST_PACK.getName()).append("\n");
> -		expected.append("P ").append(TEST_PACK.getName()).append("\n");
> -		expected.append("P ").append(TEST_PACK.getName()).append("\n");
> -		expected.append("\n");
> +		expected.append("P ").append(TEST_PACK.getName()).append('\n');
> +		expected.append("P ").append(TEST_PACK.getName()).append('\n');
> +		expected.append("P ").append(TEST_PACK.getName()).append('\n');
> +		expected.append('\n');

This should be squashed to the patch that introduced the code,
not be twiddled in something that is completely unrelated to it.
  		
> diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/InfoDirectoryDatabaseTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/InfoDirectoryDatabaseTest.java
> +	public void testUpdateInfoCache() throws Exception {
> +		Collection<Ref> refs = new ArrayList<Ref>();
> +		refs.add(new Ref(Ref.Storage.LOOSE, "refs/heads/master", ObjectId.fromString("32aae7aef7a412d62192f710f2130302997ec883")));
> +		refs.add(new Ref(Ref.Storage.LOOSE, "refs/heads/development", ObjectId.fromString("184063c9b594f8968d61a686b2f6052779551613")));
> +
> +		File expectedFile = new File(testDir, "refs");
> +		assertFalse(expectedFile.exists());
> +		
> +		
> +		final StringWriter expectedString = new StringWriter();
> +		new RefWriter(refs) {
> +			@Override
> +			protected void writeFile(String file, byte[] content) throws IOException {
> +				expectedString.write(new String(content));
> +			}
> +		}.writeInfoRefs();

This feels a bit too much like testing the formatting code by
relying on the formatting code to produce the correct output.

Its a 2 line file with a very well known format that cannot change
without breaking every Git HTTP client out in the wild.  We will
not break those clients anytime in the next few years.  You have
the data hardcoded above *anyway*, hardcode the expected result
here to ensure we formatted it right.

Oh, and IIRC order doesn't matter in the file but I think almost
everyone assumes the order is as per git ls-remote, which matches the
order produced by RefComparator.  Which means you want to assert that
development comes before master, and that tags come before heads.

Also, we need to assert that the peeled information for a tag appears
in the file.  So you need a tag ref with a peeled ObjectId available.

> diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/InfoDirectoryDatabase.java b/org.spearce.jgit/src/org/spearce/jgit/lib/InfoDirectoryDatabase.java
> @@ -51,4 +54,16 @@ public void create() {
>  		info.mkdirs();
>  	}
>  
> +	@Override
> +	public void updateInfoCache(Collection<Ref> refs) throws IOException {
> +		new RefWriter(refs) {
> +			@Override
> +			protected void writeFile(String file, byte[] content) throws IOException {
> +				FileOutputStream fos = new FileOutputStream(new File(info, "refs"));
> +				fos.write(content);
> +				fos.close();

I think you need to use a LockFile to avoid races between readers
and writers.

-- 
Shawn.
