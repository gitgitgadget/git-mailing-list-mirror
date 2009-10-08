From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH JGit 3/5] Implemented directory based info cache for
	objects/info/packs.
Date: Thu, 8 Oct 2009 10:00:19 -0700
Message-ID: <20091008170019.GF9261@spearce.org>
References: <1253062116-13830-1-git-send-email-mr.gaffo@gmail.com> <1253062116-13830-2-git-send-email-mr.gaffo@gmail.com> <1253062116-13830-3-git-send-email-mr.gaffo@gmail.com> <1253062116-13830-4-git-send-email-mr.gaffo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: mr.gaffo@gmail.com
X-From: git-owner@vger.kernel.org Thu Oct 08 19:05:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MvwQO-0002bc-E4
	for gcvg-git-2@lo.gmane.org; Thu, 08 Oct 2009 19:05:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932611AbZJHRA5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Oct 2009 13:00:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932538AbZJHRA5
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Oct 2009 13:00:57 -0400
Received: from george.spearce.org ([209.20.77.23]:51545 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932282AbZJHRA4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Oct 2009 13:00:56 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 9B9BD381FE; Thu,  8 Oct 2009 17:00:19 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1253062116-13830-4-git-send-email-mr.gaffo@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129703>

mr.gaffo@gmail.com wrote:
> Add abstract method for updating the object db's info cache to directory.
> 
> Implemented passthrough on Alternate for the update of infocache.
> 
> Added utility that generates the contents of the objects/info/packs
> file as a string from a list of PackFiles.
> 
> Added implementation from ObjectDirectory on down
> for creating the info cache.
> 
> Added test for creating the info cache

Reading this message gave me the funny feeling that I'm going to
see a lot of unrelated code mashed into one patch.  There doesn't
seem to be a general theme to the commit, at least as far as the
message is concerned.

[a bit later...] After reading the code itself, I agree with the
original guess on the commit message, there is too much happening
in this one patch that is unrelated, and there are several problems
lurking that are harder to spot because its a mash of changes.
Please try to break it down to more focused commits.
 
> diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/CachedPacksInfoFileContentsGeneratorTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/CachedPacksInfoFileContentsGeneratorTest.java
> new file mode 100644
> index 0000000..bea0b70
> --- /dev/null
> +++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/CachedPacksInfoFileContentsGeneratorTest.java
> @@ -0,0 +1,74 @@

FYI, our new package space is org.eclipse.jgit and any new changes
need to take that into account.

> + * - Neither the name of the Git Development Community nor the

Also FYI, since our move to the Eclipse Foundation the generic term
"Git Development Community" has been replaced in the license header
by "Eclipse Foundation, Inc.", otherwise the license header remains
as-is and copyright is still attributed to the contributor.

> +public class CachedPacksInfoFileContentsGeneratorTest extends TestCase {
...
> +	public void testGettingPacksContentsMultiplePacks() throws Exception {
> +		List<PackFile> packs = new ArrayList<PackFile>();
> +		packs.add(new PackFile(TEST_IDX, TEST_PACK));
> +		packs.add(new PackFile(TEST_IDX, TEST_PACK));
> +		packs.add(new PackFile(TEST_IDX, TEST_PACK));

I think we should be testing multiple names here, to ensure the
generator didn't do something stupid like reuse the same array index
for pulling the name while looping for the size of the input list.

> diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/ObjectDirectoryTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/ObjectDirectoryTest.java
> @@ -54,9 +54,9 @@
>  
>  	@Override
>  	protected void setUp() throws Exception {
> -		testDir = new File(new File(System.getProperty("java.io.tmpdir")), UUID.randomUUID().toString());
> +		testDir = JGitTestUtil.generateTempDirectoryFileObject();

Yea, I'm confused about this hunk.  It isn't strictly necessary
for the new feature this commit is adding.  Pull this into its own
commit, before the new feature, so you can take advantage of the
refactoring in your new tests, but you also don't muddle the new
feature addition with old code refactoring.

> diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/util/JGitTestUtil.java b/org.spearce.jgit.test/tst/org/spearce/jgit/util/JGitTestUtil.java
> @@ -74,7 +76,8 @@ public static File getTestResourceFile(final String fileName) {
>  		}
>  	}
>  
> -	public static void copyFile(final File fromFile, final File toFile) throws IOException {
> +	public static void copyFile(final File fromFile, final File toFile)
> +			throws IOException {
>  		InputStream in = new FileInputStream(fromFile);
>  		OutputStream out = new FileOutputStream(toFile);

Unnecessary reformatting hunk; we try to avoid these when possible.

> @@ -87,6 +90,21 @@ public static void copyFile(final File fromFile, final File toFile) throws IOExc
>  		out.close();
>  	}
>  
> +	public static String readFileAsString(final File file)
> +			throws java.io.IOException {

This method already exists in some form in the RepositoryTest class.
Can we instead make a commit to refactor it out of there here?

> +		StringBuilder fileData = new StringBuilder(1000);
> +		BufferedReader reader = new BufferedReader(new FileReader(file));

We should be more specific about our encoding and not rely on the
platform default.

> +		char[] buf = new char[1024];
> +		int numRead = 0;
> +		while ((numRead = reader.read(buf)) != -1) {
> +			String readData = String.valueOf(buf, 0, numRead);
> +			fileData.append(readData);
> +			buf = new char[1024];

There is no need to reallocate the buffer, String.valueOf is required
to copy the array to ensure the returned String is immutable.
Worse, you don't need to convert the char array to string, there is
a method on StringBuilder to append a char[] taking char[],int,int.

> @@ -136,4 +154,8 @@ private static void reportDeleteFailure(final String name,
> +
> +	public static File generateTempDirectoryFileObject() {
> +		return new File(new File(System.getProperty("java.io.tmpdir")), UUID.randomUUID().toString());
> +	}

Please generate temporary directories under the same area that
RepositoryTest produces them, which makes it easier to cleanup,
and ensures we aren't treading out of our build area.

> diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/AlternateRepositoryDatabase.java b/org.spearce.jgit/src/org/spearce/jgit/lib/AlternateRepositoryDatabase.java
> index 68ad488..70ce505 100644
> --- a/org.spearce.jgit/src/org/spearce/jgit/lib/AlternateRepositoryDatabase.java
> +++ b/org.spearce.jgit/src/org/spearce/jgit/lib/AlternateRepositoryDatabase.java
> @@ -130,4 +130,9 @@ protected void closeAlternates(final ObjectDatabase[] alt) {
>  	public List<PackFile> listLocalPacks() {
>  		return odb.listLocalPacks();
>  	}
> +
> +	@Override
> +	public void updateInfoCache() throws IOException {
> +		odb.updateInfoCache();
> +	}
>  }
> diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/CachedPacksInfoFileContentsGenerator.java b/org.spearce.jgit/src/org/spearce/jgit/lib/CachedPacksInfoFileContentsGenerator.java
> + * This file is used to generate the contents of the file system
> + * based pack file cache used by the dumb git-http client protocol.
> + * @author mike

We don't record @author annotations.

> +public class CachedPacksInfoFileContentsGenerator {
> +
> +	private List<PackFile> packs;
> +
> +	public CachedPacksInfoFileContentsGenerator(List<PackFile> packs) {
> +		this.packs = packs;
> +	}
> +	
> +	public String generateContents(){

Style nit: space between () and {.

I also wonder about the value of an instance for this class, if
all it does is produce one return value as a string, why not just
use a static method?

> diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Constants.java b/org.spearce.jgit/src/org/spearce/jgit/lib/Constants.java
> index 9afea67..2d78dda 100644
> --- a/org.spearce.jgit/src/org/spearce/jgit/lib/Constants.java
> +++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Constants.java
> @@ -224,6 +224,9 @@
>  
>  	/** Info refs folder */
>  	public static final String INFO_REFS = "info/refs";
> +	
> +	/** cached packs file */
> +	public static final String CACHED_PACKS_FILE = "info/packs"; 

I think you should denote in the comment that this is relative to
the objects directory, and not the repository.  The INFO_REFS file
right above you is relative to the repository and something looks
wrong seeing these together in context.
  
> diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectDatabase.java b/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectDatabase.java
> index 722c802..5ded7bb 100644
> --- a/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectDatabase.java
> +++ b/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectDatabase.java
> @@ -75,6 +75,14 @@ protected ObjectDatabase() {
>  	public abstract List<PackFile> listLocalPacks();
>  	
>  	/**
> +	 * Creates the caches that are typically done by 
> +	 * update-server-info, namely objects/info/packs and 
> +	 * info/refs

Why is the object database updating info/refs?  The info/refs file
has nothing to do with the raw object storage.

> +	 * @throws IOException 
> +	 */
> +	public abstract void updateInfoCache() throws IOException;

I'm not sure I'm happy with this being on ObjectDatabase but there
may not be any other choice.  We'd like to eventually have other
types of ObjectDatabase that don't even store packs, in such a
database updating the info cache makes no sense.  Asking them to
implement the operation is silly.  But... we have no other way to
easily signal the database that it should do this update.

Hmmph.  I wonder if it might be better to configure the
ObjectDirectory at creation time to automatically maintain
the info/packs file during openPack, and put this method on
ObjectDirectory for explicit invocation in case someone has made
edits outside of JGit and wants to force the cache to be current
again.

I'm not sold either way yet.  I'm still open on the approach.

> diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectDirectory.java b/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectDirectory.java
> index cbe132d..f4251c1 100644
> --- a/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectDirectory.java
> +++ b/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectDirectory.java
> @@ -514,4 +514,9 @@ boolean tryAgain(final long currLastModified) {
>  		tryAgain1();
>  		return new ArrayList<PackFile>(Arrays.asList(packList.get().packs));
>  	}
> +
> +	@Override
> +	public void updateInfoCache() throws IOException {
> +		new UpdateDirectoryBasedPacksInfoCache(this.listLocalPacks(), new File(this.getDirectory(), Constants.CACHED_PACKS_FILE)).execute();

Style-nit: Line is far too long, we try to wrap at around 80
characters but sometimes allow a line to go longer if its only
longer by 1 or 2 characters and the wrapped result would be harder
to read than the unwrapped result.  This is out at 140, too many
over the limit.

> diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/UpdateDirectoryBasedPacksInfoCache.java b/org.spearce.jgit/src/org/spearce/jgit/lib/UpdateDirectoryBasedPacksInfoCache.java
> +public class UpdateDirectoryBasedPacksInfoCache {
> +	public void execute() throws IOException {
> +		String packsContents = new CachedPacksInfoFileContentsGenerator(packsList).generateContents();
> +		FileOutputStream fos = new FileOutputStream(infoPacksFile);
> +		fos.write(packsContents.getBytes());
> +		fos.close();

I'm not sure why this 4 line method requires its own top level
class and being able to create an instance.  Code bloat?

You need to specify the character encoding here and not rely on
the platform default.

I'm not sure how C Git handles this update, but we probably should be
safer about it and use the LockFile class so the update is going to
be transactional.  Here you are truncating a live file, which means
readers could see an empty content if they happen to request the file
from the web server at the wrong moment.  LockFile does the writing
to a temporary file and then renames it over, which on a POSIX file
system means there is no way someone can see a partial update.

> diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/UpdateDirectoryInfoCache.java b/org.spearce.jgit/src/org/spearce/jgit/lib/UpdateDirectoryInfoCache.java
> +public class UpdateDirectoryInfoCache {
> +	public void execute() throws IOException {
> +		String packsContents = new CachedPacksInfoFileContentsGenerator(packsList).generateContents();
> +		FileOutputStream fos = new FileOutputStream(infoPacksFile);
> +		fos.write(packsContents.getBytes());
> +		fos.close();

Uh, isn't this the same as UpdateDirectoryBasedPacksInfoCache?
Two top level classes for a 4 line method?

> diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/ReceivePack.java b/org.spearce.jgit/src/org/spearce/jgit/transport/ReceivePack.java
> +	private void updateObjectInfoCache() {
> +		try{

Style-nit: space after try

> +			getRepository().getObjectDatabase().updateInfoCache();
> +		} 
> +		catch (IOException e){

Style-nit: space between ) and {

> +			sendMessage("error updating server info: " + e.getMessage());

-- 
Shawn.
