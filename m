From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGIT PATCH] Encode/decode index and tree entries using UTF-8
Date: Sun, 19 Oct 2008 10:14:56 -0700
Message-ID: <20081019171456.GC14786@spearce.org>
References: <200810191529.43439.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Mon Oct 20 09:33:13 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Krbtw-0003GI-Lh
	for gcvg-git-2@gmane.org; Sun, 19 Oct 2008 19:17:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751510AbYJSRO6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Oct 2008 13:14:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751508AbYJSRO6
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Oct 2008 13:14:58 -0400
Received: from george.spearce.org ([209.20.77.23]:54221 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751478AbYJSRO5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Oct 2008 13:14:57 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 6CD883835F; Sun, 19 Oct 2008 17:14:56 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <200810191529.43439.robin.rosenberg.lists@dewire.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98623>

Robin Rosenberg <robin.rosenberg.lists@dewire.com> wrote:
> Decoding uses the same strategy as for commit messages and other string
> entities. Encoding is always done in UTF-8. This is incompatible with
> Git for non-unicode unices, but it leads to the expected behavior on
> Windows and cross-locale sharing of repositories.

FWIW I think this is a good idea.
 
> Inpired by the recent thread on the gitml, I decideed to clean up jgit a little. I
> know the GitIndex is soon to be obsoleted, but it it still the class that does
> the dirty work when committing in Egit and the changes are fairly simple
> anyway.

Yup, I agree.

I mostly agree with the patch, but we have a utility function you
are missing using:
 
> @@ -300,11 +302,11 @@ static boolean File_hasExecute() {
>  		return FS.INSTANCE.supportsExecute();
>  	}
>  
> -	static byte[] makeKey(File wd, File f) {
> +	static byte[] makeKey(File wd, File f) throws IOException {
>  		if (!f.getPath().startsWith(wd.getPath()))
>  			throw new Error("Path is not in working dir");
>  		String relName = Repository.stripWorkDir(wd, f);
> -		return relName.getBytes();
> +		return relName.getBytes(Constants.CHARACTER_ENCODING);
>  	}

Instead of "relName.getBytes(Constants.CHARACTER_ENCODING)" use
"Constants.encode(relName)".  Its shorter and faster.
  
> @@ -591,7 +593,7 @@ public String toString() {
>  		 * @return path name for this entry
>  		 */
>  		public String getName() {
> -			return new String(name);
> +			return RawParseUtils.decode(Constants.CHARSET, name, 0, name.length);

Heh.  That's actually a common idiom.  We probably should add:

	String decode(final byte[] arr) {
		return decode(Constants.CHARSET, arr, 0, arr.length);
	}

to RawParseUtils to make these decode whole array calls easier
to make.

I think you should squash this into your patch, and fix up the
getBytes and decode calls as I noted above before we apply this.

diff --git a/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCacheEntry.java b/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCacheEntry.java
index cc683d7..913f3ae 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCacheEntry.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCacheEntry.java
@@ -42,7 +42,6 @@
 import java.io.IOException;
 import java.io.InputStream;
 import java.io.OutputStream;
-import java.nio.ByteBuffer;
 import java.util.Arrays;
 
 import org.spearce.jgit.lib.AnyObjectId;
@@ -50,6 +49,7 @@
 import org.spearce.jgit.lib.FileMode;
 import org.spearce.jgit.lib.ObjectId;
 import org.spearce.jgit.util.NB;
+import org.spearce.jgit.util.RawParseUtils;
 
 /**
  * A single file (or stage of a file) in a {@link DirCache}.
@@ -405,7 +405,7 @@ public void setObjectIdFromRaw(final byte[] bs, final int p) {
 	 *         returned string.
 	 */
 	public String getPathString() {
-		return Constants.CHARSET.decode(ByteBuffer.wrap(path)).toString();
+		return RawParseUtils.decode(path);
 	}
 
 	/**
diff --git a/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCacheTree.java b/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCacheTree.java
index 26b6348..589894a 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCacheTree.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCacheTree.java
@@ -39,7 +39,6 @@
 
 import java.io.IOException;
 import java.io.OutputStream;
-import java.nio.ByteBuffer;
 import java.util.Arrays;
 import java.util.Comparator;
 
@@ -251,8 +250,7 @@ ObjectId getObjectId() {
 	 * @return name of the tree. This does not contain any '/' characters.
 	 */
 	public String getNameString() {
-		final ByteBuffer bb = ByteBuffer.wrap(encodedName);
-		return Constants.CHARSET.decode(bb).toString();
+		return RawParseUtils.decode(encodedName);
 	}
 
 	/**
diff --git a/org.spearce.jgit/src/org/spearce/jgit/util/RawParseUtils.java b/org.spearce.jgit/src/org/spearce/jgit/util/RawParseUtils.java
index 6c0e339..2519f19 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/util/RawParseUtils.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/util/RawParseUtils.java
@@ -379,6 +379,21 @@ public static PersonIdent parsePersonIdent(final byte[] raw, final int nameB) {
 	}
 
 	/**
+	 * Decode a region of the buffer from the default character set (UTF-8).
+	 * 
+	 * If the byte stream cannot be decoded that way, the platform default is
+	 * tried and if that too fails, the fail-safe ISO-8859-1 encoding is tried.
+	 * 
+	 * @param buffer
+	 *            buffer to pull raw bytes from.
+	 * @return a string representation of the entire buffer, after decoding the
+	 *         region through the specified character set.
+	 */
+	public static String decode(final byte[] buffer) {
+		return decode(Constants.CHARSET, buffer, 0, buffer.length);
+	}
+
+	/**
 	 * Decode a region of the buffer under the specified character set if possible.
 	 *
 	 * If the byte stream cannot be decoded that way, the platform default is tried

-- 
Shawn.
