From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGIT PATCH 4/4] Intelligent parsing of ambiguously encoded
	meta data.
Date: Sun, 12 Oct 2008 19:27:08 -0700
Message-ID: <20081013022708.GJ4856@spearce.org>
References: <1223851860-13068-1-git-send-email-robin.rosenberg@dewire.com> <1223851860-13068-2-git-send-email-robin.rosenberg@dewire.com> <1223851860-13068-3-git-send-email-robin.rosenberg@dewire.com> <1223851860-13068-4-git-send-email-robin.rosenberg@dewire.com> <1223851860-13068-5-git-send-email-robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Mon Oct 13 04:28:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KpDAU-0000vF-PI
	for gcvg-git-2@gmane.org; Mon, 13 Oct 2008 04:28:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754367AbYJMC1L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Oct 2008 22:27:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754254AbYJMC1K
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Oct 2008 22:27:10 -0400
Received: from george.spearce.org ([209.20.77.23]:36892 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753723AbYJMC1J (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Oct 2008 22:27:09 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 709C13835F; Mon, 13 Oct 2008 02:27:08 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1223851860-13068-5-git-send-email-robin.rosenberg@dewire.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98074>

Robin Rosenberg <robin.rosenberg@dewire.com> wrote:
> We cannot trust meta data to be encoded in any particular way, so we try
> different encodings. First we try UTF-8, which is the only sane encoding
> for non-local data, even when used in regions where eight bit legacy
> encodings are common. The chance of mistakenly parsing non-UTF-8 data
> as valid UTF-8 is varies from extremely low (western encodings) to low
> for most other encodings. If the data does not look like UTF-8, we try the
> suggested encoding. If that fails we try the user locale and finally, if
> that fails we try ISO-8859-1, which cannot fail.

Hmm.  I'm concerned about the infinite loop you have here.
If ISO-8859-1 fails we'd be stuck here until the end of time.
Plus its a bit ugly to read.

I wonder if this is any better.  It passes your tests and is 2
lines shorter.

diff --git a/org.spearce.jgit/src/org/spearce/jgit/util/RawParseUtils.java b/org.spearce.jgit/src/org/spearce/jgit/util/RawParseUtils.java
index a31734b..6c0e339 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/util/RawParseUtils.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/util/RawParseUtils.java
@@ -42,7 +42,10 @@
 import static org.spearce.jgit.lib.ObjectChecker.encoding;
 
 import java.nio.ByteBuffer;
+import java.nio.charset.CharacterCodingException;
 import java.nio.charset.Charset;
+import java.nio.charset.CharsetDecoder;
+import java.nio.charset.CodingErrorAction;
 import java.util.Arrays;
 
 import org.spearce.jgit.lib.Constants;
@@ -376,7 +379,10 @@ public static PersonIdent parsePersonIdent(final byte[] raw, final int nameB) {
 	}
 
 	/**
-	 * Decode a region of the buffer under the specified character set.
+	 * Decode a region of the buffer under the specified character set if possible.
+	 *
+	 * If the byte stream cannot be decoded that way, the platform default is tried
+	 * and if that too fails, the fail-safe ISO-8859-1 encoding is tried.
 	 * 
 	 * @param cs
 	 *            character set to use when decoding the buffer.
@@ -393,7 +399,56 @@ public static PersonIdent parsePersonIdent(final byte[] raw, final int nameB) {
 	public static String decode(final Charset cs, final byte[] buffer,
 			final int start, final int end) {
 		final ByteBuffer b = ByteBuffer.wrap(buffer, start, end - start);
-		return cs.decode(b).toString();
+		b.mark();
+
+		// Try our built-in favorite. The assumption here is that
+		// decoding will fail if the data is not actually encoded
+		// using that encoder.
+		//
+		try {
+			return decode(b, Constants.CHARSET);
+		} catch (CharacterCodingException e) {
+			b.reset();
+		}
+
+		if (!cs.equals(Constants.CHARSET)) {
+			// Try the suggested encoding, it might be right since it was
+			// provided by the caller.
+			//
+			try {
+				return decode(b, cs);
+			} catch (CharacterCodingException e) {
+				b.reset();
+			}
+		}
+
+		// Try the default character set. A small group of people
+		// might actually use the same (or very similar) locale.
+		//
+		final Charset defcs = Charset.defaultCharset();
+		if (!defcs.equals(cs) && !defcs.equals(Constants.CHARSET)) {
+			try {
+				return decode(b, defcs);
+			} catch (CharacterCodingException e) {
+				b.reset();
+			}
+		}
+
+		// Fall back to an ISO-8859-1 style encoding. At least all of
+		// the bytes will be present in the output.
+		//
+		final StringBuilder r = new StringBuilder(end - start);
+		for (int i = start; i < end; i++)
+			r.append((char) (buffer[i] & 0xff));
+		return r.toString();
+	}
+
+	private static String decode(final ByteBuffer b, final Charset charset)
+			throws CharacterCodingException {
+		final CharsetDecoder d = charset.newDecoder();
+		d.onMalformedInput(CodingErrorAction.REPORT);
+		d.onUnmappableCharacter(CodingErrorAction.REPORT);
+		return d.decode(b).toString();
 	}
 
 	/**


-- 
Shawn.
